-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 9/9).
-- 작품 4개(새 2개), seed 31개 중 잇기 24·숨김 7·그대로 0.
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

-- ===== 사에구사 시게아키 (composer_id 310) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 4개 중 음반 묶음 2개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 2개,
-- 새 작품 2개, part 22개, 그 아래 0개.
-- seed 31개 중 22개를 음반 묶음 안 곡으로 잇고, 2개는 낱개 작품으로 두고, 7개를 숨긴다.

-- None 가곡 <BLUE ENDLESS WAY>

UPDATE pieces piece
SET piece.title = '가곡 <BLUE ENDLESS WAY>', piece.title_en = 'BLUE ENDLESS WAY',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15946 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Duo '87

UPDATE pieces piece
SET piece.title = 'Duo ''87', piece.title_en = 'Duo ''87',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18876 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック', '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 310
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15943 AND linked.composer_id = 310), 'musicbrainz:37c24856-6371-475b-88f5-b731dfd64f48', 1, NULL, 'MAIN TITLE (メイン・タイトル)', 'MAIN TITLE (メイン・タイトル)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37c24856-6371-475b-88f5-b731dfd64f48'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "MAIN TITLE (メイン・タイトル)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: MAIN TITLE (メイン・タイトル)', piece.editor_locked = 1
WHERE piece.id = 15943 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15930 AND linked.composer_id = 310), 'musicbrainz:92d1b100-c77c-4d15-8891-3ea16bc87b35', 2, NULL, 'QUESS PARAYA (クェス・パラヤ)', 'QUESS PARAYA (クェス・パラヤ)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d1b100-c77c-4d15-8891-3ea16bc87b35'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "QUESS PARAYA (クェス・パラヤ)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: QUESS PARAYA (クェス・パラヤ)', piece.editor_locked = 1
WHERE piece.id = 15930 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15931 AND linked.composer_id = 310), 'musicbrainz:db11dc7f-6f7b-4728-b4dd-e52760fbbe4c', 3, NULL, 'NEO ZION (ネオ・ジオン軍)', 'NEO ZION (ネオ・ジオン軍)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db11dc7f-6f7b-4728-b4dd-e52760fbbe4c'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "NEO ZION (ネオ・ジオン軍)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: NEO ZION (ネオ・ジオン軍)', piece.editor_locked = 1
WHERE piece.id = 15931 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15932 AND linked.composer_id = 310), 'musicbrainz:39504e25-52e9-4ac6-b46a-b6fb35693fb5', 4, NULL, 'SALLY (出撃)', 'SALLY (出撃)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39504e25-52e9-4ac6-b46a-b6fb35693fb5'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "SALLY (出撃)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: SALLY (出撃)', piece.editor_locked = 1
WHERE piece.id = 15932 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15933 AND linked.composer_id = 310), 'musicbrainz:1317b7c1-25ac-4ed9-8f14-8cc723b628c5', 5, NULL, 'RONDO BELL (ロンド・ベル隊)', 'RONDO BELL (ロンド・ベル隊)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1317b7c1-25ac-4ed9-8f14-8cc723b628c5'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "RONDO BELL (ロンド・ベル隊)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: RONDO BELL (ロンド・ベル隊)', piece.editor_locked = 1
WHERE piece.id = 15933 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15934 AND linked.composer_id = 310), 'musicbrainz:b815dd0a-f332-45d7-a884-c01869ce8b42', 6, NULL, 'SWAN (白鳥)', 'SWAN (白鳥)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b815dd0a-f332-45d7-a884-c01869ce8b42'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "SWAN (白鳥)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: SWAN (白鳥)', piece.editor_locked = 1
WHERE piece.id = 15934 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15935 AND linked.composer_id = 310), 'musicbrainz:0bdb990c-fde7-4e5c-a514-a8bf19d25248', 7, NULL, 'ν GUNDAM (ニュー・ガンダム)', 'ν GUNDAM (ニュー・ガンダム)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bdb990c-fde7-4e5c-a514-a8bf19d25248'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "ν GUNDAM (ニュー・ガンダム)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: ν GUNDAM (ニュー・ガンダム)', piece.editor_locked = 1
WHERE piece.id = 15935 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15936 AND linked.composer_id = 310), 'musicbrainz:07a57cff-f800-4b0b-8cbd-a94735f427f2', 8, NULL, 'ANXIETY (不安)', 'ANXIETY (不安)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07a57cff-f800-4b0b-8cbd-a94735f427f2'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "ANXIETY (不安)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: ANXIETY (不安)', piece.editor_locked = 1
WHERE piece.id = 15936 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15937 AND linked.composer_id = 310), 'musicbrainz:8b9f5037-abe6-4c98-99c3-7dbc2664c458', 9, NULL, 'MISSION (使命)', 'MISSION (使命)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b9f5037-abe6-4c98-99c3-7dbc2664c458'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "MISSION (使命)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: MISSION (使命)', piece.editor_locked = 1
WHERE piece.id = 15937 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15938 AND linked.composer_id = 310), 'musicbrainz:9dce0502-89d5-4023-9d3b-1087da75ae5b', 10, NULL, 'AXCIS (惑星アクシズ)', 'AXCIS (惑星アクシズ)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dce0502-89d5-4023-9d3b-1087da75ae5b'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "AXCIS (惑星アクシズ)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: AXCIS (惑星アクシズ)', piece.editor_locked = 1
WHERE piece.id = 15938 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15939 AND linked.composer_id = 310), 'musicbrainz:bb7a6cf8-a295-4f03-9758-23d5f2386b4d', 11, NULL, 'SACRIFICE (犠牲)', 'SACRIFICE (犠牲)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb7a6cf8-a295-4f03-9758-23d5f2386b4d'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "SACRIFICE (犠牲)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: SACRIFICE (犠牲)', piece.editor_locked = 1
WHERE piece.id = 15939 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15940 AND linked.composer_id = 310), 'musicbrainz:fac04b75-b2c9-4aac-a27e-fdb45e2261a5', 12, NULL, 'COMBAT (格闘)', 'COMBAT (格闘)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fac04b75-b2c9-4aac-a27e-fdb45e2261a5'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "COMBAT (格闘)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: COMBAT (格闘)', piece.editor_locked = 1
WHERE piece.id = 15940 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15941 AND linked.composer_id = 310), 'musicbrainz:dd2ecf7a-4687-4fe7-b999-5d834dfcc92a', 13, NULL, 'DESTINY (宿命)', 'DESTINY (宿命)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd2ecf7a-4687-4fe7-b999-5d834dfcc92a'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "DESTINY (宿命)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: DESTINY (宿命)', piece.editor_locked = 1
WHERE piece.id = 15941 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15942 AND linked.composer_id = 310), 'musicbrainz:984021d4-03be-478a-ae2b-68e7739c30bd', 14, NULL, 'AURORA (オーロラ)', 'AURORA (オーロラ)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:984021d4-03be-478a-ae2b-68e7739c30bd'
);

