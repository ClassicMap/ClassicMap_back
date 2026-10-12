-- 홀스트 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 152개(묶음 33, 다악장 24, 낱곡 95),
-- 새 작품 7개, part 236개, 그 아래 12개.
-- seed 168개 중 145개를 작품·part 에 잇고, 21개를 숨기고, 2개는 그대로 둔다.
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

-- H. 83 16 Folk Songs from Hampshire H. 83

UPDATE pieces piece
SET piece.title = '16 Folk Songs from Hampshire H. 83', piece.title_en = '16 Folk Songs from Hampshire, H. 83',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '83',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9178 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Willow Tree', part.name_en = '16 Folk Songs from Hampshire, H. 83: No. 6. The Willow Tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9178 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4893ae2d-d631-4ca7-b02f-7f18c09df734' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4893ae2d-d631-4ca7-b02f-7f18c09df734', 1, NULL, 'The Willow Tree', '16 Folk Songs from Hampshire, H. 83: No. 6. The Willow Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9178 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4893ae2d-d631-4ca7-b02f-7f18c09df734'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Abroad as I Was Walking', part.name_en = '16 Folk Songs from Hampshire, H. 83: No. 1. Abroad as I Was Walking',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9178 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:9c08fefb-0623-49e3-a1aa-e71bf5eafa75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c08fefb-0623-49e3-a1aa-e71bf5eafa75', 2, NULL, 'Abroad as I Was Walking', '16 Folk Songs from Hampshire, H. 83: No. 1. Abroad as I Was Walking', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9178 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c08fefb-0623-49e3-a1aa-e71bf5eafa75'
);


-- Op. 43 2개의 모테트 Op. 43

UPDATE pieces piece
SET piece.title = '2개의 모테트 Op. 43', piece.title_en = '2 Motets, op. 43',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '43',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10966 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Evening Watch, op. 43 no. 1, H. 159', part.name_en = 'The Evening Watch, op. 43 no. 1, H. 159',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10966 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:686b5dae-d61e-467e-b445-b541a69b1aab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:686b5dae-d61e-467e-b445-b541a69b1aab', 1, NULL, 'The Evening Watch, op. 43 no. 1, H. 159', 'The Evening Watch, op. 43 no. 1, H. 159', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10966 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:686b5dae-d61e-467e-b445-b541a69b1aab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sing Me the Men, op. 43 no. 2', part.name_en = 'Sing Me the Men, op. 43 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10966 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c0bba048-d05e-4bac-9f74-b7244cea3112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0bba048-d05e-4bac-9f74-b7244cea3112', 2, NULL, 'Sing Me the Men, op. 43 no. 2', 'Sing Me the Men, op. 43 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10966 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0bba048-d05e-4bac-9f74-b7244cea3112'
);


-- None 3개의 찬가

UPDATE pieces piece
SET piece.title = '3개의 찬가', piece.title_en = '3 Hymns for the English Hymnal',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7858 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'From Glory to Glory Advancing', part.name_en = 'From Glory to Glory Advancing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7858 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:2f75bf11-9e18-4be0-96ab-c8642fb137f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f75bf11-9e18-4be0-96ab-c8642fb137f0', 1, NULL, 'From Glory to Glory Advancing', 'From Glory to Glory Advancing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7858 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f75bf11-9e18-4be0-96ab-c8642fb137f0'
);


-- H. 13 3 Short Part-Songs H. 13

UPDATE pieces piece
SET piece.title = '3 Short Part-Songs H. 13', piece.title_en = '3 Short Part-Songs, H. 13',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '13',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9932 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'In the Forest Moonbeam-Brightened, H. 13 no. 1', part.name_en = 'In the Forest Moonbeam-Brightened, H. 13 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9932 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:65d1083e-8d9f-48ab-8d6a-27d77cab9a07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65d1083e-8d9f-48ab-8d6a-27d77cab9a07', 1, NULL, 'In the Forest Moonbeam-Brightened, H. 13 no. 1', 'In the Forest Moonbeam-Brightened, H. 13 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9932 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65d1083e-8d9f-48ab-8d6a-27d77cab9a07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'All the Nests with Song Are Ringing, H. 13 no. 2', part.name_en = 'All the Nests with Song Are Ringing, H. 13 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9932 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1bc85309-efdb-4dfc-9dfa-3463636ad28f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bc85309-efdb-4dfc-9dfa-3463636ad28f', 2, NULL, 'All the Nests with Song Are Ringing, H. 13 no. 2', 'All the Nests with Song Are Ringing, H. 13 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9932 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bc85309-efdb-4dfc-9dfa-3463636ad28f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Soft and Gently through My Soul, H. 13 no. 3', part.name_en = 'Soft and Gently through My Soul, H. 13 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9932 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:70c3929e-8d02-461b-9d22-34c00dd18aab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70c3929e-8d02-461b-9d22-34c00dd18aab', 3, NULL, 'Soft and Gently through My Soul, H. 13 no. 3', 'Soft and Gently through My Soul, H. 13 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9932 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70c3929e-8d02-461b-9d22-34c00dd18aab'
);


-- Op. 34 4 Choruses Op. 34

UPDATE pieces piece
SET piece.title = '4 Choruses Op. 34', piece.title_en = '4 Choruses, op. 34',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '34',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10833 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'This Have I Done For My True Love, op. 34 no. 1', part.name_en = 'This Have I Done For My True Love, op. 34 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10833 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:cb1bdc8f-d679-40a2-9e41-37a0e02c3105' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb1bdc8f-d679-40a2-9e41-37a0e02c3105', 1, NULL, 'This Have I Done For My True Love, op. 34 no. 1', 'This Have I Done For My True Love, op. 34 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10833 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb1bdc8f-d679-40a2-9e41-37a0e02c3105'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Of One That Is So Fair and Bright, op. 34 no. 3', part.name_en = 'Of One That Is So Fair and Bright, op. 34 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10833 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:32aec0bb-1a48-47c6-9753-3502c3cdd93c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32aec0bb-1a48-47c6-9753-3502c3cdd93c', 2, NULL, 'Of One That Is So Fair and Bright, op. 34 no. 3', 'Of One That Is So Fair and Bright, op. 34 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10833 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32aec0bb-1a48-47c6-9753-3502c3cdd93c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Bring Us In Good Ale, op. 34 no. 4', part.name_en = 'Bring Us In Good Ale, op. 34 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10833 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c2b8e165-0208-47c4-917b-dbaf82002f21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2b8e165-0208-47c4-917b-dbaf82002f21', 3, NULL, 'Bring Us In Good Ale, op. 34 no. 4', 'Bring Us In Good Ale, op. 34 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10833 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2b8e165-0208-47c4-917b-dbaf82002f21'
);


-- H. 14 4개의 가곡 H. 14

UPDATE pieces piece
SET piece.title = '4개의 가곡 H. 14', piece.title_en = '4 Songs, H. 14',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '14',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11072 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Margrete''s Cradle-Song, H. 14 no. 1', part.name_en = 'Margrete''s Cradle-Song, H. 14 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11072 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:8f7d0b80-6ac0-4adf-9fe0-34f1477c8253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f7d0b80-6ac0-4adf-9fe0-34f1477c8253', 1, NULL, 'Margrete''s Cradle-Song, H. 14 no. 1', 'Margrete''s Cradle-Song, H. 14 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11072 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f7d0b80-6ac0-4adf-9fe0-34f1477c8253'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Slumber-Song, H. 14 no. 2', part.name_en = 'Slumber-Song, H. 14 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11072 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:5c7a4766-7993-49f6-bfc7-3168380475ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c7a4766-7993-49f6-bfc7-3168380475ee', 2, NULL, 'Slumber-Song, H. 14 no. 2', 'Slumber-Song, H. 14 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11072 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c7a4766-7993-49f6-bfc7-3168380475ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Soft and Gently, H. 14 no. 3', part.name_en = 'Soft and Gently, H. 14 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11072 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d9a3beb5-5ba4-4c7e-8de7-3efd12029c96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9a3beb5-5ba4-4c7e-8de7-3efd12029c96', 3, NULL, 'Soft and Gently, H. 14 no. 3', 'Soft and Gently, H. 14 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11072 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9a3beb5-5ba4-4c7e-8de7-3efd12029c96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Awake, My Heart, H. 14 no. 4', part.name_en = 'Awake, My Heart, H. 14 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11072 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:bc4729a8-9cf4-4405-b1a2-74a7fcf83d86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc4729a8-9cf4-4405-b1a2-74a7fcf83d86', 4, NULL, 'Awake, My Heart, H. 14 no. 4', 'Awake, My Heart, H. 14 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11072 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc4729a8-9cf4-4405-b1a2-74a7fcf83d86'
);


-- Op. 9a 5개의 합창곡

UPDATE pieces piece
SET piece.title = '5개의 합창곡', piece.title_en = '5 Part-Songs, op. 9a, H. 48',
    piece.type = 'song', piece.opus_number = 'Op. 9a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9909 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 12 5개의 합창곡 Op. 12

UPDATE pieces piece
SET piece.title = '5개의 합창곡 Op. 12', piece.title_en = '5 Partsongs, Op. 12, H. 61',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '12',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8412 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dream Tryst', part.name_en = '5 Partsongs, Op. 12, H. 61: No. 1, Dream Tryst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8412 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:6e280c36-656e-44fd-978f-754a68a1ca24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e280c36-656e-44fd-978f-754a68a1ca24', 1, NULL, 'Dream Tryst', '5 Partsongs, Op. 12, H. 61: No. 1, Dream Tryst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8412 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e280c36-656e-44fd-978f-754a68a1ca24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Come to Me', part.name_en = '5 Partsongs, Op. 12, H. 61: No. 5, Come to Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8412 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:95514152-2c93-4328-9440-11adcbd70a39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95514152-2c93-4328-9440-11adcbd70a39', 2, NULL, 'Come to Me', '5 Partsongs, Op. 12, H. 61: No. 5, Come to Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8412 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95514152-2c93-4328-9440-11adcbd70a39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ye Little Birds', part.name_en = '5 Partsongs, Op. 12, H. 61: No. 2, Ye Little Birds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8412 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d7d58bf0-32b0-45b9-84f7-31b699e7ac47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7d58bf0-32b0-45b9-84f7-31b699e7ac47', 3, NULL, 'Ye Little Birds', '5 Partsongs, Op. 12, H. 61: No. 2, Ye Little Birds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8412 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7d58bf0-32b0-45b9-84f7-31b699e7ac47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Her Eyes the Glow-Worm Lend Thee', part.name_en = '5 Partsongs, Op. 12, H. 61: No. 3, Her Eyes the Glow-Worm Lend Thee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8412 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:da8bfb38-44e4-46d2-8d4f-39413e022b77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da8bfb38-44e4-46d2-8d4f-39413e022b77', 4, NULL, 'Her Eyes the Glow-Worm Lend Thee', '5 Partsongs, Op. 12, H. 61: No. 3, Her Eyes the Glow-Worm Lend Thee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8412 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da8bfb38-44e4-46d2-8d4f-39413e022b77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Now Is the Month of Maying', part.name_en = '5 Partsongs, Op. 12, H. 61: No. 4, Now Is the Month of Maying',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8412 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:e22b9d9a-128a-4fd1-ac13-865acfcb9f81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e22b9d9a-128a-4fd1-ac13-865acfcb9f81', 5, NULL, 'Now Is the Month of Maying', '5 Partsongs, Op. 12, H. 61: No. 4, Now Is the Month of Maying', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8412 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e22b9d9a-128a-4fd1-ac13-865acfcb9f81'
);


-- Op. 15 6개의 가곡 Op. 15

UPDATE pieces piece
SET piece.title = '6개의 가곡 Op. 15', piece.title_en = '6 Songs, op. 15',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '15',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8654 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'H. 68: No. 1. Invocation to the Dawn', part.name_en = '6 Songs, op. 15, H. 68: No. 1. Invocation to the Dawn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8654 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:f721ccae-f16b-4d7a-b2b3-3e2ad906c598' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f721ccae-f16b-4d7a-b2b3-3e2ad906c598', 1, NULL, 'H. 68: No. 1. Invocation to the Dawn', '6 Songs, op. 15, H. 68: No. 1. Invocation to the Dawn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8654 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f721ccae-f16b-4d7a-b2b3-3e2ad906c598'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'H. 68: No. 2. Fain Would I Change That Note', part.name_en = '6 Songs, op. 15, H. 68: No. 2. Fain Would I Change That Note',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8654 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:440e931b-0b70-4317-b25a-e63b9d128f0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:440e931b-0b70-4317-b25a-e63b9d128f0e', 2, NULL, 'H. 68: No. 2. Fain Would I Change That Note', '6 Songs, op. 15, H. 68: No. 2. Fain Would I Change That Note', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8654 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:440e931b-0b70-4317-b25a-e63b9d128f0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'H. 68: No. 3. The Sergeant''s Song', part.name_en = '6 Songs, op. 15, H. 68: No. 3. The Sergeant''s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8654 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:2ac4c34f-9bc4-4432-86e5-53a8468898e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ac4c34f-9bc4-4432-86e5-53a8468898e2', 3, NULL, 'H. 68: No. 3. The Sergeant''s Song', '6 Songs, op. 15, H. 68: No. 3. The Sergeant''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8654 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac4c34f-9bc4-4432-86e5-53a8468898e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'H. 68: No. 4. In a Wood', part.name_en = '6 Songs, op. 15, H. 68: No. 4. In a Wood',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8654 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:8f9f8df9-f25e-4869-9053-f0d75d375f59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f9f8df9-f25e-4869-9053-f0d75d375f59', 4, NULL, 'H. 68: No. 4. In a Wood', '6 Songs, op. 15, H. 68: No. 4. In a Wood', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8654 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f9f8df9-f25e-4869-9053-f0d75d375f59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'H. 68: No. 5. Between Us Now', part.name_en = '6 Songs, op. 15, H. 68: No. 5. Between Us Now',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8654 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:2aca8387-1f2f-427f-a0e8-f80255d850f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2aca8387-1f2f-427f-a0e8-f80255d850f3', 5, NULL, 'H. 68: No. 5. Between Us Now', '6 Songs, op. 15, H. 68: No. 5. Between Us Now', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8654 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aca8387-1f2f-427f-a0e8-f80255d850f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'H. 68: No. 6. I Will Not Let Thee Go', part.name_en = '6 Songs, op. 15, H. 68: No. 6. I Will Not Let Thee Go',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8654 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:465d051f-b890-4f05-8218-f4b9c41c4f85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:465d051f-b890-4f05-8218-f4b9c41c4f85', 6, NULL, 'H. 68: No. 6. I Will Not Let Thee Go', '6 Songs, op. 15, H. 68: No. 6. I Will Not Let Thee Go', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8654 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:465d051f-b890-4f05-8218-f4b9c41c4f85'
);


-- H. 146 7 Choruses from the Alcestis of Euripides H. 146

UPDATE pieces piece
SET piece.title = '7 Choruses from the Alcestis of Euripides H. 146', piece.title_en = '7 Choruses from the Alcestis of Euripides, H. 146',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '146',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9423 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I Have Sojourned in the Muses'' Land', part.name_en = '7 Choruses from the Alcestis of Euripides, H. 146: No. 6, I Have Sojourned in the Muses'' Land',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9423 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1c42228d-58aa-4417-b68e-16d09e5575fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c42228d-58aa-4417-b68e-16d09e5575fc', 1, NULL, 'I Have Sojourned in the Muses'' Land', '7 Choruses from the Alcestis of Euripides, H. 146: No. 6, I Have Sojourned in the Muses'' Land', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9423 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c42228d-58aa-4417-b68e-16d09e5575fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'O Paian Wise!', part.name_en = '7 Choruses from the Alcestis of Euripides, H. 146: No. 1, O Paian Wise!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9423 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1ea5375f-d715-460b-b775-18ba5415358a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea5375f-d715-460b-b775-18ba5415358a', 2, NULL, 'O Paian Wise!', '7 Choruses from the Alcestis of Euripides, H. 146: No. 1, O Paian Wise!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9423 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea5375f-d715-460b-b775-18ba5415358a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Daughter of Pelias, Fare Thee Well', part.name_en = '7 Choruses from the Alcestis of Euripides, H. 146: No. 2, Daughter of Pelias, Fare Thee Well',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9423 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7749ffa7-a89b-41b2-8dfe-9d43e4f8b2fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7749ffa7-a89b-41b2-8dfe-9d43e4f8b2fb', 3, NULL, 'Daughter of Pelias, Fare Thee Well', '7 Choruses from the Alcestis of Euripides, H. 146: No. 2, Daughter of Pelias, Fare Thee Well', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9423 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7749ffa7-a89b-41b2-8dfe-9d43e4f8b2fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'There Be Many Shapes of Mystery', part.name_en = '7 Choruses from the Alcestis of Euripides, H. 146: No. 7, There Be Many Shapes of Mystery',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9423 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7f6dcb94-67c7-4693-b7ca-78235f26bbe7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f6dcb94-67c7-4693-b7ca-78235f26bbe7', 4, NULL, 'There Be Many Shapes of Mystery', '7 Choruses from the Alcestis of Euripides, H. 146: No. 7, There Be Many Shapes of Mystery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9423 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f6dcb94-67c7-4693-b7ca-78235f26bbe7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Oh, a House That Loves the Stranger', part.name_en = '7 Choruses from the Alcestis of Euripides, H. 146: No. 3, Oh, a House That Loves the Stranger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9423 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7f75b53f-81e9-4f9c-b90f-76edcedb66a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f75b53f-81e9-4f9c-b90f-76edcedb66a4', 5, NULL, 'Oh, a House That Loves the Stranger', '7 Choruses from the Alcestis of Euripides, H. 146: No. 3, Oh, a House That Loves the Stranger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9423 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f75b53f-81e9-4f9c-b90f-76edcedb66a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Advance, Advance', part.name_en = '7 Choruses from the Alcestis of Euripides, H. 146: No. 5, Advance, Advance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9423 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:863eff4b-2fba-422f-b6f1-1764fd2fa2d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:863eff4b-2fba-422f-b6f1-1764fd2fa2d5', 6, NULL, 'Advance, Advance', '7 Choruses from the Alcestis of Euripides, H. 146: No. 5, Advance, Advance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9423 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:863eff4b-2fba-422f-b6f1-1764fd2fa2d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ah Me! Farewell', part.name_en = '7 Choruses from the Alcestis of Euripides, H. 146: No. 4, Ah Me! Farewell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9423 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:f456df10-0d2c-4591-a73c-1e0451d473d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f456df10-0d2c-4591-a73c-1e0451d473d8', 7, NULL, 'Ah Me! Farewell', '7 Choruses from the Alcestis of Euripides, H. 146: No. 4, Ah Me! Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9423 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f456df10-0d2c-4591-a73c-1e0451d473d8'
);


