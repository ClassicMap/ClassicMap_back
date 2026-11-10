-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 8/11).
-- 작품 3개(새 2개), seed 45개 중 잇기 29·숨김 16·그대로 0.
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

-- ===== Mina Kubota (composer_id 154) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 3개 중 음반 묶음 2개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 1개,
-- 새 작품 2개, part 30개, 그 아래 0개.
-- seed 45개 중 28개를 음반 묶음 안 곡으로 잇고, 1개는 낱개 작품으로 두고, 16개를 숨긴다.

-- None 가곡 <Vento>

UPDATE pieces piece
SET piece.title = '가곡 <Vento>', piece.title_en = 'Vento',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15954 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None TVアニメ「フォトカノ」オリジナルサウンドトラック

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'TVアニメ「フォトカノ」オリジナルサウンドトラック', 'TVアニメ「フォトカノ」オリジナルサウンドトラック', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 154
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17466 AND linked.composer_id = 154), 'musicbrainz:5838d70f-0f77-469e-80e3-450cf94ed1fd', 1, NULL, 'メインテーマ', 'メインテーマ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5838d70f-0f77-469e-80e3-450cf94ed1fd'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "メインテーマ"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: メインテーマ', piece.editor_locked = 1
WHERE piece.id = 17466 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16187 AND linked.composer_id = 154), 'musicbrainz:0bd2fc88-ea96-4237-b4a9-779d832e768a', 2, NULL, 'リボン', 'リボン', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bd2fc88-ea96-4237-b4a9-779d832e768a'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "リボン"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: リボン', piece.editor_locked = 1
WHERE piece.id = 16187 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16651 AND linked.composer_id = 154), 'musicbrainz:278887c9-502a-4cea-ae33-cc23bc486e12', 3, NULL, 'ライズボール', 'ライズボール', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:278887c9-502a-4cea-ae33-cc23bc486e12'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ライズボール"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: ライズボール', piece.editor_locked = 1
WHERE piece.id = 16651 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17039 AND linked.composer_id = 154), 'musicbrainz:3e6d1212-5abe-4fd7-b0ca-dee14301a025', 4, NULL, 'プリズム', 'プリズム', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e6d1212-5abe-4fd7-b0ca-dee14301a025'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "プリズム"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: プリズム', piece.editor_locked = 1
WHERE piece.id = 17039 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19559 AND linked.composer_id = 154), 'musicbrainz:dd19910f-5718-4fc5-a190-5764e6f24704', 5, NULL, '恋のはじまり', '恋のはじまり', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd19910f-5718-4fc5-a190-5764e6f24704'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "恋のはじまり"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: 恋のはじまり', piece.editor_locked = 1
WHERE piece.id = 19559 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19586 AND linked.composer_id = 154), 'musicbrainz:df61ac51-fb3a-4425-bad1-3516716995d3', 6, NULL, '写真部のテーマ', '写真部のテーマ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df61ac51-fb3a-4425-bad1-3516716995d3'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "写真部のテーマ"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: 写真部のテーマ', piece.editor_locked = 1
WHERE piece.id = 19586 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19322 AND linked.composer_id = 154), 'musicbrainz:cd7f55bb-8f06-4601-8a39-de2c9ef340a6', 7, NULL, 'ガールズ', 'ガールズ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd7f55bb-8f06-4601-8a39-de2c9ef340a6'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ガールズ"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: ガールズ', piece.editor_locked = 1
WHERE piece.id = 19322 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18742 AND linked.composer_id = 154), 'musicbrainz:a7a48396-dc66-4352-8ccb-048e49509366', 8, NULL, '風のダンス', '風のダンス', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7a48396-dc66-4352-8ccb-048e49509366'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "風のダンス"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: 風のダンス', piece.editor_locked = 1
WHERE piece.id = 18742 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a44c211-56dc-4432-8860-39633131f759', 9, NULL, '約束', '約束', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a44c211-56dc-4432-8860-39633131f759'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19927 AND linked.composer_id = 154), 'musicbrainz:f5c13c14-c878-4956-94bf-1ca26ad08f14', 10, NULL, 'スイートピー', 'スイートピー', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5c13c14-c878-4956-94bf-1ca26ad08f14'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "スイートピー"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: スイートピー', piece.editor_locked = 1
WHERE piece.id = 19927 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd265ab3-6c7b-461f-b399-d766a9ec5593', 11, NULL, '極秘会議', '極秘会議', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd265ab3-6c7b-461f-b399-d766a9ec5593'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17476 AND linked.composer_id = 154), 'musicbrainz:58db8dad-12eb-4070-b127-4dfc45e5b2e6', 12, NULL, '秋桜', '秋桜', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58db8dad-12eb-4070-b127-4dfc45e5b2e6'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "秋桜"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: 秋桜', piece.editor_locked = 1
WHERE piece.id = 17476 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17447 AND linked.composer_id = 154), 'musicbrainz:57777eb0-f479-4ab5-a24d-d2bff35d6b8b', 13, NULL, 'タンポポとこんぺいとう', 'タンポポとこんぺいとう', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57777eb0-f479-4ab5-a24d-d2bff35d6b8b'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "タンポポとこんぺいとう"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: タンポポとこんぺいとう', piece.editor_locked = 1
WHERE piece.id = 17447 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18350 AND linked.composer_id = 154), 'musicbrainz:8fb11750-8968-4a61-92d2-29f68673bc31', 14, NULL, 'メッセージ', 'メッセージ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fb11750-8968-4a61-92d2-29f68673bc31'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "メッセージ"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: メッセージ', piece.editor_locked = 1
WHERE piece.id = 18350 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18270 AND linked.composer_id = 154), 'musicbrainz:8b401f00-23fa-4e50-baf5-42fe0a9bf820', 15, NULL, 'あかね色', 'あかね色', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b401f00-23fa-4e50-baf5-42fe0a9bf820'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "あかね色"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: あかね色', piece.editor_locked = 1
WHERE piece.id = 18270 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17521 AND linked.composer_id = 154), 'musicbrainz:5bc063ef-3316-431f-9988-b9b1b85d7653', 16, NULL, 'ミッション', 'ミッション', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bc063ef-3316-431f-9988-b9b1b85d7653'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ミッション"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: ミッション', piece.editor_locked = 1
WHERE piece.id = 17521 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17773 AND linked.composer_id = 154), 'musicbrainz:6b3636d3-d072-4056-a424-450c137b72b0', 17, NULL, '星の見える丘', '星の見える丘', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b3636d3-d072-4056-a424-450c137b72b0'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "星の見える丘"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: 星の見える丘', piece.editor_locked = 1
WHERE piece.id = 17773 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18554 AND linked.composer_id = 154), 'musicbrainz:9c03deb5-202d-447b-b192-1ad517e6635b', 18, NULL, '想いの向こう', '想いの向こう', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c03deb5-202d-447b-b192-1ad517e6635b'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "想いの向こう"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: 想いの向こう', piece.editor_locked = 1
WHERE piece.id = 18554 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19170 AND linked.composer_id = 154), 'musicbrainz:c37075a6-1f59-4ecc-b757-77b7d1f6d131', 19, NULL, 'ピクニック', 'ピクニック', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c37075a6-1f59-4ecc-b757-77b7d1f6d131'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ピクニック"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: ピクニック', piece.editor_locked = 1
WHERE piece.id = 19170 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19555 AND linked.composer_id = 154), 'musicbrainz:dc9e9ae9-4c61-4cb6-95cb-fe6e9318f098', 20, NULL, 'ハートビート', 'ハートビート', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc9e9ae9-4c61-4cb6-95cb-fe6e9318f098'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ハートビート"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: ハートビート', piece.editor_locked = 1
WHERE piece.id = 19555 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17129 AND linked.composer_id = 154), 'musicbrainz:445fb703-4672-46b6-b59e-18373015b932', 21, NULL, 'ブルー', 'ブルー', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:445fb703-4672-46b6-b59e-18373015b932'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ブルー"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: ブルー', piece.editor_locked = 1
WHERE piece.id = 17129 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16847 AND linked.composer_id = 154), 'musicbrainz:33675d03-af6e-49b2-bbc7-0b7b98045c85', 22, NULL, 'ファニー・スパイ', 'ファニー・スパイ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33675d03-af6e-49b2-bbc7-0b7b98045c85'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "ファニー・スパイ"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: ファニー・スパイ', piece.editor_locked = 1
WHERE piece.id = 16847 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17645 AND linked.composer_id = 154), 'musicbrainz:63663c95-c6c8-4bc6-af12-fd0c416736a2', 23, NULL, '嘘と鏡', '嘘と鏡', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63663c95-c6c8-4bc6-af12-fd0c416736a2'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "嘘と鏡"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: 嘘と鏡', piece.editor_locked = 1
WHERE piece.id = 17645 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18863 AND linked.composer_id = 154), 'musicbrainz:afbde1cc-57da-4021-86f4-b8f43b12b361', 24, NULL, '17ステップス', '17ステップス', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afbde1cc-57da-4021-86f4-b8f43b12b361'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "17ステップス"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: 17ステップス', piece.editor_locked = 1
WHERE piece.id = 18863 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18611 AND linked.composer_id = 154), 'musicbrainz:a020b363-36a0-4c55-afad-db21138d83ea', 25, NULL, 'もの想う午後', 'もの想う午後', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a020b363-36a0-4c55-afad-db21138d83ea'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "もの想う午後"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: もの想う午後', piece.editor_locked = 1
WHERE piece.id = 18611 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18010 AND linked.composer_id = 154), 'musicbrainz:79da09c7-f499-4fb8-9243-2bb24e17f87b', 26, NULL, 'フォトセッション', 'フォトセッション', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79da09c7-f499-4fb8-9243-2bb24e17f87b'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "フォトセッション"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: フォトセッション', piece.editor_locked = 1
WHERE piece.id = 18010 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16814 AND linked.composer_id = 154), 'musicbrainz:31d242fb-c067-4bb6-af08-f79e21d47448', 27, NULL, '君を探して', '君を探して', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31d242fb-c067-4bb6-af08-f79e21d47448'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "君を探して"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: 君を探して', piece.editor_locked = 1
WHERE piece.id = 16814 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18674 AND linked.composer_id = 154), 'musicbrainz:a42bfa8a-2a75-4261-9f48-e0fd7f7ef146', 28, NULL, 'フォトグラフ', 'フォトグラフ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a42bfa8a-2a75-4261-9f48-e0fd7f7ef146'
);