UPDATE pieces piece
SET piece.title = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック 중 "AURORA (オーロラ)"', piece.title_en = '機動戦士ガンダム 逆襲のシャア オリジナル・サウンドトラック: AURORA (オーロラ)', piece.editor_locked = 1
WHERE piece.id = 15942 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 30億光年の宇宙 〜星たちの軌跡〜

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '30億光年の宇宙 〜星たちの軌跡〜', '30億光年の宇宙 〜星たちの軌跡〜', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 310
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '30億光年の宇宙 〜星たちの軌跡〜'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16893 AND linked.composer_id = 310), 'musicbrainz:35d86d79-335a-44ed-90af-335fc546ca35', 1, NULL, 'Startrek = スタートレック', 'Startrek = スタートレック', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '30億光年の宇宙 〜星たちの軌跡〜' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35d86d79-335a-44ed-90af-335fc546ca35'
);

UPDATE pieces piece
SET piece.title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Startrek = スタートレック"', piece.title_en = '30億光年の宇宙 〜星たちの軌跡〜: Startrek = スタートレック', piece.editor_locked = 1
WHERE piece.id = 16893 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18056 AND linked.composer_id = 310), 'musicbrainz:7c2da95d-5926-40b6-8cf6-30f6f8ac67d8', 2, NULL, 'Orion Nebula = オリオン大星雲', 'Orion Nebula = オリオン大星雲', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '30億光年の宇宙 〜星たちの軌跡〜' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c2da95d-5926-40b6-8cf6-30f6f8ac67d8'
);

