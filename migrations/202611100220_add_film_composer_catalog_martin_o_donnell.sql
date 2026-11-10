-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 11/11).
-- 작품 1개(새 1개), seed 12개 중 잇기 12·숨김 0·그대로 0.
--
-- 영화·TV·게임·애니 작곡가는 4차 규칙 위에 음반 묶음을 얹었다(사람·에이전트 판단 없음).
-- 규칙은 seed_pipeline/curation/catalog-wave6-2026-11-10/tools/film_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave6-2026-11-10/<작곡가>/(catalog.json·seed_map.json·groups.json).
--   연주회용 작품(MB 갈래 교향곡·협주곡·오페라·칸타타 등, 우리말로 옮길 수 있는 갈래 제목,
--     갈래 없는 다악장·묶음)과 영화 단위 MB 작품(갈래 Soundtrack 이면서 part 가 있는 seed)은
--     4차 규칙 그대로 둔다.
--   큐·노래 seed 는 녹음이 실린 MusicBrainz 음반(release group) 하나에 묶는다. 음반이
--     한 줄 묶음 작품(type album, manual)이 되고 seed 는 그 안 곡(piece_parts.linked_piece_id)이
--     되며 제목은 「<묶음> 중 "<곡>"」으로 바뀐다. 곡 순서는 대표 판의 트랙 순서이고,
--     seed 가 없는 곡은 이름만 넣는다. seed 가 하나만 이어지는 음반은 묶지 않고 낱곡으로 둔다.
--   묶음 제목: 위키데이터에서 이 작곡가가 음악을 맡은 영화이면 「영화 <원제> 사운드트랙」,
--     그 영화의 한국어 위키백과 문서가 있으면 문서 제목을 한국 개봉 제목으로 쓴다.
--     모음집·TV·게임·애니·일반 음반은 음반 원제 그대로. 운영 작품 제목과 겹치면 「(음반)」.
--   어느 음반에도 없는 큐는 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     노래는 음반에 없어도 보이게 둔다. 비교 구간이 있거나 part 가 가리키는 작품은
--     숨기지 않는다. 두 번 돌려도 같다.

-- ===== Martin O'Donnell (composer_id 255) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 1개 중 음반 묶음 1개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 0개,
-- 새 작품 1개, part 12개, 그 아래 0개.
-- seed 12개 중 12개를 음반 묶음 안 곡으로 잇고, 0개는 낱개 작품으로 두고, 0개를 숨긴다.