UPDATE pieces piece
SET piece.title = 'TVアニメ「フォトカノ」オリジナルサウンドトラック 중 "フォトグラフ"', piece.title_en = 'TVアニメ「フォトカノ」オリジナルサウンドトラック: フォトグラフ', piece.editor_locked = 1
WHERE piece.id = 18674 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節-

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節-', 'ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節-', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 154
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節-'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15796 AND linked.composer_id = 154), 'musicbrainz:943765c8-c7bc-41a8-ac74-5f3c367413c9', 1, NULL, 'ユーフォリア', 'ユーフォリア', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節-' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:943765c8-c7bc-41a8-ac74-5f3c367413c9'
);

UPDATE pieces piece
SET piece.title = 'ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節- 중 "ユーフォリア"', piece.title_en = 'ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節-: ユーフォリア', piece.editor_locked = 1
WHERE piece.id = 15796 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15948 AND linked.composer_id = 154), 'musicbrainz:883da580-c8ac-4106-8bed-ab5805f66a88', 2, NULL, 'ウンディーネ', 'ウンディーネ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 154 AND p.title = 'ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節-' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:883da580-c8ac-4106-8bed-ab5805f66a88'
);

UPDATE pieces piece
SET piece.title = 'ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節- 중 "ウンディーネ"', piece.title_en = 'ARIA 〜ピアノ・コレクション〜 スタジオーネ -季節-: ウンディーネ', piece.editor_locked = 1
WHERE piece.id = 15948 AND piece.composer_id = 154
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 16개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 154 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15735, 15743, 15949, 15950, 15951, 15952, 15953, 15955, 15956, 15971, 15972, 15973, 16328, 18526, 18732, 19066
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