-- None A Choral Fantasia

UPDATE pieces piece
SET piece.title = 'A Choral Fantasia', piece.title_en = 'A Choral Fantasia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11210 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Dirge for Two Veterans

UPDATE pieces piece
SET piece.title = 'A Dirge for Two Veterans', piece.title_en = 'A Dirge for Two Veterans',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9392 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 40 No. 2 A Fugal Concerto

UPDATE pieces piece
SET piece.title = 'A Fugal Concerto', piece.title_en = 'A Fugal Concerto, op. 40 no. 2',
    piece.type = 'album', piece.opus_number = 'Op. 40 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9203 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'A Fugal Concerto, op. 40 no. 2: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9203 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c29d7dc8-964a-4bd3-959d-584d858e8af6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c29d7dc8-964a-4bd3-959d-584d858e8af6', 1, 'I', 'Moderato', 'A Fugal Concerto, op. 40 no. 2: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9203 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c29d7dc8-964a-4bd3-959d-584d858e8af6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'A Fugal Concerto, op. 40 no. 2: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9203 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7a999dba-622c-4323-91fb-61779cdaec38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a999dba-622c-4323-91fb-61779cdaec38', 2, 'II', 'Adagio', 'A Fugal Concerto, op. 40 no. 2: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9203 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a999dba-622c-4323-91fb-61779cdaec38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'A Fugal Concerto, op. 40 no. 2: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9203 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:e951badf-21e6-4bd0-82b5-d6737d408b5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e951badf-21e6-4bd0-82b5-d6737d408b5d', 3, 'III', 'Allegro', 'A Fugal Concerto, op. 40 no. 2: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9203 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e951badf-21e6-4bd0-82b5-d6737d408b5d'
);


-- Op. 40 No. 1 A Fugal Overture

UPDATE pieces piece
SET piece.title = 'A Fugal Overture', piece.title_en = 'A Fugal Overture, op. 40 no. 1',
    piece.type = 'album', piece.opus_number = 'Op. 40 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10747 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'A Fugal Overture, op. 40 no. 1: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10747 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:85e20dca-2bc9-486b-bd5f-2df32cd67149' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85e20dca-2bc9-486b-bd5f-2df32cd67149', 1, 'I', 'Moderato', 'A Fugal Overture, op. 40 no. 1: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10747 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85e20dca-2bc9-486b-bd5f-2df32cd67149'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'A Fugal Overture, op. 40 no. 1: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10747 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:2f9499a5-4926-46ea-a40d-01ea6680f620' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f9499a5-4926-46ea-a40d-01ea6680f620', 2, 'II', 'Adagio', 'A Fugal Overture, op. 40 no. 1: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10747 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f9499a5-4926-46ea-a40d-01ea6680f620'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'A Fugal Overture, op. 40 no. 1: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10747 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:237bc6a9-9494-469d-924e-fec803a52300' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:237bc6a9-9494-469d-924e-fec803a52300', 3, 'III', 'Allegro', 'A Fugal Overture, op. 40 no. 1: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10747 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:237bc6a9-9494-469d-924e-fec803a52300'
);


-- H. 25 A Lake and a Fairy Boat

UPDATE pieces piece
SET piece.title = 'A Lake and a Fairy Boat', piece.title_en = 'A Lake and a Fairy Boat, H. 25',
    piece.type = 'song', piece.opus_number = 'H. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11138 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Piece for Yvonne

UPDATE pieces piece
SET piece.title = 'A Piece for Yvonne', piece.title_en = 'A Piece for Yvonne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9342 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 21 No. 2 A Somerset Rhapsody

UPDATE pieces piece
SET piece.title = 'A Somerset Rhapsody', piece.title_en = 'A Somerset Rhapsody, op. 21 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 21 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8269 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19 No. 1 A Song of the Night

UPDATE pieces piece
SET piece.title = 'A Song of the Night', piece.title_en = 'A Song of the Night, op. 19 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 19 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8838 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 52 A Spring Song

UPDATE pieces piece
SET piece.title = 'A Spring Song', piece.title_en = 'A Spring Song, H. 52',
    piece.type = 'song', piece.opus_number = 'H. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10853 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 91 No. 1 가곡 <A Welcome Song>

UPDATE pieces piece
SET piece.title = '가곡 <A Welcome Song>', piece.title_en = 'A Welcome Song, H. 91 no. 1',
    piece.type = 'song', piece.opus_number = 'H. 91 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9452 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 31 A Winter Idyll

UPDATE pieces piece
SET piece.title = 'A Winter Idyll', piece.title_en = 'A Winter Idyll, H. 31',
    piece.type = 'song', piece.opus_number = 'H. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11256 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 18 Ah Tyrant Love

UPDATE pieces piece
SET piece.title = 'Ah Tyrant Love', piece.title_en = 'Ah Tyrant Love, H. 18',
    piece.type = 'song', piece.opus_number = 'H. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9580 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 45 Ah, Come, Fair Mistress

UPDATE pieces piece
SET piece.title = 'Ah, Come, Fair Mistress', piece.title_en = 'Ah, Come, Fair Mistress, H. 45',
    piece.type = 'song', piece.opus_number = 'H. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7901 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Air and Variations for Oboe and String Quartet

UPDATE pieces piece
SET piece.title = 'Air and Variations for Oboe and String Quartet', piece.title_en = 'Air and Variations for Oboe and String Quartet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10074 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 27 Airly Beacon

UPDATE pieces piece
SET piece.title = 'Airly Beacon', piece.title_en = 'Airly Beacon, H. 27',
    piece.type = 'song', piece.opus_number = 'H. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9825 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 12 All Night I Waited by the Spring

UPDATE pieces piece
SET piece.title = 'All Night I Waited by the Spring', piece.title_en = 'All Night I Waited by the Spring, H. 12',
    piece.type = 'song', piece.opus_number = 'H. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10527 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Arpeggio Study

UPDATE pieces piece
SET piece.title = 'Arpeggio Study', piece.title_en = 'Arpeggio Study',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10124 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 42 오페라 <At the Boar's Head>

UPDATE pieces piece
SET piece.title = '오페라 <At the Boar''s Head>', piece.title_en = 'At the Boar''s Head, op. 42',
    piece.type = 'song', piece.opus_number = 'Op. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8048 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 35 Autumn Song

UPDATE pieces piece
SET piece.title = 'Autumn Song', piece.title_en = 'Autumn Song, H. 35',
    piece.type = 'song', piece.opus_number = 'H. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10549 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 9b Ave Maria

UPDATE pieces piece
SET piece.title = 'Ave Maria', piece.title_en = 'Ave Maria, op. 9b',
    piece.type = 'song', piece.opus_number = 'Op. 9b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9605 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 29 No. 1 Beni Mora

UPDATE pieces piece
SET piece.title = 'Beni Mora', piece.title_en = 'Beni Mora, op. 29 no. 1',
    piece.type = 'album', piece.opus_number = 'Op. 29 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7610 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'First Dance', part.name_en = 'Beni Mora, op. 29 no. 1: I. First Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7610 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:240cb908-6d9d-446d-a9f7-46e335f4de76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:240cb908-6d9d-446d-a9f7-46e335f4de76', 1, 'I', 'First Dance', 'Beni Mora, op. 29 no. 1: I. First Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7610 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240cb908-6d9d-446d-a9f7-46e335f4de76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Second Dance', part.name_en = 'Beni Mora, op. 29 no. 1: II. Second Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7610 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:afb1c9eb-dcb8-4416-b8a5-41d99001eb2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afb1c9eb-dcb8-4416-b8a5-41d99001eb2c', 2, 'II', 'Second Dance', 'Beni Mora, op. 29 no. 1: II. Second Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7610 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afb1c9eb-dcb8-4416-b8a5-41d99001eb2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale: In the Street of Ouled Naïls', part.name_en = 'Beni Mora, op. 29 no. 1: III. Finale: In the Street of Ouled Naïls',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7610 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:164176b7-383c-4a3e-a96a-b3394f5a7242' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:164176b7-383c-4a3e-a96a-b3394f5a7242', 3, 'III', 'Finale: In the Street of Ouled Naïls', 'Beni Mora, op. 29 no. 1: III. Finale: In the Street of Ouled Naïls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7610 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:164176b7-383c-4a3e-a96a-b3394f5a7242'
);


-- H. 44 Bhanavar's Lament

UPDATE pieces piece
SET piece.title = 'Bhanavar''s Lament', piece.title_en = 'Bhanavar''s Lament, H. 44',
    piece.type = 'song', piece.opus_number = 'H. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11254 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 190 Brook Green Suite

UPDATE pieces piece
SET piece.title = 'Brook Green Suite', piece.title_en = 'Brook Green Suite, H. 190',
    piece.type = 'album', piece.opus_number = 'H. 190',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9370 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude', part.name_en = 'Brook Green Suite: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9370 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:999fbe99-1e83-3b03-b289-3fa18686ebb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:999fbe99-1e83-3b03-b289-3fa18686ebb4', 1, 'I', 'Prelude', 'Brook Green Suite: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9370 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:999fbe99-1e83-3b03-b289-3fa18686ebb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Air', part.name_en = 'Brook Green Suite: II. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9370 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4608afb4-cf42-3849-831c-02b7d107571f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4608afb4-cf42-3849-831c-02b7d107571f', 2, 'II', 'Air', 'Brook Green Suite: II. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9370 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4608afb4-cf42-3849-831c-02b7d107571f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dance', part.name_en = 'Brook Green Suite: III. Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9370 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:635b045c-4c60-33f4-907f-58e8fffcfcb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:635b045c-4c60-33f4-907f-58e8fffcfcb1', 3, 'III', 'Dance', 'Brook Green Suite: III. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9370 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:635b045c-4c60-33f4-907f-58e8fffcfcb1'
);


-- Op. 26 Choral Hymns from the Rig Veda Op. 26

UPDATE pieces piece
SET piece.title = 'Choral Hymns from the Rig Veda Op. 26', piece.title_en = 'Choral Hymns from the Rig Veda, op. 26',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '26',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10671 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'First Group, op. 26 no. 1', part.name_en = 'Choral Hymns from the Rig Veda: First Group, op. 26 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:cd7d05bc-2222-42da-abef-d2b032d229c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd7d05bc-2222-42da-abef-d2b032d229c9', 1, NULL, 'First Group, op. 26 no. 1', 'Choral Hymns from the Rig Veda: First Group, op. 26 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd7d05bc-2222-42da-abef-d2b032d229c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Second Group, op. 26 no. 2', part.name_en = 'Choral Hymns from the Rig Veda: Second Group, op. 26 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:87464c1f-5257-460f-958b-aee589f93db0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87464c1f-5257-460f-958b-aee589f93db0', 2, NULL, 'Second Group, op. 26 no. 2', 'Choral Hymns from the Rig Veda: Second Group, op. 26 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87464c1f-5257-460f-958b-aee589f93db0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87464c1f-5257-460f-958b-aee589f93db0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'To Varuna (God of the Waters)', part.name_en = 'Choral Hymns from the Rig Veda: Second Group, op. 26 no. 2: No. 1. To Varuna (God of the Waters)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:2c837f21-2e3b-49c9-9b88-7f049e2315bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c837f21-2e3b-49c9-9b88-7f049e2315bb', 1, NULL, 'To Varuna (God of the Waters)', 'Choral Hymns from the Rig Veda: Second Group, op. 26 no. 2: No. 1. To Varuna (God of the Waters)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87464c1f-5257-460f-958b-aee589f93db0'
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c837f21-2e3b-49c9-9b88-7f049e2315bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87464c1f-5257-460f-958b-aee589f93db0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'To Agni (God of Fire)', part.name_en = 'Choral Hymns from the Rig Veda: Second Group, op. 26 no. 2: No. 2. To Agni (God of Fire)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4602ac27-fdfb-452b-ad3f-c312e71d33fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4602ac27-fdfb-452b-ad3f-c312e71d33fa', 2, NULL, 'To Agni (God of Fire)', 'Choral Hymns from the Rig Veda: Second Group, op. 26 no. 2: No. 2. To Agni (God of Fire)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87464c1f-5257-460f-958b-aee589f93db0'
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4602ac27-fdfb-452b-ad3f-c312e71d33fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87464c1f-5257-460f-958b-aee589f93db0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Funeral Chant', part.name_en = 'Choral Hymns from the Rig Veda: Second Group, op. 26 no. 2: No. 3. Funeral Chant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:681076a5-a728-45be-b9bc-305e329570a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:681076a5-a728-45be-b9bc-305e329570a7', 3, NULL, 'Funeral Chant', 'Choral Hymns from the Rig Veda: Second Group, op. 26 no. 2: No. 3. Funeral Chant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87464c1f-5257-460f-958b-aee589f93db0'
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:681076a5-a728-45be-b9bc-305e329570a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Third Group, op. 26 no. 3', part.name_en = 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53', 3, NULL, 'Third Group, op. 26 no. 3', 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hymn to the Dawn', part.name_en = 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3: I. Hymn to the Dawn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:e87d6a5d-8ab7-4c23-83bf-3d005f4c7827' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e87d6a5d-8ab7-4c23-83bf-3d005f4c7827', 1, NULL, 'Hymn to the Dawn', 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3: I. Hymn to the Dawn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53'
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e87d6a5d-8ab7-4c23-83bf-3d005f4c7827'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hymn to the Waters', part.name_en = 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3: II. Hymn to the Waters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:60295459-0c60-49cd-bb41-d0a8e38c9266' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:60295459-0c60-49cd-bb41-d0a8e38c9266', 2, NULL, 'Hymn to the Waters', 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3: II. Hymn to the Waters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53'
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60295459-0c60-49cd-bb41-d0a8e38c9266'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Hymn to Vena', part.name_en = 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3: III. Hymn to Vena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:20100093-c72d-43f9-a309-b81a90fd62b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20100093-c72d-43f9-a309-b81a90fd62b2', 3, NULL, 'Hymn to Vena', 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3: III. Hymn to Vena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53'
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20100093-c72d-43f9-a309-b81a90fd62b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Hymn of the Travellers', part.name_en = 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3: IV. Hymn of the Travellers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:5da17162-e45a-407a-992d-ee0b8fa276c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5da17162-e45a-407a-992d-ee0b8fa276c6', 4, NULL, 'Hymn of the Travellers', 'Choral Hymns from the Rig Veda: Third Group, op. 26 no. 3: IV. Hymn of the Travellers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10e69855-35eb-477f-9597-caf7e4c34c53'
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5da17162-e45a-407a-992d-ee0b8fa276c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fourth Group, op. 26 no. 4', part.name_en = 'Choral Hymns from the Rig Veda: Fourth Group, op. 26 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10671 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:9ba70538-0b6e-4a7b-96d9-f1b845fa0bdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ba70538-0b6e-4a7b-96d9-f1b845fa0bdc', 4, NULL, 'Fourth Group, op. 26 no. 4', 'Choral Hymns from the Rig Veda: Fourth Group, op. 26 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10671 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ba70538-0b6e-4a7b-96d9-f1b845fa0bdc'
);


-- None Chrissemas Day in the Morning

UPDATE pieces piece
SET piece.title = 'Chrissemas Day in the Morning', piece.title_en = 'Chrissemas Day in the Morning',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10876 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Christ Hath a Garden

UPDATE pieces piece
SET piece.title = 'Christ Hath a Garden', piece.title_en = 'Christ Hath a Garden',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9515 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 5 Clear and Cool

UPDATE pieces piece
SET piece.title = 'Clear and Cool', piece.title_en = 'Clear and Cool, op. 5, H. 30',
    piece.type = 'song', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10299 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 40 Clouds o'er the Summer Sky, Canon

UPDATE pieces piece
SET piece.title = 'Clouds o''er the Summer Sky, Canon', piece.title_en = 'Clouds o''er the Summer Sky, Canon, H. 40',
    piece.type = 'song', piece.opus_number = 'H. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9635 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cranham

UPDATE pieces piece
SET piece.title = 'Cranham', piece.title_en = 'Cranham',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8813 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 72 가곡 <Darest Thou Now, O Soul>

UPDATE pieces piece
SET piece.title = '가곡 <Darest Thou Now, O Soul>', piece.title_en = 'Darest Thou Now, O Soul, H. 72',
    piece.type = 'song', piece.opus_number = 'H. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8586 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deux pièces

UPDATE pieces piece
SET piece.title = 'Deux pièces', piece.title_en = 'Deux pièces',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7614 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fancine', part.name_en = 'Deux pièces: No. 1. Fancine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7614 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:49e2c553-d518-42e9-ad63-6a594c501696' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49e2c553-d518-42e9-ad63-6a594c501696', 1, NULL, 'Fancine', 'Deux pièces: No. 1. Fancine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7614 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49e2c553-d518-42e9-ad63-6a594c501696'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deux pièces; No. 2. Lucille', part.name_en = 'Deux pièces; No. 2. Lucille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7614 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:a636cd0c-f032-4e31-a0b6-4a77800c7244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a636cd0c-f032-4e31-a0b6-4a77800c7244', 2, NULL, 'Deux pièces; No. 2. Lucille', 'Deux pièces; No. 2. Lucille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7614 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a636cd0c-f032-4e31-a0b6-4a77800c7244'
);