UPDATE pieces piece
SET piece.title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Orion Nebula = オリオン大星雲"', piece.title_en = '30億光年の宇宙 〜星たちの軌跡〜: Orion Nebula = オリオン大星雲', piece.editor_locked = 1
WHERE piece.id = 18056 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17892 AND linked.composer_id = 310), 'musicbrainz:71a95ec3-8d2a-455b-ae3c-97dfbca5d899', 3, NULL, 'Radio Galaxy M87 = 電波銀河', 'Radio Galaxy M87 = 電波銀河', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '30億光年の宇宙 〜星たちの軌跡〜' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71a95ec3-8d2a-455b-ae3c-97dfbca5d899'
);

UPDATE pieces piece
SET piece.title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Radio Galaxy M87 = 電波銀河"', piece.title_en = '30億光年の宇宙 〜星たちの軌跡〜: Radio Galaxy M87 = 電波銀河', piece.editor_locked = 1
WHERE piece.id = 17892 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17292 AND linked.composer_id = 310), 'musicbrainz:4d91bed2-1243-40d7-ac2d-d83992272830', 4, NULL, 'Quasar 3C273 = クェーサー', 'Quasar 3C273 = クェーサー', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '30億光年の宇宙 〜星たちの軌跡〜' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d91bed2-1243-40d7-ac2d-d83992272830'
);

UPDATE pieces piece
SET piece.title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Quasar 3C273 = クェーサー"', piece.title_en = '30億光年の宇宙 〜星たちの軌跡〜: Quasar 3C273 = クェーサー', piece.editor_locked = 1
WHERE piece.id = 17292 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20048 AND linked.composer_id = 310), 'musicbrainz:fca4cc10-fb3f-43b6-b928-2db66b00e8f9', 5, NULL, 'Pulser = バルサー', 'Pulser = バルサー', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '30億光年の宇宙 〜星たちの軌跡〜' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fca4cc10-fb3f-43b6-b928-2db66b00e8f9'
);

UPDATE pieces piece
SET piece.title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Pulser = バルサー"', piece.title_en = '30億光年の宇宙 〜星たちの軌跡〜: Pulser = バルサー', piece.editor_locked = 1
WHERE piece.id = 20048 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17273 AND linked.composer_id = 310), 'musicbrainz:4bfb7470-cc05-4ab5-bd0d-bcf3a0cbf23e', 6, NULL, 'Ring Nebula M57 = リング星雲', 'Ring Nebula M57 = リング星雲', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '30億光年の宇宙 〜星たちの軌跡〜' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bfb7470-cc05-4ab5-bd0d-bcf3a0cbf23e'
);

UPDATE pieces piece
SET piece.title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Ring Nebula M57 = リング星雲"', piece.title_en = '30億光年の宇宙 〜星たちの軌跡〜: Ring Nebula M57 = リング星雲', piece.editor_locked = 1
WHERE piece.id = 17273 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17296 AND linked.composer_id = 310), 'musicbrainz:4dee2483-12f9-4ac4-a860-ff64966fa949', 7, NULL, 'Startrek (Reprise) = スタートレック(リプライズ)', 'Startrek (Reprise) = スタートレック(リプライズ)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '30億光年の宇宙 〜星たちの軌跡〜' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dee2483-12f9-4ac4-a860-ff64966fa949'
);

UPDATE pieces piece
SET piece.title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Startrek (Reprise) = スタートレック(リプライズ)"', piece.title_en = '30億光年の宇宙 〜星たちの軌跡〜: Startrek (Reprise) = スタートレック(リプライズ)', piece.editor_locked = 1
WHERE piece.id = 17296 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17018 AND linked.composer_id = 310), 'musicbrainz:3d454865-219e-4704-98c9-de9d8f6ee078', 8, NULL, 'Globular Cluster = 球状星团', 'Globular Cluster = 球状星团', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 310 AND p.title = '30億光年の宇宙 〜星たちの軌跡〜' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d454865-219e-4704-98c9-de9d8f6ee078'
);

UPDATE pieces piece
SET piece.title = '30億光年の宇宙 〜星たちの軌跡〜 중 "Globular Cluster = 球状星团"', piece.title_en = '30億光年の宇宙 〜星たちの軌跡〜: Globular Cluster = 球状星团', piece.editor_locked = 1
WHERE piece.id = 17018 AND piece.composer_id = 310
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 7개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 310 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15724, 15778, 15926, 15928, 15945, 15947, 17363
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