-- None Echoes of the First Dreamer (The Musical Prequel to Golem)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Echoes of the First Dreamer (The Musical Prequel to Golem)', 'Echoes of the First Dreamer (The Musical Prequel to Golem)', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 255
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17844 AND linked.composer_id = 255), 'musicbrainz:6f2119eb-a620-4137-a6d5-33eb0c97aa67', 1, NULL, 'Dreamer’s Lullaby (Piano)', 'Dreamer’s Lullaby (Piano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f2119eb-a620-4137-a6d5-33eb0c97aa67'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Dreamer’s Lullaby (Piano)"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Dreamer’s Lullaby (Piano)', piece.editor_locked = 1
WHERE piece.id = 17844 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16004 AND linked.composer_id = 255), 'musicbrainz:0144556f-7669-4447-b7c9-93eece5732a3', 2, NULL, 'Kindled Echoes', 'Kindled Echoes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0144556f-7669-4447-b7c9-93eece5732a3'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Kindled Echoes"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Kindled Echoes', piece.editor_locked = 1
WHERE piece.id = 16004 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16954 AND linked.composer_id = 255), 'musicbrainz:394034b8-e8a5-43cf-8d80-5062ff17fa54', 3, NULL, 'Standing Alone', 'Standing Alone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:394034b8-e8a5-43cf-8d80-5062ff17fa54'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Standing Alone"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Standing Alone', piece.editor_locked = 1
WHERE piece.id = 16954 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19593 AND linked.composer_id = 255), 'musicbrainz:dfe3638e-9c19-47e7-93d6-6a2b7f5e08b7', 4, NULL, 'Lament in the Endless City (Orchestra)', 'Lament in the Endless City (Orchestra)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfe3638e-9c19-47e7-93d6-6a2b7f5e08b7'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Lament in the Endless City (Orchestra)"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Lament in the Endless City (Orchestra)', piece.editor_locked = 1
WHERE piece.id = 19593 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17614 AND linked.composer_id = 255), 'musicbrainz:615f739f-35e1-4fd1-b7c2-fe6c2a45fbae', 5, NULL, 'Vision of a Lasting Flame (Piano)', 'Vision of a Lasting Flame (Piano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:615f739f-35e1-4fd1-b7c2-fe6c2a45fbae'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Vision of a Lasting Flame (Piano)"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Vision of a Lasting Flame (Piano)', piece.editor_locked = 1
WHERE piece.id = 17614 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19304 AND linked.composer_id = 255), 'musicbrainz:cc02527a-e019-4559-8df4-2547d275fa60', 6, NULL, 'Silent Tide', 'Silent Tide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc02527a-e019-4559-8df4-2547d275fa60'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Silent Tide"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Silent Tide', piece.editor_locked = 1
WHERE piece.id = 19304 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17063 AND linked.composer_id = 255), 'musicbrainz:402b8789-8329-4b1c-b734-ee120319f023', 7, NULL, 'Lament in the Endless City (Piano)', 'Lament in the Endless City (Piano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:402b8789-8329-4b1c-b734-ee120319f023'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Lament in the Endless City (Piano)"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Lament in the Endless City (Piano)', piece.editor_locked = 1
WHERE piece.id = 17063 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19362 AND linked.composer_id = 255), 'musicbrainz:d019b79f-fe50-42b7-aba5-348a3a5a0a62', 8, NULL, 'Dreamer’s Lullaby (Orchestra)', 'Dreamer’s Lullaby (Orchestra)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d019b79f-fe50-42b7-aba5-348a3a5a0a62'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Dreamer’s Lullaby (Orchestra)"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Dreamer’s Lullaby (Orchestra)', piece.editor_locked = 1
WHERE piece.id = 19362 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17629 AND linked.composer_id = 255), 'musicbrainz:624697bb-95c6-4a60-b9fc-548c7a193a38', 9, NULL, 'Vision of a Lasting Flame (Piano and Orchestra)', 'Vision of a Lasting Flame (Piano and Orchestra)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:624697bb-95c6-4a60-b9fc-548c7a193a38'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Vision of a Lasting Flame (Piano and Orchestra)"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Vision of a Lasting Flame (Piano and Orchestra)', piece.editor_locked = 1
WHERE piece.id = 17629 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19424 AND linked.composer_id = 255), 'musicbrainz:d3e22e2c-1cb1-488f-ba2d-2a5f511093f7', 10, NULL, 'Seek and Hide', 'Seek and Hide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3e22e2c-1cb1-488f-ba2d-2a5f511093f7'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Seek and Hide"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Seek and Hide', piece.editor_locked = 1
WHERE piece.id = 19424 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17374 AND linked.composer_id = 255), 'musicbrainz:538d01e8-7a5f-42b8-a5be-91fda4f61478', 11, NULL, 'Path of the Golem', 'Path of the Golem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:538d01e8-7a5f-42b8-a5be-91fda4f61478'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Path of the Golem"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Path of the Golem', piece.editor_locked = 1
WHERE piece.id = 17374 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18261 AND linked.composer_id = 255), 'musicbrainz:8acdcedd-9d8d-4118-b4bc-8b3c2b4f9b7b', 12, NULL, 'Fanfare', 'Fanfare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 255 AND p.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8acdcedd-9d8d-4118-b4bc-8b3c2b4f9b7b'
);

UPDATE pieces piece
SET piece.title = 'Echoes of the First Dreamer (The Musical Prequel to Golem) 중 "Fanfare"', piece.title_en = 'Echoes of the First Dreamer (The Musical Prequel to Golem): Fanfare', piece.editor_locked = 1
WHERE piece.id = 18261 AND piece.composer_id = 255
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음