-- None Die Planeten

UPDATE pieces piece
SET piece.title = 'Die Planeten', piece.title_en = 'Die Planeten',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10408 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H 124 Dirge and Hymeneal

UPDATE pieces piece
SET piece.title = 'Dirge and Hymeneal', piece.title_en = 'Dirge and Hymeneal, H 124',
    piece.type = 'song', piece.opus_number = 'H 124',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9861 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 137 Diverus and Lazarus

UPDATE pieces piece
SET piece.title = 'Diverus and Lazarus', piece.title_en = 'Diverus and Lazarus, H. 137',
    piece.type = 'song', piece.opus_number = 'H. 137',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9925 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 49 Double Concerto for Two Violins & Small Orchestra

UPDATE pieces piece
SET piece.title = 'Double Concerto for Two Violins & Small Orchestra', piece.title_en = 'Double Concerto for Two Violins & Small Orchestra, op. 49',
    piece.type = 'album', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8615 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Scherzo', part.name_en = 'Double Concerto for Two Violins & Small Orchestra, op. 49: I. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8615 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:bb1b6a8b-1f62-44b8-a005-9c4cf3a36d0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb1b6a8b-1f62-44b8-a005-9c4cf3a36d0e', 1, 'I', 'Scherzo', 'Double Concerto for Two Violins & Small Orchestra, op. 49: I. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8615 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb1b6a8b-1f62-44b8-a005-9c4cf3a36d0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lament', part.name_en = 'Double Concerto for Two Violins & Small Orchestra, op. 49: II. Lament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8615 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:503635a3-3b31-4046-b46b-52d40283f17d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:503635a3-3b31-4046-b46b-52d40283f17d', 2, 'II', 'Lament', 'Double Concerto for Two Violins & Small Orchestra, op. 49: II. Lament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8615 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:503635a3-3b31-4046-b46b-52d40283f17d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Variations on a Ground', part.name_en = 'Double Concerto for Two Violins & Small Orchestra, op. 49: III. Variations on a Ground',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8615 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:647c52d0-8c66-43ca-a233-9386c1b537f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:647c52d0-8c66-43ca-a233-9386c1b537f4', 3, 'III', 'Variations on a Ground', 'Double Concerto for Two Violins & Small Orchestra, op. 49: III. Variations on a Ground', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8615 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:647c52d0-8c66-43ca-a233-9386c1b537f4'
);


-- H. 37 Draw Not Away Thy Hands

UPDATE pieces piece
SET piece.title = 'Draw Not Away Thy Hands', piece.title_en = 'Draw Not Away Thy Hands, H. 37',
    piece.type = 'song', piece.opus_number = 'H. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10875 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 6 2중창 D장조

UPDATE pieces piece
SET piece.title = '2중창 D장조', piece.title_en = 'Duet in D major, H. 6',
    piece.type = 'song', piece.opus_number = 'H. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9620 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Duo Concertante for trombone and organ

UPDATE pieces piece
SET piece.title = 'Duo Concertante for trombone and organ', piece.title_en = 'Duo Concertante for trombone and organ',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9008 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 47 Egdon Heath

UPDATE pieces piece
SET piece.title = 'Egdon Heath', piece.title_en = 'Egdon Heath, op. 47',
    piece.type = 'song', piece.opus_number = 'Op. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 529 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 187 Eight Canons H. 187

UPDATE pieces piece
SET piece.title = 'Eight Canons H. 187', piece.title_en = 'Eight Canons, H. 187',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '187',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8372 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Fields of Sorrow', part.name_en = 'Eight Canons, H. 187: 3. The Fields of Sorrow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8372 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:8321b726-55d9-43ac-93ec-0fc84e370610' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8321b726-55d9-43ac-93ec-0fc84e370610', 1, NULL, 'The Fields of Sorrow', 'Eight Canons, H. 187: 3. The Fields of Sorrow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8372 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8321b726-55d9-43ac-93ec-0fc84e370610'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'David''s Lament for Jonathan', part.name_en = 'Eight Canons, H. 187: 4. David''s Lament for Jonathan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8372 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c11fe47b-10bc-4bdd-8bfd-6b8cca3ea4d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c11fe47b-10bc-4bdd-8bfd-6b8cca3ea4d8', 2, NULL, 'David''s Lament for Jonathan', 'Eight Canons, H. 187: 4. David''s Lament for Jonathan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8372 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c11fe47b-10bc-4bdd-8bfd-6b8cca3ea4d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Truth of all Truth', part.name_en = 'Eight Canons, H. 187: 6. Truth of all Truth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8372 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:98b9440f-6e9d-41ec-bdb3-7a73e215b897' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b9440f-6e9d-41ec-bdb3-7a73e215b897', 3, NULL, 'Truth of all Truth', 'Eight Canons, H. 187: 6. Truth of all Truth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8372 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b9440f-6e9d-41ec-bdb3-7a73e215b897'
);


-- None Eternal Father

UPDATE pieces piece
SET piece.title = 'Eternal Father', piece.title_en = 'Eternal Father',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10880 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 2 Fantasiestücke Op. 2

UPDATE pieces piece
SET piece.title = 'Fantasiestücke Op. 2', piece.title_en = 'Fantasiestücke, op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11151 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'March', part.name_en = 'Fantasiestücke, op. 2: No. 1. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11151 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d9f65ddc-119a-470e-ac5e-95d87cf612e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9f65ddc-119a-470e-ac5e-95d87cf612e9', 1, NULL, 'March', 'Fantasiestücke, op. 2: No. 1. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11151 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9f65ddc-119a-470e-ac5e-95d87cf612e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Minuet', part.name_en = 'Fantasiestücke, op. 2: No. 2. Minuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11151 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d0f6052c-e246-4fd3-9278-254d8e4c7ff1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0f6052c-e246-4fd3-9278-254d8e4c7ff1', 2, NULL, 'Minuet', 'Fantasiestücke, op. 2: No. 2. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11151 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0f6052c-e246-4fd3-9278-254d8e4c7ff1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scherzo', part.name_en = 'Fantasiestücke, op. 2: No. 3. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11151 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:501fd324-980a-4953-9f40-24fdda7e14e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:501fd324-980a-4953-9f40-24fdda7e14e9', 3, NULL, 'Scherzo', 'Fantasiestücke, op. 2: No. 3. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11151 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:501fd324-980a-4953-9f40-24fdda7e14e9'
);


-- Op. 41 First Choral Symphony Op. 41

UPDATE pieces piece
SET piece.title = 'First Choral Symphony Op. 41', piece.title_en = 'First Choral Symphony, op. 41',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '41',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9286 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude: Invocation to Pan', part.name_en = 'First Choral Symphony, op. 41: I. Prelude: Invocation to Pan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9286 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:e215e556-1b51-4adb-bbbb-c0479adafcdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e215e556-1b51-4adb-bbbb-c0479adafcdd', 1, NULL, 'Prelude: Invocation to Pan', 'First Choral Symphony, op. 41: I. Prelude: Invocation to Pan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9286 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e215e556-1b51-4adb-bbbb-c0479adafcdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Song and Bacchanal', part.name_en = 'First Choral Symphony, op. 41: II. Song and Bacchanal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9286 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:6c4713c0-2fa9-4516-be73-e5de49aa2645' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c4713c0-2fa9-4516-be73-e5de49aa2645', 2, NULL, 'Song and Bacchanal', 'First Choral Symphony, op. 41: II. Song and Bacchanal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9286 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c4713c0-2fa9-4516-be73-e5de49aa2645'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ode on a Grecian Urn', part.name_en = 'First Choral Symphony, op. 41: III. Ode on a Grecian Urn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9286 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:9f56b706-00fe-4c6d-9652-a5dddbc769b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f56b706-00fe-4c6d-9652-a5dddbc769b0', 3, NULL, 'Ode on a Grecian Urn', 'First Choral Symphony, op. 41: III. Ode on a Grecian Urn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9286 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f56b706-00fe-4c6d-9652-a5dddbc769b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scherzo: Fancy', part.name_en = 'First Choral Symphony, op. 41: IV. Scherzo: Fancy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9286 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:096724a4-d522-40ab-b4fe-a1447039f99b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:096724a4-d522-40ab-b4fe-a1447039f99b', 4, NULL, 'Scherzo: Fancy', 'First Choral Symphony, op. 41: IV. Scherzo: Fancy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9286 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:096724a4-d522-40ab-b4fe-a1447039f99b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Folly’s Song', part.name_en = 'First Choral Symphony, op. 41: V. Folly’s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9286 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:bb2da22c-2f96-471d-adfb-db33e0a9a0d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb2da22c-2f96-471d-adfb-db33e0a9a0d5', 5, NULL, 'Folly’s Song', 'First Choral Symphony, op. 41: V. Folly’s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9286 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb2da22c-2f96-471d-adfb-db33e0a9a0d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI: Finale', part.name_en = 'First Choral Symphony, op. 41: VI: Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9286 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:5bcc4414-e7f4-4ac0-b8c7-a5c11d9af809' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bcc4414-e7f4-4ac0-b8c7-a5c11d9af809', 6, NULL, 'VI: Finale', 'First Choral Symphony, op. 41: VI: Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9286 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bcc4414-e7f4-4ac0-b8c7-a5c11d9af809'
);


-- Op. 28 No. 1 First Suite in E-flat for Military Band

UPDATE pieces piece
SET piece.title = 'First Suite in E-flat for Military Band', piece.title_en = 'First Suite in E-flat for Military Band, op. 28 no. 1',
    piece.type = 'album', piece.opus_number = 'Op. 28 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10951 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Chaconne', part.name_en = 'First Suite in E-flat for Military Band, op. 28 no. 1: I. Chaconne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10951 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:56346ce1-1920-31ae-9e6f-bd37fe8212bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56346ce1-1920-31ae-9e6f-bd37fe8212bd', 1, 'I', 'Chaconne', 'First Suite in E-flat for Military Band, op. 28 no. 1: I. Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10951 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56346ce1-1920-31ae-9e6f-bd37fe8212bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo', part.name_en = 'First Suite in E-flat for Military Band, op. 28 no. 1: II. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10951 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:b58d8d76-c489-311b-af0a-aa3a730d5300' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b58d8d76-c489-311b-af0a-aa3a730d5300', 2, 'II', 'Intermezzo', 'First Suite in E-flat for Military Band, op. 28 no. 1: II. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10951 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b58d8d76-c489-311b-af0a-aa3a730d5300'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'March', part.name_en = 'First Suite in E-flat for Military Band, op. 28 no. 1: III. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10951 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:26f268c6-833e-3489-abef-55a229142e55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26f268c6-833e-3489-abef-55a229142e55', 3, 'III', 'March', 'First Suite in E-flat for Military Band, op. 28 no. 1: III. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10951 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26f268c6-833e-3489-abef-55a229142e55'
);


-- H. 161 4개의 찬가 H. 161

UPDATE pieces piece
SET piece.title = '4개의 찬가 H. 161', piece.title_en = 'Four Hymns for Songs of Praise, H. 161',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '161',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8254 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'In This World, the Isle of Dreams', part.name_en = 'In This World, the Isle of Dreams',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8254 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1a1694c7-7e20-4e47-b019-3be572c66ab8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a1694c7-7e20-4e47-b019-3be572c66ab8', 1, NULL, 'In This World, the Isle of Dreams', 'In This World, the Isle of Dreams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8254 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a1694c7-7e20-4e47-b019-3be572c66ab8'
);


-- Op. 20b Four Old English Carols Op. 20b

UPDATE pieces piece
SET piece.title = 'Four Old English Carols Op. 20b', piece.title_en = 'Four Old English Carols, op. 20b',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '20b',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10624 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A Babe Is Born', part.name_en = 'Four Old English Carols, op. 20b: No. 1. A Babe Is Born',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10624 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c9a022ec-c130-4c71-9a0f-e1b37192a7fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9a022ec-c130-4c71-9a0f-e1b37192a7fa', 1, NULL, 'A Babe Is Born', 'Four Old English Carols, op. 20b: No. 1. A Babe Is Born', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10624 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9a022ec-c130-4c71-9a0f-e1b37192a7fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Now Let Us Sing', part.name_en = 'Four Old English Carols, op. 20b: No. 2. Now Let Us Sing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10624 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:dd9fc911-7826-475f-b346-08cdd819a066' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd9fc911-7826-475f-b346-08cdd819a066', 2, NULL, 'Now Let Us Sing', 'Four Old English Carols, op. 20b: No. 2. Now Let Us Sing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10624 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd9fc911-7826-475f-b346-08cdd819a066'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jesu, Thou the Virgin-Born', part.name_en = 'Four Old English Carols, op. 20b: No. 3. Jesu, Thou the Virgin-Born',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10624 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:ad199b7a-5e62-4b19-a532-a61de2cb2f07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad199b7a-5e62-4b19-a532-a61de2cb2f07', 3, NULL, 'Jesu, Thou the Virgin-Born', 'Four Old English Carols, op. 20b: No. 3. Jesu, Thou the Virgin-Born', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10624 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad199b7a-5e62-4b19-a532-a61de2cb2f07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Saviour of the World Is Born', part.name_en = 'Four Old English Carols, op. 20b: No. 4. The Saviour of the World Is Born',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10624 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4f35b685-00a9-4daa-a0ee-e3d9a92a0b28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f35b685-00a9-4daa-a0ee-e3d9a92a0b28', 4, NULL, 'The Saviour of the World Is Born', 'Four Old English Carols, op. 20b: No. 4. The Saviour of the World Is Born', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10624 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f35b685-00a9-4daa-a0ee-e3d9a92a0b28'
);


-- Op. 35 4개의 가곡 Op. 35

UPDATE pieces piece
SET piece.title = '4개의 가곡 Op. 35', piece.title_en = 'Four Songs, op. 35, H. 132',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '35',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9810 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jesu Sweet, now will I sing', part.name_en = 'Four Songs, op. 35, H. 132: 1. Jesu Sweet, now will I sing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9810 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:0acc6113-08fc-4a8d-b87d-a387e87bca9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0acc6113-08fc-4a8d-b87d-a387e87bca9c', 1, NULL, 'Jesu Sweet, now will I sing', 'Four Songs, op. 35, H. 132: 1. Jesu Sweet, now will I sing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9810 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0acc6113-08fc-4a8d-b87d-a387e87bca9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'My soul has nought but fire and ice', part.name_en = 'Four Songs, op. 35, H. 132: 2. My soul has nought but fire and ice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9810 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:b57edd89-2d76-4c14-a7e5-9b0222c9d3c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b57edd89-2d76-4c14-a7e5-9b0222c9d3c0', 2, NULL, 'My soul has nought but fire and ice', 'Four Songs, op. 35, H. 132: 2. My soul has nought but fire and ice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9810 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b57edd89-2d76-4c14-a7e5-9b0222c9d3c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'I sing of a maiden that matchless is', part.name_en = 'Four Songs, op. 35, H. 132: 3. I sing of a maiden that matchless is',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9810 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:5f75716d-2cfe-4121-a0f4-fe7f347da3bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f75716d-2cfe-4121-a0f4-fe7f347da3bd', 3, NULL, 'I sing of a maiden that matchless is', 'Four Songs, op. 35, H. 132: 3. I sing of a maiden that matchless is', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9810 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f75716d-2cfe-4121-a0f4-fe7f347da3bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'My Leman is so true', part.name_en = 'Four Songs, op. 35, H. 132: 4. My Leman is so true',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9810 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d14f527b-d30b-4661-8164-d73fe05d2975' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d14f527b-d30b-4661-8164-d73fe05d2975', 4, NULL, 'My Leman is so true', 'Four Songs, op. 35, H. 132: 4. My Leman is so true', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9810 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d14f527b-d30b-4661-8164-d73fe05d2975'
);


-- H. 190a 가보트

UPDATE pieces piece
SET piece.title = '가보트', piece.title_en = 'Gavotte, H. 190a',
    piece.type = 'song', piece.opus_number = 'H. 190a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9590 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 81 가곡 <Home They Brought Her Warrior Dead>

UPDATE pieces piece
SET piece.title = '가곡 <Home They Brought Her Warrior Dead>', piece.title_en = 'Home They Brought Her Warrior Dead, H. 81',
    piece.type = 'song', piece.opus_number = 'H. 81',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8485 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 31 No. 2 Hymn to Dionysus

UPDATE pieces piece
SET piece.title = 'Hymn to Dionysus', piece.title_en = 'Hymn to Dionysus, op. 31 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 31 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10011 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 24 Hymns From the Rig Veda Op. 24

UPDATE pieces piece
SET piece.title = 'Hymns From the Rig Veda Op. 24', piece.title_en = 'Hymns From the Rig Veda, op. 24, H. 90',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '24',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8241 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ushas (Dawn)', part.name_en = 'Hymns From the Rig Veda, op. 24, H. 90: 1. Ushas (Dawn)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8241 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:75b14b20-493b-4761-a134-200d9591c589' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75b14b20-493b-4761-a134-200d9591c589', 1, NULL, 'Ushas (Dawn)', 'Hymns From the Rig Veda, op. 24, H. 90: 1. Ushas (Dawn)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8241 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75b14b20-493b-4761-a134-200d9591c589'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Varuna I (Sky)', part.name_en = 'Hymns From the Rig Veda, op. 24, H. 90: 2. Varuna I (Sky)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8241 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:a089d400-b0ea-4521-b921-1027666cde00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a089d400-b0ea-4521-b921-1027666cde00', 2, NULL, 'Varuna I (Sky)', 'Hymns From the Rig Veda, op. 24, H. 90: 2. Varuna I (Sky)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8241 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a089d400-b0ea-4521-b921-1027666cde00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Maruts (Stormclouds)', part.name_en = 'Hymns From the Rig Veda, op. 24, H. 90: 3. Maruts (Stormclouds)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8241 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:47f169db-947b-4b25-b08f-dac8ab49e87c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47f169db-947b-4b25-b08f-dac8ab49e87c', 3, NULL, 'Maruts (Stormclouds)', 'Hymns From the Rig Veda, op. 24, H. 90: 3. Maruts (Stormclouds)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8241 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f169db-947b-4b25-b08f-dac8ab49e87c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Indra (God of Storm and Battle)', part.name_en = 'Hymns From the Rig Veda, op. 24, H. 90: 4. Indra (God of Storm and Battle)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8241 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:fc306b8e-eb5a-44b3-931b-f0720c523ede' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc306b8e-eb5a-44b3-931b-f0720c523ede', 4, NULL, 'Indra (God of Storm and Battle)', 'Hymns From the Rig Veda, op. 24, H. 90: 4. Indra (God of Storm and Battle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8241 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc306b8e-eb5a-44b3-931b-f0720c523ede'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Varuna II (The Waters)', part.name_en = 'Hymns From the Rig Veda, op. 24, H. 90: 5. Varuna II (The Waters)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8241 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:0a662774-0cb3-4c70-a7b6-b980f360f7a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a662774-0cb3-4c70-a7b6-b980f360f7a8', 5, NULL, 'Varuna II (The Waters)', 'Hymns From the Rig Veda, op. 24, H. 90: 5. Varuna II (The Waters)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8241 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a662774-0cb3-4c70-a7b6-b980f360f7a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Song of the Frogs', part.name_en = 'Hymns From the Rig Veda, op. 24, H. 90: 6. Song of the Frogs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8241 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4cb5b691-9b4b-45c1-8f0d-520ea94c7e06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cb5b691-9b4b-45c1-8f0d-520ea94c7e06', 6, NULL, 'Song of the Frogs', 'Hymns From the Rig Veda, op. 24, H. 90: 6. Song of the Frogs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8241 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cb5b691-9b4b-45c1-8f0d-520ea94c7e06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vac (Speech)', part.name_en = 'Hymns From the Rig Veda, op. 24, H. 90: 7. Vac (Speech)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8241 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7bfbc022-778e-4df6-aab5-e8396f1c9386' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bfbc022-778e-4df6-aab5-e8396f1c9386', 7, NULL, 'Vac (Speech)', 'Hymns From the Rig Veda, op. 24, H. 90: 7. Vac (Speech)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8241 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bfbc022-778e-4df6-aab5-e8396f1c9386'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Creation', part.name_en = 'Hymns From the Rig Veda, op. 24, H. 90: 8. Creation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8241 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:240f653b-a3d6-476f-ad62-f60af0b58cb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:240f653b-a3d6-476f-ad62-f60af0b58cb3', 8, NULL, 'Creation', 'Hymns From the Rig Veda, op. 24, H. 90: 8. Creation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8241 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240f653b-a3d6-476f-ad62-f60af0b58cb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Faith (Sraddha)', part.name_en = 'Hymns From the Rig Veda, op. 24, H. 90: 9. Faith (Sraddha)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8241 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:bc6e3ded-a796-466c-89d5-df5a224d5cef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc6e3ded-a796-466c-89d5-df5a224d5cef', 9, NULL, 'Faith (Sraddha)', 'Hymns From the Rig Veda, op. 24, H. 90: 9. Faith (Sraddha)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8241 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc6e3ded-a796-466c-89d5-df5a224d5cef'
);


-- H. 38 I Scanned Her Picture

UPDATE pieces piece
SET piece.title = 'I Scanned Her Picture', piece.title_en = 'I Scanned Her Picture, H. 38',
    piece.type = 'song', piece.opus_number = 'H. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10441 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Vow to Thee, My Country

UPDATE pieces piece
SET piece.title = 'I Vow to Thee, My Country', piece.title_en = 'I Vow to Thee, My Country',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1746 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Youth Is Pleasure

UPDATE pieces piece
SET piece.title = 'In Youth Is Pleasure', piece.title_en = 'In Youth Is Pleasure',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7854 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 13 Indra

UPDATE pieces piece
SET piece.title = 'Indra', piece.title_en = 'Indra, op. 13, H. 66',
    piece.type = 'song', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8634 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19 No. 2 Invocation

UPDATE pieces piece
SET piece.title = 'Invocation', piece.title_en = 'Invocation, op. 19 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 19 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9966 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 33 Japanese Suite

UPDATE pieces piece
SET piece.title = 'Japanese Suite', piece.title_en = 'Japanese Suite, op. 33, H. 126',
    piece.type = 'album', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8136 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude: Song of the Fisherman', part.name_en = 'Japanese Suite, op. 33, H. 126: I. Prelude: Song of the Fisherman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8136 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7471d84a-2795-4bab-929a-cb950bce6d83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7471d84a-2795-4bab-929a-cb950bce6d83', 1, 'I', 'Prelude: Song of the Fisherman', 'Japanese Suite, op. 33, H. 126: I. Prelude: Song of the Fisherman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8136 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7471d84a-2795-4bab-929a-cb950bce6d83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ceremonial Dance', part.name_en = 'Japanese Suite, op. 33, H. 126: II. Ceremonial Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8136 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1e9106af-a214-4ad1-97d9-7a1d62f6f97a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e9106af-a214-4ad1-97d9-7a1d62f6f97a', 2, 'II', 'Ceremonial Dance', 'Japanese Suite, op. 33, H. 126: II. Ceremonial Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8136 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e9106af-a214-4ad1-97d9-7a1d62f6f97a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dance of the Marionette', part.name_en = 'Japanese Suite, op. 33, H. 126: III. Dance of the Marionette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8136 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c85c5982-802e-4dc4-ae6d-bb1358694221' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c85c5982-802e-4dc4-ae6d-bb1358694221', 3, 'III', 'Dance of the Marionette', 'Japanese Suite, op. 33, H. 126: III. Dance of the Marionette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8136 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c85c5982-802e-4dc4-ae6d-bb1358694221'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Interlude: Song of the Fisherman', part.name_en = 'Japanese Suite, op. 33, H. 126: IV. Interlude: Song of the Fisherman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8136 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:07454190-77b5-4048-8a4b-eca406ecefff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07454190-77b5-4048-8a4b-eca406ecefff', 4, 'IV', 'Interlude: Song of the Fisherman', 'Japanese Suite, op. 33, H. 126: IV. Interlude: Song of the Fisherman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8136 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07454190-77b5-4048-8a4b-eca406ecefff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dance Under the Cherry Tree', part.name_en = 'Japanese Suite, op. 33, H. 126: V. Dance Under the Cherry Tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8136 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:44531374-4e16-479a-a5eb-b53251b093a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44531374-4e16-479a-a5eb-b53251b093a6', 5, 'V', 'Dance Under the Cherry Tree', 'Japanese Suite, op. 33, H. 126: V. Dance Under the Cherry Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8136 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44531374-4e16-479a-a5eb-b53251b093a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Finale: Dance of the Wolves', part.name_en = 'Japanese Suite, op. 33, H. 126: VI. Finale: Dance of the Wolves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8136 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:b747172c-5db2-446d-8403-ef6a49da8eac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b747172c-5db2-446d-8403-ef6a49da8eac', 6, 'VI', 'Finale: Dance of the Wolves', 'Japanese Suite, op. 33, H. 126: VI. Finale: Dance of the Wolves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8136 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b747172c-5db2-446d-8403-ef6a49da8eac'
);


-- None Journey's End

UPDATE pieces piece
SET piece.title = 'Journey''s End', piece.title_en = 'Journey''s End',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8177 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jupiter, Bringer Of Jollity (From The Planet Opus 32) (Excerpt)

UPDATE pieces piece
SET piece.title = 'Jupiter, Bringer Of Jollity (From The Planet Opus 32) (Excerpt)', piece.title_en = 'Jupiter, Bringer Of Jollity (From The Planet Opus 32) (Excerpt)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8795 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 51 Lied ohne Worte

UPDATE pieces piece
SET piece.title = 'Lied ohne Worte', piece.title_en = 'Lied ohne Worte, H. 51',
    piece.type = 'song', piece.opus_number = 'H. 51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8352 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Light Leaves Whisper

UPDATE pieces piece
SET piece.title = 'Light Leaves Whisper', piece.title_en = 'Light Leaves Whisper',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8785 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 191 Lyric Movement for Viola and Small Orchestra

UPDATE pieces piece
SET piece.title = 'Lyric Movement for Viola and Small Orchestra', piece.title_en = 'Lyric Movement for Viola and Small Orchestra, H. 191',
    piece.type = 'song', piece.opus_number = 'H. 191',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9344 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 53 Ländler

UPDATE pieces piece
SET piece.title = 'Ländler', piece.title_en = 'Ländler, H. 53',
    piece.type = 'song', piece.opus_number = 'H. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9800 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Man Born to Toil

UPDATE pieces piece
SET piece.title = 'Man Born to Toil', piece.title_en = 'Man Born to Toil',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11260 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Masters in This Hall

UPDATE pieces piece
SET piece.title = 'Masters in This Hall', piece.title_en = 'Masters in This Hall',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9752 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 55 Maya

UPDATE pieces piece
SET piece.title = 'Maya', piece.title_en = 'Maya, H. 55',
    piece.type = 'song', piece.opus_number = 'H. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10922 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Morris Dance Tunes

UPDATE pieces piece
SET piece.title = 'Morris Dance Tunes', piece.title_en = 'Morris Dance Tunes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8141 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Set 1: 1. Bean Setting', part.name_en = 'Morris Dance Tunes, Set 1: 1. Bean Setting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8141 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:ad9b1aeb-6adc-4752-bf41-461f1fd6f1c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad9b1aeb-6adc-4752-bf41-461f1fd6f1c5', 1, NULL, 'Set 1: 1. Bean Setting', 'Morris Dance Tunes, Set 1: 1. Bean Setting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8141 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad9b1aeb-6adc-4752-bf41-461f1fd6f1c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Set 1: 2. Laudnum Bunches', part.name_en = 'Morris Dance Tunes, Set 1: 2. Laudnum Bunches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8141 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:ec1f182f-685e-4c0b-bc1b-95ade2f8e94e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec1f182f-685e-4c0b-bc1b-95ade2f8e94e', 2, NULL, 'Set 1: 2. Laudnum Bunches', 'Morris Dance Tunes, Set 1: 2. Laudnum Bunches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8141 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec1f182f-685e-4c0b-bc1b-95ade2f8e94e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Set 1: 3. Country Gardens', part.name_en = 'Morris Dance Tunes, Set 1: 3. Country Gardens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8141 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:f68a9580-e8ea-4a5f-b4bc-af8b6705ed57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f68a9580-e8ea-4a5f-b4bc-af8b6705ed57', 3, NULL, 'Set 1: 3. Country Gardens', 'Morris Dance Tunes, Set 1: 3. Country Gardens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8141 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f68a9580-e8ea-4a5f-b4bc-af8b6705ed57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Set 1: 5. Trunkles', part.name_en = 'Morris Dance Tunes, Set 1: 5. Trunkles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8141 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:aada96e6-2237-4609-a0ce-664f526a2072' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aada96e6-2237-4609-a0ce-664f526a2072', 4, NULL, 'Set 1: 5. Trunkles', 'Morris Dance Tunes, Set 1: 5. Trunkles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8141 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aada96e6-2237-4609-a0ce-664f526a2072'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Set 2: 1. Rigs O''Marlow', part.name_en = 'Morris Dance Tunes, Set 2: 1. Rigs O''Marlow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8141 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:379d4eeb-a033-483c-9f37-5146f08d3bd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:379d4eeb-a033-483c-9f37-5146f08d3bd3', 5, NULL, 'Set 2: 1. Rigs O''Marlow', 'Morris Dance Tunes, Set 2: 1. Rigs O''Marlow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8141 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:379d4eeb-a033-483c-9f37-5146f08d3bd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Set 2: 3. How D''ye Do', part.name_en = 'Morris Dance Tunes, Set 2: 3. How D''ye Do',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8141 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:48db2f5a-3cef-4767-9253-94ab299ed945' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48db2f5a-3cef-4767-9253-94ab299ed945', 6, NULL, 'Set 2: 3. How D''ye Do', 'Morris Dance Tunes, Set 2: 3. How D''ye Do', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8141 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48db2f5a-3cef-4767-9253-94ab299ed945'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Set 2: 4. Shepherd’s Hey', part.name_en = 'Morris Dance Tunes, Set 2: 4. Shepherd’s Hey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8141 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:0c3623e7-d159-4493-998b-f630d5587f15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c3623e7-d159-4493-998b-f630d5587f15', 7, NULL, 'Set 2: 4. Shepherd’s Hey', 'Morris Dance Tunes, Set 2: 4. Shepherd’s Hey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8141 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c3623e7-d159-4493-998b-f630d5587f15'
);


-- H. 36 My Joy

UPDATE pieces piece
SET piece.title = 'My Joy', piece.title_en = 'My Joy, H. 36',
    piece.type = 'song', piece.opus_number = 'H. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10605 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 22 Not Unto Us, O Lord

UPDATE pieces piece
SET piece.title = 'Not Unto Us, O Lord', piece.title_en = 'Not Unto Us, O Lord, H. 22',
    piece.type = 'song', piece.opus_number = 'H. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9445 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 32 Not a Sound But Echoing in Me

UPDATE pieces piece
SET piece.title = 'Not a Sound But Echoing in Me', piece.title_en = 'Not a Sound But Echoing in Me, H. 32',
    piece.type = 'song', piece.opus_number = 'H. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8093 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nunc dimittis

UPDATE pieces piece
SET piece.title = 'Nunc dimittis', piece.title_en = 'Nunc dimittis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9619 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O Spiritual Pilgrim

UPDATE pieces piece
SET piece.title = 'O Spiritual Pilgrim', piece.title_en = 'O Spiritual Pilgrim',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10489 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 24 O Spring's Little Children

UPDATE pieces piece
SET piece.title = 'O Spring''s Little Children', piece.title_en = 'O Spring''s Little Children, H. 24',
    piece.type = 'song', piece.opus_number = 'H. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10326 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38 Ode to Death

UPDATE pieces piece
SET piece.title = 'Ode to Death', piece.title_en = 'Ode to Death, op. 38',
    piece.type = 'song', piece.opus_number = 'Op. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10815 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Our Blest Redeemer

UPDATE pieces piece
SET piece.title = 'Our Blest Redeemer', piece.title_en = 'Our Blest Redeemer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9564 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Phantasy Quartet on British Folksongs

UPDATE pieces piece
SET piece.title = 'Phantasy Quartet on British Folksongs', piece.title_en = 'Phantasy Quartet on British Folksongs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9176 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 118a Playground Song

UPDATE pieces piece
SET piece.title = 'Playground Song', piece.title_en = 'Playground Song, H. 118a',
    piece.type = 'song', piece.opus_number = 'H. 118a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8236 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 5중주 A단조

UPDATE pieces piece
SET piece.title = '5중주 A단조', piece.title_en = 'Quintet in A minor, op. 3',
    piece.type = 'album', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9869 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Quintet in A minor, op. 3: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9869 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:9db230b8-71f6-45ac-8bc4-c45854d7d937' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9db230b8-71f6-45ac-8bc4-c45854d7d937', 1, 'I', 'Allegro moderato', 'Quintet in A minor, op. 3: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9869 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9db230b8-71f6-45ac-8bc4-c45854d7d937'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo, Allegro vivace', part.name_en = 'Quintet in A minor, op. 3: II. Scherzo, Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9869 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:b590bc12-9fe3-4b86-99d4-20e1dde08381' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b590bc12-9fe3-4b86-99d4-20e1dde08381', 2, 'II', 'Scherzo, Allegro vivace', 'Quintet in A minor, op. 3: II. Scherzo, Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9869 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b590bc12-9fe3-4b86-99d4-20e1dde08381'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'Quintet in A minor, op. 3: III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9869 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d1ae2156-2b25-49fd-a6c6-db75c6fc2a1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1ae2156-2b25-49fd-a6c6-db75c6fc2a1a', 3, 'III', 'Adagio', 'Quintet in A minor, op. 3: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9869 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1ae2156-2b25-49fd-a6c6-db75c6fc2a1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio', part.name_en = 'Quintet in A minor, op. 3: IV. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9869 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:611ae2f7-50d4-44ac-b741-535c7b3309f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:611ae2f7-50d4-44ac-b741-535c7b3309f9', 4, 'IV', 'Allegro con brio', 'Quintet in A minor, op. 3: IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9869 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:611ae2f7-50d4-44ac-b741-535c7b3309f9'
);


-- H. 192 스케르초

UPDATE pieces piece
SET piece.title = '스케르초', piece.title_en = 'Scherzo, H. 192',
    piece.type = 'song', piece.opus_number = 'H. 192',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8247 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 23 스케르초 H. 23

UPDATE pieces piece
SET piece.title = '스케르초 H. 23', piece.title_en = 'Scherzo, H. 23',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '23',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8045 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 28 No. 2 Second Suite in F for Military Band

UPDATE pieces piece
SET piece.title = 'Second Suite in F for Military Band', piece.title_en = 'Second Suite in F for Military Band, op. 28 no. 2',
    piece.type = 'album', piece.opus_number = 'Op. 28 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8517 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'March: Morris dance, Swansea Town, Claudy Banks', part.name_en = 'Second Suite in F for Military Band, op. 28 no. 2: I. March: Morris dance, Swansea Town, Claudy Banks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8517 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4841870f-dabf-3794-9baa-80b7d6a5150b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4841870f-dabf-3794-9baa-80b7d6a5150b', 1, 'I', 'March: Morris dance, Swansea Town, Claudy Banks', 'Second Suite in F for Military Band, op. 28 no. 2: I. March: Morris dance, Swansea Town, Claudy Banks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8517 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4841870f-dabf-3794-9baa-80b7d6a5150b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Song Without Words, ''I''ll Love My Love''', part.name_en = 'Second Suite in F for Military Band, op. 28 no. 2: II. Song Without Words, ''I''ll Love My Love''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8517 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c2883900-dfbe-380e-9401-bf17c7ec49b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2883900-dfbe-380e-9401-bf17c7ec49b7', 2, 'II', 'Song Without Words, ''I''ll Love My Love''', 'Second Suite in F for Military Band, op. 28 no. 2: II. Song Without Words, ''I''ll Love My Love''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8517 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2883900-dfbe-380e-9401-bf17c7ec49b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Song of the Blacksmith', part.name_en = 'Second Suite in F for Military Band, op. 28 no. 2: III. Song of the Blacksmith',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8517 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:62669a3e-8709-3145-9733-2969846e51c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62669a3e-8709-3145-9733-2969846e51c2', 3, 'III', 'Song of the Blacksmith', 'Second Suite in F for Military Band, op. 28 no. 2: III. Song of the Blacksmith', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8517 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62669a3e-8709-3145-9733-2969846e51c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fantasia on the "Dargason"', part.name_en = 'Second Suite in F for Military Band, op. 28 no. 2: IV. Fantasia on the "Dargason"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8517 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7df0f06f-9a05-37fc-a2e1-ca16d565b770' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7df0f06f-9a05-37fc-a2e1-ca16d565b770', 4, 'IV', 'Fantasia on the "Dargason"', 'Second Suite in F for Military Band, op. 28 no. 2: IV. Fantasia on the "Dargason"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8517 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7df0f06f-9a05-37fc-a2e1-ca16d565b770'
);


-- Op. 44 7개의 합창곡

UPDATE pieces piece
SET piece.title = '7개의 합창곡', piece.title_en = 'Seven Part-Songs, op. 44',
    piece.type = 'album', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10255 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Say, Who Is This', part.name_en = 'Seven Part-Songs, op. 44: I. Say, Who Is This',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10255 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d5c222e5-051c-418f-a9fe-3f06fdb593c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5c222e5-051c-418f-a9fe-3f06fdb593c5', 1, 'I', 'Say, Who Is This', 'Seven Part-Songs, op. 44: I. Say, Who Is This', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10255 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5c222e5-051c-418f-a9fe-3f06fdb593c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Of Love I Complain', part.name_en = 'Seven Part-Songs, op. 44: II. Of Love I Complain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10255 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d062e48c-0716-4369-9f36-0583cfaa8460' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d062e48c-0716-4369-9f36-0583cfaa8460', 2, 'II', 'Of Love I Complain', 'Seven Part-Songs, op. 44: II. Of Love I Complain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10255 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d062e48c-0716-4369-9f36-0583cfaa8460'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Angel Spirits of Sleep', part.name_en = 'Seven Part-Songs, op. 44: III. Angel Spirits of Sleep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10255 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4e131358-f38e-4c27-9a71-e5acbd08cb42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e131358-f38e-4c27-9a71-e5acbd08cb42', 3, 'III', 'Angel Spirits of Sleep', 'Seven Part-Songs, op. 44: III. Angel Spirits of Sleep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10255 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e131358-f38e-4c27-9a71-e5acbd08cb42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'When First We Meet', part.name_en = 'Seven Part-Songs, op. 44: IV. When First We Meet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10255 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:0e095bd5-4158-4874-9b62-c090603acfa4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e095bd5-4158-4874-9b62-c090603acfa4', 4, 'IV', 'When First We Meet', 'Seven Part-Songs, op. 44: IV. When First We Meet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10255 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e095bd5-4158-4874-9b62-c090603acfa4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sorrow and Joy', part.name_en = 'Seven Part-Songs, op. 44: V. Sorrow and Joy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10255 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:070f8520-ffa7-4bc0-8540-282c36791ec7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:070f8520-ffa7-4bc0-8540-282c36791ec7', 5, 'V', 'Sorrow and Joy', 'Seven Part-Songs, op. 44: V. Sorrow and Joy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10255 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:070f8520-ffa7-4bc0-8540-282c36791ec7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Love On My Heart', part.name_en = 'Seven Part-Songs, op. 44: VI. Love On My Heart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10255 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c6a1705c-2482-40af-9f1e-9ceeb986cb6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6a1705c-2482-40af-9f1e-9ceeb986cb6f', 6, 'VI', 'Love On My Heart', 'Seven Part-Songs, op. 44: VI. Love On My Heart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10255 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6a1705c-2482-40af-9f1e-9ceeb986cb6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Assemble, All Ye Maidens', part.name_en = 'Seven Part-Songs, op. 44: VII. Assemble, All Ye Maidens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10255 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1b3612cd-6f29-445a-a581-cde2b2c76e1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b3612cd-6f29-445a-a581-cde2b2c76e1d', 7, 'VII', 'Assemble, All Ye Maidens', 'Seven Part-Songs, op. 44: VII. Assemble, All Ye Maidens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10255 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b3612cd-6f29-445a-a581-cde2b2c76e1d'
);


-- None Seven Scottish Airs

UPDATE pieces piece
SET piece.title = 'Seven Scottish Airs', piece.title_en = 'Seven Scottish Airs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10117 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 10 6중주 E단조

UPDATE pieces piece
SET piece.title = '6중주 E단조', piece.title_en = 'Sextet in E minor, H. 10',
    piece.type = 'song', piece.opus_number = 'H. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11290 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Short Festival Te Deum

UPDATE pieces piece
SET piece.title = 'Short Festival Te Deum', piece.title_en = 'Short Festival Te Deum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9160 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 26 Sing Heigh-Ho!

UPDATE pieces piece
SET piece.title = 'Sing Heigh-Ho!', piece.title_en = 'Sing Heigh-Ho!, H. 26',
    piece.type = 'song', piece.opus_number = 'H. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8883 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 89 오페라 <Sita> Op. 89

UPDATE pieces piece
SET piece.title = '오페라 <Sita> Op. 89', piece.title_en = 'Sita, op. 89, H. 89',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '89',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11023 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Sita, op. 89: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11023 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:a9580a5e-6b70-4b36-b0ed-be589ea76d73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9580a5e-6b70-4b36-b0ed-be589ea76d73', 1, NULL, 'Act I', 'Sita, op. 89: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11023 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9580a5e-6b70-4b36-b0ed-be589ea76d73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Sita, op. 89: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11023 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:ed2a254d-8e76-4885-bf1b-1383b8e14348' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed2a254d-8e76-4885-bf1b-1383b8e14348', 2, NULL, 'Act II', 'Sita, op. 89: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11023 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed2a254d-8e76-4885-bf1b-1383b8e14348'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Sita, op. 89: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11023 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:bd229fcf-eb3d-4796-853e-9e5843b9a450' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd229fcf-eb3d-4796-853e-9e5843b9a450', 3, NULL, 'Act III', 'Sita, op. 89: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11023 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd229fcf-eb3d-4796-853e-9e5843b9a450'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bd229fcf-eb3d-4796-853e-9e5843b9a450'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III. Interlude', part.name_en = 'Sita, op. 89: Act III. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11023 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:dcba5e34-48f4-4569-bee0-645eb6a5b6cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dcba5e34-48f4-4569-bee0-645eb6a5b6cd', 1, NULL, 'Act III. Interlude', 'Sita, op. 89: Act III. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bd229fcf-eb3d-4796-853e-9e5843b9a450'
WHERE p.id = 11023 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcba5e34-48f4-4569-bee0-645eb6a5b6cd'
);


-- Op. 36b 연가곡집 <Six Choral Folk Songs>

UPDATE pieces piece
SET piece.title = '연가곡집 <Six Choral Folk Songs>', piece.title_en = 'Six Choral Folk Songs, op. 36b',
    piece.type = 'album', piece.opus_number = 'Op. 36b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9943 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'I Sowed the Seeds of Love', part.name_en = 'Six Choral Folk Songs, op. 36b: I. I Sowed the Seeds of Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9943 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:756dbbea-ee52-455c-8c9c-cbab234119f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:756dbbea-ee52-455c-8c9c-cbab234119f2', 1, 'I', 'I Sowed the Seeds of Love', 'Six Choral Folk Songs, op. 36b: I. I Sowed the Seeds of Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9943 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:756dbbea-ee52-455c-8c9c-cbab234119f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'There Was a Tree', part.name_en = 'Six Choral Folk Songs, op. 36b: II. There Was a Tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9943 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:0e984cf9-ed9b-40eb-82ae-cde05e9c7011' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e984cf9-ed9b-40eb-82ae-cde05e9c7011', 2, 'II', 'There Was a Tree', 'Six Choral Folk Songs, op. 36b: II. There Was a Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9943 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e984cf9-ed9b-40eb-82ae-cde05e9c7011'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Matthew, Mark, Luke and John', part.name_en = 'Six Choral Folk Songs, op. 36b: III. Matthew, Mark, Luke and John',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9943 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:60f44947-d625-346d-beba-d6e244b9332e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60f44947-d625-346d-beba-d6e244b9332e', 3, 'III', 'Matthew, Mark, Luke and John', 'Six Choral Folk Songs, op. 36b: III. Matthew, Mark, Luke and John', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9943 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60f44947-d625-346d-beba-d6e244b9332e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Song of the Blacksmith', part.name_en = 'Six Choral Folk Songs, op. 36b: IV. The Song of the Blacksmith',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9943 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:3f9c4f44-de97-4619-adaf-df569e3afba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f9c4f44-de97-4619-adaf-df569e3afba5', 4, 'IV', 'The Song of the Blacksmith', 'Six Choral Folk Songs, op. 36b: IV. The Song of the Blacksmith', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9943 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f9c4f44-de97-4619-adaf-df569e3afba5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'I Love My Love', part.name_en = 'Six Choral Folk Songs, op. 36b: V. I Love My Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9943 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:f0200345-2ae5-4ed1-ab79-c6dc34e5fd06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0200345-2ae5-4ed1-ab79-c6dc34e5fd06', 5, 'V', 'I Love My Love', 'Six Choral Folk Songs, op. 36b: V. I Love My Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9943 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0200345-2ae5-4ed1-ab79-c6dc34e5fd06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Swansea Town', part.name_en = 'Six Choral Folk Songs, op. 36b: VI. Swansea Town',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9943 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:9915ec41-4977-407d-934f-7ea524c566d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9915ec41-4977-407d-934f-7ea524c566d7', 6, 'VI', 'Swansea Town', 'Six Choral Folk Songs, op. 36b: VI. Swansea Town', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9943 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9915ec41-4977-407d-934f-7ea524c566d7'
);


-- Op. 53 Six Choruses for Male Voices

UPDATE pieces piece
SET piece.title = 'Six Choruses for Male Voices', piece.title_en = 'Six Choruses for Male Voices, op. 53, H. 186',
    piece.type = 'album', piece.opus_number = 'Op. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8478 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Good Friday', part.name_en = 'Six Choruses for Male Voices, op. 53, H. 186: I. Good Friday',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8478 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:181a2a97-2a5d-4e82-86e3-f0f949aca5e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:181a2a97-2a5d-4e82-86e3-f0f949aca5e8', 1, 'I', 'Good Friday', 'Six Choruses for Male Voices, op. 53, H. 186: I. Good Friday', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8478 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:181a2a97-2a5d-4e82-86e3-f0f949aca5e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intercession', part.name_en = 'Six Choruses for Male Voices, op. 53, H. 186: II. Intercession',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8478 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:e072789b-9bbb-44ea-a6ab-c2c46412bf54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e072789b-9bbb-44ea-a6ab-c2c46412bf54', 2, 'II', 'Intercession', 'Six Choruses for Male Voices, op. 53, H. 186: II. Intercession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8478 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e072789b-9bbb-44ea-a6ab-c2c46412bf54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'How Mighty Are the Sabbaths', part.name_en = 'Six Choruses for Male Voices, op. 53, H. 186: III. How Mighty Are the Sabbaths',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8478 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:dfb1e52d-9661-46e4-8682-ebb3c17ac916' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfb1e52d-9661-46e4-8682-ebb3c17ac916', 3, 'III', 'How Mighty Are the Sabbaths', 'Six Choruses for Male Voices, op. 53, H. 186: III. How Mighty Are the Sabbaths', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8478 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfb1e52d-9661-46e4-8682-ebb3c17ac916'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'A Love Song', part.name_en = 'Six Choruses for Male Voices, op. 53, H. 186: IV. A Love Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8478 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d8b47426-e6e9-49ee-83bf-b614f89bccb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8b47426-e6e9-49ee-83bf-b614f89bccb1', 4, 'IV', 'A Love Song', 'Six Choruses for Male Voices, op. 53, H. 186: IV. A Love Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8478 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8b47426-e6e9-49ee-83bf-b614f89bccb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Drinking Song', part.name_en = 'Six Choruses for Male Voices, op. 53, H. 186: V. Drinking Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8478 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1a35f494-71be-47ce-9f1f-3cd6778bbfd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a35f494-71be-47ce-9f1f-3cd6778bbfd4', 5, 'V', 'Drinking Song', 'Six Choruses for Male Voices, op. 53, H. 186: V. Drinking Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8478 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a35f494-71be-47ce-9f1f-3cd6778bbfd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Before Sleep', part.name_en = 'Six Choruses for Male Voices, op. 53, H. 186: VI. Before Sleep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8478 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:2c7c30ef-a529-4aa9-9960-38957deb0b90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c7c30ef-a529-4aa9-9960-38957deb0b90', 6, 'VI', 'Before Sleep', 'Six Choruses for Male Voices, op. 53, H. 186: VI. Before Sleep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8478 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c7c30ef-a529-4aa9-9960-38957deb0b90'
);


-- Op. 16 6개의 가곡 Op. 16

UPDATE pieces piece
SET piece.title = '6개의 가곡 Op. 16', piece.title_en = 'Six Songs, op. 16, H. 69',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '16',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11130 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Calm is the morn', part.name_en = 'Six Songs, op. 16, H. 69: 1. Calm is the morn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11130 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:59f2ac9c-abb8-434f-95b2-60fe097be3e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59f2ac9c-abb8-434f-95b2-60fe097be3e8', 1, NULL, 'Calm is the morn', 'Six Songs, op. 16, H. 69: 1. Calm is the morn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11130 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f2ac9c-abb8-434f-95b2-60fe097be3e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'My true love hath my heart', part.name_en = 'Six Songs, op. 16, H. 69: 2. My true love hath my heart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11130 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:8b0db923-8c1c-4cc5-a9ba-8971fd597de6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b0db923-8c1c-4cc5-a9ba-8971fd597de6', 2, NULL, 'My true love hath my heart', 'Six Songs, op. 16, H. 69: 2. My true love hath my heart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11130 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b0db923-8c1c-4cc5-a9ba-8971fd597de6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Weep you no more, sad fountains', part.name_en = 'Six Songs, op. 16, H. 69: 3. Weep you no more, sad fountains',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11130 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:0cb10c99-a4af-4760-ae24-852a6cc4442f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cb10c99-a4af-4760-ae24-852a6cc4442f', 3, NULL, 'Weep you no more, sad fountains', 'Six Songs, op. 16, H. 69: 3. Weep you no more, sad fountains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11130 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cb10c99-a4af-4760-ae24-852a6cc4442f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lovely kind and kindly loving', part.name_en = 'Six Songs, op. 16, H. 69: 4. Lovely kind and kindly loving',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11130 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1239ed29-3cfd-48b9-9bd1-63986e9393d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1239ed29-3cfd-48b9-9bd1-63986e9393d4', 4, NULL, 'Lovely kind and kindly loving', 'Six Songs, op. 16, H. 69: 4. Lovely kind and kindly loving', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11130 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1239ed29-3cfd-48b9-9bd1-63986e9393d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cradle Song', part.name_en = 'Six Songs, op. 16, H. 69: 5. Cradle Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11130 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:aba7b4cc-28f7-4d49-b88a-29d41162fd70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aba7b4cc-28f7-4d49-b88a-29d41162fd70', 5, NULL, 'Cradle Song', 'Six Songs, op. 16, H. 69: 5. Cradle Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11130 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aba7b4cc-28f7-4d49-b88a-29d41162fd70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Peace', part.name_en = 'Six Songs, op. 16, H. 69: 6. Peace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11130 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:088fff89-20aa-4551-99ad-1ead8d2f274e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:088fff89-20aa-4551-99ad-1ead8d2f274e', 6, NULL, 'Peace', 'Six Songs, op. 16, H. 69: 6. Peace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11130 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:088fff89-20aa-4551-99ad-1ead8d2f274e'
);


-- H. 17 Song to the Sleeping Lady

UPDATE pieces piece
SET piece.title = 'Song to the Sleeping Lady', piece.title_en = 'Song to the Sleeping Lady, H. 17',
    piece.type = 'song', piece.opus_number = 'H. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9683 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 20a 연가곡집 <Songs From “The Princess”>

UPDATE pieces piece
SET piece.title = '연가곡집 <Songs From “The Princess”>', piece.title_en = 'Songs From “The Princess”, op. 20a',
    piece.type = 'album', piece.opus_number = 'Op. 20a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8201 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sweet and Low', part.name_en = 'Songs From “The Princess”, op. 20a: I. Sweet and Low',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8201 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:0d0e72a6-2077-416b-88d6-c3ac42206577' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d0e72a6-2077-416b-88d6-c3ac42206577', 1, 'I', 'Sweet and Low', 'Songs From “The Princess”, op. 20a: I. Sweet and Low', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8201 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d0e72a6-2077-416b-88d6-c3ac42206577'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Splendour Falls', part.name_en = 'Songs From “The Princess”, op. 20a: II. The Splendour Falls',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8201 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4ce9627a-c6fe-4e25-9332-0624a62cde0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ce9627a-c6fe-4e25-9332-0624a62cde0f', 2, 'II', 'The Splendour Falls', 'Songs From “The Princess”, op. 20a: II. The Splendour Falls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8201 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ce9627a-c6fe-4e25-9332-0624a62cde0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tears, Idle Tears', part.name_en = 'Songs From “The Princess”, op. 20a: III. Tears, Idle Tears',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8201 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:f1882d38-7189-46ca-966b-eb670dea3a59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1882d38-7189-46ca-966b-eb670dea3a59', 3, 'III', 'Tears, Idle Tears', 'Songs From “The Princess”, op. 20a: III. Tears, Idle Tears', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8201 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1882d38-7189-46ca-966b-eb670dea3a59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'O Swallow, Swallow', part.name_en = 'Songs From “The Princess”, op. 20a: IV. O Swallow, Swallow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8201 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:e897ae3a-94bf-4e38-94eb-553721c16785' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e897ae3a-94bf-4e38-94eb-553721c16785', 4, 'IV', 'O Swallow, Swallow', 'Songs From “The Princess”, op. 20a: IV. O Swallow, Swallow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8201 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e897ae3a-94bf-4e38-94eb-553721c16785'
);


-- H. 3 Spring It Is Cheery

UPDATE pieces piece
SET piece.title = 'Spring It Is Cheery', piece.title_en = 'Spring It Is Cheery, H. 3',
    piece.type = 'song', piece.opus_number = 'H. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10056 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 29 No. 2 St. Paul’s Suite for String Orchestra

UPDATE pieces piece
SET piece.title = 'St. Paul’s Suite for String Orchestra', piece.title_en = 'St. Paul’s Suite for String Orchestra, op. 29 no. 2',
    piece.type = 'album', piece.opus_number = 'Op. 29 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10837 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Jig. Vivace', part.name_en = 'St. Paul’s Suite for String Orchestra, op. 29 no. 2: I. Jig. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10837 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:698d789d-e6de-3e98-9e6f-6fb1861df5a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:698d789d-e6de-3e98-9e6f-6fb1861df5a3', 1, 'I', 'Jig. Vivace', 'St. Paul’s Suite for String Orchestra, op. 29 no. 2: I. Jig. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10837 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:698d789d-e6de-3e98-9e6f-6fb1861df5a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ostinato. Presto', part.name_en = 'St. Paul’s Suite for String Orchestra, op. 29 no. 2: II. Ostinato. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10837 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:f8b3e0fa-691d-39fd-9f11-f6ab022ef008' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8b3e0fa-691d-39fd-9f11-f6ab022ef008', 2, 'II', 'Ostinato. Presto', 'St. Paul’s Suite for String Orchestra, op. 29 no. 2: II. Ostinato. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10837 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8b3e0fa-691d-39fd-9f11-f6ab022ef008'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intermezzo. Andante con moto - Vivace', part.name_en = 'St. Paul’s Suite for String Orchestra, op. 29 no. 2: III. Intermezzo. Andante con moto - Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10837 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:222843b6-76bf-3377-a4de-784880318d8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:222843b6-76bf-3377-a4de-784880318d8b', 3, 'III', 'Intermezzo. Andante con moto - Vivace', 'St. Paul’s Suite for String Orchestra, op. 29 no. 2: III. Intermezzo. Andante con moto - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10837 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:222843b6-76bf-3377-a4de-784880318d8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale (The Dargason). Allegro', part.name_en = 'St. Paul’s Suite for String Orchestra, op. 29 no. 2: IV. Finale (The Dargason). Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10837 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:bbf203ea-d4cf-344f-8204-3be6eb616ab1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbf203ea-d4cf-344f-8204-3be6eb616ab1', 4, 'IV', 'Finale (The Dargason). Allegro', 'St. Paul’s Suite for String Orchestra, op. 29 no. 2: IV. Finale (The Dargason). Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10837 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbf203ea-d4cf-344f-8204-3be6eb616ab1'
);


-- Op. 10 Suite de Ballet in E-flat

UPDATE pieces piece
SET piece.title = 'Suite de Ballet in E-flat', piece.title_en = 'Suite de Ballet in E-flat, op. 10, H. 43',
    piece.type = 'album', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7531 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Danse Rustique', part.name_en = 'Suite de Ballet in E-Flat, op. 10: I. Danse Rustique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7531 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:6f8d3d58-bd60-3203-a49e-7a1a28a04a61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f8d3d58-bd60-3203-a49e-7a1a28a04a61', 1, 'I', 'Danse Rustique', 'Suite de Ballet in E-Flat, op. 10: I. Danse Rustique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7531 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f8d3d58-bd60-3203-a49e-7a1a28a04a61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Valse', part.name_en = 'Suite de Ballet in E-Flat, op. 10: II. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7531 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:74cfae28-868a-3882-accd-165a8c849a0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74cfae28-868a-3882-accd-165a8c849a0a', 2, 'II', 'Valse', 'Suite de Ballet in E-Flat, op. 10: II. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7531 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74cfae28-868a-3882-accd-165a8c849a0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scène de Nuit', part.name_en = 'Suite de Ballet in E-Flat, op. 10: III. Scène de Nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7531 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:48c3b744-7d1f-33d8-89f2-e83d10f7f685' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48c3b744-7d1f-33d8-89f2-e83d10f7f685', 3, 'III', 'Scène de Nuit', 'Suite de Ballet in E-Flat, op. 10: III. Scène de Nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7531 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48c3b744-7d1f-33d8-89f2-e83d10f7f685'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Carnival', part.name_en = 'Suite de Ballet in E-Flat, op. 10: IV. Carnival',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7531 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:bdea27f8-7d15-3d76-9761-b169d91f0731' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdea27f8-7d15-3d76-9761-b169d91f0731', 4, 'IV', 'Carnival', 'Suite de Ballet in E-Flat, op. 10: IV. Carnival', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7531 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdea27f8-7d15-3d76-9761-b169d91f0731'
);


-- H. 41 모음곡 G단조

UPDATE pieces piece
SET piece.title = '모음곡 G단조', piece.title_en = 'Suite in G minor, H. 41',
    piece.type = 'song', piece.opus_number = 'H. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8348 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 47 교향곡 F장조 "The Cotswolds"

UPDATE pieces piece
SET piece.title = '교향곡 F장조 "The Cotswolds"', piece.title_en = 'Symphony in F major "The Cotswolds", H. 47',
    piece.type = 'album', piece.opus_number = 'H. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10280 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'Symphony in F major "The Cotswolds", H. 47: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10280 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:ff467910-125f-4fcd-95d9-18888f86f9f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff467910-125f-4fcd-95d9-18888f86f9f9', 1, 'I', 'Allegro con brio', 'Symphony in F major "The Cotswolds", H. 47: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10280 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff467910-125f-4fcd-95d9-18888f86f9f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Elegy (In Memoriam William Morris)', part.name_en = 'Symphony in F major "The Cotswolds", H. 47: II. Elegy (In Memoriam William Morris)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10280 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4ed621d4-a0d0-4766-b886-ea746e009a85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ed621d4-a0d0-4766-b886-ea746e009a85', 2, 'II', 'Elegy (In Memoriam William Morris)', 'Symphony in F major "The Cotswolds", H. 47: II. Elegy (In Memoriam William Morris)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10280 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ed621d4-a0d0-4766-b886-ea746e009a85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo', part.name_en = 'Symphony in F major "The Cotswolds", H. 47: III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10280 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c62428b3-8e00-4b78-b947-12536832398a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c62428b3-8e00-4b78-b947-12536832398a', 3, 'III', 'Scherzo', 'Symphony in F major "The Cotswolds", H. 47: III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10280 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c62428b3-8e00-4b78-b947-12536832398a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale', part.name_en = 'Symphony in F major "The Cotswolds", H. 47: IV. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10280 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:6df8815a-29dd-4f7f-959c-55516850241a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6df8815a-29dd-4f7f-959c-55516850241a', 4, 'IV', 'Finale', 'Symphony in F major "The Cotswolds", H. 47: IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10280 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6df8815a-29dd-4f7f-959c-55516850241a'
);


-- Op. 25 오페라 <Sāvitri>

UPDATE pieces piece
SET piece.title = '오페라 <Sāvitri>', piece.title_en = 'Sāvitri, op. 25',
    piece.type = 'song', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9060 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Terly Terlow

UPDATE pieces piece
SET piece.title = 'Terly Terlow', piece.title_en = 'Terly Terlow',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8090 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 1 The Autumn Is Old

UPDATE pieces piece
SET piece.title = 'The Autumn Is Old', piece.title_en = 'The Autumn Is Old, H. 1',
    piece.type = 'song', piece.opus_number = 'H. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9186 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 19 The Ballade of Prince Eric

UPDATE pieces piece
SET piece.title = 'The Ballade of Prince Eric', piece.title_en = 'The Ballade of Prince Eric, H. 19',
    piece.type = 'song', piece.opus_number = 'H. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10570 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 29 The Day of the Lord

UPDATE pieces piece
SET piece.title = 'The Day of the Lord', piece.title_en = 'The Day of the Lord, H. 29',
    piece.type = 'song', piece.opus_number = 'H. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9434 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 45 No. 1 발레 <The Golden Goose>

UPDATE pieces piece
SET piece.title = '발레 <The Golden Goose>', piece.title_en = 'The Golden Goose, op. 45 no. 1',
    piece.type = 'album', piece.opus_number = 'Op. 45 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7605 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude', part.name_en = 'The Golden Goose, op. 45 no. 1: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:6013fe0d-2661-4b82-b180-c17f08037117' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6013fe0d-2661-4b82-b180-c17f08037117', 1, 'I', 'Prelude', 'The Golden Goose, op. 45 no. 1: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6013fe0d-2661-4b82-b180-c17f08037117'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Sound of drum and trumpets play"', part.name_en = 'The Golden Goose, op. 45 no. 1: II. "Sound of drum and trumpets play"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:3e951e0a-0b06-4af4-8c90-a02fbe76a2c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e951e0a-0b06-4af4-8c90-a02fbe76a2c8', 2, 'II', '"Sound of drum and trumpets play"', 'The Golden Goose, op. 45 no. 1: II. "Sound of drum and trumpets play"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e951e0a-0b06-4af4-8c90-a02fbe76a2c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"A mummers'' play, a mummers'' play"', part.name_en = 'The Golden Goose, op. 45 no. 1: III. "A mummers'' play, a mummers'' play"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:88f2a325-5b58-4335-a34a-38dc2b66da7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88f2a325-5b58-4335-a34a-38dc2b66da7e', 3, 'III', '"A mummers'' play, a mummers'' play"', 'The Golden Goose, op. 45 no. 1: III. "A mummers'' play, a mummers'' play"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f2a325-5b58-4335-a34a-38dc2b66da7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Mummers'' Play', part.name_en = 'The Golden Goose, op. 45 no. 1: IV. The Mummers'' Play',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:f6dfa804-bc2e-482e-815e-18f92fd675ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6dfa804-bc2e-482e-815e-18f92fd675ae', 4, 'IV', 'The Mummers'' Play', 'The Golden Goose, op. 45 no. 1: IV. The Mummers'' Play', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6dfa804-bc2e-482e-815e-18f92fd675ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"Vainly awaiting, some beguiling"', part.name_en = 'The Golden Goose, op. 45 no. 1: V. "Vainly awaiting, some beguiling"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:8fa4fe2c-8eac-4172-85a1-31bff0091841' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fa4fe2c-8eac-4172-85a1-31bff0091841', 5, 'V', '"Vainly awaiting, some beguiling"', 'The Golden Goose, op. 45 no. 1: V. "Vainly awaiting, some beguiling"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fa4fe2c-8eac-4172-85a1-31bff0091841'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Human Organ', part.name_en = 'The Golden Goose, op. 45 no. 1: VI. The Human Organ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:19231e05-e74c-4ba6-907c-1de83e13c6c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19231e05-e74c-4ba6-907c-1de83e13c6c1', 6, 'VI', 'The Human Organ', 'The Golden Goose, op. 45 no. 1: VI. The Human Organ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19231e05-e74c-4ba6-907c-1de83e13c6c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Execution', part.name_en = 'The Golden Goose, op. 45 no. 1: VII. Execution',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:83ed4e38-d36a-4961-b0fd-f9493b1f7c9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83ed4e38-d36a-4961-b0fd-f9493b1f7c9d', 7, 'VII', 'Execution', 'The Golden Goose, op. 45 no. 1: VII. Execution', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83ed4e38-d36a-4961-b0fd-f9493b1f7c9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Sleep', part.name_en = 'The Golden Goose, op. 45 no. 1: VIII. Sleep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:5f3073f7-d980-43ea-a161-04d413c233c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f3073f7-d980-43ea-a161-04d413c233c4', 8, 'VIII', 'Sleep', 'The Golden Goose, op. 45 no. 1: VIII. Sleep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f3073f7-d980-43ea-a161-04d413c233c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Dance of the Three Girls', part.name_en = 'The Golden Goose, op. 45 no. 1: IX. Dance of the Three Girls',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:48395032-607f-4187-b00e-a993feb2b0f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48395032-607f-4187-b00e-a993feb2b0f0', 9, 'IX', 'Dance of the Three Girls', 'The Golden Goose, op. 45 no. 1: IX. Dance of the Three Girls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48395032-607f-4187-b00e-a993feb2b0f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'The Goose Dance', part.name_en = 'The Golden Goose, op. 45 no. 1: X. The Goose Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:911a1d35-ce9f-4251-ad3e-2f31dd46cfc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:911a1d35-ce9f-4251-ad3e-2f31dd46cfc0', 10, 'X', 'The Goose Dance', 'The Golden Goose, op. 45 no. 1: X. The Goose Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:911a1d35-ce9f-4251-ad3e-2f31dd46cfc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Love, Sweet Love', part.name_en = 'The Golden Goose, op. 45 no. 1: XI. Love, Sweet Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:91b9cc7b-4763-42bf-93df-894d992e877f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91b9cc7b-4763-42bf-93df-894d992e877f', 11, 'XI', 'Love, Sweet Love', 'The Golden Goose, op. 45 no. 1: XI. Love, Sweet Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91b9cc7b-4763-42bf-93df-894d992e877f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = '"Sound drum and trumpet play"', part.name_en = 'The Golden Goose, op. 45 no. 1: XII. "Sound drum and trumpet play"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7605 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:ed1312a5-0945-4841-8c93-6ceabd2548d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed1312a5-0945-4841-8c93-6ceabd2548d3', 12, 'XII', '"Sound drum and trumpet play"', 'The Golden Goose, op. 45 no. 1: XII. "Sound drum and trumpet play"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7605 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed1312a5-0945-4841-8c93-6ceabd2548d3'
);


-- H. 95 가곡 <The Heart Worships>

UPDATE pieces piece
SET piece.title = '가곡 <The Heart Worships>', piece.title_en = 'The Heart Worships, H. 95',
    piece.type = 'song', piece.opus_number = 'H. 95',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11176 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 120 The Homecoming

UPDATE pieces piece
SET piece.title = 'The Homecoming', piece.title_en = 'The Homecoming, H. 120',
    piece.type = 'song', piece.opus_number = 'H. 120',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9210 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 37 The Hymn of Jesus Op. 37

UPDATE pieces piece
SET piece.title = 'The Hymn of Jesus Op. 37', piece.title_en = 'The Hymn of Jesus, op. 37',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '37',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11084 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Senza misura - Lento', part.name_en = 'The Hymn of Jesus, op. 37 "Prelude": Senza misura - Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11084 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:49a50581-d796-3506-b05b-154ec69897df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a50581-d796-3506-b05b-154ec69897df', 1, NULL, 'Senza misura - Lento', 'The Hymn of Jesus, op. 37 "Prelude": Senza misura - Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11084 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a50581-d796-3506-b05b-154ec69897df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Moderato maestoso', part.name_en = 'The Hymn of Jesus, op. 37 "The Hymn": Moderato maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11084 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:62b27dc6-b723-3f6e-9b52-1952e51f0a9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62b27dc6-b723-3f6e-9b52-1952e51f0a9c', 2, NULL, 'Moderato maestoso', 'The Hymn of Jesus, op. 37 "The Hymn": Moderato maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11084 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62b27dc6-b723-3f6e-9b52-1952e51f0a9c'
);


-- H. 21 오페라 <The Idea> H. 21

UPDATE pieces piece
SET piece.title = '오페라 <The Idea> H. 21', piece.title_en = 'The Idea, H. 21',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '21',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8824 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'The Idea, H. 21: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8824 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7f000b6e-1cba-4038-a857-e2c4a4f10b13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f000b6e-1cba-4038-a857-e2c4a4f10b13', 1, NULL, 'Act I', 'The Idea, H. 21: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8824 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f000b6e-1cba-4038-a857-e2c4a4f10b13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'The Idea, H. 21: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8824 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:0236b1b0-a921-465a-b3de-bfb523bf536b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0236b1b0-a921-465a-b3de-bfb523bf536b', 2, NULL, 'Act II', 'The Idea, H. 21: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8824 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0236b1b0-a921-465a-b3de-bfb523bf536b'
);


-- H. 16 The Kiss

UPDATE pieces piece
SET piece.title = 'The Kiss', piece.title_en = 'The Kiss, H. 16',
    piece.type = 'song', piece.opus_number = 'H. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10387 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Lure

UPDATE pieces piece
SET piece.title = 'The Lure', piece.title_en = 'The Lure',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9576 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 45 No. 2 발레 <The Morning of the Year> Op. 45 No. 2

UPDATE pieces piece
SET piece.title = '발레 <The Morning of the Year> Op. 45 No. 2', piece.title_en = 'The Morning of the Year, op. 45 no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '45 No. 2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8861 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I am that which men did make', part.name_en = 'The Morning of the Year, op. 45 no. 2: I am that which men did make',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8861 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:f43f6f63-4846-4514-b187-80a26c806d06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f43f6f63-4846-4514-b187-80a26c806d06', 1, NULL, 'I am that which men did make', 'The Morning of the Year, op. 45 no. 2: I am that which men did make', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8861 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f43f6f63-4846-4514-b187-80a26c806d06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dance of Headman and Hobby-horse', part.name_en = 'The Morning of the Year, op. 45 no. 2: Dance of Headman and Hobby-horse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8861 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:fcb89fbc-a5e3-4283-991f-5a3e48b9d2c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcb89fbc-a5e3-4283-991f-5a3e48b9d2c3', 2, NULL, 'Dance of Headman and Hobby-horse', 'The Morning of the Year, op. 45 no. 2: Dance of Headman and Hobby-horse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8861 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcb89fbc-a5e3-4283-991f-5a3e48b9d2c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dance of Youths', part.name_en = 'The Morning of the Year, op. 45 no. 2: Dance of Youths',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8861 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7c0b4482-f874-4d55-8a76-6502f7989666' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c0b4482-f874-4d55-8a76-6502f7989666', 3, NULL, 'Dance of Youths', 'The Morning of the Year, op. 45 no. 2: Dance of Youths', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8861 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c0b4482-f874-4d55-8a76-6502f7989666'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dance of Maidens', part.name_en = 'The Morning of the Year, op. 45 no. 2: Dance of Maidens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8861 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:972b08be-2226-4c00-b575-98bf38d97fd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:972b08be-2226-4c00-b575-98bf38d97fd2', 4, NULL, 'Dance of Maidens', 'The Morning of the Year, op. 45 no. 2: Dance of Maidens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8861 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:972b08be-2226-4c00-b575-98bf38d97fd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Mating Dance', part.name_en = 'The Morning of the Year, op. 45 no. 2: Mating Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8861 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:6e7cd3de-e958-4db4-852b-1313b7f0d42c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e7cd3de-e958-4db4-852b-1313b7f0d42c', 5, NULL, 'Mating Dance', 'The Morning of the Year, op. 45 no. 2: Mating Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8861 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e7cd3de-e958-4db4-852b-1313b7f0d42c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Dance of the Youngest Couple', part.name_en = 'The Morning of the Year, op. 45 no. 2: Dance of the Youngest Couple',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8861 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:42d61cf7-97dd-4ae4-8cc9-e6e09905f1b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42d61cf7-97dd-4ae4-8cc9-e6e09905f1b5', 6, NULL, 'Dance of the Youngest Couple', 'The Morning of the Year, op. 45 no. 2: Dance of the Youngest Couple', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8861 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42d61cf7-97dd-4ae4-8cc9-e6e09905f1b5'
);


-- Op. 18 The Mystic Trumpeter

UPDATE pieces piece
SET piece.title = 'The Mystic Trumpeter', piece.title_en = 'The Mystic Trumpeter, op. 18',
    piece.type = 'song', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10012 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 39 오페라 <The Perfect Fool> Op. 39

UPDATE pieces piece
SET piece.title = '오페라 <The Perfect Fool> Op. 39', piece.title_en = 'The Perfect Fool, op. 39',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '39',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7558 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ballet Music', part.name_en = 'The Perfect Fool, op. 39: Ballet Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7558 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a', 1, NULL, 'Ballet Music', 'The Perfect Fool, op. 39: Ballet Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7558 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'The Perfect Fool, op. 39: Ballet Music: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7558 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:99c7e86b-2eeb-3b3d-a1f6-cee5fec1c429' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:99c7e86b-2eeb-3b3d-a1f6-cee5fec1c429', 1, NULL, 'Andante', 'The Perfect Fool, op. 39: Ballet Music: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a'
WHERE p.id = 7558 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99c7e86b-2eeb-3b3d-a1f6-cee5fec1c429'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dance of Spirits of Earth', part.name_en = 'The Perfect Fool, op. 39: Ballet Music: II. Dance of Spirits of Earth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7558 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:3b397e08-d23d-3887-ab30-2661d97487bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b397e08-d23d-3887-ab30-2661d97487bf', 2, NULL, 'Dance of Spirits of Earth', 'The Perfect Fool, op. 39: Ballet Music: II. Dance of Spirits of Earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a'
WHERE p.id = 7558 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b397e08-d23d-3887-ab30-2661d97487bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dance of Spirits of Water', part.name_en = 'The Perfect Fool, op. 39: Ballet Music: III. Dance of Spirits of Water',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7558 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:9c34bdb8-c1de-3e0c-ac5b-1d302f972440' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c34bdb8-c1de-3e0c-ac5b-1d302f972440', 3, NULL, 'Dance of Spirits of Water', 'The Perfect Fool, op. 39: Ballet Music: III. Dance of Spirits of Water', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a'
WHERE p.id = 7558 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c34bdb8-c1de-3e0c-ac5b-1d302f972440'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dance of Spirits of Fire', part.name_en = 'The Perfect Fool, op. 39: Ballet Music: IV. Dance of Spirits of Fire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7558 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:07197460-b61f-3425-b2fb-fb32a8ec4cea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07197460-b61f-3425-b2fb-fb32a8ec4cea', 4, NULL, 'Dance of Spirits of Fire', 'The Perfect Fool, op. 39: Ballet Music: IV. Dance of Spirits of Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a3d2350e-5c74-4f7e-83e6-6d8084de372a'
WHERE p.id = 7558 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07197460-b61f-3425-b2fb-fb32a8ec4cea'
);


-- None The Planets

UPDATE pieces piece
SET piece.title = 'The Planets', piece.title_en = 'The Planets',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10490 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 1 오페라 <The Revoke>

UPDATE pieces piece
SET piece.title = '오페라 <The Revoke>', piece.title_en = 'The Revoke, op. 1',
    piece.type = 'song', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10270 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 2 The Stars Are with the Voyager

UPDATE pieces piece
SET piece.title = 'The Stars Are with the Voyager', piece.title_en = 'The Stars Are with the Voyager, H. 2',
    piece.type = 'song', piece.opus_number = 'H. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9297 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 101 The Vision of Dame Christian H. 101

UPDATE pieces piece
SET piece.title = 'The Vision of Dame Christian H. 101', piece.title_en = 'The Vision of Dame Christian, H. 101',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'H.', piece.catalogue_number = '101',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7922 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'The Vision of Dame Christian, H. 101: No. 5, Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7922 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:5c2bc463-c083-4736-b11d-fbdd529cbad1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c2bc463-c083-4736-b11d-fbdd529cbad1', 1, NULL, 'Finale', 'The Vision of Dame Christian, H. 101: No. 5, Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7922 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c2bc463-c083-4736-b11d-fbdd529cbad1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'How Shall We Tell of Him', part.name_en = 'The Vision of Dame Christian, H. 101: No. 4, How Shall We Tell of Him',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7922 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:62bbb12a-157a-462a-8144-fdd4abc1f396' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62bbb12a-157a-462a-8144-fdd4abc1f396', 2, NULL, 'How Shall We Tell of Him', 'The Vision of Dame Christian, H. 101: No. 4, How Shall We Tell of Him', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7922 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62bbb12a-157a-462a-8144-fdd4abc1f396'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Interlude', part.name_en = 'The Vision of Dame Christian, H. 101: No. 3b, Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7922 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:673e35cd-4d5b-4638-acce-64e1094fb165' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:673e35cd-4d5b-4638-acce-64e1094fb165', 3, NULL, 'Interlude', 'The Vision of Dame Christian, H. 101: No. 3b, Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7922 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:673e35cd-4d5b-4638-acce-64e1094fb165'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'The Vision of Dame Christian, H. 101: No. 1, Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7922 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:777c7f1e-6701-4b7e-a9ee-2b128759190b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:777c7f1e-6701-4b7e-a9ee-2b128759190b', 4, NULL, 'Prelude', 'The Vision of Dame Christian, H. 101: No. 1, Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7922 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:777c7f1e-6701-4b7e-a9ee-2b128759190b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Knowest Thou Not the Warning', part.name_en = 'The Vision of Dame Christian, H. 101: No. 2, Knowest Thou Not the Warning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7922 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:77e3eb1f-741d-4990-9028-027c4bb07481' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77e3eb1f-741d-4990-9028-027c4bb07481', 5, NULL, 'Knowest Thou Not the Warning', 'The Vision of Dame Christian, H. 101: No. 2, Knowest Thou Not the Warning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7922 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77e3eb1f-741d-4990-9028-027c4bb07481'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Oh Let Us Render Thanks to God Above', part.name_en = 'The Vision of Dame Christian, H. 101: No. 3a, Oh Let Us Render Thanks to God Above',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7922 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d12c5a52-0f7c-4312-b7ce-166c0e444ba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d12c5a52-0f7c-4312-b7ce-166c0e444ba5', 6, NULL, 'Oh Let Us Render Thanks to God Above', 'The Vision of Dame Christian, H. 101: No. 3a, Oh Let Us Render Thanks to God Above', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7922 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d12c5a52-0f7c-4312-b7ce-166c0e444ba5'
);


-- Op. 50 오페라 <The Wandering Scholar>

UPDATE pieces piece
SET piece.title = '오페라 <The Wandering Scholar>', piece.title_en = 'The Wandering Scholar, op. 50',
    piece.type = 'album', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11226 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'When boughs are green in April', part.name_en = 'The Wandering Scholar, op. 50: I. When boughs are green in April',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11226 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:5c408275-ef9f-4cb2-ae47-da3dd0dee102' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c408275-ef9f-4cb2-ae47-da3dd0dee102', 1, 'I', 'When boughs are green in April', 'The Wandering Scholar, op. 50: I. When boughs are green in April', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11226 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c408275-ef9f-4cb2-ae47-da3dd0dee102'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'When rainbows follow flying showers', part.name_en = 'The Wandering Scholar, op. 50: II. When rainbows follow flying showers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11226 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:ef0ab7d5-f9c9-4d28-86d0-0e4d28ac0f48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef0ab7d5-f9c9-4d28-86d0-0e4d28ac0f48', 2, 'II', 'When rainbows follow flying showers', 'The Wandering Scholar, op. 50: II. When rainbows follow flying showers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11226 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef0ab7d5-f9c9-4d28-86d0-0e4d28ac0f48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Piggy, piggy, piggy!', part.name_en = 'The Wandering Scholar, op. 50: III. Piggy, piggy, piggy!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11226 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:6694be84-3014-47f1-af95-4b44cc2ae452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6694be84-3014-47f1-af95-4b44cc2ae452', 3, 'III', 'Piggy, piggy, piggy!', 'The Wandering Scholar, op. 50: III. Piggy, piggy, piggy!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11226 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6694be84-3014-47f1-af95-4b44cc2ae452'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Someone is coming!', part.name_en = 'The Wandering Scholar, op. 50: IV. Someone is coming!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11226 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:add28685-9df8-4e2d-ad00-7f793c55efd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:add28685-9df8-4e2d-ad00-7f793c55efd6', 4, 'IV', 'Someone is coming!', 'The Wandering Scholar, op. 50: IV. Someone is coming!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11226 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:add28685-9df8-4e2d-ad00-7f793c55efd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Before that I was twenty', part.name_en = 'The Wandering Scholar, op. 50: V. Before that I was twenty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11226 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:b6442157-935f-4c25-b085-fa07321e860d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6442157-935f-4c25-b085-fa07321e860d', 5, 'V', 'Before that I was twenty', 'The Wandering Scholar, op. 50: V. Before that I was twenty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11226 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6442157-935f-4c25-b085-fa07321e860d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Learned? Comely?', part.name_en = 'The Wandering Scholar, op. 50: VI. Learned? Comely?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11226 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:ec1c9900-2a64-4e14-96ad-f53f26ca9bc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec1c9900-2a64-4e14-96ad-f53f26ca9bc9', 6, 'VI', 'Learned? Comely?', 'The Wandering Scholar, op. 50: VI. Learned? Comely?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11226 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec1c9900-2a64-4e14-96ad-f53f26ca9bc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Heigho, a pretty knave!', part.name_en = 'The Wandering Scholar, op. 50: VII. Heigho, a pretty knave!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11226 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:76aa0e95-769d-4896-adc8-fa443d6cc841' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76aa0e95-769d-4896-adc8-fa443d6cc841', 7, 'VII', 'Heigho, a pretty knave!', 'The Wandering Scholar, op. 50: VII. Heigho, a pretty knave!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11226 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76aa0e95-769d-4896-adc8-fa443d6cc841'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'He''ll lie all day in the sun', part.name_en = 'The Wandering Scholar, op. 50: VIII. He''ll lie all day in the sun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11226 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:6485562e-2084-48db-a0aa-4db53cbb4f5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6485562e-2084-48db-a0aa-4db53cbb4f5a', 8, 'VIII', 'He''ll lie all day in the sun', 'The Wandering Scholar, op. 50: VIII. He''ll lie all day in the sun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11226 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6485562e-2084-48db-a0aa-4db53cbb4f5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'As I was walking here to-day', part.name_en = 'The Wandering Scholar, op. 50: IX. As I was walking here to-day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11226 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:5a4e4edf-2270-4204-8bca-0defe948cbd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a4e4edf-2270-4204-8bca-0defe948cbd6', 9, 'IX', 'As I was walking here to-day', 'The Wandering Scholar, op. 50: IX. As I was walking here to-day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11226 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a4e4edf-2270-4204-8bca-0defe948cbd6'
);


-- H. 15 There's a Voice in the Wind

UPDATE pieces piece
SET piece.title = 'There''s a Voice in the Wind', piece.title_en = 'There''s a Voice in the Wind, H. 15',
    piece.type = 'song', piece.opus_number = 'H. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8094 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Carols

UPDATE pieces piece
SET piece.title = 'Three Carols', piece.title_en = 'Three Carols',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8926 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Personent Hodie', part.name_en = 'Personent Hodie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8926 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:8a91fd1c-ed9e-4666-a626-f97e3bc2982d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a91fd1c-ed9e-4666-a626-f97e3bc2982d', 1, NULL, 'Personent Hodie', 'Personent Hodie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8926 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a91fd1c-ed9e-4666-a626-f97e3bc2982d'
);


-- None Three Festival Choruses

UPDATE pieces piece
SET piece.title = 'Three Festival Choruses', piece.title_en = 'Three Festival Choruses',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8043 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Let all mortal flesh keep silence, op. 36a no. 1', part.name_en = 'Let all mortal flesh keep silence, op. 36a no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8043 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:f40014cc-6eea-4ee3-b923-a796b9832335' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f40014cc-6eea-4ee3-b923-a796b9832335', 1, NULL, 'Let all mortal flesh keep silence, op. 36a no. 1', 'Let all mortal flesh keep silence, op. 36a no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8043 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f40014cc-6eea-4ee3-b923-a796b9832335'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Turn back, O man, op. 36a no. 2', part.name_en = 'Turn back, O man, op. 36a no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8043 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:11b890d6-1965-44b5-83ad-452cda57808f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11b890d6-1965-44b5-83ad-452cda57808f', 2, NULL, 'Turn back, O man, op. 36a no. 2', 'Turn back, O man, op. 36a no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8043 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11b890d6-1965-44b5-83ad-452cda57808f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A festival chime, op. 36a no. 3', part.name_en = 'A festival chime, op. 36a no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8043 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:6392046d-5134-40f0-9dc1-31f3a73bd846' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6392046d-5134-40f0-9dc1-31f3a73bd846', 3, NULL, 'A festival chime, op. 36a no. 3', 'A festival chime, op. 36a no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8043 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6392046d-5134-40f0-9dc1-31f3a73bd846'
);


-- Op. 48 Twelve Humbert Wolfe Songs Op. 48

UPDATE pieces piece
SET piece.title = 'Twelve Humbert Wolfe Songs Op. 48', piece.title_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '48',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9961 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Persephone', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 1. Persephone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:ada7ab47-bd01-4f02-b98b-161f67cb856e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ada7ab47-bd01-4f02-b98b-161f67cb856e', 1, NULL, 'Persephone', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 1. Persephone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ada7ab47-bd01-4f02-b98b-161f67cb856e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Things lovelier', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 2. Things lovelier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:e8d911fb-c5d0-4d8e-8bf4-9322116e4db0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8d911fb-c5d0-4d8e-8bf4-9322116e4db0', 2, NULL, 'Things lovelier', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 2. Things lovelier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8d911fb-c5d0-4d8e-8bf4-9322116e4db0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Now in these fairylands', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 3. Now in these fairylands',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:034446bb-3515-4f14-ae1e-9f552bd755bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:034446bb-3515-4f14-ae1e-9f552bd755bc', 3, NULL, 'Now in these fairylands', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 3. Now in these fairylands', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:034446bb-3515-4f14-ae1e-9f552bd755bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A little music', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 4. A little music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:535b2fac-00e7-4e19-872a-7e4bbe78cf8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:535b2fac-00e7-4e19-872a-7e4bbe78cf8e', 4, NULL, 'A little music', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 4. A little music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:535b2fac-00e7-4e19-872a-7e4bbe78cf8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The thought', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 5. The thought',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:8e2a6d84-8b73-4c6b-9982-2c9c319c042e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e2a6d84-8b73-4c6b-9982-2c9c319c042e', 5, NULL, 'The thought', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 5. The thought', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e2a6d84-8b73-4c6b-9982-2c9c319c042e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The floral bandit', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 6. The floral bandit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:be4091ff-94f0-4448-917c-e450c1ccd8a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be4091ff-94f0-4448-917c-e450c1ccd8a9', 6, NULL, 'The floral bandit', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 6. The floral bandit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be4091ff-94f0-4448-917c-e450c1ccd8a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Envoi', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 7. Envoi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1f8ec9a7-8a1a-4da1-b775-130f93f81510' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f8ec9a7-8a1a-4da1-b775-130f93f81510', 7, NULL, 'Envoi', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 7. Envoi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f8ec9a7-8a1a-4da1-b775-130f93f81510'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The dream-city', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 8. The dream-city',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:3e33c975-4628-422d-a0a0-b8ec723cbbce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e33c975-4628-422d-a0a0-b8ec723cbbce', 8, NULL, 'The dream-city', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 8. The dream-city', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e33c975-4628-422d-a0a0-b8ec723cbbce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Journey''s end', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 9. Journey''s end',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:9a20e857-412f-4a93-b1d8-4a863c285337' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a20e857-412f-4a93-b1d8-4a863c285337', 9, NULL, 'Journey''s end', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 9. Journey''s end', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a20e857-412f-4a93-b1d8-4a863c285337'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'In the street of lost time', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 10. In the street of lost time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:b913a502-5f2c-413a-b2f7-bab3f9f63e65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b913a502-5f2c-413a-b2f7-bab3f9f63e65', 10, NULL, 'In the street of lost time', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 10. In the street of lost time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b913a502-5f2c-413a-b2f7-bab3f9f63e65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Rhyme', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 11. Rhyme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:4e59534c-5791-4b89-bc81-31f23b757d3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e59534c-5791-4b89-bc81-31f23b757d3e', 11, NULL, 'Rhyme', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 11. Rhyme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e59534c-5791-4b89-bc81-31f23b757d3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Betelgeuse', part.name_en = 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 12. Betelgeuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9961 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:2edbc40e-af99-4332-8fa3-803a25e6b7d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2edbc40e-af99-4332-8fa3-803a25e6b7d5', 12, NULL, 'Betelgeuse', 'Twelve Humbert Wolfe Songs, op. 48, H. 174: 12. Betelgeuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9961 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2edbc40e-af99-4332-8fa3-803a25e6b7d5'
);


-- None Twelve Welsh Folk Songs

UPDATE pieces piece
SET piece.title = 'Twelve Welsh Folk Songs', piece.title_en = 'Twelve Welsh Folk Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7697 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Green Grass (Gwellty Glas)', part.name_en = '12 Welsh Folk Songs: Green Grass (Gwellty Glas)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7697 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:59dd7c64-3c5f-494e-b424-4e7c40d9d107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59dd7c64-3c5f-494e-b424-4e7c40d9d107', 1, NULL, 'Green Grass (Gwellty Glas)', '12 Welsh Folk Songs: Green Grass (Gwellty Glas)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7697 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59dd7c64-3c5f-494e-b424-4e7c40d9d107'
);


-- H. 28 Twin Stars Aloft

UPDATE pieces piece
SET piece.title = 'Twin Stars Aloft', piece.title_en = 'Twin Stars Aloft, H. 28',
    piece.type = 'song', piece.opus_number = 'H. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8864 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 39 Two Brown Eyes

UPDATE pieces piece
SET piece.title = 'Two Brown Eyes', piece.title_en = 'Two Brown Eyes, H. 39',
    piece.type = 'song', piece.opus_number = 'H. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11091 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Dances for Piano Duet

UPDATE pieces piece
SET piece.title = 'Two Dances for Piano Duet', piece.title_en = 'Two Dances for Piano Duet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7618 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Two Dances for Piano Duet: No. 1. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7618 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:5de5cfd3-2d8d-46ee-bb5c-71a2fbd536c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5de5cfd3-2d8d-46ee-bb5c-71a2fbd536c1', 1, NULL, 'Allegretto', 'Two Dances for Piano Duet: No. 1. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7618 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5de5cfd3-2d8d-46ee-bb5c-71a2fbd536c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ländler', part.name_en = 'Two Dances for Piano Duet: No. 2. Ländler',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7618 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1009511c-8632-45ea-9640-57df24d366f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1009511c-8632-45ea-9640-57df24d366f8', 2, NULL, 'Ländler', 'Two Dances for Piano Duet: No. 2. Ländler', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7618 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1009511c-8632-45ea-9640-57df24d366f8'
);


-- None Two Eastern Pictures

UPDATE pieces piece
SET piece.title = 'Two Eastern Pictures', piece.title_en = 'Two Eastern Pictures',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9349 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Spring', part.name_en = 'Two Eastern Pictures: I. Spring',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9349 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:41cd6d30-de0f-442a-9d9b-e3e46c04feaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41cd6d30-de0f-442a-9d9b-e3e46c04feaf', 1, 'I', 'Spring', 'Two Eastern Pictures: I. Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9349 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41cd6d30-de0f-442a-9d9b-e3e46c04feaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Summer', part.name_en = 'Two Eastern Pictures: II. Summer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9349 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:7d5b7982-2f25-4196-a243-df2c2edeb4fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d5b7982-2f25-4196-a243-df2c2edeb4fb', 2, 'II', 'Summer', 'Two Eastern Pictures: II. Summer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9349 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d5b7982-2f25-4196-a243-df2c2edeb4fb'
);


-- None Two Folksong Fragments

UPDATE pieces piece
SET piece.title = 'Two Folksong Fragments', piece.title_en = 'Two Folksong Fragments',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9454 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Oh! I hae seen the roses blaw', part.name_en = 'Two Folksong Fragments: No. 1. Oh! I hae seen the roses blaw',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9454 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:b48de0c6-9f9c-467a-a144-6c3ed4fe81ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b48de0c6-9f9c-467a-a144-6c3ed4fe81ef', 1, NULL, 'Oh! I hae seen the roses blaw', 'Two Folksong Fragments: No. 1. Oh! I hae seen the roses blaw', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9454 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b48de0c6-9f9c-467a-a144-6c3ed4fe81ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Shoemakker', part.name_en = 'Two Folksong Fragments: No. 2. The Shoemakker',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9454 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:e69762da-3b80-4d2c-92ca-348bf9dec596' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e69762da-3b80-4d2c-92ca-348bf9dec596', 2, NULL, 'The Shoemakker', 'Two Folksong Fragments: No. 2. The Shoemakker', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9454 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e69762da-3b80-4d2c-92ca-348bf9dec596'
);


-- None Two Psalms

UPDATE pieces piece
SET piece.title = 'Two Psalms', piece.title_en = 'Two Psalms',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8416 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'To My Humble Supplication (Psalm 86)', part.name_en = 'Two Psalms: To My Humble Supplication (Psalm 86)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8416 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:37d83a6b-f36c-4623-b98d-e9ea21721add' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37d83a6b-f36c-4623-b98d-e9ea21721add', 1, NULL, 'To My Humble Supplication (Psalm 86)', 'Two Psalms: To My Humble Supplication (Psalm 86)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8416 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37d83a6b-f36c-4623-b98d-e9ea21721add'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lord, Who Hast Made Us for Thine Own (Psalm 148)', part.name_en = 'Two Psalms: Lord, Who Hast Made Us for Thine Own (Psalm 148)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8416 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:424b3ba2-1e5c-4d83-8630-781f246edf73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:424b3ba2-1e5c-4d83-8630-781f246edf73', 2, NULL, 'Lord, Who Hast Made Us for Thine Own (Psalm 148)', 'Two Psalms: Lord, Who Hast Made Us for Thine Own (Psalm 148)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8416 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:424b3ba2-1e5c-4d83-8630-781f246edf73'
);


-- Op. 22 Two Songs Without Words

UPDATE pieces piece
SET piece.title = 'Two Songs Without Words', piece.title_en = 'Two Songs Without Words, op. 22',
    piece.type = 'album', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10628 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Country Song', part.name_en = 'Two Songs Without Words, op. 22: I. Country Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10628 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:1eb12e02-d21a-4063-af5d-eede3f910278' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1eb12e02-d21a-4063-af5d-eede3f910278', 1, 'I', 'Country Song', 'Two Songs Without Words, op. 22: I. Country Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10628 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1eb12e02-d21a-4063-af5d-eede3f910278'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Marching Song', part.name_en = 'Two Songs Without Words, op. 22: II. Marching Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10628 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:d08d681c-e746-4da4-9f37-45b30ce7c2b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d08d681c-e746-4da4-9f37-45b30ce7c2b2', 2, 'II', 'Marching Song', 'Two Songs Without Words, op. 22: II. Marching Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10628 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d08d681c-e746-4da4-9f37-45b30ce7c2b2'
);


-- H. 9 변주곡

UPDATE pieces piece
SET piece.title = '변주곡', piece.title_en = 'Variations, H. 9',
    piece.type = 'song', piece.opus_number = 'H. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8339 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 7 Walt Whitman

UPDATE pieces piece
SET piece.title = 'Walt Whitman', piece.title_en = 'Walt Whitman, op. 7, H. 42',
    piece.type = 'song', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7783 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 182 Wassail Song

UPDATE pieces piece
SET piece.title = 'Wassail Song', piece.title_en = 'Wassail Song, H. 182',
    piece.type = 'song', piece.opus_number = 'H. 182',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10641 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 33 Whether We Die or Live

UPDATE pieces piece
SET piece.title = 'Whether We Die or Live', piece.title_en = 'Whether We Die or Live, H. 33',
    piece.type = 'song', piece.opus_number = 'H. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9968 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 목관 5중주 A♭장조

UPDATE pieces piece
SET piece.title = '목관 5중주 A♭장조', piece.title_en = 'Wind Quintet in A-flat major, op. 14',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8758 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato (un poco rubato)', part.name_en = 'Wind Quintet in A-flat major, op. 14: I. Allegro moderato (un poco rubato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8758 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:0a7be41b-32ee-416f-a8e9-4e5cd39468ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a7be41b-32ee-416f-a8e9-4e5cd39468ac', 1, 'I', 'Allegro moderato (un poco rubato)', 'Wind Quintet in A-flat major, op. 14: I. Allegro moderato (un poco rubato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8758 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a7be41b-32ee-416f-a8e9-4e5cd39468ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Wind Quintet in A-flat major, op. 14: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8758 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:c939b39b-b2d2-463f-b906-48e6272ef075' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c939b39b-b2d2-463f-b906-48e6272ef075', 2, 'II', 'Adagio', 'Wind Quintet in A-flat major, op. 14: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8758 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c939b39b-b2d2-463f-b906-48e6272ef075'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Minuet (in canon): Allegretto - Trio: Poco vivace', part.name_en = 'Wind Quintet in A-flat major, op. 14: III. Minuet (in canon): Allegretto - Trio: Poco vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8758 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:27ea152a-83e2-4574-8020-df66e9622b45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27ea152a-83e2-4574-8020-df66e9622b45', 3, 'III', 'Minuet (in canon): Allegretto - Trio: Poco vivace', 'Wind Quintet in A-flat major, op. 14: III. Minuet (in canon): Allegretto - Trio: Poco vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8758 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27ea152a-83e2-4574-8020-df66e9622b45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Air and Variations', part.name_en = 'Wind Quintet in A-flat major, op. 14: IV. Air and Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8758 AND p.composer_id = 70 AND part.part_key = 'musicbrainz:2b037d06-6862-4735-8356-f5e6d1daca74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b037d06-6862-4735-8356-f5e6d1daca74', 4, 'IV', 'Air and Variations', 'Wind Quintet in A-flat major, op. 14: IV. Air and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8758 AND p.composer_id = 70
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b037d06-6862-4735-8356-f5e6d1daca74'
);


-- None Winter and the birds

UPDATE pieces piece
SET piece.title = 'Winter and the birds', piece.title_en = 'Winter and the birds',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9734 AND piece.composer_id = 70
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- H. 173 A Moorside Suite

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A Moorside Suite', 'A Moorside Suite, H. 173', 'album', 'H. 173', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 70
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A Moorside Suite'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2559583-d9ab-4245-b2ee-8be5ff7f4bbc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e2559583-d9ab-4245-b2ee-8be5ff7f4bbc'
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'A Moorside Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e2559583-d9ab-4245-b2ee-8be5ff7f4bbc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee328c58-9d3f-3ffd-a6e9-e1aa955fc93b', 1, 'I', 'Scherzo', 'A Moorside Suite, H. 173: I. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'A Moorside Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee328c58-9d3f-3ffd-a6e9-e1aa955fc93b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51dc4dc6-33a0-30c3-8b14-913786bb2286', 2, 'II', 'Nocturne', 'A Moorside Suite, H. 173: II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'A Moorside Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51dc4dc6-33a0-30c3-8b14-913786bb2286'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3193ef5d-b627-3caa-abaf-bd070a39d1f1', 3, 'III', 'March', 'A Moorside Suite, H. 173: III. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'A Moorside Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3193ef5d-b627-3caa-abaf-bd070a39d1f1'
);


-- None All People That on Earth Do Dwell

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'All People That on Earth Do Dwell', 'All People That on Earth Do Dwell', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 70
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'All People That on Earth Do Dwell'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30d90e04-8bbf-483a-9bce-c51b6d0fd85b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30d90e04-8bbf-483a-9bce-c51b6d0fd85b'
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'All People That on Earth Do Dwell' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30d90e04-8bbf-483a-9bce-c51b6d0fd85b'
);


-- H. 54 Greeting

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Greeting', 'Greeting, H. 54', 'song', 'H. 54', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 70
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Greeting'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b231ecbe-bc99-42bb-9faf-832730a48ae1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b231ecbe-bc99-42bb-9faf-832730a48ae1'
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'Greeting' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b231ecbe-bc99-42bb-9faf-832730a48ae1'
);


-- None O Lady, Leave That Silken Thread

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'O Lady, Leave That Silken Thread', 'O Lady, Leave That Silken Thread', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 70
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'O Lady, Leave That Silken Thread'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f61ad5f-73a7-4c6b-9007-e25b01389121'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f61ad5f-73a7-4c6b-9007-e25b01389121'
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'O Lady, Leave That Silken Thread' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f61ad5f-73a7-4c6b-9007-e25b01389121'
);


-- Op. 30 The Cloud Messenger

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Cloud Messenger', 'The Cloud Messenger, op. 30', 'album', 'Op. 30', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 70
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Cloud Messenger'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3af57df2-2cd6-48dc-973d-582d4c4b58cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3af57df2-2cd6-48dc-973d-582d4c4b58cd'
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Cloud Messenger' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3af57df2-2cd6-48dc-973d-582d4c4b58cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52ec508b-63a2-3225-9f0a-cc576091d368', 1, 'I', 'Adagio', 'The Cloud Messenger, op. 30: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Cloud Messenger' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52ec508b-63a2-3225-9f0a-cc576091d368'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7de342cc-6f8e-37f6-a294-9dd5cd2aa2d8', 2, 'II', 'Allegro', 'The Cloud Messenger, op. 30: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Cloud Messenger' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7de342cc-6f8e-37f6-a294-9dd5cd2aa2d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:478b9e91-0899-33d6-89bc-74a6045f2c80', 3, 'III', 'Andante', 'The Cloud Messenger, op. 30: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Cloud Messenger' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:478b9e91-0899-33d6-89bc-74a6045f2c80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbbe20ea-4c62-39da-9ebe-c5e040370da0', 4, 'IV', 'Moderato maestoso, senza, accelerando', 'The Cloud Messenger, op. 30: IV. Moderato maestoso, senza, accelerando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Cloud Messenger' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbbe20ea-4c62-39da-9ebe-c5e040370da0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6184acc6-f6f3-3ded-9690-44808038aa18', 5, 'V', 'Adagio - Moderato', 'The Cloud Messenger, op. 30: V. Adagio - Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Cloud Messenger' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6184acc6-f6f3-3ded-9690-44808038aa18'
);


-- Op. 32 The Planets Op. 32

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Planets Op. 32', 'The Planets, op. 32', 'album', NULL, 'Op.', '32', NULL, 'manual', 1
FROM composers c
WHERE c.id = 70
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Planets Op. 32'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a01210f-0140-440a-98c7-0be594d32c21'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a01210f-0140-440a-98c7-0be594d32c21'
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Planets Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a01210f-0140-440a-98c7-0be594d32c21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:084f102a-96d5-4328-a40a-ef8fa17ec7dc', 1, 'I', 'Mars, the Bringer of War', 'The Planets, op. 32: I. Mars, the Bringer of War', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Planets Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:084f102a-96d5-4328-a40a-ef8fa17ec7dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce008ef9-f12f-4dce-a8ba-1c022ee7e243', 2, 'II', 'Venus, the Bringer of Peace', 'The Planets, op. 32: II. Venus, the Bringer of Peace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Planets Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce008ef9-f12f-4dce-a8ba-1c022ee7e243'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc26997c-9c66-4ac8-876b-f2a1c5ab54b9', 3, 'III', 'Mercury, the Winged Messenger', 'The Planets, op. 32: III. Mercury, the Winged Messenger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Planets Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc26997c-9c66-4ac8-876b-f2a1c5ab54b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dd726d0-450e-4bb0-a716-ca4253f52173', 4, 'IV', 'Jupiter, the Bringer of Jollity', 'The Planets, op. 32: IV. Jupiter, the Bringer of Jollity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Planets Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dd726d0-450e-4bb0-a716-ca4253f52173'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d9fd156-c10b-44fa-b9c9-d0e2d30b2623', 5, 'V', 'Saturn, the Bringer of Old Age', 'The Planets, op. 32: V. Saturn, the Bringer of Old Age', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Planets Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d9fd156-c10b-44fa-b9c9-d0e2d30b2623'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:807c5edc-31a8-4fcc-83a7-6724590d1317', 6, 'VI', 'Uranus, the Magician', 'The Planets, op. 32: VI. Uranus, the Magician', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Planets Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:807c5edc-31a8-4fcc-83a7-6724590d1317'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffaad41a-4123-4519-8e8e-36a148073fd9', 7, 'VII', 'Neptune, the Mystic', 'The Planets, op. 32: VII. Neptune, the Mystic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 70 AND p.title = 'The Planets Op. 32' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffaad41a-4123-4519-8e8e-36a148073fd9'
);


-- None 토카타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타', 'Toccata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 70
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62e8df59-546c-4b90-bac9-aa5569959076'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62e8df59-546c-4b90-bac9-aa5569959076'
FROM pieces p
WHERE p.composer_id = 70 AND p.title = '토카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62e8df59-546c-4b90-bac9-aa5569959076'
);


-- 카탈로그에 대응이 없는 seed 작품 21개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 70 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7483, 7715, 7723, 7817, 8199, 8428, 8560, 8592, 8597, 8815, 8848, 9290, 10119, 10210, 10266, 10459, 10463, 10770, 10900, 10992,
    11000
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
