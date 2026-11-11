-- 남은 원어 seed 정리(1/2). 작곡가 25명, seed 439개:
-- 잇기 14, 묶음 안 곡 373(이름 묶음 56·음반 묶음 4), 숨김 0, 그대로 43.
--
-- 4·5·6차 자동 카탈로그가 판단하지 못한 seed(origin=seed, 잠기지 않음, 숨기지 않음)다. 대부분
-- 「Antigonae: I. …」처럼 MusicBrainz 에서 부모 작품 관계가 없는 악장·대목 work 라 목록 맨 위에 낱곡으로
-- 흩어져 보였다. 결정과 근거는 seed_pipeline/curation/leftover-seeds-2026-11-11/decisions.jsonl, 규칙은 tools/leftover.py.
--   잇기: 카탈로그 작품의 part 와 같은 곡(MB 제목이 같거나, 작품번호가 겹치고 악장 번호·이름이 같음)이면
--     그 part 에 잇고 제목을 「<작품> 중 "<곡>"」으로 바꾼다. part 가 이미 다른 작품을 가리키면 숨긴다.
--   이름 묶음: 콜론 앞 이름이 같은 seed 가 둘 이상이면 그 이름으로 작품(manual, 묶음)을 새로 만들고
--     seed 를 그 안 곡으로 잇는다. 제목은 seed 의 우리말 제목 앞부분, 없으면 4차 제목 규칙.
--   음반 묶음: 낱개 seed 는 녹음이 실린 MB 음반이 같은 것끼리 셋 이상이면 음반 이름으로 묶는다
--     (모음집·실황·전집 음반과 작품번호가 있는 seed 는 빼고).
--   숨김: hidden_reason='catalog_unmatched'(지우지 않음). 비교 구간이 있거나 part 가 가리키면 숨기지 않는다.
--   두 번 넣어도 같다.

-- ===== 보케리니 (composer_id 20) =====
-- 잇기 13, 새 묶음 9(이름) + 0(음반), 숨김 0, 그대로 3

-- 카탈로그 part 에 잇기
UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 7826 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:28decd14-6be1-4526-908c-19f3536e55db' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 F장조 중 "Adagio ma non tanto"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 74 in F major, Op. 39 No. 2 G. 338: II. Adagio ma non tanto', piece.editor_locked = 1
WHERE piece.id = 7826 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:28decd14-6be1-4526-908c-19f3536e55db'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 7864 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:6b606da1-19af-4bab-9aa8-96bfc6bae5b3' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 B♭장조 중 "Rondeau. Allegro non tanto"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 73 in B-flat major, Op. 39 No. 1 G. 337: V. Rondeau. Allegro non tanto', piece.editor_locked = 1
WHERE piece.id = 7864 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:6b606da1-19af-4bab-9aa8-96bfc6bae5b3'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 7931 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:35aa27a1-1abc-4662-b261-09ee2543572f' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 D장조 중 "Finale. Presto"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 75 in D major, Op. 39 No. 3 G. 339: III. Finale. Presto', piece.editor_locked = 1
WHERE piece.id = 7931 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:35aa27a1-1abc-4662-b261-09ee2543572f'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 8268 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:3392c6da-0dbc-4659-9046-599d5c903673' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 D장조 중 "Pastorale amoroso ma non lento"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 75 in D major, Op. 39 No. 3 G. 339: II. Pastorale. Amoroso ma non lento', piece.editor_locked = 1
WHERE piece.id = 8268 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:3392c6da-0dbc-4659-9046-599d5c903673'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 8554 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:78b6fb5f-c6f9-4e70-8e32-55e6e3bd1298' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 B♭장조 중 "Tempo di minuetto"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 73 in B-flat major, Op. 39 No. 1 G. 337: III. Tempo di Minuetto', piece.editor_locked = 1
WHERE piece.id = 8554 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:78b6fb5f-c6f9-4e70-8e32-55e6e3bd1298'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 8694 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:c3df442b-c3bb-4b3a-812f-a31eed46e004' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 F장조 중 "Allegro vivo ma non presto"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 74 in F major, Op. 39 No. 2 G. 338: I. Allegro vivo ma non presto', piece.editor_locked = 1
WHERE piece.id = 8694 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:c3df442b-c3bb-4b3a-812f-a31eed46e004'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 8927 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:5a7fb911-5935-4598-8c96-56f184a638b6' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 F장조 중 "Minuetto – Trio"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 74 in F major, Op. 39 No. 2 G. 338: III. Minuetto e Trio', piece.editor_locked = 1
WHERE piece.id = 8927 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:5a7fb911-5935-4598-8c96-56f184a638b6'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 9139 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:e14598db-ddac-46c5-9f70-ab93caab16d0' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 B♭장조 중 "Allegro vivo"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 73 in B-flat major, Op. 39 No. 1 G. 337: II. Allegro vivo', piece.editor_locked = 1
WHERE piece.id = 9139 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:e14598db-ddac-46c5-9f70-ab93caab16d0'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 9757 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:434c93db-37dc-4c6d-9ac0-890bc0aee5e2' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 D장조 중 "Allegro vivo"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 75 in D major, Op. 39 No. 3 G. 339: I. Allegro vivo', piece.editor_locked = 1
WHERE piece.id = 9757 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:434c93db-37dc-4c6d-9ac0-890bc0aee5e2'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 10533 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:c8a0c8f1-7393-480a-b7cd-d98ab1bea05e' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 B♭장조 중 "Grave"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 73 in B-flat major, Op. 39 No. 1 G. 337: IV. Grave', piece.editor_locked = 1
WHERE piece.id = 10533 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:c8a0c8f1-7393-480a-b7cd-d98ab1bea05e'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 10645 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:2aa4c104-c91b-45c6-88c6-379c441cb317' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 B♭장조 중 "Andante lento"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 73 in B-flat major, Op. 39 No. 1 G. 337: I. Andante lento', piece.editor_locked = 1
WHERE piece.id = 10645 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:2aa4c104-c91b-45c6-88c6-379c441cb317'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 10920 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:b10ef14c-24f8-411a-9813-98c80fd323ba' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 F장조 중 "Finale. Allegro vivo ma non presto"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 74 in F major, Op. 39 No. 2 G. 338: IV. Finale. Allegro vivo ma non presto', piece.editor_locked = 1
WHERE piece.id = 10920 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:b10ef14c-24f8-411a-9813-98c80fd323ba'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 11166 AND seed.composer_id = 20 AND seed.origin = 'seed')
WHERE owner.id = 10716 AND owner.composer_id = 20
  AND part.part_key = 'musicbrainz:5bc3b2a0-0745-4101-a02f-c35c2d676a08' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 현악 5중주 Op. 39 B♭장조 중 "Minuetto – Trio"', piece.title_en = 'Quintet for 2 Violins, Viola, and 2 Cellos No. 73 in B-flat major, Op. 39 No. 1 G. 337: VI. Minuetto', piece.editor_locked = 1
WHERE piece.id = 11166 AND piece.composer_id = 20 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 10716 AND part.part_key = 'musicbrainz:5bc3b2a0-0745-4101-a02f-c35c2d676a08'
      AND part.linked_piece_id = piece.id
  );

-- None 첼로와 관현악을 위한 협주곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 관현악을 위한 협주곡 B♭장조', 'Concerto In Si Bemolle Maggiore Per Violoncello E Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 20
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 관현악을 위한 협주곡 B♭장조'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8156 AND linked.composer_id = 20), 'musicbrainz:1d3b42ee-46b0-4aed-842e-3e870b209879', 1, 'I', 'Allegro Moderato', 'Allegro Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '첼로와 관현악을 위한 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d3b42ee-46b0-4aed-842e-3e870b209879'
);

UPDATE pieces piece
SET piece.title = '첼로와 관현악을 위한 협주곡 B♭장조 중 "Allegro Moderato"', piece.title_en = 'Concerto In Si Bemolle Maggiore Per Violoncello E Orchestra: Allegro Moderato', piece.editor_locked = 1
WHERE piece.id = 8156 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8782 AND linked.composer_id = 20), 'musicbrainz:4b63b3b3-c913-4630-a56e-3d5c95a3870d', 2, 'II', 'Adagio Non Troppo', 'Adagio Non Troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '첼로와 관현악을 위한 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b63b3b3-c913-4630-a56e-3d5c95a3870d'
);

UPDATE pieces piece
SET piece.title = '첼로와 관현악을 위한 협주곡 B♭장조 중 "Adagio Non Troppo"', piece.title_en = 'Concerto In Si Bemolle Maggiore Per Violoncello E Orchestra: Adagio Non Troppo', piece.editor_locked = 1
WHERE piece.id = 8782 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11107 AND linked.composer_id = 20), 'musicbrainz:f3ce12d5-51e1-4248-9b85-172aa0ebe1a9', 3, 'III', 'Rondò (Allegro)', 'Rondò (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '첼로와 관현악을 위한 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3ce12d5-51e1-4248-9b85-172aa0ebe1a9'
);

UPDATE pieces piece
SET piece.title = '첼로와 관현악을 위한 협주곡 B♭장조 중 "Rondò (Allegro)"', piece.title_en = 'Concerto In Si Bemolle Maggiore Per Violoncello E Orchestra: Rondò (Allegro)', piece.editor_locked = 1
WHERE piece.id = 11107 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조', 'Quartett für Flöte, Violine, Viola und Violoncello in D-Dur', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 20
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11251 AND linked.composer_id = 20), 'musicbrainz:fd7e60ee-f8c0-36a5-bf7b-8257ab619766', 1, NULL, 'Allegro vivace (Pro-Arte-Quartett)', 'Allegro vivace (Pro-Arte-Quartett)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd7e60ee-f8c0-36a5-bf7b-8257ab619766'
);

UPDATE pieces piece
SET piece.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조 중 "Allegro vivace (Pro-Arte-Quartett)"', piece.title_en = 'Quartett für Flöte, Violine, Viola und Violoncello in D-Dur: Allegro vivace (Pro-Arte-Quartett)', piece.editor_locked = 1
WHERE piece.id = 11251 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9232 AND linked.composer_id = 20), 'musicbrainz:6b2bc105-33d8-3791-9fdf-3d9e01b2e201', 2, NULL, 'Menuett (Pro-Arte-Quartett)', 'Menuett (Pro-Arte-Quartett)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b2bc105-33d8-3791-9fdf-3d9e01b2e201'
);

UPDATE pieces piece
SET piece.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조 중 "Menuett (Pro-Arte-Quartett)"', piece.title_en = 'Quartett für Flöte, Violine, Viola und Violoncello in D-Dur: Menuett (Pro-Arte-Quartett)', piece.editor_locked = 1
WHERE piece.id = 9232 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10159 AND linked.composer_id = 20), 'musicbrainz:acfd1466-def3-3c35-966d-0f5a89d5b6a0', 3, NULL, 'Larghetto (Pro-Arte-Quartett)', 'Larghetto (Pro-Arte-Quartett)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acfd1466-def3-3c35-966d-0f5a89d5b6a0'
);

UPDATE pieces piece
SET piece.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조 중 "Larghetto (Pro-Arte-Quartett)"', piece.title_en = 'Quartett für Flöte, Violine, Viola und Violoncello in D-Dur: Larghetto (Pro-Arte-Quartett)', piece.editor_locked = 1
WHERE piece.id = 10159 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9374 AND linked.composer_id = 20), 'musicbrainz:749d7b07-8c46-3894-aa6f-89f49001fe7a', 4, NULL, 'Finale: Presto (Pro-Arte-Quartett)', 'Finale: Presto (Pro-Arte-Quartett)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:749d7b07-8c46-3894-aa6f-89f49001fe7a'
);

UPDATE pieces piece
SET piece.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조 중 "Finale: Presto (Pro-Arte-Quartett)"', piece.title_en = 'Quartett für Flöte, Violine, Viola und Violoncello in D-Dur: Finale: Presto (Pro-Arte-Quartett)', piece.editor_locked = 1
WHERE piece.id = 9374 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- G 429 플루트와 현악을 위한 5중주 B♭장조 G 429

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 현악을 위한 5중주 B♭장조 G 429', 'Quintet for flute and strings in B flat major, G 429', 'album', NULL, 'G', '429', NULL, 'manual', 1
FROM composers c
WHERE c.id = 20
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 현악을 위한 5중주 B♭장조 G 429'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8675 AND linked.composer_id = 20), 'musicbrainz:4414d65f-0c19-49c7-8e4f-196a70b98bf2', 1, 'I', 'Allegro moderato', 'Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 B♭장조 G 429' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4414d65f-0c19-49c7-8e4f-196a70b98bf2'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 B♭장조 G 429 중 "Allegro moderato"', piece.title_en = 'Quintet for flute and strings in B flat major, G 429: Allegro moderato', piece.editor_locked = 1
WHERE piece.id = 8675 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8053 AND linked.composer_id = 20), 'musicbrainz:15388f41-4a53-40cd-bb34-d373e67faf20', 2, 'II', 'Presto assai', 'Presto assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 B♭장조 G 429' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15388f41-4a53-40cd-bb34-d373e67faf20'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 B♭장조 G 429 중 "Presto assai"', piece.title_en = 'Quintet for flute and strings in B flat major, G 429: Presto assai', piece.editor_locked = 1
WHERE piece.id = 8053 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- G 427 플루트와 현악을 위한 5중주 C장조 G 427

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 현악을 위한 5중주 C장조 G 427', 'Quintet for flute and strings in C major, G 427', 'album', NULL, 'G', '427', NULL, 'manual', 1
FROM composers c
WHERE c.id = 20
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 현악을 위한 5중주 C장조 G 427'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9458 AND linked.composer_id = 20), 'musicbrainz:7aa6fdf3-f0a6-43cc-abce-3076bf026b40', 1, 'I', 'Andante non tanto', 'Andante non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 C장조 G 427' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aa6fdf3-f0a6-43cc-abce-3076bf026b40'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 C장조 G 427 중 "Andante non tanto"', piece.title_en = 'Quintet for flute and strings in C major, G 427: Andante non tanto', piece.editor_locked = 1
WHERE piece.id = 9458 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7866 AND linked.composer_id = 20), 'musicbrainz:09406a11-bb9f-4e82-99f7-ec1ffee2cdda', 2, 'II', 'Rondeau grazioso', 'Rondeau grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 C장조 G 427' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09406a11-bb9f-4e82-99f7-ec1ffee2cdda'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 C장조 G 427 중 "Rondeau grazioso"', piece.title_en = 'Quintet for flute and strings in C major, G 427: Rondeau grazioso', piece.editor_locked = 1
WHERE piece.id = 7866 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- G 428 플루트와 현악을 위한 5중주 D장조 G 428

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 현악을 위한 5중주 D장조 G 428', 'Quintet for flute and strings in D major, G 428', 'album', NULL, 'G', '428', NULL, 'manual', 1
FROM composers c
WHERE c.id = 20
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 현악을 위한 5중주 D장조 G 428'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9923 AND linked.composer_id = 20), 'musicbrainz:9b96bdc3-8c41-4365-a960-2259b361666d', 1, 'I', 'Adagio assai', 'Adagio assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 D장조 G 428' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b96bdc3-8c41-4365-a960-2259b361666d'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 D장조 G 428 중 "Adagio assai"', piece.title_en = 'Quintet for flute and strings in D major, G 428: Adagio assai', piece.editor_locked = 1
WHERE piece.id = 9923 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9441 AND linked.composer_id = 20), 'musicbrainz:7980644a-53e8-4e45-ae9c-16392da1ea7b', 2, 'II', 'Minuetto con moto', 'Minuetto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 D장조 G 428' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7980644a-53e8-4e45-ae9c-16392da1ea7b'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 D장조 G 428 중 "Minuetto con moto"', piece.title_en = 'Quintet for flute and strings in D major, G 428: Minuetto con moto', piece.editor_locked = 1
WHERE piece.id = 9441 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas"', 'Quintet for flute and strings in D major, G 430 "Las Parejas"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 20
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas"'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8841 AND linked.composer_id = 20), 'musicbrainz:503e7962-84c9-4cfa-986e-f5de0bb39790', 1, 'I', 'Entrada - Marcia', 'Entrada - Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:503e7962-84c9-4cfa-986e-f5de0bb39790'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Entrada - Marcia"', piece.title_en = 'Quintet for flute and strings in D major, G 430 "Las Parejas": Entrada - Marcia', piece.editor_locked = 1
WHERE piece.id = 8841 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9205 AND linked.composer_id = 20), 'musicbrainz:6965a6a4-0cda-4ea9-b9e7-5ac43917f1fc', 2, 'II', 'Galope', 'Galope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6965a6a4-0cda-4ea9-b9e7-5ac43917f1fc'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas" 중 "Galope"', piece.title_en = 'Quintet for flute and strings in D major, G 430 "Las Parejas": Galope', piece.editor_locked = 1
WHERE piece.id = 9205 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- G 425 플루트와 현악을 위한 5중주 E♭장조 G 425

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 현악을 위한 5중주 E♭장조 G 425', 'Quintet for flute and strings in E flat major, G 425', 'album', NULL, 'G', '425', NULL, 'manual', 1
FROM composers c
WHERE c.id = 20
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 현악을 위한 5중주 E♭장조 G 425'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8465 AND linked.composer_id = 20), 'musicbrainz:343a28c6-6df3-4cea-b9e1-7beb93569567', 1, 'I', 'Allegro con moto', 'Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 E♭장조 G 425' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:343a28c6-6df3-4cea-b9e1-7beb93569567'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 E♭장조 G 425 중 "Allegro con moto"', piece.title_en = 'Quintet for flute and strings in E flat major, G 425: Allegro con moto', piece.editor_locked = 1
WHERE piece.id = 8465 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10487 AND linked.composer_id = 20), 'musicbrainz:c548256f-fc0f-4a06-8177-fd382fa50e05', 2, 'II', 'Minuè', 'Minuè', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 E♭장조 G 425' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c548256f-fc0f-4a06-8177-fd382fa50e05'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 E♭장조 G 425 중 "Minuè"', piece.title_en = 'Quintet for flute and strings in E flat major, G 425: Minuè', piece.editor_locked = 1
WHERE piece.id = 10487 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- G 426 플루트와 현악을 위한 5중주 G단조 G 426

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 현악을 위한 5중주 G단조 G 426', 'Quintet for flute and strings in G minor, G 426', 'album', NULL, 'G', '426', NULL, 'manual', 1
FROM composers c
WHERE c.id = 20
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 현악을 위한 5중주 G단조 G 426'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11043 AND linked.composer_id = 20), 'musicbrainz:eeb4568b-c876-4220-96dc-db7289ae3225', 1, 'I', 'Allegro e con un poco di moto', 'Allegro e con un poco di moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 G단조 G 426' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeb4568b-c876-4220-96dc-db7289ae3225'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 G단조 G 426 중 "Allegro e con un poco di moto"', piece.title_en = 'Quintet for flute and strings in G minor, G 426: Allegro e con un poco di moto', piece.editor_locked = 1
WHERE piece.id = 11043 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10845 AND linked.composer_id = 20), 'musicbrainz:e0064ba0-65cb-4a39-a414-1474e39bea8d', 2, 'II', 'Minuetto con moto', 'Minuetto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '플루트와 현악을 위한 5중주 G단조 G 426' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0064ba0-65cb-4a39-a414-1474e39bea8d'
);

UPDATE pieces piece
SET piece.title = '플루트와 현악을 위한 5중주 G단조 G 426 중 "Minuetto con moto"', piece.title_en = 'Quintet for flute and strings in G minor, G 426: Minuetto con moto', piece.editor_locked = 1
WHERE piece.id = 10845 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- G. 2b 소나타 2번 C단조 G. 2b

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타 2번 C단조 G. 2b', 'Sonata No. 2 in C Minor, G. 2b', 'album', NULL, 'G.', '2b', NULL, 'manual', 1
FROM composers c
WHERE c.id = 20
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타 2번 C단조 G. 2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8009 AND linked.composer_id = 20), 'musicbrainz:12619ae8-9eb0-497f-bf3f-43b55ad0da1a', 1, 'I', 'Adagio', 'Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '소나타 2번 C단조 G. 2b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12619ae8-9eb0-497f-bf3f-43b55ad0da1a'
);

UPDATE pieces piece
SET piece.title = '소나타 2번 C단조 G. 2b 중 "Adagio"', piece.title_en = 'Sonata No. 2 in C Minor, G. 2b: Adagio', piece.editor_locked = 1
WHERE piece.id = 8009 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9931 AND linked.composer_id = 20), 'musicbrainz:9bf9399b-ac38-43ec-a9e9-7b12b8b274b9', 2, 'II', 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '소나타 2번 C단조 G. 2b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bf9399b-ac38-43ec-a9e9-7b12b8b274b9'
);

UPDATE pieces piece
SET piece.title = '소나타 2번 C단조 G. 2b 중 "Allegro"', piece.title_en = 'Sonata No. 2 in C Minor, G. 2b: Allegro', piece.editor_locked = 1
WHERE piece.id = 9931 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9608 AND linked.composer_id = 20), 'musicbrainz:84ec5de4-7b36-4a38-ab93-4ea020b08b56', 3, 'III', 'Allegretto', 'Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 20 AND p.title = '소나타 2번 C단조 G. 2b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84ec5de4-7b36-4a38-ab93-4ea020b08b56'
);

UPDATE pieces piece
SET piece.title = '소나타 2번 C단조 G. 2b 중 "Allegretto"', piece.title_en = 'Sonata No. 2 in C Minor, G. 2b: Allegretto', piece.editor_locked = 1
WHERE piece.id = 9608 AND piece.composer_id = 20
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'concerto', piece.form_key = 'concertante'
WHERE piece.composer_id = 20 AND piece.title = '첼로와 관현악을 위한 협주곡 B♭장조' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'chamber', piece.form_key = 'chamber_other'
WHERE piece.composer_id = 20 AND piece.title = '플루트, 바이올린, 비올라, 첼로를 위한 4중주 D장조' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'chamber', piece.form_key = 'chamber_other'
WHERE piece.composer_id = 20 AND piece.title = '플루트와 현악을 위한 5중주 B♭장조 G 429' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'chamber', piece.form_key = 'chamber_other'
WHERE piece.composer_id = 20 AND piece.title = '플루트와 현악을 위한 5중주 C장조 G 427' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'chamber', piece.form_key = 'chamber_other'
WHERE piece.composer_id = 20 AND piece.title = '플루트와 현악을 위한 5중주 D장조 G 428' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'chamber', piece.form_key = 'chamber_other'
WHERE piece.composer_id = 20 AND piece.title = '플루트와 현악을 위한 5중주 D장조 G 430 "Las Parejas"' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'chamber', piece.form_key = 'chamber_other'
WHERE piece.composer_id = 20 AND piece.title = '플루트와 현악을 위한 5중주 E♭장조 G 425' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'chamber', piece.form_key = 'chamber_other'
WHERE piece.composer_id = 20 AND piece.title = '플루트와 현악을 위한 5중주 G단조 G 426' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'piano', piece.form_key = 'sonata'
WHERE piece.composer_id = 20 AND piece.title = '소나타 2번 C단조 G. 2b' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 베를리오즈 (composer_id 37) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 1

-- None 극적 전설 <파우스트의 겁벌>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '극적 전설 <파우스트의 겁벌>', 'La Damnation de Faust', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 37
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '극적 전설 <파우스트의 겁벌>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1927 AND linked.composer_id = 37), 'musicbrainz:8411e2d7-7953-48fc-a5e6-89fce357c471', 1, NULL, 'Première partie : Introduction : « Le vieil hiver a fait place au printemps »', 'Première partie : Introduction : « Le vieil hiver a fait place au printemps »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8411e2d7-7953-48fc-a5e6-89fce357c471'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Première partie : Introduction : « Le vieil hiver a fait place au printemps »"', piece.title_en = 'La Damnation de Faust: Première partie : Introduction : « Le vieil hiver a fait place au printemps »', piece.editor_locked = 1
WHERE piece.id = 1927 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1799 AND linked.composer_id = 37), 'musicbrainz:75f997f1-8150-490a-a69a-7a11153c7703', 2, NULL, '헝가리 행진곡', 'Première partie : Marche Hongroise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75f997f1-8150-490a-a69a-7a11153c7703'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "헝가리 행진곡"', piece.title_en = 'La Damnation de Faust: Première partie : Marche Hongroise', piece.editor_locked = 1
WHERE piece.id = 1799 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1154 AND linked.composer_id = 37), 'musicbrainz:230df80f-8e3c-4f01-a0f7-5bb2a63339d6', 3, NULL, 'Première partie : Ronde des paysans : « Les bergers quittent leurs troupeaux »', 'Première partie : Ronde des paysans : « Les bergers quittent leurs troupeaux »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:230df80f-8e3c-4f01-a0f7-5bb2a63339d6'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Première partie : Ronde des paysans : « Les bergers quittent leurs troupeaux »"', piece.title_en = 'La Damnation de Faust: Première partie : Ronde des paysans : « Les bergers quittent leurs troupeaux »', piece.editor_locked = 1
WHERE piece.id = 1154 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2489 AND linked.composer_id = 37), 'musicbrainz:c4892347-702f-4916-88f1-72b267741de4', 4, NULL, 'Deuxième partie : Chœur de buveurs : « A boire encor ! Du Vin »', 'Deuxième partie : Chœur de buveurs : « A boire encor ! Du Vin »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4892347-702f-4916-88f1-72b267741de4'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Deuxième partie : Chœur de buveurs : « A boire encor ! Du Vin »"', piece.title_en = 'La Damnation de Faust: Deuxième partie : Chœur de buveurs : « A boire encor ! Du Vin »', piece.editor_locked = 1
WHERE piece.id = 2489 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2228 AND linked.composer_id = 37), 'musicbrainz:a6dede2d-0e13-48da-b36f-dad2727cbf79', 5, NULL, 'Deuxième partie : Chanson de Brander : « Certain rat, dans une cuisine »', 'Deuxième partie : Chanson de Brander : « Certain rat, dans une cuisine »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6dede2d-0e13-48da-b36f-dad2727cbf79'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Deuxième partie : Chanson de Brander : « Certain rat, dans une cuisine »"', piece.title_en = 'La Damnation de Faust: Deuxième partie : Chanson de Brander : « Certain rat, dans une cuisine »', piece.editor_locked = 1
WHERE piece.id = 2228 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1542 AND linked.composer_id = 37), 'musicbrainz:54ea6bf0-f7ac-40fd-9df1-af200b283230', 6, NULL, 'Deuxième partie : Chant de la fête de Pâques', 'Deuxième partie : Chant de la fête de Pâques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54ea6bf0-f7ac-40fd-9df1-af200b283230'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Deuxième partie : Chant de la fête de Pâques"', piece.title_en = 'La Damnation de Faust: Deuxième partie : Chant de la fête de Pâques', piece.editor_locked = 1
WHERE piece.id = 1542 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1638 AND linked.composer_id = 37), 'musicbrainz:621d8758-0972-43ab-a943-7ee2ec35c575', 7, NULL, 'Deuxième partie : « O pure émotion ! Enfant du saint parvis ! »', 'Deuxième partie : « O pure émotion ! Enfant du saint parvis ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:621d8758-0972-43ab-a943-7ee2ec35c575'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Deuxième partie : « O pure émotion ! Enfant du saint parvis ! »"', piece.title_en = 'La Damnation de Faust: Deuxième partie : « O pure émotion ! Enfant du saint parvis ! »', piece.editor_locked = 1
WHERE piece.id = 1638 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 860 AND linked.composer_id = 37), 'musicbrainz:02a66437-7d46-4adb-a0d2-452686c5e797', 8, NULL, 'Deuxième partie : « Sans regrets j''ai quitté les riantes campagnes »', 'Deuxième partie : « Sans regrets j''ai quitté les riantes campagnes »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02a66437-7d46-4adb-a0d2-452686c5e797'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Deuxième partie : « Sans regrets j''ai quitté les riantes campagnes »"', piece.title_en = 'La Damnation de Faust: Deuxième partie : « Sans regrets j''ai quitté les riantes campagnes »', piece.editor_locked = 1
WHERE piece.id = 860 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2793 AND linked.composer_id = 37), 'musicbrainz:e6bbca5e-c11d-4488-acb8-c0824de2264c', 9, NULL, 'Troisième partie : « Que l''air est étouffant ! »', 'Troisième partie : « Que l''air est étouffant ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6bbca5e-c11d-4488-acb8-c0824de2264c'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Troisième partie : « Que l''air est étouffant ! »"', piece.title_en = 'La Damnation de Faust: Troisième partie : « Que l''air est étouffant ! »', piece.editor_locked = 1
WHERE piece.id = 2793 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1516 AND linked.composer_id = 37), 'musicbrainz:5117eaa6-5b40-4b31-ab93-a0dad958988a', 10, NULL, 'Troisième partie : Air de Faust : « Merci, doux crépuscule ! »', 'Troisième partie : Air de Faust : « Merci, doux crépuscule ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5117eaa6-5b40-4b31-ab93-a0dad958988a'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Troisième partie : Air de Faust : « Merci, doux crépuscule ! »"', piece.title_en = 'La Damnation de Faust: Troisième partie : Air de Faust : « Merci, doux crépuscule ! »', piece.editor_locked = 1
WHERE piece.id = 1516 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1344 AND linked.composer_id = 37), 'musicbrainz:3bf694e3-4de4-42d2-a073-4e382e47762c', 11, NULL, '이중창: Grand Dieu ! Que vois-je ?', 'Troisième partie : Duo : « Grand Dieu ! Que vois-je ? »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bf694e3-4de4-42d2-a073-4e382e47762c'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "이중창: Grand Dieu ! Que vois-je ?"', piece.title_en = 'La Damnation de Faust: Troisième partie : Duo : « Grand Dieu ! Que vois-je ? »', piece.editor_locked = 1
WHERE piece.id = 1344 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1397 AND linked.composer_id = 37), 'musicbrainz:41bd9685-4347-4be7-8bc7-b9dcb56f887b', 12, NULL, 'Troisième partie : Evocation : « Esprits des flammes inconstantes »', 'Troisième partie : Evocation : « Esprits des flammes inconstantes »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41bd9685-4347-4be7-8bc7-b9dcb56f887b'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Troisième partie : Evocation : « Esprits des flammes inconstantes »"', piece.title_en = 'La Damnation de Faust: Troisième partie : Evocation : « Esprits des flammes inconstantes »', piece.editor_locked = 1
WHERE piece.id = 1397 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1123 AND linked.composer_id = 37), 'musicbrainz:2018b1a7-ef25-4850-ad48-d053b50698e6', 13, NULL, 'Troisième partie : Le Roi de Thulé (Chanson gothique)', 'Troisième partie : Le Roi de Thulé (Chanson gothique)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2018b1a7-ef25-4850-ad48-d053b50698e6'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Troisième partie : Le Roi de Thulé (Chanson gothique)"', piece.title_en = 'La Damnation de Faust: Troisième partie : Le Roi de Thulé (Chanson gothique)', piece.editor_locked = 1
WHERE piece.id = 1123 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1396 AND linked.composer_id = 37), 'musicbrainz:41b3aca7-01cc-4e45-86c2-c3a9b1163f12', 14, NULL, '도깨비불의 합창을 곁들인 메피스토펠레스의 세레나데', 'Troisième partie : Sérénade de Méphistophélès avec chœur de feux follets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41b3aca7-01cc-4e45-86c2-c3a9b1163f12'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "도깨비불의 합창을 곁들인 메피스토펠레스의 세레나데"', piece.title_en = 'La Damnation de Faust: Troisième partie : Sérénade de Méphistophélès avec chœur de feux follets', piece.editor_locked = 1
WHERE piece.id = 1396 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1532 AND linked.composer_id = 37), 'musicbrainz:53d6c243-2243-4f7f-a9b9-15338789f306', 15, NULL, 'Troisième partie : « Tambours et trompettes sonnent la retraite »', 'Troisième partie : « Tambours et trompettes sonnent la retraite »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53d6c243-2243-4f7f-a9b9-15338789f306'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Troisième partie : « Tambours et trompettes sonnent la retraite »"', piece.title_en = 'La Damnation de Faust: Troisième partie : « Tambours et trompettes sonnent la retraite »', piece.editor_locked = 1
WHERE piece.id = 1532 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2932 AND linked.composer_id = 37), 'musicbrainz:f594ca1e-ef02-4c67-b40b-365903fa717c', 16, NULL, '로망스: D''amour l''ardente flamme', 'Quatrième partie : Romance : « D''amour l''ardente flamme »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f594ca1e-ef02-4c67-b40b-365903fa717c'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "로망스: D''amour l''ardente flamme"', piece.title_en = 'La Damnation de Faust: Quatrième partie : Romance : « D''amour l''ardente flamme »', piece.editor_locked = 1
WHERE piece.id = 2932 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1921 AND linked.composer_id = 37), 'musicbrainz:83b33136-4ab6-416b-915a-2d02741d3fb5', 17, NULL, 'Quatrième partie : Récitatif et chasse : « A la voûte azurée »', 'Quatrième partie : Récitatif et chasse : « A la voûte azurée »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83b33136-4ab6-416b-915a-2d02741d3fb5'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Quatrième partie : Récitatif et chasse : « A la voûte azurée »"', piece.title_en = 'La Damnation de Faust: Quatrième partie : Récitatif et chasse : « A la voûte azurée »', piece.editor_locked = 1
WHERE piece.id = 1921 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2963 AND linked.composer_id = 37), 'musicbrainz:f99e3c7c-e6e4-4dd9-84ca-e82690478d1d', 18, NULL, 'Quatrième partie : Pandemonium. Epilogue : « Alors l''enfer se tut »', 'Quatrième partie : Pandemonium. Epilogue : « Alors l''enfer se tut »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f99e3c7c-e6e4-4dd9-84ca-e82690478d1d'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Quatrième partie : Pandemonium. Epilogue : « Alors l''enfer se tut »"', piece.title_en = 'La Damnation de Faust: Quatrième partie : Pandemonium. Epilogue : « Alors l''enfer se tut »', piece.editor_locked = 1
WHERE piece.id = 2963 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2862 AND linked.composer_id = 37), 'musicbrainz:edfef15a-6a55-4f0a-8c46-742175a2dc0b', 19, NULL, 'Quatrième partie : Invocation : « Nature immense, impénétrable et fière »', 'Quatrième partie : Invocation : « Nature immense, impénétrable et fière »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edfef15a-6a55-4f0a-8c46-742175a2dc0b'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Quatrième partie : Invocation : « Nature immense, impénétrable et fière »"', piece.title_en = 'La Damnation de Faust: Quatrième partie : Invocation : « Nature immense, impénétrable et fière »', piece.editor_locked = 1
WHERE piece.id = 2862 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2675 AND linked.composer_id = 37), 'musicbrainz:da3a9746-cf2e-43b8-8447-99b4f2fbc6bc', 20, NULL, 'Quatrième partie : La course à l''abîme : « Dans mon cœur retentit sa voix »', 'Quatrième partie : La course à l''abîme : « Dans mon cœur retentit sa voix »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da3a9746-cf2e-43b8-8447-99b4f2fbc6bc'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "Quatrième partie : La course à l''abîme : « Dans mon cœur retentit sa voix »"', piece.title_en = 'La Damnation de Faust: Quatrième partie : La course à l''abîme : « Dans mon cœur retentit sa voix »', piece.editor_locked = 1
WHERE piece.id = 2675 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1001 AND linked.composer_id = 37), 'musicbrainz:1220a716-fc6d-401f-bb0d-33e53396c47c', 21, NULL, '메피스토펠레스의 세레나데: Devant la maison', 'Bonus : Sérénade de Méphistophélès : « Devant la maison »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 37 AND p.title = '극적 전설 <파우스트의 겁벌>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1220a716-fc6d-401f-bb0d-33e53396c47c'
);

UPDATE pieces piece
SET piece.title = '극적 전설 <파우스트의 겁벌> 중 "메피스토펠레스의 세레나데: Devant la maison"', piece.title_en = 'La Damnation de Faust: Bonus : Sérénade de Méphistophélès : « Devant la maison »', piece.editor_locked = 1
WHERE piece.id = 1001 AND piece.composer_id = 37
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 마스네 (composer_id 62) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 3

-- None 모음곡 5번 <Scènes napolitaines>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 5번 <Scènes napolitaines>', 'Suite No. 5: Scènes napolitaines', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 5번 <Scènes napolitaines>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10471 AND linked.composer_id = 62), 'musicbrainz:c4675284-3eb6-4750-b1fa-99121d34642e', 1, 'I', 'La danse', 'La danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '모음곡 5번 <Scènes napolitaines>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4675284-3eb6-4750-b1fa-99121d34642e'
);

UPDATE pieces piece
SET piece.title = '모음곡 5번 <Scènes napolitaines> 중 "La danse"', piece.title_en = 'Suite No. 5: Scènes napolitaines: La danse', piece.editor_locked = 1
WHERE piece.id = 10471 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9032 AND linked.composer_id = 62), 'musicbrainz:5bdf1aa9-d066-4e97-8049-37cca85454f6', 2, 'II', 'La procession', 'La procession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '모음곡 5번 <Scènes napolitaines>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bdf1aa9-d066-4e97-8049-37cca85454f6'
);

UPDATE pieces piece
SET piece.title = '모음곡 5번 <Scènes napolitaines> 중 "La procession"', piece.title_en = 'Suite No. 5: Scènes napolitaines: La procession', piece.editor_locked = 1
WHERE piece.id = 9032 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7835 AND linked.composer_id = 62), 'musicbrainz:06c03761-e958-4fb8-9a35-4232db378597', 3, 'III', 'La fete', 'La fete', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '모음곡 5번 <Scènes napolitaines>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06c03761-e958-4fb8-9a35-4232db378597'
);

UPDATE pieces piece
SET piece.title = '모음곡 5번 <Scènes napolitaines> 중 "La fete"', piece.title_en = 'Suite No. 5: Scènes napolitaines: La fete', piece.editor_locked = 1
WHERE piece.id = 7835 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 모음곡 6번 <Scènes de feerie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 6번 <Scènes de feerie>', 'Suite No. 6: Scènes de feerie', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 62
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 6번 <Scènes de feerie>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9699 AND linked.composer_id = 62), 'musicbrainz:8b0d17ef-1d5d-43af-8224-0934b3f464f3', 1, 'I', 'Cortège', 'Cortège', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '모음곡 6번 <Scènes de feerie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b0d17ef-1d5d-43af-8224-0934b3f464f3'
);

UPDATE pieces piece
SET piece.title = '모음곡 6번 <Scènes de feerie> 중 "Cortège"', piece.title_en = 'Suite No. 6: Scènes de feerie: Cortège', piece.editor_locked = 1
WHERE piece.id = 9699 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9386 AND linked.composer_id = 62), 'musicbrainz:752c106b-370b-44bb-b4c3-486cbf529296', 2, 'II', 'Ballet', 'Ballet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '모음곡 6번 <Scènes de feerie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:752c106b-370b-44bb-b4c3-486cbf529296'
);

UPDATE pieces piece
SET piece.title = '모음곡 6번 <Scènes de feerie> 중 "Ballet"', piece.title_en = 'Suite No. 6: Scènes de feerie: Ballet', piece.editor_locked = 1
WHERE piece.id = 9386 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11155 AND linked.composer_id = 62), 'musicbrainz:f781d59c-fa3c-4f96-bb74-73af240c450a', 3, 'III', 'Apparition', 'Apparition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '모음곡 6번 <Scènes de feerie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f781d59c-fa3c-4f96-bb74-73af240c450a'
);

UPDATE pieces piece
SET piece.title = '모음곡 6번 <Scènes de feerie> 중 "Apparition"', piece.title_en = 'Suite No. 6: Scènes de feerie: Apparition', piece.editor_locked = 1
WHERE piece.id = 11155 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8378 AND linked.composer_id = 62), 'musicbrainz:2ee6200a-8045-46a4-9833-d150b7ed962c', 4, 'IV', 'Bacchanale', 'Bacchanale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 62 AND p.title = '모음곡 6번 <Scènes de feerie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ee6200a-8045-46a4-9833-d150b7ed962c'
);

UPDATE pieces piece
SET piece.title = '모음곡 6번 <Scènes de feerie> 중 "Bacchanale"', piece.title_en = 'Suite No. 6: Scènes de feerie: Bacchanale', piece.editor_locked = 1
WHERE piece.id = 8378 AND piece.composer_id = 62
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'orchestral', piece.form_key = 'orch_suite'
WHERE piece.composer_id = 62 AND piece.title = '모음곡 5번 <Scènes napolitaines>' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'orchestral', piece.form_key = 'orch_suite'
WHERE piece.composer_id = 62 AND piece.title = '모음곡 6번 <Scènes de feerie>' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 엘가 (composer_id 64) =====
-- 잇기 1, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 5

-- 카탈로그 part 에 잇기
UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 871 AND seed.composer_id = 64 AND seed.origin = 'seed')
WHERE owner.id = 1204 AND owner.composer_id = 64
  AND part.part_key = 'musicbrainz:f9e5c5f8-511a-4235-b771-c4a576451e08' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '3개의 모테트 Op. 2 중 "Ave Maria, op. 2 no. 2"', piece.title_en = 'Three Motets/Anthems, op. 2: II. Ave Maria', piece.editor_locked = 1
WHERE piece.id = 871 AND piece.composer_id = 64 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 1204 AND part.part_key = 'musicbrainz:f9e5c5f8-511a-4235-b771-c4a576451e08'
      AND part.linked_piece_id = piece.id
  );

-- None King Arthur

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'King Arthur', 'King Arthur', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 64
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'King Arthur'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1917 AND linked.composer_id = 64), 'musicbrainz:8318a997-8992-41c7-9358-b00f27aeeaaf', 1, NULL, 'The King and Sir Bedivere', 'The King and Sir Bedivere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'King Arthur' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8318a997-8992-41c7-9358-b00f27aeeaaf'
);

UPDATE pieces piece
SET piece.title = 'King Arthur 중 "The King and Sir Bedivere"', piece.title_en = 'King Arthur: The King and Sir Bedivere', piece.editor_locked = 1
WHERE piece.id = 1917 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2828 AND linked.composer_id = 64), 'musicbrainz:ea44d362-4f5f-4b8b-9fb4-ec4c31a56680', 2, NULL, 'Elaine Asleep', 'Elaine Asleep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'King Arthur' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea44d362-4f5f-4b8b-9fb4-ec4c31a56680'
);

UPDATE pieces piece
SET piece.title = 'King Arthur 중 "Elaine Asleep"', piece.title_en = 'King Arthur: Elaine Asleep', piece.editor_locked = 1
WHERE piece.id = 2828 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2700 AND linked.composer_id = 64), 'musicbrainz:dd75d6b6-16dc-4623-817d-81d45b03c9ef', 3, NULL, 'The Banqueting Hall at Westminster', 'The Banqueting Hall at Westminster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'King Arthur' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd75d6b6-16dc-4623-817d-81d45b03c9ef'
);

UPDATE pieces piece
SET piece.title = 'King Arthur 중 "The Banqueting Hall at Westminster"', piece.title_en = 'King Arthur: The Banqueting Hall at Westminster', piece.editor_locked = 1
WHERE piece.id = 2700 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1552 AND linked.composer_id = 64), 'musicbrainz:560dce51-a6a9-43b5-a3cc-2843628808c0', 4, NULL, 'The Queen''s Tower at Night', 'The Queen''s Tower at Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'King Arthur' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:560dce51-a6a9-43b5-a3cc-2843628808c0'
);

UPDATE pieces piece
SET piece.title = 'King Arthur 중 "The Queen''s Tower at Night"', piece.title_en = 'King Arthur: The Queen''s Tower at Night', piece.editor_locked = 1
WHERE piece.id = 1552 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2268 AND linked.composer_id = 64), 'musicbrainz:ac275f0f-ded2-4b52-9d84-97f4c486d352', 5, NULL, 'Battle Scene', 'Battle Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'King Arthur' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac275f0f-ded2-4b52-9d84-97f4c486d352'
);

UPDATE pieces piece
SET piece.title = 'King Arthur 중 "Battle Scene"', piece.title_en = 'King Arthur: Battle Scene', piece.editor_locked = 1
WHERE piece.id = 2268 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1328 AND linked.composer_id = 64), 'musicbrainz:3aab31e9-4229-4c62-a380-eeff8d37d56d', 6, NULL, 'Arthur''s Passage to Avalon', 'Arthur''s Passage to Avalon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 64 AND p.title = 'King Arthur' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aab31e9-4229-4c62-a380-eeff8d37d56d'
);

UPDATE pieces piece
SET piece.title = 'King Arthur 중 "Arthur''s Passage to Avalon"', piece.title_en = 'King Arthur: Arthur''s Passage to Avalon', piece.editor_locked = 1
WHERE piece.id = 1328 AND piece.composer_id = 64
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 본 윌리엄스 (composer_id 69) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 2

-- None Folksongs for Schools (Excerpts)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Folksongs for Schools (Excerpts)', 'Folksongs for Schools (Excerpts)', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Folksongs for Schools (Excerpts)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10258 AND linked.composer_id = 69), 'musicbrainz:b3dab0f4-42e5-4858-9be2-46ac104dfb9f', 1, NULL, 'The Cuckoo and the Nightingale [Version for Solo Voice & Piano]', 'The Cuckoo and the Nightingale [Version for Solo Voice & Piano]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folksongs for Schools (Excerpts)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3dab0f4-42e5-4858-9be2-46ac104dfb9f'
);

UPDATE pieces piece
SET piece.title = 'Folksongs for Schools (Excerpts) 중 "The Cuckoo and the Nightingale [Version for Solo Voice & Piano]"', piece.title_en = 'Folksongs for Schools (Excerpts): The Cuckoo and the Nightingale [Version for Solo Voice & Piano]', piece.editor_locked = 1
WHERE piece.id = 10258 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8446 AND linked.composer_id = 69), 'musicbrainz:32f0a5e1-18c9-4057-9ae9-3b8ffda6a33e', 2, NULL, 'Servant Man and Husbandman', 'Servant Man and Husbandman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = 'Folksongs for Schools (Excerpts)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32f0a5e1-18c9-4057-9ae9-3b8ffda6a33e'
);

UPDATE pieces piece
SET piece.title = 'Folksongs for Schools (Excerpts) 중 "Servant Man and Husbandman"', piece.title_en = 'Folksongs for Schools (Excerpts): Servant Man and Husbandman', piece.editor_locked = 1
WHERE piece.id = 8446 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 로망스와 파스토랄

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스와 파스토랄', 'Romance and Pastorale', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 69
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스와 파스토랄'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10180 AND linked.composer_id = 69), 'musicbrainz:adfb4de8-d49b-4dc4-bd3d-60f3e856c888', 1, NULL, 'Romance. Andantino', 'Romance. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '로망스와 파스토랄' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adfb4de8-d49b-4dc4-bd3d-60f3e856c888'
);

UPDATE pieces piece
SET piece.title = '로망스와 파스토랄 중 "Romance. Andantino"', piece.title_en = 'Romance and Pastorale: Romance. Andantino', piece.editor_locked = 1
WHERE piece.id = 10180 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8516 AND linked.composer_id = 69), 'musicbrainz:37d8300c-32d1-4efe-aaa5-6a8997c4a372', 2, NULL, 'Pastorale. Andante con moto', 'Pastorale. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 69 AND p.title = '로망스와 파스토랄' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37d8300c-32d1-4efe-aaa5-6a8997c4a372'
);

UPDATE pieces piece
SET piece.title = '로망스와 파스토랄 중 "Pastorale. Andante con moto"', piece.title_en = 'Romance and Pastorale: Pastorale. Andante con moto', piece.editor_locked = 1
WHERE piece.id = 8516 AND piece.composer_id = 69
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 번스타인 (composer_id 87) =====
-- 잇기 0, 새 묶음 3(이름) + 0(음반), 숨김 0, 그대로 0

-- None 금관 음악

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '금관 음악', 'Brass Music', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 87
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '금관 음악'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1399 AND linked.composer_id = 87), 'musicbrainz:4205c010-2f20-4691-9008-ca94ce7a4274', 1, NULL, 'Elegy for Mippy II', 'Elegy for Mippy II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '금관 음악' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4205c010-2f20-4691-9008-ca94ce7a4274'
);

UPDATE pieces piece
SET piece.title = '금관 음악 중 "Elegy for Mippy II"', piece.title_en = 'Brass Music: Elegy for Mippy II', piece.editor_locked = 1
WHERE piece.id = 1399 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1540 AND linked.composer_id = 87), 'musicbrainz:54d1e619-2f20-4c54-9177-647a5bd33658', 2, NULL, 'Waltz for Mippy III', 'Waltz for Mippy III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '금관 음악' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54d1e619-2f20-4c54-9177-647a5bd33658'
);

UPDATE pieces piece
SET piece.title = '금관 음악 중 "Waltz for Mippy III"', piece.title_en = 'Brass Music: Waltz for Mippy III', piece.editor_locked = 1
WHERE piece.id = 1540 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None <Dybbuk> 모음곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Dybbuk> 모음곡 1번', 'Dybbuk Suite no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 87
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Dybbuk> 모음곡 1번'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1699 AND linked.composer_id = 87), 'musicbrainz:6b0eeab5-55c0-43a9-bf16-562f2c9d94c3', 1, 'I', 'Invocation and Trance', 'Invocation and Trance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b0eeab5-55c0-43a9-bf16-562f2c9d94c3'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 1번 중 "Invocation and Trance"', piece.title_en = 'Dybbuk Suite no. 1: Invocation and Trance', piece.editor_locked = 1
WHERE piece.id = 1699 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2395 AND linked.composer_id = 87), 'musicbrainz:bad28b9e-5cd2-4485-acaa-4260605409ad', 2, 'II', 'The Pledge', 'The Pledge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bad28b9e-5cd2-4485-acaa-4260605409ad'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 1번 중 "The Pledge"', piece.title_en = 'Dybbuk Suite no. 1: The Pledge', piece.editor_locked = 1
WHERE piece.id = 2395 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 951 AND linked.composer_id = 87), 'musicbrainz:0cfd2e64-bbb9-4f09-9aa0-379e3c033351', 3, 'III', 'Kabbalah', 'Kabbalah', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cfd2e64-bbb9-4f09-9aa0-379e3c033351'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 1번 중 "Kabbalah"', piece.title_en = 'Dybbuk Suite no. 1: Kabbalah', piece.editor_locked = 1
WHERE piece.id = 951 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2418 AND linked.composer_id = 87), 'musicbrainz:bc9780d2-97c6-4e1b-84e8-f84496677017', 4, 'IV', 'Possession', 'Possession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc9780d2-97c6-4e1b-84e8-f84496677017'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 1번 중 "Possession"', piece.title_en = 'Dybbuk Suite no. 1: Possession', piece.editor_locked = 1
WHERE piece.id = 2418 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2807 AND linked.composer_id = 87), 'musicbrainz:e7d98a79-7ecf-4087-b61d-2d4485eb4950', 5, 'V', 'Pas de deux', 'Pas de deux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7d98a79-7ecf-4087-b61d-2d4485eb4950'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 1번 중 "Pas de deux"', piece.title_en = 'Dybbuk Suite no. 1: Pas de deux', piece.editor_locked = 1
WHERE piece.id = 2807 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1691 AND linked.composer_id = 87), 'musicbrainz:69c48ee1-80e0-4b3d-9633-7092ce097d96', 6, 'VI', 'Exorcism', 'Exorcism', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69c48ee1-80e0-4b3d-9633-7092ce097d96'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 1번 중 "Exorcism"', piece.title_en = 'Dybbuk Suite no. 1: Exorcism', piece.editor_locked = 1
WHERE piece.id = 1691 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None <Dybbuk> 모음곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Dybbuk> 모음곡 2번', 'Dybbuk Suite no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 87
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Dybbuk> 모음곡 2번'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1531 AND linked.composer_id = 87), 'musicbrainz:53a8e4aa-b9d1-4f8c-99d3-c58fc538661d', 1, 'I', 'The Messengers', 'The Messengers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53a8e4aa-b9d1-4f8c-99d3-c58fc538661d'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 2번 중 "The Messengers"', piece.title_en = 'Dybbuk Suite no. 2: The Messengers', piece.editor_locked = 1
WHERE piece.id = 1531 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2532 AND linked.composer_id = 87), 'musicbrainz:c9bcfe53-dba5-4c8b-9116-1b0c1b5f4488', 2, 'II', 'Leah', 'Leah', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9bcfe53-dba5-4c8b-9116-1b0c1b5f4488'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 2번 중 "Leah"', piece.title_en = 'Dybbuk Suite no. 2: Leah', piece.editor_locked = 1
WHERE piece.id = 2532 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2437 AND linked.composer_id = 87), 'musicbrainz:be09d699-38a7-4ba5-a999-d84748826ce9', 3, 'III', 'Five Kabbalah Variations', 'Five Kabbalah Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be09d699-38a7-4ba5-a999-d84748826ce9'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 2번 중 "Five Kabbalah Variations"', piece.title_en = 'Dybbuk Suite no. 2: Five Kabbalah Variations', piece.editor_locked = 1
WHERE piece.id = 2437 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2477 AND linked.composer_id = 87), 'musicbrainz:c38659da-7ff6-43e4-9b3a-570dbdd8e50a', 4, 'IV', 'Dream', 'Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '<Dybbuk> 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c38659da-7ff6-43e4-9b3a-570dbdd8e50a'
);

UPDATE pieces piece
SET piece.title = '<Dybbuk> 모음곡 2번 중 "Dream"', piece.title_en = 'Dybbuk Suite no. 2: Dream', piece.editor_locked = 1
WHERE piece.id = 2477 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'orchestral', piece.form_key = 'orch_suite'
WHERE piece.composer_id = 87 AND piece.title = '<Dybbuk> 모음곡 1번' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'orchestral', piece.form_key = 'orch_suite'
WHERE piece.composer_id = 87 AND piece.title = '<Dybbuk> 모음곡 2번' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 오르프 (composer_id 91) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 0

-- None Antigonae

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Antigonae', 'Antigonae', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 91
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Antigonae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10501 AND linked.composer_id = 91), 'musicbrainz:c610c9be-214c-4249-ae12-79e9c40db391', 1, NULL, 'I. "Gemeinsamschwesterliches! O Ismenes Haut!"', 'I. "Gemeinsamschwesterliches! O Ismenes Haut!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c610c9be-214c-4249-ae12-79e9c40db391'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "I. "Gemeinsamschwesterliches! O Ismenes Haut!""', piece.title_en = 'Antigonae: I. "Gemeinsamschwesterliches! O Ismenes Haut!"', piece.editor_locked = 1
WHERE piece.id = 10501 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10294 AND linked.composer_id = 91), 'musicbrainz:b6db1230-5f67-415c-a892-2a729f09acf9', 2, NULL, 'I. "Bedenke, Schwester, wie der Vater, von uns"', 'I. "Bedenke, Schwester, wie der Vater, von uns"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6db1230-5f67-415c-a892-2a729f09acf9'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "I. "Bedenke, Schwester, wie der Vater, von uns""', piece.title_en = 'Antigonae: I. "Bedenke, Schwester, wie der Vater, von uns"', piece.editor_locked = 1
WHERE piece.id = 10294 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8981 AND linked.composer_id = 91), 'musicbrainz:58cd175e-41be-45a5-826d-5e459f0ff997', 3, NULL, 'I. "Zwischenspiel"', 'I. "Zwischenspiel"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58cd175e-41be-45a5-826d-5e459f0ff997'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "I. "Zwischenspiel""', piece.title_en = 'Antigonae: I. "Zwischenspiel"', piece.editor_locked = 1
WHERE piece.id = 8981 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10787 AND linked.composer_id = 91), 'musicbrainz:db5e94f3-f28f-401f-8a73-d94eeafc4a36', 4, NULL, 'I. "O Blick der Sonne, du schönster"', 'I. "O Blick der Sonne, du schönster"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db5e94f3-f28f-401f-8a73-d94eeafc4a36'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "I. "O Blick der Sonne, du schönster""', piece.title_en = 'Antigonae: I. "O Blick der Sonne, du schönster"', piece.editor_locked = 1
WHERE piece.id = 10787 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7782 AND linked.composer_id = 91), 'musicbrainz:03d5a473-6e91-46d6-9d24-400d2b98f6e6', 5, NULL, 'I. "Ihr Männer, wär''s die Stadt allen"', 'I. "Ihr Männer, wär''s die Stadt allen"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d5a473-6e91-46d6-9d24-400d2b98f6e6'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "I. "Ihr Männer, wär''s die Stadt allen""', piece.title_en = 'Antigonae: I. "Ihr Männer, wär''s die Stadt allen"', piece.editor_locked = 1
WHERE piece.id = 7782 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8748 AND linked.composer_id = 91), 'musicbrainz:493dbb8b-4cbb-43b0-94b7-7bac0bfb9dda', 6, NULL, 'I. "Mein König, diesmal plaudr'' ich nicht"', 'I. "Mein König, diesmal plaudr'' ich nicht"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:493dbb8b-4cbb-43b0-94b7-7bac0bfb9dda'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "I. "Mein König, diesmal plaudr'' ich nicht""', piece.title_en = 'Antigonae: I. "Mein König, diesmal plaudr'' ich nicht"', piece.editor_locked = 1
WHERE piece.id = 8748 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8354 AND linked.composer_id = 91), 'musicbrainz:2d5f6f57-0454-4599-9087-7f2b4f9ab25c', 7, NULL, 'I. "Zuletzt, als weiter nichts zu forschen war, spricht einer"', 'I. "Zuletzt, als weiter nichts zu forschen war, spricht einer"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d5f6f57-0454-4599-9087-7f2b4f9ab25c'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "I. "Zuletzt, als weiter nichts zu forschen war, spricht einer""', piece.title_en = 'Antigonae: I. "Zuletzt, als weiter nichts zu forschen war, spricht einer"', piece.editor_locked = 1
WHERE piece.id = 8354 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8012 AND linked.composer_id = 91), 'musicbrainz:126e4bc0-74fa-49ef-b6af-a09fc0eb7d33', 8, NULL, 'I. "Mein König, lange rät, es möchte göttlich"', 'I. "Mein König, lange rät, es möchte göttlich"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:126e4bc0-74fa-49ef-b6af-a09fc0eb7d33'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "I. "Mein König, lange rät, es möchte göttlich""', piece.title_en = 'Antigonae: I. "Mein König, lange rät, es möchte göttlich"', piece.editor_locked = 1
WHERE piece.id = 8012 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7909 AND linked.composer_id = 91), 'musicbrainz:0bbc00e7-70e7-4ee5-9f6d-35b950192782', 9, NULL, 'I. "Und schlimme Worte fuhren drcheinander"', 'I. "Und schlimme Worte fuhren drcheinander"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bbc00e7-70e7-4ee5-9f6d-35b950192782'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "I. "Und schlimme Worte fuhren drcheinander""', piece.title_en = 'Antigonae: I. "Und schlimme Worte fuhren drcheinander"', piece.editor_locked = 1
WHERE piece.id = 7909 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9496 AND linked.composer_id = 91), 'musicbrainz:7caa7b8f-e3a1-467a-b8be-5382c4004a88', 10, NULL, 'II. "Ungeheuer ist viel"', 'II. "Ungeheuer ist viel"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7caa7b8f-e3a1-467a-b8be-5382c4004a88'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "II. "Ungeheuer ist viel""', piece.title_en = 'Antigonae: II. "Ungeheuer ist viel"', piece.editor_locked = 1
WHERE piece.id = 9496 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8364 AND linked.composer_id = 91), 'musicbrainz:2e01fdcf-9285-4896-9ac5-88bc693d45eb', 11, NULL, 'II. "Wie Gottes Versuchung aber steht es vor mir"', 'II. "Wie Gottes Versuchung aber steht es vor mir"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e01fdcf-9285-4896-9ac5-88bc693d45eb'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "II. "Wie Gottes Versuchung aber steht es vor mir""', piece.title_en = 'Antigonae: II. "Wie Gottes Versuchung aber steht es vor mir"', piece.editor_locked = 1
WHERE piece.id = 8364 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10749 AND linked.composer_id = 91), 'musicbrainz:d8c62bfa-2ff6-4b18-839c-cfa3dc354655', 12, NULL, 'II. "Du also, die zur Erde neigt das Haupt"', 'II. "Du also, die zur Erde neigt das Haupt"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8c62bfa-2ff6-4b18-839c-cfa3dc354655'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "II. "Du also, die zur Erde neigt das Haupt""', piece.title_en = 'Antigonae: II. "Du also, die zur Erde neigt das Haupt"', piece.editor_locked = 1
WHERE piece.id = 10749 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9560 AND linked.composer_id = 91), 'musicbrainz:814ca4c1-15c5-4f61-8b18-476c3881175a', 13, NULL, 'II. "Du weißt doch wohl, daß allzuspröde Sprach''"', 'II. "Du weißt doch wohl, daß allzuspröde Sprach''"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:814ca4c1-15c5-4f61-8b18-476c3881175a'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "II. "Du weißt doch wohl, daß allzuspröde Sprach''""', piece.title_en = 'Antigonae: II. "Du weißt doch wohl, daß allzuspröde Sprach''"', piece.editor_locked = 1
WHERE piece.id = 9560 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8370 AND linked.composer_id = 91), 'musicbrainz:2e5dda4d-ea46-4456-9162-0fb7485d7ea3', 14, NULL, 'II. "Aber jetzt kommt aus dem Tor Ismene"', 'II. "Aber jetzt kommt aus dem Tor Ismene"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e5dda4d-ea46-4456-9162-0fb7485d7ea3'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "II. "Aber jetzt kommt aus dem Tor Ismene""', piece.title_en = 'Antigonae: II. "Aber jetzt kommt aus dem Tor Ismene"', piece.editor_locked = 1
WHERE piece.id = 8370 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10421 AND linked.composer_id = 91), 'musicbrainz:c0415ab5-84c6-4593-be37-303bafe7b7f2', 15, NULL, 'II. "Die ist''s. Die hat''s getan"', 'II. "Die ist''s. Die hat''s getan"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0415ab5-84c6-4593-be37-303bafe7b7f2'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "II. "Die ist''s. Die hat''s getan""', piece.title_en = 'Antigonae: II. "Die ist''s. Die hat''s getan"', piece.editor_locked = 1
WHERE piece.id = 10421 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10114 AND linked.composer_id = 91), 'musicbrainz:a96f54e6-676c-41fb-b745-fd33fa87bca2', 16, NULL, 'III. "Glückselige solcher Zeit, da man nicht schmeckt das Übel"', 'III. "Glückselige solcher Zeit, da man nicht schmeckt das Übel"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a96f54e6-676c-41fb-b745-fd33fa87bca2'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "III. "Glückselige solcher Zeit, da man nicht schmeckt das Übel""', piece.title_en = 'Antigonae: III. "Glückselige solcher Zeit, da man nicht schmeckt das Übel"', piece.editor_locked = 1
WHERE piece.id = 10114 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9880 AND linked.composer_id = 91), 'musicbrainz:9951295f-5ba4-409b-bf4a-8fa456db6c6f', 17, NULL, 'III. "Bald haben wohl, o Sohn, mehr als die Seher"', 'III. "Bald haben wohl, o Sohn, mehr als die Seher"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9951295f-5ba4-409b-bf4a-8fa456db6c6f'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "III. "Bald haben wohl, o Sohn, mehr als die Seher""', piece.title_en = 'Antigonae: III. "Bald haben wohl, o Sohn, mehr als die Seher"', piece.editor_locked = 1
WHERE piece.id = 9880 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9064 AND linked.composer_id = 91), 'musicbrainz:5e78accb-5b58-4f68-a452-055824dfa8d5', 18, NULL, 'III. "Als wie von Gott, himmlisch kommt die Besinnung"', 'III. "Als wie von Gott, himmlisch kommt die Besinnung"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e78accb-5b58-4f68-a452-055824dfa8d5'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "III. "Als wie von Gott, himmlisch kommt die Besinnung""', piece.title_en = 'Antigonae: III. "Als wie von Gott, himmlisch kommt die Besinnung"', piece.editor_locked = 1
WHERE piece.id = 9064 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8206 AND linked.composer_id = 91), 'musicbrainz:206fbdef-dd96-4223-8eb8-260aac1ec762', 19, NULL, 'III. "Mein König, billig ist es, wenn er an der Zeit spricht"', 'III. "Mein König, billig ist es, wenn er an der Zeit spricht"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:206fbdef-dd96-4223-8eb8-260aac1ec762'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "III. "Mein König, billig ist es, wenn er an der Zeit spricht""', piece.title_en = 'Antigonae: III. "Mein König, billig ist es, wenn er an der Zeit spricht"', piece.editor_locked = 1
WHERE piece.id = 8206 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9351 AND linked.composer_id = 91), 'musicbrainz:7339beb5-47b3-431e-8e7e-9943bd2f8920', 20, NULL, 'III. "Geist der Liebe, dennoch Sieger"', 'III. "Geist der Liebe, dennoch Sieger"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7339beb5-47b3-431e-8e7e-9943bd2f8920'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "III. "Geist der Liebe, dennoch Sieger""', piece.title_en = 'Antigonae: III. "Geist der Liebe, dennoch Sieger"', piece.editor_locked = 1
WHERE piece.id = 9351 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10548 AND linked.composer_id = 91), 'musicbrainz:c9f0dcba-11ff-4ffd-a4d9-d2639fc72b04', 21, NULL, 'III. "Jetzt aber komm'' ich eben selber"', 'III. "Jetzt aber komm'' ich eben selber"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9f0dcba-11ff-4ffd-a4d9-d2639fc72b04'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "III. "Jetzt aber komm'' ich eben selber""', piece.title_en = 'Antigonae: III. "Jetzt aber komm'' ich eben selber"', piece.editor_locked = 1
WHERE piece.id = 10548 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11028 AND linked.composer_id = 91), 'musicbrainz:ed58a47e-bcc9-4338-9885-a7b430a6dcae', 22, NULL, 'III. "O Grab! O Brautbett!"', 'III. "O Grab! O Brautbett!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed58a47e-bcc9-4338-9885-a7b430a6dcae'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "III. "O Grab! O Brautbett!""', piece.title_en = 'Antigonae: III. "O Grab! O Brautbett!"', piece.editor_locked = 1
WHERE piece.id = 11028 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7794 AND linked.composer_id = 91), 'musicbrainz:04431f6c-5d72-4cdb-a50a-0cf7de07a76a', 23, NULL, 'IV. "O des Landes Thebes Vaterliche Stadt"', 'IV. "O des Landes Thebes Vaterliche Stadt"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04431f6c-5d72-4cdb-a50a-0cf7de07a76a'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "IV. "O des Landes Thebes Vaterliche Stadt""', piece.title_en = 'Antigonae: IV. "O des Landes Thebes Vaterliche Stadt"', piece.editor_locked = 1
WHERE piece.id = 7794 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8398 AND linked.composer_id = 91), 'musicbrainz:307b06d8-667e-4ae6-9be7-93229d1889e3', 24, NULL, 'IV. "Der Leib auch Danaes musste"', 'IV. "Der Leib auch Danaes musste"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:307b06d8-667e-4ae6-9be7-93229d1889e3'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "IV. "Der Leib auch Danaes musste""', piece.title_en = 'Antigonae: IV. "Der Leib auch Danaes musste"', piece.editor_locked = 1
WHERE piece.id = 8398 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8496 AND linked.composer_id = 91), 'musicbrainz:368b9744-8c45-4635-8d0f-344d059bd773', 25, NULL, 'IV. "Ihr Fürsten Thebes! Miteinander kommen"', 'IV. "Ihr Fürsten Thebes! Miteinander kommen"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:368b9744-8c45-4635-8d0f-344d059bd773'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "IV. "Ihr Fürsten Thebes! Miteinander kommen""', piece.title_en = 'Antigonae: IV. "Ihr Fürsten Thebes! Miteinander kommen"', piece.editor_locked = 1
WHERE piece.id = 8496 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10128 AND linked.composer_id = 91), 'musicbrainz:aa56bd0c-8a29-473a-8f62-e640c0a49f2d', 26, NULL, 'IV. "O Alter! Alle, wie auf eines Schützen Ziel"', 'IV. "O Alter! Alle, wie auf eines Schützen Ziel"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa56bd0c-8a29-473a-8f62-e640c0a49f2d'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "IV. "O Alter! Alle, wie auf eines Schützen Ziel""', piece.title_en = 'Antigonae: IV. "O Alter! Alle, wie auf eines Schützen Ziel"', piece.editor_locked = 1
WHERE piece.id = 10128 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8079 AND linked.composer_id = 91), 'musicbrainz:173f073a-5e7c-4acc-a1a3-3417b0d5ca41', 27, NULL, 'IV. "Der Mann, mein König, ging viel prophezeiend"', 'IV. "Der Mann, mein König, ging viel prophezeiend"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:173f073a-5e7c-4acc-a1a3-3417b0d5ca41'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "IV. "Der Mann, mein König, ging viel prophezeiend""', piece.title_en = 'Antigonae: IV. "Der Mann, mein König, ging viel prophezeiend"', piece.editor_locked = 1
WHERE piece.id = 8079 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9892 AND linked.composer_id = 91), 'musicbrainz:99f3ec8f-616f-4638-b925-9e33dc8732e9', 28, NULL, 'V. "Namenschopfer, der du von den Wassern, welche Kadmos"', 'V. "Namenschopfer, der du von den Wassern, welche Kadmos"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99f3ec8f-616f-4638-b925-9e33dc8732e9'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "V. "Namenschopfer, der du von den Wassern, welche Kadmos""', piece.title_en = 'Antigonae: V. "Namenschopfer, der du von den Wassern, welche Kadmos"', piece.editor_locked = 1
WHERE piece.id = 9892 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9120 AND linked.composer_id = 91), 'musicbrainz:622ba249-ab49-441a-b775-f794ee3777bd', 29, NULL, 'V. "O ihr des Kadmos Nachbarn und Amphios"', 'V. "O ihr des Kadmos Nachbarn und Amphios"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:622ba249-ab49-441a-b775-f794ee3777bd'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "V. "O ihr des Kadmos Nachbarn und Amphios""', piece.title_en = 'Antigonae: V. "O ihr des Kadmos Nachbarn und Amphios"', piece.editor_locked = 1
WHERE piece.id = 9120 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10032 AND linked.composer_id = 91), 'musicbrainz:a3803456-83ea-4b60-b1ff-179cd85609ae', 30, NULL, 'V. "O all ihr Bürger! Eine Rede merkt'' ich"', 'V. "O all ihr Bürger! Eine Rede merkt'' ich"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3803456-83ea-4b60-b1ff-179cd85609ae'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "V. "O all ihr Bürger! Eine Rede merkt'' ich""', piece.title_en = 'Antigonae: V. "O all ihr Bürger! Eine Rede merkt'' ich"', piece.editor_locked = 1
WHERE piece.id = 10032 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8967 AND linked.composer_id = 91), 'musicbrainz:57e04e3c-76c4-4f8b-a55c-c79b74770dfa', 31, NULL, 'V. "Ich, liebe Frau, sag'' es, als Augenzeuge"', 'V. "Ich, liebe Frau, sag'' es, als Augenzeuge"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57e04e3c-76c4-4f8b-a55c-c79b74770dfa'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "V. "Ich, liebe Frau, sag'' es, als Augenzeuge""', piece.title_en = 'Antigonae: V. "Ich, liebe Frau, sag'' es, als Augenzeuge"', piece.editor_locked = 1
WHERE piece.id = 8967 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7965 AND linked.composer_id = 91), 'musicbrainz:0fd3d568-2921-409b-a5a3-28966f8a5b95', 32, NULL, 'V. "Wie nimmst du dies? Die Frau ging wieder weg"', 'V. "Wie nimmst du dies? Die Frau ging wieder weg"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fd3d568-2921-409b-a5a3-28966f8a5b95'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "V. "Wie nimmst du dies? Die Frau ging wieder weg""', piece.title_en = 'Antigonae: V. "Wie nimmst du dies? Die Frau ging wieder weg"', piece.editor_locked = 1
WHERE piece.id = 7965 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10497 AND linked.composer_id = 91), 'musicbrainz:c5f1b67c-fa46-403f-9696-a655461ffa02', 33, NULL, 'V. "Io! Unsinnige Sinne!"', 'V. "Io! Unsinnige Sinne!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5f1b67c-fa46-403f-9696-a655461ffa02'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "V. "Io! Unsinnige Sinne!""', piece.title_en = 'Antigonae: V. "Io! Unsinnige Sinne!"', piece.editor_locked = 1
WHERE piece.id = 10497 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9459 AND linked.composer_id = 91), 'musicbrainz:7aaa1f9c-2712-4eb4-9550-1c3bbe46dc55', 34, NULL, 'V. "Weh! Weh! Weh! Weh! Mich beflügelt die Furcht"', 'V. "Weh! Weh! Weh! Weh! Mich beflügelt die Furcht"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aaa1f9c-2712-4eb4-9550-1c3bbe46dc55'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "V. "Weh! Weh! Weh! Weh! Mich beflügelt die Furcht""', piece.title_en = 'Antigonae: V. "Weh! Weh! Weh! Weh! Mich beflügelt die Furcht"', piece.editor_locked = 1
WHERE piece.id = 9459 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9918 AND linked.composer_id = 91), 'musicbrainz:9b637865-7f2f-411c-aa22-01253cd3074d', 35, NULL, 'V. "Um Vieles ist das Denken mehr"', 'V. "Um Vieles ist das Denken mehr"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 91 AND p.title = 'Antigonae' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b637865-7f2f-411c-aa22-01253cd3074d'
);

UPDATE pieces piece
SET piece.title = 'Antigonae 중 "V. "Um Vieles ist das Denken mehr""', piece.title_en = 'Antigonae: V. "Um Vieles ist das Denken mehr"', piece.editor_locked = 1
WHERE piece.id = 9918 AND piece.composer_id = 91
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 필립 글래스 (composer_id 93) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 3

-- None 발레를 위한 12개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레를 위한 12개의 소품', '12 Pieces for a Ballet', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레를 위한 12개의 소품'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10881 AND linked.composer_id = 93), 'musicbrainz:e3302ac7-afe3-4342-93cf-5e0ab1b1c976', 1, NULL, '변주 1번', 'Variation No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '발레를 위한 12개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3302ac7-afe3-4342-93cf-5e0ab1b1c976'
);

UPDATE pieces piece
SET piece.title = '발레를 위한 12개의 소품 중 "변주 1번"', piece.title_en = '12 Pieces for a Ballet: Variation No. 1', piece.editor_locked = 1
WHERE piece.id = 10881 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8147 AND linked.composer_id = 93), 'musicbrainz:1c66085a-d67c-4004-9213-38c7505390f9', 2, NULL, '변주 2번', 'Variation No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '발레를 위한 12개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c66085a-d67c-4004-9213-38c7505390f9'
);

UPDATE pieces piece
SET piece.title = '발레를 위한 12개의 소품 중 "변주 2번"', piece.title_en = '12 Pieces for a Ballet: Variation No. 2', piece.editor_locked = 1
WHERE piece.id = 8147 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None A Brief History of Time

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A Brief History of Time', 'A Brief History of Time', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A Brief History of Time'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8185 AND linked.composer_id = 93), 'musicbrainz:1f166136-8786-4bb2-914a-e9548cb0e23b', 1, NULL, 'Title', 'Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f166136-8786-4bb2-914a-e9548cb0e23b'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Title"', piece.title_en = 'A Brief History of Time: Title', piece.editor_locked = 1
WHERE piece.id = 8185 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10485 AND linked.composer_id = 93), 'musicbrainz:c529d983-2df7-4baf-b275-f32cb2aa5df6', 2, NULL, 'Mysterious no. 4', 'Mysterious no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c529d983-2df7-4baf-b275-f32cb2aa5df6'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Mysterious no. 4"', piece.title_en = 'A Brief History of Time: Mysterious no. 4', piece.editor_locked = 1
WHERE piece.id = 10485 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7932 AND linked.composer_id = 93), 'musicbrainz:0d84e0fe-be91-4a34-aeba-17b3f1f79129', 3, NULL, 'Bombs with Fidelity', 'Bombs with Fidelity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d84e0fe-be91-4a34-aeba-17b3f1f79129'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Bombs with Fidelity"', piece.title_en = 'A Brief History of Time: Bombs with Fidelity', piece.editor_locked = 1
WHERE piece.id = 7932 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8957 AND linked.composer_id = 93), 'musicbrainz:571d6844-24ec-4738-8a33-c713526c6292', 4, NULL, 'Slow, Simple, Sad no. 3', 'Slow, Simple, Sad no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:571d6844-24ec-4738-8a33-c713526c6292'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Slow, Simple, Sad no. 3"', piece.title_en = 'A Brief History of Time: Slow, Simple, Sad no. 3', piece.editor_locked = 1
WHERE piece.id = 8957 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9460 AND linked.composer_id = 93), 'musicbrainz:7aaa89ef-f0e4-45d2-92fe-0983c682a952', 5, NULL, 'Mysterious no. 1', 'Mysterious no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aaa89ef-f0e4-45d2-92fe-0983c682a952'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Mysterious no. 1"', piece.title_en = 'A Brief History of Time: Mysterious no. 1', piece.editor_locked = 1
WHERE piece.id = 9460 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8063 AND linked.composer_id = 93), 'musicbrainz:162d4c7c-2d88-4cdc-adf4-78712506e200', 6, NULL, 'Slow, Simple, Sad no. 4', 'Slow, Simple, Sad no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:162d4c7c-2d88-4cdc-adf4-78712506e200'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Slow, Simple, Sad no. 4"', piece.title_en = 'A Brief History of Time: Slow, Simple, Sad no. 4', piece.editor_locked = 1
WHERE piece.id = 8063 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9584 AND linked.composer_id = 93), 'musicbrainz:834d8410-d0a5-4ad3-814f-d6fbedbd29c2', 7, NULL, 'Mysterious no. 2', 'Mysterious no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:834d8410-d0a5-4ad3-814f-d6fbedbd29c2'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Mysterious no. 2"', piece.title_en = 'A Brief History of Time: Mysterious no. 2', piece.editor_locked = 1
WHERE piece.id = 9584 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10971 AND linked.composer_id = 93), 'musicbrainz:e981cf4c-55dd-4d26-8113-38a8a0f77918', 8, NULL, 'Hawking Radiation', 'Hawking Radiation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e981cf4c-55dd-4d26-8113-38a8a0f77918'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Hawking Radiation"', piece.title_en = 'A Brief History of Time: Hawking Radiation', piece.editor_locked = 1
WHERE piece.id = 10971 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8766 AND linked.composer_id = 93), 'musicbrainz:4a5c2c77-b575-4e37-92e6-7edcb75804eb', 9, NULL, 'Bombs', 'Bombs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a5c2c77-b575-4e37-92e6-7edcb75804eb'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Bombs"', piece.title_en = 'A Brief History of Time: Bombs', piece.editor_locked = 1
WHERE piece.id = 8766 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7846 AND linked.composer_id = 93), 'musicbrainz:076d7022-b98d-4653-8946-4b5dbc27d89a', 10, NULL, 'Dice', 'Dice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:076d7022-b98d-4653-8946-4b5dbc27d89a'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Dice"', piece.title_en = 'A Brief History of Time: Dice', piece.editor_locked = 1
WHERE piece.id = 7846 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9514 AND linked.composer_id = 93), 'musicbrainz:7e0aa48b-b33a-4028-9052-20eb7c52bae4', 11, NULL, 'Hawking Radiation with Brass', 'Hawking Radiation with Brass', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e0aa48b-b33a-4028-9052-20eb7c52bae4'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Hawking Radiation with Brass"', piece.title_en = 'A Brief History of Time: Hawking Radiation with Brass', piece.editor_locked = 1
WHERE piece.id = 9514 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7964 AND linked.composer_id = 93), 'musicbrainz:0fcef3c9-c2a5-4d78-b5a0-01654bf4cb8c', 12, NULL, 'Climbing the Stairs', 'Climbing the Stairs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fcef3c9-c2a5-4d78-b5a0-01654bf4cb8c'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Climbing the Stairs"', piece.title_en = 'A Brief History of Time: Climbing the Stairs', piece.editor_locked = 1
WHERE piece.id = 7964 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9762 AND linked.composer_id = 93), 'musicbrainz:8ff1cf32-5fdb-4817-be62-d01f493d21d3', 13, NULL, 'End with Strings and Trumpets', 'End with Strings and Trumpets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ff1cf32-5fdb-4817-be62-d01f493d21d3'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "End with Strings and Trumpets"', piece.title_en = 'A Brief History of Time: End with Strings and Trumpets', piece.editor_locked = 1
WHERE piece.id = 9762 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9212 AND linked.composer_id = 93), 'musicbrainz:69ceb6a8-7f0f-40d3-be8f-b522a22dc04e', 14, NULL, 'Melody in Major', 'Melody in Major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69ceb6a8-7f0f-40d3-be8f-b522a22dc04e'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Melody in Major"', piece.title_en = 'A Brief History of Time: Melody in Major', piece.editor_locked = 1
WHERE piece.id = 9212 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10282 AND linked.composer_id = 93), 'musicbrainz:b622ad49-594f-4abd-b92f-7257eb2ba408', 15, NULL, 'Signature', 'Signature', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b622ad49-594f-4abd-b92f-7257eb2ba408'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Signature"', piece.title_en = 'A Brief History of Time: Signature', piece.editor_locked = 1
WHERE piece.id = 10282 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8964 AND linked.composer_id = 93), 'musicbrainz:57d5a0e9-45b8-4e60-85ff-df28e9df5bb7', 16, NULL, 'Utility no. 1', 'Utility no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57d5a0e9-45b8-4e60-85ff-df28e9df5bb7'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Utility no. 1"', piece.title_en = 'A Brief History of Time: Utility no. 1', piece.editor_locked = 1
WHERE piece.id = 8964 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8939 AND linked.composer_id = 93), 'musicbrainz:560479f3-829b-496f-b875-07ba7b008010', 17, NULL, 'House', 'House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:560479f3-829b-496f-b875-07ba7b008010'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "House"', piece.title_en = 'A Brief History of Time: House', piece.editor_locked = 1
WHERE piece.id = 8939 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10516 AND linked.composer_id = 93), 'musicbrainz:c75bc1f2-4855-43df-aaea-3fa75042b733', 18, NULL, 'Closing no. 1', 'Closing no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c75bc1f2-4855-43df-aaea-3fa75042b733'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "Closing no. 1"', piece.title_en = 'A Brief History of Time: Closing no. 1', piece.editor_locked = 1
WHERE piece.id = 10516 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9911 AND linked.composer_id = 93), 'musicbrainz:9abb8eed-c532-4299-b2ce-1a72108408c0', 19, NULL, 'End Credits Arpeggio and Brass', 'End Credits Arpeggio and Brass', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9abb8eed-c532-4299-b2ce-1a72108408c0'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "End Credits Arpeggio and Brass"', piece.title_en = 'A Brief History of Time: End Credits Arpeggio and Brass', piece.editor_locked = 1
WHERE piece.id = 9911 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9538 AND linked.composer_id = 93), 'musicbrainz:7f647890-54e8-41f5-b10a-608b770f25b7', 20, NULL, 'End Credits Major and Minor', 'End Credits Major and Minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Brief History of Time' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f647890-54e8-41f5-b10a-608b770f25b7'
);

UPDATE pieces piece
SET piece.title = 'A Brief History of Time 중 "End Credits Major and Minor"', piece.title_en = 'A Brief History of Time: End Credits Major and Minor', piece.editor_locked = 1
WHERE piece.id = 9538 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'stage', piece.form_key = 'ballet'
WHERE piece.composer_id = 93 AND piece.title = '발레를 위한 12개의 소품' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 브리튼 (composer_id 94) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 4

-- Op. 57b <The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b', 'The Prince of the Pagodas: Prelude and Dances, op. 57b', 'album', NULL, 'Op.', '57b', NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 844 AND linked.composer_id = 94), 'musicbrainz:00e24fb1-66ed-358d-9710-30690538d27d', 1, NULL, '전주곡', '1. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00e24fb1-66ed-358d-9710-30690538d27d'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "전주곡"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 1. Prelude', piece.editor_locked = 1
WHERE piece.id = 844 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2562 AND linked.composer_id = 94), 'musicbrainz:ccac9f64-58a4-3326-bdd4-1dd5a2104746', 2, NULL, '행진곡과 가보트', '2. March and Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccac9f64-58a4-3326-bdd4-1dd5a2104746'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "행진곡과 가보트"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 2. March and Gavotte', piece.editor_locked = 1
WHERE piece.id = 2562 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1941 AND linked.composer_id = 94), 'musicbrainz:859073f3-aae6-3b19-baec-06795ccc33c7', 3, NULL, 'The King of the North', '3. The King of the North', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:859073f3-aae6-3b19-baec-06795ccc33c7'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "The King of the North"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 3. The King of the North', piece.editor_locked = 1
WHERE piece.id = 1941 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2074 AND linked.composer_id = 94), 'musicbrainz:94a92adc-847b-3fe3-a99b-3af6010b001d', 4, NULL, 'The King of the East', '3. The King of the East', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94a92adc-847b-3fe3-a99b-3af6010b001d'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "The King of the East"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 3. The King of the East', piece.editor_locked = 1
WHERE piece.id = 2074 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1237 AND linked.composer_id = 94), 'musicbrainz:2dd7e2df-ced7-3c31-a1fb-c84c19c9011b', 5, NULL, 'The King of the West', '3. The King of the West', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dd7e2df-ced7-3c31-a1fb-c84c19c9011b'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "The King of the West"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 3. The King of the West', piece.editor_locked = 1
WHERE piece.id = 1237 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2979 AND linked.composer_id = 94), 'musicbrainz:fb1e69bf-4fbe-3d13-92d2-933f386357b3', 6, NULL, 'The King of the South', '3. The King of the South', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb1e69bf-4fbe-3d13-92d2-933f386357b3'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "The King of the South"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 3. The King of the South', piece.editor_locked = 1
WHERE piece.id = 2979 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2984 AND linked.composer_id = 94), 'musicbrainz:fbee2b29-c1af-3e8c-88c9-f7168afaf67c', 7, NULL, 'Belle Epine', '4. Belle Epine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbee2b29-c1af-3e8c-88c9-f7168afaf67c'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "Belle Epine"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 4. Belle Epine', piece.editor_locked = 1
WHERE piece.id = 2984 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1384 AND linked.composer_id = 94), 'musicbrainz:408d7fab-46c3-369d-b6e9-b229f23adbf8', 8, NULL, 'Belle Rose', '4. Belle Rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:408d7fab-46c3-369d-b6e9-b229f23adbf8'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "Belle Rose"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 4. Belle Rose', piece.editor_locked = 1
WHERE piece.id = 1384 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1456 AND linked.composer_id = 94), 'musicbrainz:4a5f19e9-2e5a-37be-ad7e-ea9d853228b9', 9, NULL, 'Variation of the Prince', '5. Variation of the Prince', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a5f19e9-2e5a-37be-ad7e-ea9d853228b9'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "Variation of the Prince"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 5. Variation of the Prince', piece.editor_locked = 1
WHERE piece.id = 1456 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1872 AND linked.composer_id = 94), 'musicbrainz:7dd77189-096e-3c58-94b0-655a2304dcee', 10, NULL, 'Variation of Belle Rose', '5. Variation of Belle Rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dd77189-096e-3c58-94b0-655a2304dcee'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "Variation of Belle Rose"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 5. Variation of Belle Rose', piece.editor_locked = 1
WHERE piece.id = 1872 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1931 AND linked.composer_id = 94), 'musicbrainz:846aec9a-03b5-3c2b-a43f-ee8aee695164', 11, NULL, '피날레', '6. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:846aec9a-03b5-3c2b-a43f-ee8aee695164'
);

UPDATE pieces piece
SET piece.title = '<The Prince of the Pagodas> 전주곡과 춤곡 Op. 57b 중 "피날레"', piece.title_en = 'The Prince of the Pagodas: Prelude and Dances, op. 57b: 6. Finale', piece.editor_locked = 1
WHERE piece.id = 1931 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 베베른 (composer_id 97) =====
-- 잇기 0, 새 묶음 4(이름) + 0(음반), 숨김 0, 그대로 7

-- None 페르디난트 아베나리우스의 시에 의한 3개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '페르디난트 아베나리우스의 시에 의한 3개의 가곡', '3 Songs on Poems by Ferdinand Avenarius', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 97
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '페르디난트 아베나리우스의 시에 의한 3개의 가곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8415 AND linked.composer_id = 97), 'musicbrainz:31879974-efa0-432a-a100-57c0ec79fbae', 1, 'I', 'Gefunden - Nun wir uns lieben, rauscht mein stolzes Glück', 'Gefunden "Nun wir uns lieben, rauscht mein stolzes Glück"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '페르디난트 아베나리우스의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31879974-efa0-432a-a100-57c0ec79fbae'
);

UPDATE pieces piece
SET piece.title = '페르디난트 아베나리우스의 시에 의한 3개의 가곡 중 "Gefunden - Nun wir uns lieben, rauscht mein stolzes Glück"', piece.title_en = '3 Songs on Poems by Ferdinand Avenarius: Gefunden "Nun wir uns lieben, rauscht mein stolzes Glück"', piece.editor_locked = 1
WHERE piece.id = 8415 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8225 AND linked.composer_id = 97), 'musicbrainz:22959827-7bf9-4b0c-a3ec-5b7407c2c327', 2, 'II', 'Gebet - Ertrage du''s, laß schneiden dir den Schmerz', 'Gebet "Ertrage du''s, laß schneiden dir den Schmerz"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '페르디난트 아베나리우스의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22959827-7bf9-4b0c-a3ec-5b7407c2c327'
);

UPDATE pieces piece
SET piece.title = '페르디난트 아베나리우스의 시에 의한 3개의 가곡 중 "Gebet - Ertrage du''s, laß schneiden dir den Schmerz"', piece.title_en = '3 Songs on Poems by Ferdinand Avenarius: Gebet "Ertrage du''s, laß schneiden dir den Schmerz"', piece.editor_locked = 1
WHERE piece.id = 8225 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10369 AND linked.composer_id = 97), 'musicbrainz:bc75b7ab-b36a-4639-a393-ff04c443020e', 3, 'III', 'Freunde - Schmerze und Freuden reift jede Stunde', 'Freunde "Schmerze und Freuden reift jede Stunde"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '페르디난트 아베나리우스의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc75b7ab-b36a-4639-a393-ff04c443020e'
);

UPDATE pieces piece
SET piece.title = '페르디난트 아베나리우스의 시에 의한 3개의 가곡 중 "Freunde - Schmerze und Freuden reift jede Stunde"', piece.title_en = '3 Songs on Poems by Ferdinand Avenarius: Freunde "Schmerze und Freuden reift jede Stunde"', piece.editor_locked = 1
WHERE piece.id = 10369 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 슈테판 게오르게의 시에 의한 4개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슈테판 게오르게의 시에 의한 4개의 가곡', '4 Songs on Poems by Stefan George', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 97
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슈테판 게오르게의 시에 의한 4개의 가곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9093 AND linked.composer_id = 97), 'musicbrainz:6061e0ff-78c9-4371-831c-8fcc37aaaa1a', 1, 'I', 'Erwachen aus dem tiefsten traumes-schooße', '"Erwachen aus dem tiefsten traumes-schooße"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '슈테판 게오르게의 시에 의한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6061e0ff-78c9-4371-831c-8fcc37aaaa1a'
);

UPDATE pieces piece
SET piece.title = '슈테판 게오르게의 시에 의한 4개의 가곡 중 "Erwachen aus dem tiefsten traumes-schooße"', piece.title_en = '4 Songs on Poems by Stefan George: "Erwachen aus dem tiefsten traumes-schooße"', piece.editor_locked = 1
WHERE piece.id = 9093 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9009 AND linked.composer_id = 97), 'musicbrainz:5a6144ed-c221-495a-b048-037b2824bc95', 2, 'II', 'Kunfttag I', 'Kunfttag I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '슈테판 게오르게의 시에 의한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a6144ed-c221-495a-b048-037b2824bc95'
);

UPDATE pieces piece
SET piece.title = '슈테판 게오르게의 시에 의한 4개의 가곡 중 "Kunfttag I"', piece.title_en = '4 Songs on Poems by Stefan George: Kunfttag I', piece.editor_locked = 1
WHERE piece.id = 9009 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10748 AND linked.composer_id = 97), 'musicbrainz:d8c20ff6-6b30-4dcb-898e-60cb1c62ebfb', 3, 'III', 'Trauer I', 'Trauer I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '슈테판 게오르게의 시에 의한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8c20ff6-6b30-4dcb-898e-60cb1c62ebfb'
);

UPDATE pieces piece
SET piece.title = '슈테판 게오르게의 시에 의한 4개의 가곡 중 "Trauer I"', piece.title_en = '4 Songs on Poems by Stefan George: Trauer I', piece.editor_locked = 1
WHERE piece.id = 10748 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8161 AND linked.composer_id = 97), 'musicbrainz:1da9eb93-9167-4bac-8884-df967a03d891', 4, 'IV', 'Das lockere Saatgefilde lechzet krank', '"Das lockere Saatgefilde lechzet krank"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '슈테판 게오르게의 시에 의한 4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1da9eb93-9167-4bac-8884-df967a03d891'
);

UPDATE pieces piece
SET piece.title = '슈테판 게오르게의 시에 의한 4개의 가곡 중 "Das lockere Saatgefilde lechzet krank"', piece.title_en = '4 Songs on Poems by Stefan George: "Das lockere Saatgefilde lechzet krank"', piece.editor_locked = 1
WHERE piece.id = 8161 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 리하르트 데멜의 시에 의한 5개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리하르트 데멜의 시에 의한 5개의 가곡', '5 Songs on Poems by Richard Dehmel', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 97
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리하르트 데멜의 시에 의한 5개의 가곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11087 AND linked.composer_id = 97), 'musicbrainz:f2422860-3fbc-4c7b-ba4e-390cbc832f42', 1, 'I', 'Ideale Landschaft', 'Ideale Landschaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '리하르트 데멜의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2422860-3fbc-4c7b-ba4e-390cbc832f42'
);

UPDATE pieces piece
SET piece.title = '리하르트 데멜의 시에 의한 5개의 가곡 중 "Ideale Landschaft"', piece.title_en = '5 Songs on Poems by Richard Dehmel: Ideale Landschaft', piece.editor_locked = 1
WHERE piece.id = 11087 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10940 AND linked.composer_id = 97), 'musicbrainz:e7982c09-525c-49b0-b97f-b19747c49149', 2, 'II', 'Am Ufer', 'Am Ufer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '리하르트 데멜의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7982c09-525c-49b0-b97f-b19747c49149'
);

UPDATE pieces piece
SET piece.title = '리하르트 데멜의 시에 의한 5개의 가곡 중 "Am Ufer"', piece.title_en = '5 Songs on Poems by Richard Dehmel: Am Ufer', piece.editor_locked = 1
WHERE piece.id = 10940 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10301 AND linked.composer_id = 97), 'musicbrainz:b7248eac-a4fd-4703-a438-2cc6942902f6', 3, 'III', 'Himmelfahrt', 'Himmelfahrt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '리하르트 데멜의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7248eac-a4fd-4703-a438-2cc6942902f6'
);

UPDATE pieces piece
SET piece.title = '리하르트 데멜의 시에 의한 5개의 가곡 중 "Himmelfahrt"', piece.title_en = '5 Songs on Poems by Richard Dehmel: Himmelfahrt', piece.editor_locked = 1
WHERE piece.id = 10301 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9494 AND linked.composer_id = 97), 'musicbrainz:7c7f9119-144a-49a3-932e-62ed96669d8a', 4, 'IV', 'Nächtliche Scheu', 'Nächtliche Scheu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '리하르트 데멜의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c7f9119-144a-49a3-932e-62ed96669d8a'
);

UPDATE pieces piece
SET piece.title = '리하르트 데멜의 시에 의한 5개의 가곡 중 "Nächtliche Scheu"', piece.title_en = '5 Songs on Poems by Richard Dehmel: Nächtliche Scheu', piece.editor_locked = 1
WHERE piece.id = 9494 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11066 AND linked.composer_id = 97), 'musicbrainz:f01624b5-9a51-4d4c-bc12-a2266affd181', 5, 'V', 'Helle Nacht', 'Helle Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '리하르트 데멜의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f01624b5-9a51-4d4c-bc12-a2266affd181'
);

UPDATE pieces piece
SET piece.title = '리하르트 데멜의 시에 의한 5개의 가곡 중 "Helle Nacht"', piece.title_en = '5 Songs on Poems by Richard Dehmel: Helle Nacht', piece.editor_locked = 1
WHERE piece.id = 11066 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 8개의 초기 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '8개의 초기 가곡', '8 Early Songs', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 97
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '8개의 초기 가곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10897 AND linked.composer_id = 97), 'musicbrainz:e4b125f4-c8e9-4db5-82ab-bf4945966cac', 1, 'I', 'Tief von fern', 'Tief von fern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '8개의 초기 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b125f4-c8e9-4db5-82ab-bf4945966cac'
);

UPDATE pieces piece
SET piece.title = '8개의 초기 가곡 중 "Tief von fern"', piece.title_en = '8 Early Songs: Tief von fern', piece.editor_locked = 1
WHERE piece.id = 10897 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9747 AND linked.composer_id = 97), 'musicbrainz:8f33d6de-ff3a-4fdc-a082-5aa805ac682c', 2, 'II', 'Aufblick', 'Aufblick', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '8개의 초기 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f33d6de-ff3a-4fdc-a082-5aa805ac682c'
);

UPDATE pieces piece
SET piece.title = '8개의 초기 가곡 중 "Aufblick"', piece.title_en = '8 Early Songs: Aufblick', piece.editor_locked = 1
WHERE piece.id = 9747 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10383 AND linked.composer_id = 97), 'musicbrainz:bd6921aa-a964-47a4-9146-98c8c032f89d', 3, 'III', 'Blumengruß', 'Blumengruß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '8개의 초기 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd6921aa-a964-47a4-9146-98c8c032f89d'
);

UPDATE pieces piece
SET piece.title = '8개의 초기 가곡 중 "Blumengruß"', piece.title_en = '8 Early Songs: Blumengruß', piece.editor_locked = 1
WHERE piece.id = 10383 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9797 AND linked.composer_id = 97), 'musicbrainz:92a37d44-f6be-4e7b-a827-a4a34b2af60f', 4, 'IV', 'Bild der Liebe', 'Bild der Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '8개의 초기 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a37d44-f6be-4e7b-a827-a4a34b2af60f'
);

UPDATE pieces piece
SET piece.title = '8개의 초기 가곡 중 "Bild der Liebe"', piece.title_en = '8 Early Songs: Bild der Liebe', piece.editor_locked = 1
WHERE piece.id = 9797 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8532 AND linked.composer_id = 97), 'musicbrainz:3904cbba-97c5-4f53-b856-a43a2a94ad53', 5, 'V', 'Sommerabend', 'Sommerabend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '8개의 초기 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3904cbba-97c5-4f53-b856-a43a2a94ad53'
);

UPDATE pieces piece
SET piece.title = '8개의 초기 가곡 중 "Sommerabend"', piece.title_en = '8 Early Songs: Sommerabend', piece.editor_locked = 1
WHERE piece.id = 8532 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8720 AND linked.composer_id = 97), 'musicbrainz:46f77063-d00b-4879-aa5b-519cc55e801d', 6, 'VI', 'Heiter', 'Heiter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '8개의 초기 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46f77063-d00b-4879-aa5b-519cc55e801d'
);

UPDATE pieces piece
SET piece.title = '8개의 초기 가곡 중 "Heiter"', piece.title_en = '8 Early Songs: Heiter', piece.editor_locked = 1
WHERE piece.id = 8720 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7969 AND linked.composer_id = 97), 'musicbrainz:10435f81-c0ac-42af-bb80-d43892a18927', 7, 'VII', 'Der Tod', 'Der Tod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '8개의 초기 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10435f81-c0ac-42af-bb80-d43892a18927'
);

UPDATE pieces piece
SET piece.title = '8개의 초기 가곡 중 "Der Tod"', piece.title_en = '8 Early Songs: Der Tod', piece.editor_locked = 1
WHERE piece.id = 7969 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10430 AND linked.composer_id = 97), 'musicbrainz:c1149d88-a453-486e-8acf-ea45375cf2eb', 8, 'VIII', 'Heimgang in der Frühe', 'Heimgang in der Frühe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 97 AND p.title = '8개의 초기 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1149d88-a453-486e-8acf-ea45375cf2eb'
);

UPDATE pieces piece
SET piece.title = '8개의 초기 가곡 중 "Heimgang in der Frühe"', piece.title_en = '8 Early Songs: Heimgang in der Frühe', piece.editor_locked = 1
WHERE piece.id = 10430 AND piece.composer_id = 97
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'vocal', piece.form_key = 'song'
WHERE piece.composer_id = 97 AND piece.title = '페르디난트 아베나리우스의 시에 의한 3개의 가곡' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'vocal', piece.form_key = 'song'
WHERE piece.composer_id = 97 AND piece.title = '슈테판 게오르게의 시에 의한 4개의 가곡' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'vocal', piece.form_key = 'song'
WHERE piece.composer_id = 97 AND piece.title = '리하르트 데멜의 시에 의한 5개의 가곡' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'vocal', piece.form_key = 'song'
WHERE piece.composer_id = 97 AND piece.title = '8개의 초기 가곡' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 야나체크 (composer_id 104) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 0

-- None "The Danube" Symphony

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"The Danube" Symphony', '"The Danube" Symphony', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 104
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"The Danube" Symphony'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8346 AND linked.composer_id = 104), 'musicbrainz:2ccb0738-e4df-451b-bdbe-fc1046f5d830', 1, 'I', 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '"The Danube" Symphony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ccb0738-e4df-451b-bdbe-fc1046f5d830'
);

UPDATE pieces piece
SET piece.title = '"The Danube" Symphony 중 "Andante"', piece.title_en = '"The Danube" Symphony: Andante', piece.editor_locked = 1
WHERE piece.id = 8346 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8910 AND linked.composer_id = 104), 'musicbrainz:54489dae-17d8-4e51-8631-7a115a7de165', 2, 'II', 'Adagio', 'Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '"The Danube" Symphony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54489dae-17d8-4e51-8631-7a115a7de165'
);

UPDATE pieces piece
SET piece.title = '"The Danube" Symphony 중 "Adagio"', piece.title_en = '"The Danube" Symphony: Adagio', piece.editor_locked = 1
WHERE piece.id = 8910 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10013 AND linked.composer_id = 104), 'musicbrainz:a25ed1c7-f94b-4b2c-87a8-0ad44165b9cf', 3, 'III', 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '"The Danube" Symphony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a25ed1c7-f94b-4b2c-87a8-0ad44165b9cf'
);

UPDATE pieces piece
SET piece.title = '"The Danube" Symphony 중 "Allegro"', piece.title_en = '"The Danube" Symphony: Allegro', piece.editor_locked = 1
WHERE piece.id = 10013 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10086 AND linked.composer_id = 104), 'musicbrainz:a718f485-10c5-4565-b1f2-1565e9ea6443', 4, 'IV', '4악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '"The Danube" Symphony' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a718f485-10c5-4565-b1f2-1565e9ea6443'
);

UPDATE pieces piece
SET piece.title = '"The Danube" Symphony 중 "4악장"', piece.title_en = '"The Danube" Symphony: 4악장', piece.editor_locked = 1
WHERE piece.id = 10086 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None <Hradčanské písničky>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Hradčanské písničky>', 'Hradčanské písničky', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 104
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Hradčanské písničky>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8121 AND linked.composer_id = 104), 'musicbrainz:1a21233b-cc14-49bd-85b0-67f16af6a810', 1, NULL, 'Zlatá ulička', 'Zlatá ulička', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '<Hradčanské písničky>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a21233b-cc14-49bd-85b0-67f16af6a810'
);

UPDATE pieces piece
SET piece.title = '<Hradčanské písničky> 중 "Zlatá ulička"', piece.title_en = 'Hradčanské písničky: Zlatá ulička', piece.editor_locked = 1
WHERE piece.id = 8121 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9067 AND linked.composer_id = 104), 'musicbrainz:5ed4dae5-05ce-4461-9fa9-51b7f6d1d1f9', 2, NULL, 'Plačící fontána', 'Plačící fontána', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '<Hradčanské písničky>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ed4dae5-05ce-4461-9fa9-51b7f6d1d1f9'
);

UPDATE pieces piece
SET piece.title = '<Hradčanské písničky> 중 "Plačící fontána"', piece.title_en = 'Hradčanské písničky: Plačící fontána', piece.editor_locked = 1
WHERE piece.id = 9067 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9975 AND linked.composer_id = 104), 'musicbrainz:9fdb587c-9aff-4bbc-85f0-bd27056810d3', 3, NULL, 'Belveder', 'Belveder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '<Hradčanské písničky>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fdb587c-9aff-4bbc-85f0-bd27056810d3'
);

UPDATE pieces piece
SET piece.title = '<Hradčanské písničky> 중 "Belveder"', piece.title_en = 'Hradčanské písničky: Belveder', piece.editor_locked = 1
WHERE piece.id = 9975 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'symphony', piece.form_key = 'symphony'
WHERE piece.composer_id = 104 AND piece.title = '"The Danube" Symphony' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== Jonathan Dove (composer_id 139) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 0

-- None It Sounded as If the Streets Were Running

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'It Sounded as If the Streets Were Running', 'It Sounded as If the Streets Were Running', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 139
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'It Sounded as If the Streets Were Running'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18409 AND linked.composer_id = 139), 'musicbrainz:93371d30-a7a9-4026-ab6b-78e074514908', 1, NULL, 'It Sounded as If the Streets Were Running', 'It Sounded as If the Streets Were Running', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'It Sounded as If the Streets Were Running' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93371d30-a7a9-4026-ab6b-78e074514908'
);

UPDATE pieces piece
SET piece.title = 'It Sounded as If the Streets Were Running 중 "It Sounded as If the Streets Were Running"', piece.title_en = 'It Sounded as If the Streets Were Running: It Sounded as If the Streets Were Running', piece.editor_locked = 1
WHERE piece.id = 18409 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19969 AND linked.composer_id = 139), 'musicbrainz:f7afed97-9cc5-4678-867f-8578fbd82705', 2, NULL, 'I Saw No Way', 'I Saw No Way', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'It Sounded as If the Streets Were Running' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7afed97-9cc5-4678-867f-8578fbd82705'
);

UPDATE pieces piece
SET piece.title = 'It Sounded as If the Streets Were Running 중 "I Saw No Way"', piece.title_en = 'It Sounded as If the Streets Were Running: I Saw No Way', piece.editor_locked = 1
WHERE piece.id = 19969 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18923 AND linked.composer_id = 139), 'musicbrainz:b3b5fbe0-c648-43d8-8235-c775b670d6bf', 3, NULL, 'How Happy Is the Little Stone', 'How Happy Is the Little Stone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'It Sounded as If the Streets Were Running' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3b5fbe0-c648-43d8-8235-c775b670d6bf'
);

UPDATE pieces piece
SET piece.title = 'It Sounded as If the Streets Were Running 중 "How Happy Is the Little Stone"', piece.title_en = 'It Sounded as If the Streets Were Running: How Happy Is the Little Stone', piece.editor_locked = 1
WHERE piece.id = 18923 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 조지 헨리 크럼 (composer_id 191) =====
-- 잇기 0, 새 묶음 3(이름) + 0(음반), 숨김 0, 그대로 0

-- None Mundus Canis

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mundus Canis', 'Mundus Canis', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 191
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mundus Canis'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15844 AND linked.composer_id = 191), 'musicbrainz:f1551d82-47e0-457d-8b2f-12bdf6ce9cca', 1, 'I', 'Tammy', 'Tammy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Mundus Canis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1551d82-47e0-457d-8b2f-12bdf6ce9cca'
);

UPDATE pieces piece
SET piece.title = 'Mundus Canis 중 "Tammy"', piece.title_en = 'Mundus Canis: Tammy', piece.editor_locked = 1
WHERE piece.id = 15844 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15752 AND linked.composer_id = 191), 'musicbrainz:42ead07e-d7c7-4340-8ec6-52d79b2fb4b4', 2, 'II', 'Fritzi', 'Fritzi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Mundus Canis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42ead07e-d7c7-4340-8ec6-52d79b2fb4b4'
);

UPDATE pieces piece
SET piece.title = 'Mundus Canis 중 "Fritzi"', piece.title_en = 'Mundus Canis: Fritzi', piece.editor_locked = 1
WHERE piece.id = 15752 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15825 AND linked.composer_id = 191), 'musicbrainz:d5e7ee88-5a32-4837-b2dd-978768b6beac', 3, 'III', 'Heidel', 'Heidel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Mundus Canis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5e7ee88-5a32-4837-b2dd-978768b6beac'
);

UPDATE pieces piece
SET piece.title = 'Mundus Canis 중 "Heidel"', piece.title_en = 'Mundus Canis: Heidel', piece.editor_locked = 1
WHERE piece.id = 15825 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15802 AND linked.composer_id = 191), 'musicbrainz:9e604251-258f-4de0-b406-229161b7ba43', 4, 'IV', 'Emma-Jean', 'Emma-Jean', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Mundus Canis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e604251-258f-4de0-b406-229161b7ba43'
);

UPDATE pieces piece
SET piece.title = 'Mundus Canis 중 "Emma-Jean"', piece.title_en = 'Mundus Canis: Emma-Jean', piece.editor_locked = 1
WHERE piece.id = 15802 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15813 AND linked.composer_id = 191), 'musicbrainz:b6b4fcb9-01ac-44f1-aa69-bc07ff9f9b74', 5, 'V', 'Yoda', 'Yoda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Mundus Canis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6b4fcb9-01ac-44f1-aa69-bc07ff9f9b74'
);

UPDATE pieces piece
SET piece.title = 'Mundus Canis 중 "Yoda"', piece.title_en = 'Mundus Canis: Yoda', piece.editor_locked = 1
WHERE piece.id = 15813 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 가곡집 <Sun and Shadow>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <Sun and Shadow>', 'Sun and Shadow (Spanish Songbook II)', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 191
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <Sun and Shadow>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16128 AND linked.composer_id = 191), 'musicbrainz:080602ec-964c-4ce1-bd2f-fdb2d0415b75', 1, 'I', 'Lazy River', 'Lazy River', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Sun and Shadow>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:080602ec-964c-4ce1-bd2f-fdb2d0415b75'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Sun and Shadow> 중 "Lazy River"', piece.title_en = 'Sun and Shadow (Spanish Songbook II): Lazy River', piece.editor_locked = 1
WHERE piece.id = 16128 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16131 AND linked.composer_id = 191), 'musicbrainz:08218018-f0e1-4fb1-9f79-ddd750588a55', 2, 'II', 'The Fly', 'The Fly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Sun and Shadow>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08218018-f0e1-4fb1-9f79-ddd750588a55'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Sun and Shadow> 중 "The Fly"', piece.title_en = 'Sun and Shadow (Spanish Songbook II): The Fly', piece.editor_locked = 1
WHERE piece.id = 16131 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18486 AND linked.composer_id = 191), 'musicbrainz:97c58119-9db7-4cfd-b3d0-958f3728878c', 3, 'III', 'The Interrupted Concert', 'The Interrupted Concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Sun and Shadow>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97c58119-9db7-4cfd-b3d0-958f3728878c'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Sun and Shadow> 중 "The Interrupted Concert"', piece.title_en = 'Sun and Shadow (Spanish Songbook II): The Interrupted Concert', piece.editor_locked = 1
WHERE piece.id = 18486 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18924 AND linked.composer_id = 191), 'musicbrainz:b3c6e297-8c89-478d-9281-bf03903aec15', 4, 'IV', 'Dance of the Moon in Santiago', 'Dance of the Moon in Santiago', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Sun and Shadow>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3c6e297-8c89-478d-9281-bf03903aec15'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Sun and Shadow> 중 "Dance of the Moon in Santiago"', piece.title_en = 'Sun and Shadow (Spanish Songbook II): Dance of the Moon in Santiago', piece.editor_locked = 1
WHERE piece.id = 18924 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16499 AND linked.composer_id = 191), 'musicbrainz:1d0cd5f2-b5bc-4c43-8686-7a5c0e5afcff', 5, 'V', 'Farewell', 'Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Sun and Shadow>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d0cd5f2-b5bc-4c43-8686-7a5c0e5afcff'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Sun and Shadow> 중 "Farewell"', piece.title_en = 'Sun and Shadow (Spanish Songbook II): Farewell', piece.editor_locked = 1
WHERE piece.id = 16499 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 가곡집 <Voices from the Heartland>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <Voices from the Heartland>', 'Voices from the Heartland (American Songbook VII)', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 191
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <Voices from the Heartland>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15994 AND linked.composer_id = 191), 'musicbrainz:00616b8d-7317-495d-8a58-1c01bd18de2d', 1, 'I', 'Softly and Tenderly', 'Softly and Tenderly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Voices from the Heartland>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00616b8d-7317-495d-8a58-1c01bd18de2d'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Voices from the Heartland> 중 "Softly and Tenderly"', piece.title_en = 'Voices from the Heartland (American Songbook VII): Softly and Tenderly', piece.editor_locked = 1
WHERE piece.id = 15994 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19086 AND linked.composer_id = 191), 'musicbrainz:be57ec9a-dc0b-470e-b25f-bf6500659eb6', 2, 'II', 'Ghost Dance', 'Ghost Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Voices from the Heartland>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be57ec9a-dc0b-470e-b25f-bf6500659eb6'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Voices from the Heartland> 중 "Ghost Dance"', piece.title_en = 'Voices from the Heartland (American Songbook VII): Ghost Dance', piece.editor_locked = 1
WHERE piece.id = 19086 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16840 AND linked.composer_id = 191), 'musicbrainz:33013dba-bb15-48c5-8e37-eafbf65e4040', 3, 'III', 'Lord, Let Me Fly!', 'Lord, Let Me Fly!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Voices from the Heartland>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33013dba-bb15-48c5-8e37-eafbf65e4040'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Voices from the Heartland> 중 "Lord, Let Me Fly!"', piece.title_en = 'Voices from the Heartland (American Songbook VII): Lord, Let Me Fly!', piece.editor_locked = 1
WHERE piece.id = 16840 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19213 AND linked.composer_id = 191), 'musicbrainz:c6043ef7-f723-48d3-a16a-e9726388a5b2', 4, 'IV', 'The Kanawha River at Dusk', 'The Kanawha River at Dusk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Voices from the Heartland>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6043ef7-f723-48d3-a16a-e9726388a5b2'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Voices from the Heartland> 중 "The Kanawha River at Dusk"', piece.title_en = 'Voices from the Heartland (American Songbook VII): The Kanawha River at Dusk', piece.editor_locked = 1
WHERE piece.id = 19213 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19781 AND linked.composer_id = 191), 'musicbrainz:edcd6db5-0c5f-42ee-91d6-0e1753a7280c', 5, 'V', 'Glory Be to the New-Born King', 'Glory Be to the New-Born King', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Voices from the Heartland>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edcd6db5-0c5f-42ee-91d6-0e1753a7280c'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Voices from the Heartland> 중 "Glory Be to the New-Born King"', piece.title_en = 'Voices from the Heartland (American Songbook VII): Glory Be to the New-Born King', piece.editor_locked = 1
WHERE piece.id = 19781 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16532 AND linked.composer_id = 191), 'musicbrainz:1fb42ca2-5ef4-4b74-80a1-4e0227c09680', 6, 'VI', 'The War of the Sexes', 'The War of the Sexes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Voices from the Heartland>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb42ca2-5ef4-4b74-80a1-4e0227c09680'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Voices from the Heartland> 중 "The War of the Sexes"', piece.title_en = 'Voices from the Heartland (American Songbook VII): The War of the Sexes', piece.editor_locked = 1
WHERE piece.id = 16532 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18394 AND linked.composer_id = 191), 'musicbrainz:920db0bc-28b3-469d-a2ed-69f033d88c71', 7, 'VIII', 'Old Blue', 'Old Blue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Voices from the Heartland>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:920db0bc-28b3-469d-a2ed-69f033d88c71'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Voices from the Heartland> 중 "Old Blue"', piece.title_en = 'Voices from the Heartland (American Songbook VII): Old Blue', piece.editor_locked = 1
WHERE piece.id = 18394 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19368 AND linked.composer_id = 191), 'musicbrainz:d0a06822-a66d-43fc-9a21-01e9e4c9f4ca', 8, 'IX', 'Song of the Earth', 'Song of the Earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = '가곡집 <Voices from the Heartland>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0a06822-a66d-43fc-9a21-01e9e4c9f4ca'
);

UPDATE pieces piece
SET piece.title = '가곡집 <Voices from the Heartland> 중 "Song of the Earth"', piece.title_en = 'Voices from the Heartland (American Songbook VII): Song of the Earth', piece.editor_locked = 1
WHERE piece.id = 19368 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'vocal', piece.form_key = 'song'
WHERE piece.composer_id = 191 AND piece.title = '가곡집 <Sun and Shadow>' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'vocal', piece.form_key = 'song'
WHERE piece.composer_id = 191 AND piece.title = '가곡집 <Voices from the Heartland>' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 프랑수아 프랑쾨르 (composer_id 199) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 0

-- None 소나타 12번 E장조 2권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타 12번 E장조 2권', 'Sonate XII en mi majeur, Livre II', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 199
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타 12번 E장조 2권'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19514 AND linked.composer_id = 199), 'musicbrainz:da6de5e0-573f-4df7-a2d8-888c3bf691d5', 1, 'I', 'Adagio', 'Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 199 AND p.title = '소나타 12번 E장조 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da6de5e0-573f-4df7-a2d8-888c3bf691d5'
);

UPDATE pieces piece
SET piece.title = '소나타 12번 E장조 2권 중 "Adagio"', piece.title_en = 'Sonate XII en mi majeur, Livre II: Adagio', piece.editor_locked = 1
WHERE piece.id = 19514 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17877 AND linked.composer_id = 199), 'musicbrainz:70c30fba-cd2a-42de-b32a-a5cfab7d5e55', 2, 'II', 'Courente', 'Courente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 199 AND p.title = '소나타 12번 E장조 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70c30fba-cd2a-42de-b32a-a5cfab7d5e55'
);

UPDATE pieces piece
SET piece.title = '소나타 12번 E장조 2권 중 "Courente"', piece.title_en = 'Sonate XII en mi majeur, Livre II: Courente', piece.editor_locked = 1
WHERE piece.id = 17877 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17123 AND linked.composer_id = 199), 'musicbrainz:43fd7ee4-05d1-4e2d-81c3-096df04c558e', 3, 'III', 'Sicilienne', 'Sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 199 AND p.title = '소나타 12번 E장조 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43fd7ee4-05d1-4e2d-81c3-096df04c558e'
);

UPDATE pieces piece
SET piece.title = '소나타 12번 E장조 2권 중 "Sicilienne"', piece.title_en = 'Sonate XII en mi majeur, Livre II: Sicilienne', piece.editor_locked = 1
WHERE piece.id = 17123 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16132 AND linked.composer_id = 199), 'musicbrainz:083eb30a-7fcc-4800-a090-03be730be538', 4, 'IV', 'Rondeau', 'Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 199 AND p.title = '소나타 12번 E장조 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:083eb30a-7fcc-4800-a090-03be730be538'
);

UPDATE pieces piece
SET piece.title = '소나타 12번 E장조 2권 중 "Rondeau"', piece.title_en = 'Sonate XII en mi majeur, Livre II: Rondeau', piece.editor_locked = 1
WHERE piece.id = 16132 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- Op. 2 No. 6 트리오 소나타 E장조 Op. 2 No. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 E장조 Op. 2 No. 6', 'Trio Sonata in E major, op. 2, no. 6', 'album', NULL, 'Op.', '2 No. 6', NULL, 'manual', 1
FROM composers c
WHERE c.id = 199
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 E장조 Op. 2 No. 6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18038 AND linked.composer_id = 199), 'musicbrainz:7b560f56-7d2d-404e-8a5b-8a8ec3971a24', 1, 'I', 'Adagio', 'Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 199 AND p.title = '트리오 소나타 E장조 Op. 2 No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b560f56-7d2d-404e-8a5b-8a8ec3971a24'
);

UPDATE pieces piece
SET piece.title = '트리오 소나타 E장조 Op. 2 No. 6 중 "Adagio"', piece.title_en = 'Trio Sonata in E major, op. 2, no. 6: Adagio', piece.editor_locked = 1
WHERE piece.id = 18038 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16263 AND linked.composer_id = 199), 'musicbrainz:0ff9d668-c318-46a1-8841-8b6ad0d5e5b7', 2, 'II', 'Courante', 'Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 199 AND p.title = '트리오 소나타 E장조 Op. 2 No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ff9d668-c318-46a1-8841-8b6ad0d5e5b7'
);

UPDATE pieces piece
SET piece.title = '트리오 소나타 E장조 Op. 2 No. 6 중 "Courante"', piece.title_en = 'Trio Sonata in E major, op. 2, no. 6: Courante', piece.editor_locked = 1
WHERE piece.id = 16263 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16180 AND linked.composer_id = 199), 'musicbrainz:0b1833c9-7bd5-4106-aa39-641fcfea9f24', 3, 'III', 'Sicilienne', 'Sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 199 AND p.title = '트리오 소나타 E장조 Op. 2 No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b1833c9-7bd5-4106-aa39-641fcfea9f24'
);

UPDATE pieces piece
SET piece.title = '트리오 소나타 E장조 Op. 2 No. 6 중 "Sicilienne"', piece.title_en = 'Trio Sonata in E major, op. 2, no. 6: Sicilienne', piece.editor_locked = 1
WHERE piece.id = 16180 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19984 AND linked.composer_id = 199), 'musicbrainz:f84d8dd3-59d6-4cc7-a405-af934052890e', 4, 'IV', 'Rondeau', 'Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 199 AND p.title = '트리오 소나타 E장조 Op. 2 No. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f84d8dd3-59d6-4cc7-a405-af934052890e'
);

UPDATE pieces piece
SET piece.title = '트리오 소나타 E장조 Op. 2 No. 6 중 "Rondeau"', piece.title_en = 'Trio Sonata in E major, op. 2, no. 6: Rondeau', piece.editor_locked = 1
WHERE piece.id = 19984 AND piece.composer_id = 199
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'piano', piece.form_key = 'sonata'
WHERE piece.composer_id = 199 AND piece.title = '소나타 12번 E장조 2권' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'chamber', piece.form_key = 'chamber_other'
WHERE piece.composer_id = 199 AND piece.title = '트리오 소나타 E장조 Op. 2 No. 6' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== Leo Brouwer (composer_id 204) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 3

-- None 2개의 쿠바 민속 주제

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 쿠바 민속 주제', 'Dos temas populares cubanos', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 204
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 쿠바 민속 주제'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16523 AND linked.composer_id = 204), 'musicbrainz:1f1cb112-2d5f-4e6a-94b1-9f839ad44f2e', 1, NULL, 'Canción de cuna', 'Canción de cuna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 204 AND p.title = '2개의 쿠바 민속 주제' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f1cb112-2d5f-4e6a-94b1-9f839ad44f2e'
);

UPDATE pieces piece
SET piece.title = '2개의 쿠바 민속 주제 중 "Canción de cuna"', piece.title_en = 'Dos temas populares cubanos: Canción de cuna', piece.editor_locked = 1
WHERE piece.id = 16523 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15748 AND linked.composer_id = 204), 'musicbrainz:39e36b35-9ec8-3d67-8abb-76b2014a3014', 2, NULL, 'Ojos brujos', 'Ojos brujos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 204 AND p.title = '2개의 쿠바 민속 주제' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39e36b35-9ec8-3d67-8abb-76b2014a3014'
);

UPDATE pieces piece
SET piece.title = '2개의 쿠바 민속 주제 중 "Ojos brujos"', piece.title_en = 'Dos temas populares cubanos: Ojos brujos', piece.editor_locked = 1
WHERE piece.id = 15748 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 현악 4중주 5번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 5번', 'String Quartet no. 5', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 204
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 5번'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19515 AND linked.composer_id = 204), 'musicbrainz:da758372-9a0f-4409-8bf7-82d9f88fde17', 1, 'I', 'Lento', 'Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 204 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da758372-9a0f-4409-8bf7-82d9f88fde17'
);

UPDATE pieces piece
SET piece.title = '현악 4중주 5번 중 "Lento"', piece.title_en = 'String Quartet no. 5: Lento', piece.editor_locked = 1
WHERE piece.id = 19515 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17795 AND linked.composer_id = 204), 'musicbrainz:6c648c14-3aa3-4ebf-bf84-757fd8238f5f', 2, 'II', 'Celebration', 'Celebration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 204 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c648c14-3aa3-4ebf-bf84-757fd8238f5f'
);

UPDATE pieces piece
SET piece.title = '현악 4중주 5번 중 "Celebration"', piece.title_en = 'String Quartet no. 5: Celebration', piece.editor_locked = 1
WHERE piece.id = 17795 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'chamber', piece.form_key = 'string_quartet'
WHERE piece.composer_id = 204 AND piece.title = '현악 4중주 5번' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== Claudio Ambrosini (composer_id 226) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 2

-- None Three Holograms

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Three Holograms', 'Three Holograms', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 226
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Three Holograms'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19049 AND linked.composer_id = 226), 'musicbrainz:bc3ed89d-2adc-407c-a600-8dd06c2de530', 1, 'I', 'Janus ipse, dixit', 'Janus ipse, dixit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 226 AND p.title = 'Three Holograms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc3ed89d-2adc-407c-a600-8dd06c2de530'
);

UPDATE pieces piece
SET piece.title = 'Three Holograms 중 "Janus ipse, dixit"', piece.title_en = 'Three Holograms: Janus ipse, dixit', piece.editor_locked = 1
WHERE piece.id = 19049 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18110 AND linked.composer_id = 226), 'musicbrainz:7f9e18ea-e0b8-4b30-854e-a7d696135deb', 2, 'II', 'Rabdomante (Mosè?)', 'Rabdomante (Mosè?)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 226 AND p.title = 'Three Holograms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f9e18ea-e0b8-4b30-854e-a7d696135deb'
);

UPDATE pieces piece
SET piece.title = 'Three Holograms 중 "Rabdomante (Mosè?)"', piece.title_en = 'Three Holograms: Rabdomante (Mosè?)', piece.editor_locked = 1
WHERE piece.id = 18110 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17391 AND linked.composer_id = 226), 'musicbrainz:541e3e48-b650-4e4b-95cd-fc2fdde04882', 3, 'III', 'Arcimboldo docet', 'Arcimboldo docet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 226 AND p.title = 'Three Holograms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:541e3e48-b650-4e4b-95cd-fc2fdde04882'
);

UPDATE pieces piece
SET piece.title = 'Three Holograms 중 "Arcimboldo docet"', piece.title_en = 'Three Holograms: Arcimboldo docet', piece.editor_locked = 1
WHERE piece.id = 17391 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 3개의 연습곡 "en plein air"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 연습곡 "en plein air"', 'Tre Studi “en plein air”', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 226
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 연습곡 "en plein air"'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19845 AND linked.composer_id = 226), 'musicbrainz:f167d1ae-fded-484c-bdf2-9a873fc78344', 1, 'I', 'Notturno', 'Notturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 226 AND p.title = '3개의 연습곡 "en plein air"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f167d1ae-fded-484c-bdf2-9a873fc78344'
);

UPDATE pieces piece
SET piece.title = '3개의 연습곡 "en plein air" 중 "Notturno"', piece.title_en = 'Tre Studi “en plein air”: Notturno', piece.editor_locked = 1
WHERE piece.id = 19845 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19454 AND linked.composer_id = 226), 'musicbrainz:d5e96d0b-3d55-4935-a54e-d6aab86bd981', 2, 'II', 'Aube', 'Aube', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 226 AND p.title = '3개의 연습곡 "en plein air"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5e96d0b-3d55-4935-a54e-d6aab86bd981'
);

UPDATE pieces piece
SET piece.title = '3개의 연습곡 "en plein air" 중 "Aube"', piece.title_en = 'Tre Studi “en plein air”: Aube', piece.editor_locked = 1
WHERE piece.id = 19454 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17236 AND linked.composer_id = 226), 'musicbrainz:49bdffe1-25fd-4c79-a665-96fbcaaa28d5', 3, 'III', 'Bus Stop', 'Bus Stop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 226 AND p.title = '3개의 연습곡 "en plein air"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49bdffe1-25fd-4c79-a665-96fbcaaa28d5'
);

UPDATE pieces piece
SET piece.title = '3개의 연습곡 "en plein air" 중 "Bus Stop"', piece.title_en = 'Tre Studi “en plein air”: Bus Stop', piece.editor_locked = 1
WHERE piece.id = 17236 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'piano', piece.form_key = 'etude'
WHERE piece.composer_id = 226 AND piece.title = '3개의 연습곡 "en plein air"' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 잔 프란체스코 말리피에로 (composer_id 260) =====
-- 잇기 0, 새 묶음 4(이름) + 0(음반), 숨김 0, 그대로 2

-- None 교향곡 11번 "della cornamuse"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 11번 "della cornamuse"', 'Symphony no. 11 "della cornamuse"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 11번 "della cornamuse"'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16853 AND linked.composer_id = 260), 'musicbrainz:339257c3-7e21-48fa-9d46-6c4f1f0695b9', 1, 'I', 'Energico ma mosso, non troppo però', 'Energico ma mosso, non troppo però', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 11번 "della cornamuse"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:339257c3-7e21-48fa-9d46-6c4f1f0695b9'
);

UPDATE pieces piece
SET piece.title = '교향곡 11번 "della cornamuse" 중 "Energico ma mosso, non troppo però"', piece.title_en = 'Symphony no. 11 "della cornamuse": Energico ma mosso, non troppo però', piece.editor_locked = 1
WHERE piece.id = 16853 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18981 AND linked.composer_id = 260), 'musicbrainz:b768aba5-e1c0-4511-a629-9cbc2f3371b7', 2, 'II', 'Lento', 'Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 11번 "della cornamuse"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b768aba5-e1c0-4511-a629-9cbc2f3371b7'
);

UPDATE pieces piece
SET piece.title = '교향곡 11번 "della cornamuse" 중 "Lento"', piece.title_en = 'Symphony no. 11 "della cornamuse": Lento', piece.editor_locked = 1
WHERE piece.id = 18981 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18373 AND linked.composer_id = 260), 'musicbrainz:90eebebd-7326-4516-9515-c8862891647b', 3, 'III', 'Gaio', 'Gaio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 11번 "della cornamuse"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90eebebd-7326-4516-9515-c8862891647b'
);

UPDATE pieces piece
SET piece.title = '교향곡 11번 "della cornamuse" 중 "Gaio"', piece.title_en = 'Symphony no. 11 "della cornamuse": Gaio', piece.editor_locked = 1
WHERE piece.id = 18373 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19552 AND linked.composer_id = 260), 'musicbrainz:dc7e96a9-e58b-457a-a586-ace8e395e996', 4, 'IV', 'Molto mosso ma marcando il tempo - Quasi lento - Molto mosso', 'Molto mosso ma marcando il tempo - Quasi lento - Molto mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 11번 "della cornamuse"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc7e96a9-e58b-457a-a586-ace8e395e996'
);

UPDATE pieces piece
SET piece.title = '교향곡 11번 "della cornamuse" 중 "Molto mosso ma marcando il tempo - Quasi lento - Molto mosso"', piece.title_en = 'Symphony no. 11 "della cornamuse": Molto mosso ma marcando il tempo - Quasi lento - Molto mosso', piece.editor_locked = 1
WHERE piece.id = 19552 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 교향곡 5번 "concertante in eco"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 5번 "concertante in eco"', 'Symphony no. 5 "concertante in eco"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 5번 "concertante in eco"'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17431 AND linked.composer_id = 260), 'musicbrainz:56641ede-bb58-4d50-9247-d55c7c308114', 1, 'I', 'Allegro agitato ma moderatamente', 'Allegro agitato ma moderatamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 5번 "concertante in eco"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56641ede-bb58-4d50-9247-d55c7c308114'
);

UPDATE pieces piece
SET piece.title = '교향곡 5번 "concertante in eco" 중 "Allegro agitato ma moderatamente"', piece.title_en = 'Symphony no. 5 "concertante in eco": Allegro agitato ma moderatamente', piece.editor_locked = 1
WHERE piece.id = 17431 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17793 AND linked.composer_id = 260), 'musicbrainz:6c630f69-5fd7-4fa7-9f22-7a00f5770c2e', 2, 'II', 'Lento', 'Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 5번 "concertante in eco"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c630f69-5fd7-4fa7-9f22-7a00f5770c2e'
);

UPDATE pieces piece
SET piece.title = '교향곡 5번 "concertante in eco" 중 "Lento"', piece.title_en = 'Symphony no. 5 "concertante in eco": Lento', piece.editor_locked = 1
WHERE piece.id = 17793 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17267 AND linked.composer_id = 260), 'musicbrainz:4bc0a141-6e90-4bf3-824b-23b1e5b65599', 3, 'III', 'Allegro vivace ma ritmato', 'Allegro vivace ma ritmato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 5번 "concertante in eco"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bc0a141-6e90-4bf3-824b-23b1e5b65599'
);

UPDATE pieces piece
SET piece.title = '교향곡 5번 "concertante in eco" 중 "Allegro vivace ma ritmato"', piece.title_en = 'Symphony no. 5 "concertante in eco": Allegro vivace ma ritmato', piece.editor_locked = 1
WHERE piece.id = 17267 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19000 AND linked.composer_id = 260), 'musicbrainz:b8ab0cba-2b14-475d-92a6-08478efcafd8', 4, 'IV', 'Lento ma non troppo - Mosso (agitato) - Ritenuto (quasi funebre)', 'Lento ma non troppo - Mosso (agitato) - Ritenuto (quasi funebre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 5번 "concertante in eco"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8ab0cba-2b14-475d-92a6-08478efcafd8'
);

UPDATE pieces piece
SET piece.title = '교향곡 5번 "concertante in eco" 중 "Lento ma non troppo - Mosso (agitato) - Ritenuto (quasi funebre)"', piece.title_en = 'Symphony no. 5 "concertante in eco": Lento ma non troppo - Mosso (agitato) - Ritenuto (quasi funebre)', piece.editor_locked = 1
WHERE piece.id = 19000 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 교향곡 6번 "degli archi"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 6번 "degli archi"', 'Symphony no. 6 "degli archi"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 6번 "degli archi"'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17141 AND linked.composer_id = 260), 'musicbrainz:4504c080-c98d-4c62-bc11-6d2b44d12559', 1, 'I', 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 6번 "degli archi"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4504c080-c98d-4c62-bc11-6d2b44d12559'
);

UPDATE pieces piece
SET piece.title = '교향곡 6번 "degli archi" 중 "Allegro"', piece.title_en = 'Symphony no. 6 "degli archi": Allegro', piece.editor_locked = 1
WHERE piece.id = 17141 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16249 AND linked.composer_id = 260), 'musicbrainz:0f213408-cbd9-4a6e-9b6d-c43d6379f585', 2, 'II', 'Piuttosto lento', 'Piuttosto lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 6번 "degli archi"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f213408-cbd9-4a6e-9b6d-c43d6379f585'
);

UPDATE pieces piece
SET piece.title = '교향곡 6번 "degli archi" 중 "Piuttosto lento"', piece.title_en = 'Symphony no. 6 "degli archi": Piuttosto lento', piece.editor_locked = 1
WHERE piece.id = 16249 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20001 AND linked.composer_id = 260), 'musicbrainz:f96add04-1ed6-40c7-bed5-9e06e0b30e1b', 3, 'III', 'Allegro vivo', 'Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 6번 "degli archi"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f96add04-1ed6-40c7-bed5-9e06e0b30e1b'
);

UPDATE pieces piece
SET piece.title = '교향곡 6번 "degli archi" 중 "Allegro vivo"', piece.title_en = 'Symphony no. 6 "degli archi": Allegro vivo', piece.editor_locked = 1
WHERE piece.id = 20001 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16998 AND linked.composer_id = 260), 'musicbrainz:3c577c12-78ee-4a5f-81e1-ff1b67e341a4', 4, 'IV', 'Lento ma non troppo - Allegro - Lento - Allegro - Molto triste', 'Lento ma non troppo - Allegro - Lento - Allegro - Molto triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 6번 "degli archi"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c577c12-78ee-4a5f-81e1-ff1b67e341a4'
);

UPDATE pieces piece
SET piece.title = '교향곡 6번 "degli archi" 중 "Lento ma non troppo - Allegro - Lento - Allegro - Molto triste"', piece.title_en = 'Symphony no. 6 "degli archi": Lento ma non troppo - Allegro - Lento - Allegro - Molto triste', piece.editor_locked = 1
WHERE piece.id = 16998 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 교향곡 8번 "Symphonia brevis"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 8번 "Symphonia brevis"', 'Symphony no. 8 "Symphonia brevis"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 260
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 8번 "Symphonia brevis"'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18518 AND linked.composer_id = 260), 'musicbrainz:99d533bd-23a3-4df2-9ea4-f944120e9191', 1, 'I', 'Piuttusto lento - Un poco più mosso', 'Piuttusto lento - Un poco più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 8번 "Symphonia brevis"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99d533bd-23a3-4df2-9ea4-f944120e9191'
);

UPDATE pieces piece
SET piece.title = '교향곡 8번 "Symphonia brevis" 중 "Piuttusto lento - Un poco più mosso"', piece.title_en = 'Symphony no. 8 "Symphonia brevis": Piuttusto lento - Un poco più mosso', piece.editor_locked = 1
WHERE piece.id = 18518 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19702 AND linked.composer_id = 260), 'musicbrainz:e76aff43-c2dd-47ef-936b-9c975654bba9', 2, 'II', 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 8번 "Symphonia brevis"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e76aff43-c2dd-47ef-936b-9c975654bba9'
);

UPDATE pieces piece
SET piece.title = '교향곡 8번 "Symphonia brevis" 중 "Allegro"', piece.title_en = 'Symphony no. 8 "Symphonia brevis": Allegro', piece.editor_locked = 1
WHERE piece.id = 19702 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19449 AND linked.composer_id = 260), 'musicbrainz:d578751e-b557-40bb-95ed-af9ccbdc4ad1', 3, 'III', 'Non troppo lento - Più mosso - Allegramente - Tranquillo - Mosso - Lento - Meno lento, non trascinare - Più mosso, gaio - Meno mosso - Agitato Lento (quasi funebre)', 'Non troppo lento - Più mosso - Allegramente - Tranquillo - Mosso - Lento - Meno lento, non trascinare - Più mosso, gaio - Meno mosso - Agitato Lento (quasi funebre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 260 AND p.title = '교향곡 8번 "Symphonia brevis"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d578751e-b557-40bb-95ed-af9ccbdc4ad1'
);

UPDATE pieces piece
SET piece.title = '교향곡 8번 "Symphonia brevis" 중 "Non troppo lento - Più mosso - Allegramente - Tranquillo - Mosso - Lento - Meno lento, non trascinare - Più mosso, gaio - Meno mosso - Agitato Lento (quasi funebre)"', piece.title_en = 'Symphony no. 8 "Symphonia brevis": Non troppo lento - Più mosso - Allegramente - Tranquillo - Mosso - Lento - Meno lento, non trascinare - Più mosso, gaio - Meno mosso - Agitato Lento (quasi funebre)', piece.editor_locked = 1
WHERE piece.id = 19449 AND piece.composer_id = 260
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'symphony', piece.form_key = 'symphony'
WHERE piece.composer_id = 260 AND piece.title = '교향곡 11번 "della cornamuse"' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'symphony', piece.form_key = 'symphony'
WHERE piece.composer_id = 260 AND piece.title = '교향곡 5번 "concertante in eco"' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'symphony', piece.form_key = 'symphony'
WHERE piece.composer_id = 260 AND piece.title = '교향곡 6번 "degli archi"' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'symphony', piece.form_key = 'symphony'
WHERE piece.composer_id = 260 AND piece.title = '교향곡 8번 "Symphonia brevis"' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 마이클 나이먼 (composer_id 280) =====
-- 잇기 0, 새 묶음 3(이름) + 3(음반), 숨김 0, 그대로 1

-- None 트롬본과 관현악을 위한 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트롬본과 관현악을 위한 협주곡', 'Concerto for Trombone and Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트롬본과 관현악을 위한 협주곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16115 AND linked.composer_id = 280), 'musicbrainz:074943b2-5234-3279-b13c-20307a0dd618', 1, 'I', '1악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '트롬본과 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074943b2-5234-3279-b13c-20307a0dd618'
);

UPDATE pieces piece
SET piece.title = '트롬본과 관현악을 위한 협주곡 중 "1악장"', piece.title_en = 'Concerto for Trombone and Orchestra: 1악장', piece.editor_locked = 1
WHERE piece.id = 16115 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17274 AND linked.composer_id = 280), 'musicbrainz:4c02f801-bcbb-3c23-9229-08207081275f', 2, 'II', '2악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '트롬본과 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c02f801-bcbb-3c23-9229-08207081275f'
);

UPDATE pieces piece
SET piece.title = '트롬본과 관현악을 위한 협주곡 중 "2악장"', piece.title_en = 'Concerto for Trombone and Orchestra: 2악장', piece.editor_locked = 1
WHERE piece.id = 17274 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18946 AND linked.composer_id = 280), 'musicbrainz:b4b45418-168b-33ab-9ad5-8c3717f6082c', 3, 'III', '3악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '트롬본과 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4b45418-168b-33ab-9ad5-8c3717f6082c'
);

UPDATE pieces piece
SET piece.title = '트롬본과 관현악을 위한 협주곡 중 "3악장"', piece.title_en = 'Concerto for Trombone and Orchestra: 3악장', piece.editor_locked = 1
WHERE piece.id = 18946 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18545 AND linked.composer_id = 280), 'musicbrainz:9b7d2182-3292-3460-ba2b-8011518a7716', 4, 'IV', '4악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '트롬본과 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b7d2182-3292-3460-ba2b-8011518a7716'
);

UPDATE pieces piece
SET piece.title = '트롬본과 관현악을 위한 협주곡 중 "4악장"', piece.title_en = 'Concerto for Trombone and Orchestra: 4악장', piece.editor_locked = 1
WHERE piece.id = 18545 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19301 AND linked.composer_id = 280), 'musicbrainz:cbc37e88-b527-33ff-8cb0-75918aea80f7', 5, 'V', '5악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '트롬본과 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbc37e88-b527-33ff-8cb0-75918aea80f7'
);

UPDATE pieces piece
SET piece.title = '트롬본과 관현악을 위한 협주곡 중 "5악장"', piece.title_en = 'Concerto for Trombone and Orchestra: 5악장', piece.editor_locked = 1
WHERE piece.id = 19301 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19728 AND linked.composer_id = 280), 'musicbrainz:e9fa881e-3a18-3280-ad54-b6ec9220f89c', 6, 'VI', '6악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '트롬본과 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9fa881e-3a18-3280-ad54-b6ec9220f89c'
);

UPDATE pieces piece
SET piece.title = '트롬본과 관현악을 위한 협주곡 중 "6악장"', piece.title_en = 'Concerto for Trombone and Orchestra: 6악장', piece.editor_locked = 1
WHERE piece.id = 19728 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19902 AND linked.composer_id = 280), 'musicbrainz:f494aeb5-606f-3b8a-9d96-ac23aba37778', 7, 'VII', '7악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '트롬본과 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f494aeb5-606f-3b8a-9d96-ac23aba37778'
);

UPDATE pieces piece
SET piece.title = '트롬본과 관현악을 위한 협주곡 중 "7악장"', piece.title_en = 'Concerto for Trombone and Orchestra: 7악장', piece.editor_locked = 1
WHERE piece.id = 19902 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18135 AND linked.composer_id = 280), 'musicbrainz:81c775ef-7fe3-3640-88f1-e5229f3ae1cb', 8, 'VIII', '8악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '트롬본과 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81c775ef-7fe3-3640-88f1-e5229f3ae1cb'
);

UPDATE pieces piece
SET piece.title = '트롬본과 관현악을 위한 협주곡 중 "8악장"', piece.title_en = 'Concerto for Trombone and Orchestra: 8악장', piece.editor_locked = 1
WHERE piece.id = 18135 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16016 AND linked.composer_id = 280), 'musicbrainz:01cb0bba-d2e6-3e6b-bd66-761ec71ae8c9', 9, 'IX', '9악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '트롬본과 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01cb0bba-d2e6-3e6b-bd66-761ec71ae8c9'
);

UPDATE pieces piece
SET piece.title = '트롬본과 관현악을 위한 협주곡 중 "9악장"', piece.title_en = 'Concerto for Trombone and Orchestra: 9악장', piece.editor_locked = 1
WHERE piece.id = 16016 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 색소폰, 첼로, 관현악을 위한 이중 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '색소폰, 첼로, 관현악을 위한 이중 협주곡', 'Double Concerto for Saxophone, Cello and Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18690 AND linked.composer_id = 280), 'musicbrainz:a4e29bbe-1b1b-33bc-93c3-37ab9995b1d9', 1, 'I', '1악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4e29bbe-1b1b-33bc-93c3-37ab9995b1d9'
);

UPDATE pieces piece
SET piece.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡 중 "1악장"', piece.title_en = 'Double Concerto for Saxophone, Cello and Orchestra: 1악장', piece.editor_locked = 1
WHERE piece.id = 18690 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19461 AND linked.composer_id = 280), 'musicbrainz:d6928856-bdfd-3955-b1e1-3b3126c29e11', 2, 'II', '2악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6928856-bdfd-3955-b1e1-3b3126c29e11'
);

UPDATE pieces piece
SET piece.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡 중 "2악장"', piece.title_en = 'Double Concerto for Saxophone, Cello and Orchestra: 2악장', piece.editor_locked = 1
WHERE piece.id = 19461 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18840 AND linked.composer_id = 280), 'musicbrainz:ae034e77-7cd0-34d3-b1f1-532d0ec38896', 3, 'III', '3악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae034e77-7cd0-34d3-b1f1-532d0ec38896'
);

UPDATE pieces piece
SET piece.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡 중 "3악장"', piece.title_en = 'Double Concerto for Saxophone, Cello and Orchestra: 3악장', piece.editor_locked = 1
WHERE piece.id = 18840 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18833 AND linked.composer_id = 280), 'musicbrainz:add0b21a-35f7-32ce-8ecc-a124a58a6c7c', 4, 'IV', '4악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:add0b21a-35f7-32ce-8ecc-a124a58a6c7c'
);

UPDATE pieces piece
SET piece.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡 중 "4악장"', piece.title_en = 'Double Concerto for Saxophone, Cello and Orchestra: 4악장', piece.editor_locked = 1
WHERE piece.id = 18833 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19490 AND linked.composer_id = 280), 'musicbrainz:d863593e-d764-314e-9deb-182f3a8d4438', 5, 'V', '5악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d863593e-d764-314e-9deb-182f3a8d4438'
);

UPDATE pieces piece
SET piece.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡 중 "5악장"', piece.title_en = 'Double Concerto for Saxophone, Cello and Orchestra: 5악장', piece.editor_locked = 1
WHERE piece.id = 19490 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None L’Orgie parisienne

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'L’Orgie parisienne', 'L’Orgie parisienne', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'L’Orgie parisienne'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16108 AND linked.composer_id = 280), 'musicbrainz:06d37dd8-990c-4018-a943-32f7c3612e3e', 1, NULL, 'Allez! On préviendra les reflux d’incendie', 'Allez! On préviendra les reflux d’incendie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'L’Orgie parisienne' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06d37dd8-990c-4018-a943-32f7c3612e3e'
);

UPDATE pieces piece
SET piece.title = 'L’Orgie parisienne 중 "Allez! On préviendra les reflux d’incendie"', piece.title_en = 'L’Orgie parisienne: Allez! On préviendra les reflux d’incendie', piece.editor_locked = 1
WHERE piece.id = 16108 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19180 AND linked.composer_id = 280), 'musicbrainz:c3f9b24a-38e4-41d1-8447-f98ff0314847', 2, NULL, 'Quand tes pieds ont dansé', 'Quand tes pieds ont dansé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'L’Orgie parisienne' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3f9b24a-38e4-41d1-8447-f98ff0314847'
);

UPDATE pieces piece
SET piece.title = 'L’Orgie parisienne 중 "Quand tes pieds ont dansé"', piece.title_en = 'L’Orgie parisienne: Quand tes pieds ont dansé', piece.editor_locked = 1
WHERE piece.id = 19180 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None McQueen

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'McQueen', 'McQueen', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'McQueen'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19705 AND linked.composer_id = 280), 'musicbrainz:e7c282ce-636e-4b3a-8bac-48e9cb144869', 1, NULL, 'Time Lapse', 'Time Lapse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7c282ce-636e-4b3a-8bac-48e9cb144869'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Time Lapse"', piece.title_en = 'McQueen: Time Lapse', piece.editor_locked = 1
WHERE piece.id = 19705 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16051 AND linked.composer_id = 280), 'musicbrainz:03f0fa9a-95d1-4a58-bf73-a7e1a7411209', 2, NULL, 'Tape No. 1: A Sixth Part of the World 1', 'Tape No. 1: A Sixth Part of the World 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03f0fa9a-95d1-4a58-bf73-a7e1a7411209'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Tape No. 1: A Sixth Part of the World 1"', piece.title_en = 'McQueen: Tape No. 1: A Sixth Part of the World 1', piece.editor_locked = 1
WHERE piece.id = 16051 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17294 AND linked.composer_id = 280), 'musicbrainz:4dd01951-fe86-4a08-8d58-f0d4ecebfc4c', 3, NULL, 'Kinky Gerlinky: Secrets, Accusations and Charges', 'Kinky Gerlinky: Secrets, Accusations and Charges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dd01951-fe86-4a08-8d58-f0d4ecebfc4c'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Kinky Gerlinky: Secrets, Accusations and Charges"', piece.title_en = 'McQueen: Kinky Gerlinky: Secrets, Accusations and Charges', piece.editor_locked = 1
WHERE piece.id = 17294 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16388 AND linked.composer_id = 280), 'musicbrainz:16b80a06-affa-49a4-972f-4738bf5e6fc1', 4, NULL, 'Jack the Ripper Stalks His Victims: Mgv 1st Region', 'Jack the Ripper Stalks His Victims: Mgv 1st Region', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16b80a06-affa-49a4-972f-4738bf5e6fc1'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Jack the Ripper Stalks His Victims: Mgv 1st Region"', piece.title_en = 'McQueen: Jack the Ripper Stalks His Victims: Mgv 1st Region', piece.editor_locked = 1
WHERE piece.id = 16388 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17774 AND linked.composer_id = 280), 'musicbrainz:6b4e6506-499f-4fc8-89c6-4edde0cc33f3', 5, NULL, 'Tape No. 2: Knights at School', 'Tape No. 2: Knights at School', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b4e6506-499f-4fc8-89c6-4edde0cc33f3'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Tape No. 2: Knights at School"', piece.title_en = 'McQueen: Tape No. 2: Knights at School', piece.editor_locked = 1
WHERE piece.id = 17774 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17268 AND linked.composer_id = 280), 'musicbrainz:4bc0b8ce-7462-44e9-a2b6-0315aa990a76', 6, NULL, 'Sky''s the Limit: Chasing Sheep Is Best Left to Shepherds', 'Sky''s the Limit: Chasing Sheep Is Best Left to Shepherds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bc0b8ce-7462-44e9-a2b6-0315aa990a76'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Sky''s the Limit: Chasing Sheep Is Best Left to Shepherds"', piece.title_en = 'McQueen: Sky''s the Limit: Chasing Sheep Is Best Left to Shepherds', piece.editor_locked = 1
WHERE piece.id = 17268 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19044 AND linked.composer_id = 280), 'musicbrainz:bbb9557b-63c2-4342-b16c-6ed76f346ebf', 7, NULL, 'Lee Scissorhands: Bird List', 'Lee Scissorhands: Bird List', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbb9557b-63c2-4342-b16c-6ed76f346ebf'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Lee Scissorhands: Bird List"', piece.title_en = 'McQueen: Lee Scissorhands: Bird List', piece.editor_locked = 1
WHERE piece.id = 19044 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17915 AND linked.composer_id = 280), 'musicbrainz:73099e36-87dc-4b7a-b42f-439a2392f79c', 8, NULL, 'Joyce: Passage de l''égalite', 'Joyce: Passage de l''égalite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73099e36-87dc-4b7a-b42f-439a2392f79c'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Joyce: Passage de l''égalite"', piece.title_en = 'McQueen: Joyce: Passage de l''égalite', piece.editor_locked = 1
WHERE piece.id = 17915 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19061 AND linked.composer_id = 280), 'musicbrainz:bce118df-7811-4ed9-a57d-5ead2df33c8c', 9, NULL, 'Nocturne (Stitching to Nyman): Big My Secret', 'Nocturne (Stitching to Nyman): Big My Secret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bce118df-7811-4ed9-a57d-5ead2df33c8c'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Nocturne (Stitching to Nyman): Big My Secret"', piece.title_en = 'McQueen: Nocturne (Stitching to Nyman): Big My Secret', piece.editor_locked = 1
WHERE piece.id = 19061 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19182 AND linked.composer_id = 280), 'musicbrainz:c447e3c5-b3f1-46a0-bb14-62aa973c99a4', 10, NULL, 'The Highland Rape: Abel Carries Ephraim', 'The Highland Rape: Abel Carries Ephraim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c447e3c5-b3f1-46a0-bb14-62aa973c99a4'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "The Highland Rape: Abel Carries Ephraim"', piece.title_en = 'McQueen: The Highland Rape: Abel Carries Ephraim', piece.editor_locked = 1
WHERE piece.id = 19182 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16707 AND linked.composer_id = 280), 'musicbrainz:2af94fb3-597d-45ed-b142-39c9bc49dfad', 11, NULL, 'Armour for the Heart: I Am Also a Painter', 'Armour for the Heart: I Am Also a Painter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2af94fb3-597d-45ed-b142-39c9bc49dfad'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Armour for the Heart: I Am Also a Painter"', piece.title_en = 'McQueen: Armour for the Heart: I Am Also a Painter', piece.editor_locked = 1
WHERE piece.id = 16707 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16501 AND linked.composer_id = 280), 'musicbrainz:1d5b279f-6ac7-435f-8b2e-ba699c464379', 12, NULL, 'Bleached Jeans and Attitude: Here to There', 'Bleached Jeans and Attitude: Here to There', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d5b279f-6ac7-435f-8b2e-ba699c464379'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Bleached Jeans and Attitude: Here to There"', piece.title_en = 'McQueen: Bleached Jeans and Attitude: Here to There', piece.editor_locked = 1
WHERE piece.id = 16501 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18654 AND linked.composer_id = 280), 'musicbrainz:a2e87eea-5f43-4f74-adcc-9c9187337eb8', 13, NULL, 'Paris Chic: Revisiting the Don', 'Paris Chic: Revisiting the Don', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2e87eea-5f43-4f74-adcc-9c9187337eb8'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Paris Chic: Revisiting the Don"', piece.title_en = 'McQueen: Paris Chic: Revisiting the Don', piece.editor_locked = 1
WHERE piece.id = 18654 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16369 AND linked.composer_id = 280), 'musicbrainz:15c4d91d-afb2-4507-8804-624713ae6243', 14, NULL, 'Search for the Golden Fleece: A Satire Against Manhood', 'Search for the Golden Fleece: A Satire Against Manhood', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15c4d91d-afb2-4507-8804-624713ae6243'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Search for the Golden Fleece: A Satire Against Manhood"', piece.title_en = 'McQueen: Search for the Golden Fleece: A Satire Against Manhood', piece.editor_locked = 1
WHERE piece.id = 16369 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20017 AND linked.composer_id = 280), 'musicbrainz:fa82f6d1-10f6-4029-8ce0-e65428e5c668', 15, NULL, 'It''s a Jungle out There: Queen of the Night', 'It''s a Jungle out There: Queen of the Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa82f6d1-10f6-4029-8ce0-e65428e5c668'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "It''s a Jungle out There: Queen of the Night"', piece.title_en = 'McQueen: It''s a Jungle out There: Queen of the Night', piece.editor_locked = 1
WHERE piece.id = 20017 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16706 AND linked.composer_id = 280), 'musicbrainz:2aefca14-c721-4b21-b414-e1c7f69ae7db', 16, NULL, 'Tape No. 4: Es war erde in ihnen', 'Tape No. 4: Es war erde in ihnen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aefca14-c721-4b21-b414-e1c7f69ae7db'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Tape No. 4: Es war erde in ihnen"', piece.title_en = 'McQueen: Tape No. 4: Es war erde in ihnen', piece.editor_locked = 1
WHERE piece.id = 16706 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18125 AND linked.composer_id = 280), 'musicbrainz:80e7d073-ed08-45b7-8230-6fa7c7ba4782', 17, NULL, 'Haute Couture: Outside Looking In', 'Haute Couture: Outside Looking In', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80e7d073-ed08-45b7-8230-6fa7c7ba4782'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Haute Couture: Outside Looking In"', piece.title_en = 'McQueen: Haute Couture: Outside Looking In', piece.editor_locked = 1
WHERE piece.id = 18125 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19766 AND linked.composer_id = 280), 'musicbrainz:ec5cf4aa-6f58-4149-98ea-6249e368f60f', 18, NULL, 'Devil Crossing the Door: Lyra da Braccio', 'Devil Crossing the Door: Lyra da Braccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec5cf4aa-6f58-4149-98ea-6249e368f60f'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Devil Crossing the Door: Lyra da Braccio"', piece.title_en = 'McQueen: Devil Crossing the Door: Lyra da Braccio', piece.editor_locked = 1
WHERE piece.id = 19766 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19688 AND linked.composer_id = 280), 'musicbrainz:e6480b72-23f0-4044-b74f-76f7807e380a', 19, NULL, 'Incubus: Flying Machines', 'Incubus: Flying Machines', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6480b72-23f0-4044-b74f-76f7807e380a'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Incubus: Flying Machines"', piece.title_en = 'McQueen: Incubus: Flying Machines', piece.editor_locked = 1
WHERE piece.id = 19688 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18882 AND linked.composer_id = 280), 'musicbrainz:b1422736-05c1-4638-ba54-0716f07d8f1e', 20, NULL, 'No Way Back: The Exchange', 'No Way Back: The Exchange', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1422736-05c1-4638-ba54-0716f07d8f1e'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "No Way Back: The Exchange"', piece.title_en = 'McQueen: No Way Back: The Exchange', piece.editor_locked = 1
WHERE piece.id = 18882 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18546 AND linked.composer_id = 280), 'musicbrainz:9b85a563-fe41-4b64-97c4-86f5a9ecc201', 21, NULL, 'Fairlight: Franklyn', 'Fairlight: Franklyn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b85a563-fe41-4b64-97c4-86f5a9ecc201'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Fairlight: Franklyn"', piece.title_en = 'McQueen: Fairlight: Franklyn', piece.editor_locked = 1
WHERE piece.id = 18546 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16331 AND linked.composer_id = 280), 'musicbrainz:13d5f715-1f8c-49fd-b633-a3d225627325', 22, NULL, 'Tape No. 5: Fish Beach', 'Tape No. 5: Fish Beach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d5f715-1f8c-49fd-b633-a3d225627325'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Tape No. 5: Fish Beach"', piece.title_en = 'McQueen: Tape No. 5: Fish Beach', piece.editor_locked = 1
WHERE piece.id = 16331 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17746 AND linked.composer_id = 280), 'musicbrainz:696dbe3c-12ad-4940-a2fb-beb2897e1321', 23, NULL, 'La Dame Bleue: The Promise', 'La Dame Bleue: The Promise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:696dbe3c-12ad-4940-a2fb-beb2897e1321'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "La Dame Bleue: The Promise"', piece.title_en = 'McQueen: La Dame Bleue: The Promise', piece.editor_locked = 1
WHERE piece.id = 17746 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18604 AND linked.composer_id = 280), 'musicbrainz:9fc0f66d-4722-46af-9b4e-ca89fb93b748', 24, NULL, 'Metamorphosis: All Imperfect Things', 'Metamorphosis: All Imperfect Things', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc0f66d-4722-46af-9b4e-ca89fb93b748'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Metamorphosis: All Imperfect Things"', piece.title_en = 'McQueen: Metamorphosis: All Imperfect Things', piece.editor_locked = 1
WHERE piece.id = 18604 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17980 AND linked.composer_id = 280), 'musicbrainz:77bf5ccd-82be-4e34-9c98-07668de2d11e', 25, NULL, 'Solitude: Trysting Fields / Sheep ''n'' Tides', 'Solitude: Trysting Fields / Sheep ''n'' Tides', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77bf5ccd-82be-4e34-9c98-07668de2d11e'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Solitude: Trysting Fields / Sheep ''n'' Tides"', piece.title_en = 'McQueen: Solitude: Trysting Fields / Sheep ''n'' Tides', piece.editor_locked = 1
WHERE piece.id = 17980 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16579 AND linked.composer_id = 280), 'musicbrainz:22eb936d-202b-49dd-9282-1c2ee8919b21', 26, NULL, 'The Final Collection: Lost and Found', 'The Final Collection: Lost and Found', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22eb936d-202b-49dd-9282-1c2ee8919b21'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "The Final Collection: Lost and Found"', piece.title_en = 'McQueen: The Final Collection: Lost and Found', piece.editor_locked = 1
WHERE piece.id = 16579 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18241 AND linked.composer_id = 280), 'musicbrainz:89a58247-a3cb-4c6a-bf79-32fcda5b70b7', 27, NULL, 'Plato''s Atlantis: The Piano Concerto, The Beach', 'Plato''s Atlantis: The Piano Concerto, The Beach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89a58247-a3cb-4c6a-bf79-32fcda5b70b7'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Plato''s Atlantis: The Piano Concerto, The Beach"', piece.title_en = 'McQueen: Plato''s Atlantis: The Piano Concerto, The Beach', piece.editor_locked = 1
WHERE piece.id = 18241 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19906 AND linked.composer_id = 280), 'musicbrainz:f4e0af3b-f21a-4231-a90a-7dbb23fc3bae', 28, NULL, 'Angels and Daemons: Upon Leaving His Mistress', 'Angels and Daemons: Upon Leaving His Mistress', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4e0af3b-f21a-4231-a90a-7dbb23fc3bae'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Angels and Daemons: Upon Leaving His Mistress"', piece.title_en = 'McQueen: Angels and Daemons: Upon Leaving His Mistress', piece.editor_locked = 1
WHERE piece.id = 19906 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17060 AND linked.composer_id = 280), 'musicbrainz:3ffa0507-0e63-4d5f-8a40-e3a6a643a9fd', 29, NULL, 'Silhouette: Diary of Love', 'Silhouette: Diary of Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ffa0507-0e63-4d5f-8a40-e3a6a643a9fd'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Silhouette: Diary of Love"', piece.title_en = 'McQueen: Silhouette: Diary of Love', piece.editor_locked = 1
WHERE piece.id = 17060 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19016 AND linked.composer_id = 280), 'musicbrainz:ba35ad35-15cd-4d56-9113-3763ba793392', 30, NULL, 'Lee''s Sarabande: Dealing for the Sarabande', 'Lee''s Sarabande: Dealing for the Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'McQueen' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba35ad35-15cd-4d56-9113-3763ba793392'
);

UPDATE pieces piece
SET piece.title = 'McQueen 중 "Lee''s Sarabande: Dealing for the Sarabande"', piece.title_en = 'McQueen: Lee''s Sarabande: Dealing for the Sarabande', piece.editor_locked = 1
WHERE piece.id = 19016 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None Man and Boy: Dada

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Man and Boy: Dada', 'Man and Boy: Dada', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Man and Boy: Dada'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18699 AND linked.composer_id = 280), 'musicbrainz:a5473631-e68b-4292-bd63-620edfd6d1b2', 1, NULL, 'Scene 1: You Need a Ticket to Breathe the Air', 'Scene 1: You Need a Ticket to Breathe the Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5473631-e68b-4292-bd63-620edfd6d1b2'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 1: You Need a Ticket to Breathe the Air"', piece.title_en = 'Man and Boy: Dada: Scene 1: You Need a Ticket to Breathe the Air', piece.editor_locked = 1
WHERE piece.id = 18699 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15992 AND linked.composer_id = 280), 'musicbrainz:0026f048-7dfa-4f22-8acc-1516dca1281a', 2, NULL, 'Scene 2: A Few Things I Collect Beside Bus Tickets', 'Scene 2: A Few Things I Collect Beside Bus Tickets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0026f048-7dfa-4f22-8acc-1516dca1281a'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 2: A Few Things I Collect Beside Bus Tickets"', piece.title_en = 'Man and Boy: Dada: Scene 2: A Few Things I Collect Beside Bus Tickets', piece.editor_locked = 1
WHERE piece.id = 15992 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19387 AND linked.composer_id = 280), 'musicbrainz:d1e8b4a1-19f1-4f7d-b3b4-a6bfab1c6261', 3, NULL, 'Scene 3: Any More Fares Please?', 'Scene 3: Any More Fares Please?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1e8b4a1-19f1-4f7d-b3b4-a6bfab1c6261'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 3: Any More Fares Please?"', piece.title_en = 'Man and Boy: Dada: Scene 3: Any More Fares Please?', piece.editor_locked = 1
WHERE piece.id = 19387 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17633 AND linked.composer_id = 280), 'musicbrainz:62ce14ac-d7bf-4850-81fd-2069ea52fbb1', 4, NULL, 'Scene 4: It''s a Kind of Interesting Rubbish', 'Scene 4: It''s a Kind of Interesting Rubbish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62ce14ac-d7bf-4850-81fd-2069ea52fbb1'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 4: It''s a Kind of Interesting Rubbish"', piece.title_en = 'Man and Boy: Dada: Scene 4: It''s a Kind of Interesting Rubbish', piece.editor_locked = 1
WHERE piece.id = 17633 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18050 AND linked.composer_id = 280), 'musicbrainz:7bde15b8-8804-448c-ba98-09ffe2ee7706', 5, NULL, 'Scene 5: Scarper!', 'Scene 5: Scarper!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bde15b8-8804-448c-ba98-09ffe2ee7706'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 5: Scarper!"', piece.title_en = 'Man and Boy: Dada: Scene 5: Scarper!', piece.editor_locked = 1
WHERE piece.id = 18050 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18523 AND linked.composer_id = 280), 'musicbrainz:9a18efbc-9ddc-4790-ae95-111ae5160adb', 6, NULL, 'Scene 6: Forty Sheep and Twenty Reindeer?', 'Scene 6: Forty Sheep and Twenty Reindeer?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a18efbc-9ddc-4790-ae95-111ae5160adb'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 6: Forty Sheep and Twenty Reindeer?"', piece.title_en = 'Man and Boy: Dada: Scene 6: Forty Sheep and Twenty Reindeer?', piece.editor_locked = 1
WHERE piece.id = 18523 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17233 AND linked.composer_id = 280), 'musicbrainz:4993e24a-11dc-43f7-acea-4c44d8665b17', 7, NULL, 'Scene 7: Coughs and Sneezes Spread Diseases', 'Scene 7: Coughs and Sneezes Spread Diseases', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4993e24a-11dc-43f7-acea-4c44d8665b17'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 7: Coughs and Sneezes Spread Diseases"', piece.title_en = 'Man and Boy: Dada: Scene 7: Coughs and Sneezes Spread Diseases', piece.editor_locked = 1
WHERE piece.id = 17233 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17358 AND linked.composer_id = 280), 'musicbrainz:52c245e7-1d8c-408f-8c0c-3501a4823159', 8, NULL, 'Scene 8: Except Take a Piss', 'Scene 8: Except Take a Piss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52c245e7-1d8c-408f-8c0c-3501a4823159'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 8: Except Take a Piss"', piece.title_en = 'Man and Boy: Dada: Scene 8: Except Take a Piss', piece.editor_locked = 1
WHERE piece.id = 17358 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17679 AND linked.composer_id = 280), 'musicbrainz:65c988b7-a253-4636-b436-d0f54f8adffc', 9, NULL, 'Scene 9: Doodlebug', 'Scene 9: Doodlebug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65c988b7-a253-4636-b436-d0f54f8adffc'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 9: Doodlebug"', piece.title_en = 'Man and Boy: Dada: Scene 9: Doodlebug', piece.editor_locked = 1
WHERE piece.id = 17679 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18340 AND linked.composer_id = 280), 'musicbrainz:8f2a94ee-f8ff-494f-b33e-3b7e9f25db0a', 10, NULL, 'Scene 10: A Famous Cup of British Tea', 'Scene 10: A Famous Cup of British Tea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f2a94ee-f8ff-494f-b33e-3b7e9f25db0a'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 10: A Famous Cup of British Tea"', piece.title_en = 'Man and Boy: Dada: Scene 10: A Famous Cup of British Tea', piece.editor_locked = 1
WHERE piece.id = 18340 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17028 AND linked.composer_id = 280), 'musicbrainz:3daf5aab-7ec9-4107-9f6c-79357b634770', 11, NULL, 'Scene 11: This Was a Good One - Ponders End to Waterloo', 'Scene 11: This Was a Good One - Ponders End to Waterloo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3daf5aab-7ec9-4107-9f6c-79357b634770'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 11: This Was a Good One - Ponders End to Waterloo"', piece.title_en = 'Man and Boy: Dada: Scene 11: This Was a Good One - Ponders End to Waterloo', piece.editor_locked = 1
WHERE piece.id = 17028 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17904 AND linked.composer_id = 280), 'musicbrainz:72a041d1-96a6-4311-acd5-1d34a973c20b', 12, NULL, 'Scene 12: I''m Highly Adept at the Tango', 'Scene 12: I''m Highly Adept at the Tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72a041d1-96a6-4311-acd5-1d34a973c20b'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 12: I''m Highly Adept at the Tango"', piece.title_en = 'Man and Boy: Dada: Scene 12: I''m Highly Adept at the Tango', piece.editor_locked = 1
WHERE piece.id = 17904 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17400 AND linked.composer_id = 280), 'musicbrainz:549830ce-0b28-472c-bb3b-47884e465e6c', 13, NULL, 'Scene 13: Show Me a Bike', 'Scene 13: Show Me a Bike', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:549830ce-0b28-472c-bb3b-47884e465e6c'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 13: Show Me a Bike"', piece.title_en = 'Man and Boy: Dada: Scene 13: Show Me a Bike', piece.editor_locked = 1
WHERE piece.id = 17400 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18082 AND linked.composer_id = 280), 'musicbrainz:7dd87d12-8821-4397-a13d-9ae68fd433f3', 14, NULL, 'Scene 14: Chuk Persh Szing', 'Scene 14: Chuk Persh Szing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dd87d12-8821-4397-a13d-9ae68fd433f3'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 14: Chuk Persh Szing"', piece.title_en = 'Man and Boy: Dada: Scene 14: Chuk Persh Szing', piece.editor_locked = 1
WHERE piece.id = 18082 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17005 AND linked.composer_id = 280), 'musicbrainz:3cb70e64-3146-4d35-8cbb-08a41a015a46', 15, NULL, 'Scene 15: Happy Birthday, Dear Michael', 'Scene 15: Happy Birthday, Dear Michael', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cb70e64-3146-4d35-8cbb-08a41a015a46'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 15: Happy Birthday, Dear Michael"', piece.title_en = 'Man and Boy: Dada: Scene 15: Happy Birthday, Dear Michael', piece.editor_locked = 1
WHERE piece.id = 17005 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19311 AND linked.composer_id = 280), 'musicbrainz:ccc922a7-4f24-4fab-a194-4c0efab0ca96', 16, NULL, 'Scene 16: I Am Having Trouble With Hanky Panky', 'Scene 16: I Am Having Trouble With Hanky Panky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccc922a7-4f24-4fab-a194-4c0efab0ca96'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 16: I Am Having Trouble With Hanky Panky"', piece.title_en = 'Man and Boy: Dada: Scene 16: I Am Having Trouble With Hanky Panky', piece.editor_locked = 1
WHERE piece.id = 19311 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16931 AND linked.composer_id = 280), 'musicbrainz:382671be-7fb7-4713-b138-e66580371884', 17, NULL, 'Scene 17: Latin À La Hammersmith Broadway', 'Scene 17: Latin À La Hammersmith Broadway', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:382671be-7fb7-4713-b138-e66580371884'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 17: Latin À La Hammersmith Broadway"', piece.title_en = 'Man and Boy: Dada: Scene 17: Latin À La Hammersmith Broadway', piece.editor_locked = 1
WHERE piece.id = 16931 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16524 AND linked.composer_id = 280), 'musicbrainz:1f32af45-a1d5-4a8d-bcb5-0dca46be7652', 18, NULL, 'Scene 18: A Hundred Stops but They Have No Names', 'Scene 18: A Hundred Stops but They Have No Names', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f32af45-a1d5-4a8d-bcb5-0dca46be7652'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 18: A Hundred Stops but They Have No Names"', piece.title_en = 'Man and Boy: Dada: Scene 18: A Hundred Stops but They Have No Names', piece.editor_locked = 1
WHERE piece.id = 16524 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16133 AND linked.composer_id = 280), 'musicbrainz:0849ae86-f6ff-48b5-846c-451339ba7a2a', 19, NULL, 'Scene 19: I Was Trying to Explain Something About Dada', 'Scene 19: I Was Trying to Explain Something About Dada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'Man and Boy: Dada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0849ae86-f6ff-48b5-846c-451339ba7a2a'
);

UPDATE pieces piece
SET piece.title = 'Man and Boy: Dada 중 "Scene 19: I Was Trying to Explain Something About Dada"', piece.title_en = 'Man and Boy: Dada: Scene 19: I Was Trying to Explain Something About Dada', piece.editor_locked = 1
WHERE piece.id = 16133 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None War Work

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'War Work', 'War Work', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 280
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'War Work'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19624 AND linked.composer_id = 280), 'musicbrainz:e166a605-0693-441b-9acb-ecd4b37e3812', 1, NULL, 'Song 1: “Urtod”', 'Song 1: “Urtod”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'War Work' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e166a605-0693-441b-9acb-ecd4b37e3812'
);

UPDATE pieces piece
SET piece.title = 'War Work 중 "Song 1: “Urtod”"', piece.title_en = 'War Work: Song 1: “Urtod”', piece.editor_locked = 1
WHERE piece.id = 19624 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18548 AND linked.composer_id = 280), 'musicbrainz:9ba2349f-b7a8-441a-8235-b4d78e1a3c22', 2, NULL, 'Song 2: “What’s Left of the Soldier‐Man?”', 'Song 2: “What’s Left of the Soldier‐Man?”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'War Work' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ba2349f-b7a8-441a-8235-b4d78e1a3c22'
);

UPDATE pieces piece
SET piece.title = 'War Work 중 "Song 2: “What’s Left of the Soldier‐Man?”"', piece.title_en = 'War Work: Song 2: “What’s Left of the Soldier‐Man?”', piece.editor_locked = 1
WHERE piece.id = 18548 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17616 AND linked.composer_id = 280), 'musicbrainz:61a6364e-d5f0-4218-8b04-7300146ddc21', 3, NULL, 'Song 3: “Kinder vor einem Londoner armenspeise Haus”', 'Song 3: “Kinder vor einem Londoner armenspeise Haus”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'War Work' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61a6364e-d5f0-4218-8b04-7300146ddc21'
);

UPDATE pieces piece
SET piece.title = 'War Work 중 "Song 3: “Kinder vor einem Londoner armenspeise Haus”"', piece.title_en = 'War Work: Song 3: “Kinder vor einem Londoner armenspeise Haus”', piece.editor_locked = 1
WHERE piece.id = 17616 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19518 AND linked.composer_id = 280), 'musicbrainz:da94fbaa-2965-4da7-a6e9-7b65a08380bd', 4, NULL, 'Song 4: “Haidekampf”', 'Song 4: “Haidekampf”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'War Work' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da94fbaa-2965-4da7-a6e9-7b65a08380bd'
);

UPDATE pieces piece
SET piece.title = 'War Work 중 "Song 4: “Haidekampf”"', piece.title_en = 'War Work: Song 4: “Haidekampf”', piece.editor_locked = 1
WHERE piece.id = 19518 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19145 AND linked.composer_id = 280), 'musicbrainz:c21ae44a-a55a-41b3-a66c-763808ec42c8', 5, NULL, 'Song 5: “L’Adieu du cavalier / The Cavalier’s Farewell”', 'Song 5: “L’Adieu du cavalier / The Cavalier’s Farewell”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'War Work' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c21ae44a-a55a-41b3-a66c-763808ec42c8'
);

UPDATE pieces piece
SET piece.title = 'War Work 중 "Song 5: “L’Adieu du cavalier / The Cavalier’s Farewell”"', piece.title_en = 'War Work: Song 5: “L’Adieu du cavalier / The Cavalier’s Farewell”', piece.editor_locked = 1
WHERE piece.id = 19145 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18810 AND linked.composer_id = 280), 'musicbrainz:ac32d09c-18ee-4d77-9c77-3e956e0f4e9e', 6, NULL, 'Song 6: “For Just One Night”', 'Song 6: “For Just One Night”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'War Work' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac32d09c-18ee-4d77-9c77-3e956e0f4e9e'
);

UPDATE pieces piece
SET piece.title = 'War Work 중 "Song 6: “For Just One Night”"', piece.title_en = 'War Work: Song 6: “For Just One Night”', piece.editor_locked = 1
WHERE piece.id = 18810 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17634 AND linked.composer_id = 280), 'musicbrainz:62f8ccd8-7ef9-4930-9f38-e63a42ab64c9', 7, NULL, 'Song 7: “Louse Hunting”', 'Song 7: “Louse Hunting”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'War Work' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62f8ccd8-7ef9-4930-9f38-e63a42ab64c9'
);

UPDATE pieces piece
SET piece.title = 'War Work 중 "Song 7: “Louse Hunting”"', piece.title_en = 'War Work: Song 7: “Louse Hunting”', piece.editor_locked = 1
WHERE piece.id = 17634 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17993 AND linked.composer_id = 280), 'musicbrainz:789e03e4-5917-47d9-95c3-1c73dd97810d', 8, NULL, 'Song 8: “Abschied”', 'Song 8: “Abschied”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 280 AND p.title = 'War Work' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:789e03e4-5917-47d9-95c3-1c73dd97810d'
);

UPDATE pieces piece
SET piece.title = 'War Work 중 "Song 8: “Abschied”"', piece.title_en = 'War Work: Song 8: “Abschied”', piece.editor_locked = 1
WHERE piece.id = 17993 AND piece.composer_id = 280
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'concerto', piece.form_key = 'concertante'
WHERE piece.composer_id = 280 AND piece.title = '트롬본과 관현악을 위한 협주곡' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'concerto', piece.form_key = 'other_concerto'
WHERE piece.composer_id = 280 AND piece.title = '색소폰, 첼로, 관현악을 위한 이중 협주곡' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 크리스티안 신딩 (composer_id 283) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 2

-- Op. 99 옛 양식의 소나타 Op. 99

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '옛 양식의 소나타 Op. 99', 'Sonate Im Alten Stil, Op. 99', 'album', NULL, 'Op.', '99', NULL, 'manual', 1
FROM composers c
WHERE c.id = 283
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '옛 양식의 소나타 Op. 99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17458 AND linked.composer_id = 283), 'musicbrainz:57fd4a9a-acc9-477a-9098-b3dbce14c4fd', 1, 'I', 'Marcato', 'Marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 283 AND p.title = '옛 양식의 소나타 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57fd4a9a-acc9-477a-9098-b3dbce14c4fd'
);

UPDATE pieces piece
SET piece.title = '옛 양식의 소나타 Op. 99 중 "Marcato"', piece.title_en = 'Sonate Im Alten Stil, Op. 99: Marcato', piece.editor_locked = 1
WHERE piece.id = 17458 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19992 AND linked.composer_id = 283), 'musicbrainz:f8e15d0d-7a14-4283-b18b-3ec99cab6d99', 2, 'II', 'Andante Doloroso', 'Andante Doloroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 283 AND p.title = '옛 양식의 소나타 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8e15d0d-7a14-4283-b18b-3ec99cab6d99'
);

UPDATE pieces piece
SET piece.title = '옛 양식의 소나타 Op. 99 중 "Andante Doloroso"', piece.title_en = 'Sonate Im Alten Stil, Op. 99: Andante Doloroso', piece.editor_locked = 1
WHERE piece.id = 19992 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18142 AND linked.composer_id = 283), 'musicbrainz:8221f237-3e4b-4667-b871-92692a5ce87c', 3, 'III', 'Menuetto', 'Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 283 AND p.title = '옛 양식의 소나타 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8221f237-3e4b-4667-b871-92692a5ce87c'
);

UPDATE pieces piece
SET piece.title = '옛 양식의 소나타 Op. 99 중 "Menuetto"', piece.title_en = 'Sonate Im Alten Stil, Op. 99: Menuetto', piece.editor_locked = 1
WHERE piece.id = 18142 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19661 AND linked.composer_id = 283), 'musicbrainz:e3baa2be-ca72-4c15-8e7d-59e825ad685c', 4, 'IV', 'Allegretto', 'Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 283 AND p.title = '옛 양식의 소나타 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3baa2be-ca72-4c15-8e7d-59e825ad685c'
);

UPDATE pieces piece
SET piece.title = '옛 양식의 소나타 Op. 99 중 "Allegretto"', piece.title_en = 'Sonate Im Alten Stil, Op. 99: Allegretto', piece.editor_locked = 1
WHERE piece.id = 19661 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19762 AND linked.composer_id = 283), 'musicbrainz:ec2655e8-7c22-401f-b870-24c0cf6c7afa', 5, 'V', 'Un Poco Maestoso', 'Un Poco Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 283 AND p.title = '옛 양식의 소나타 Op. 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec2655e8-7c22-401f-b870-24c0cf6c7afa'
);

UPDATE pieces piece
SET piece.title = '옛 양식의 소나타 Op. 99 중 "Un Poco Maestoso"', piece.title_en = 'Sonate Im Alten Stil, Op. 99: Un Poco Maestoso', piece.editor_locked = 1
WHERE piece.id = 19762 AND piece.composer_id = 283
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 보이치에흐 킬라르 (composer_id 290) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 1

-- None Dracula Toolbox

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Dracula Toolbox', 'Dracula Toolbox', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Dracula Toolbox'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17664 AND linked.composer_id = 290), 'musicbrainz:64c37425-b215-434f-a5cc-e9cd4b9b8e39', 1, NULL, 'Lucy’s Lullaby', 'Lucy’s Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Dracula Toolbox' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64c37425-b215-434f-a5cc-e9cd4b9b8e39'
);

UPDATE pieces piece
SET piece.title = 'Dracula Toolbox 중 "Lucy’s Lullaby"', piece.title_en = 'Dracula Toolbox: Lucy’s Lullaby', piece.editor_locked = 1
WHERE piece.id = 17664 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16189 AND linked.composer_id = 290), 'musicbrainz:0be5e299-e0fb-4646-b327-0414f852c841', 2, NULL, 'Tears to Diamonds', 'Tears to Diamonds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Dracula Toolbox' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0be5e299-e0fb-4646-b327-0414f852c841'
);

UPDATE pieces piece
SET piece.title = 'Dracula Toolbox 중 "Tears to Diamonds"', piece.title_en = 'Dracula Toolbox: Tears to Diamonds', piece.editor_locked = 1
WHERE piece.id = 16189 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 니코 멀리 (composer_id 293) =====
-- 잇기 0, 새 묶음 3(이름) + 1(음반), 숨김 0, 그대로 1

-- None Drones & Piano

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Drones & Piano', 'Drones & Piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Drones & Piano'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18765 AND linked.composer_id = 293), 'musicbrainz:a9a14110-343b-4ebd-b369-931dab6f3264', 1, 'I', '1악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a14110-343b-4ebd-b369-931dab6f3264'
);

UPDATE pieces piece
SET piece.title = 'Drones & Piano 중 "1악장"', piece.title_en = 'Drones & Piano: 1악장', piece.editor_locked = 1
WHERE piece.id = 18765 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18336 AND linked.composer_id = 293), 'musicbrainz:8eeeb531-0a60-41c1-ad60-079594ea1435', 2, 'II', '2악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eeeb531-0a60-41c1-ad60-079594ea1435'
);

UPDATE pieces piece
SET piece.title = 'Drones & Piano 중 "2악장"', piece.title_en = 'Drones & Piano: 2악장', piece.editor_locked = 1
WHERE piece.id = 18336 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16571 AND linked.composer_id = 293), 'musicbrainz:2240c934-66c4-4e6b-a97d-18fcae1b0e49', 3, 'III', 'The 8th Tune', 'The 8th Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2240c934-66c4-4e6b-a97d-18fcae1b0e49'
);

UPDATE pieces piece
SET piece.title = 'Drones & Piano 중 "The 8th Tune"', piece.title_en = 'Drones & Piano: The 8th Tune', piece.editor_locked = 1
WHERE piece.id = 16571 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16696 AND linked.composer_id = 293), 'musicbrainz:2a3e51d4-1e08-45ee-8cad-c868ebe847a8', 4, 'IV', '4악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a3e51d4-1e08-45ee-8cad-c868ebe847a8'
);

UPDATE pieces piece
SET piece.title = 'Drones & Piano 중 "4악장"', piece.title_en = 'Drones & Piano: 4악장', piece.editor_locked = 1
WHERE piece.id = 16696 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19676 AND linked.composer_id = 293), 'musicbrainz:e5ad55a8-be20-4968-8016-039122b67f32', 5, 'V', '5악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5ad55a8-be20-4968-8016-039122b67f32'
);

UPDATE pieces piece
SET piece.title = 'Drones & Piano 중 "5악장"', piece.title_en = 'Drones & Piano: 5악장', piece.editor_locked = 1
WHERE piece.id = 19676 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None Drones & Viola

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Drones & Viola', 'Drones & Viola', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Drones & Viola'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18507 AND linked.composer_id = 293), 'musicbrainz:98dc6166-002d-4f91-bd85-0b05dc276a37', 1, 'I', 'Material in D', 'Material in D', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Viola' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98dc6166-002d-4f91-bd85-0b05dc276a37'
);

UPDATE pieces piece
SET piece.title = 'Drones & Viola 중 "Material in D"', piece.title_en = 'Drones & Viola: Material in D', piece.editor_locked = 1
WHERE piece.id = 18507 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17346 AND linked.composer_id = 293), 'musicbrainz:51c7880c-9684-416f-bfc1-b4df94155d76', 2, 'II', 'Material in a Handsome Stack', 'Material in a Handsome Stack', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Viola' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51c7880c-9684-416f-bfc1-b4df94155d76'
);

UPDATE pieces piece
SET piece.title = 'Drones & Viola 중 "Material in a Handsome Stack"', piece.title_en = 'Drones & Viola: Material in a Handsome Stack', piece.editor_locked = 1
WHERE piece.id = 17346 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18543 AND linked.composer_id = 293), 'musicbrainz:9b5eba0a-25b2-4943-937a-8300a33ebece', 3, 'III', 'Material with no Tricks', 'Material with no Tricks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Viola' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b5eba0a-25b2-4943-937a-8300a33ebece'
);

UPDATE pieces piece
SET piece.title = 'Drones & Viola 중 "Material with no Tricks"', piece.title_en = 'Drones & Viola: Material with no Tricks', piece.editor_locked = 1
WHERE piece.id = 18543 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16811 AND linked.composer_id = 293), 'musicbrainz:31904f00-d3f5-4926-89a0-f64565ca6f9c', 4, 'IV', 'Material in a Long Cadence', 'Material in a Long Cadence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Viola' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31904f00-d3f5-4926-89a0-f64565ca6f9c'
);

UPDATE pieces piece
SET piece.title = 'Drones & Viola 중 "Material in a Long Cadence"', piece.title_en = 'Drones & Viola: Material in a Long Cadence', piece.editor_locked = 1
WHERE piece.id = 16811 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None Drones & Violin

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Drones & Violin', 'Drones & Violin', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Drones & Violin'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16339 AND linked.composer_id = 293), 'musicbrainz:14299b4c-67cd-4393-bddf-42978bdb0eb7', 1, 'I', 'Material in Eb', 'Material in Eb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Violin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14299b4c-67cd-4393-bddf-42978bdb0eb7'
);

UPDATE pieces piece
SET piece.title = 'Drones & Violin 중 "Material in Eb"', piece.title_en = 'Drones & Violin: Material in Eb', piece.editor_locked = 1
WHERE piece.id = 16339 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18106 AND linked.composer_id = 293), 'musicbrainz:7f635161-7434-4f7d-b768-ee43d20cfdff', 2, 'II', 'Material in Sevenths', 'Material in Sevenths', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Violin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f635161-7434-4f7d-b768-ee43d20cfdff'
);

UPDATE pieces piece
SET piece.title = 'Drones & Violin 중 "Material in Sevenths"', piece.title_en = 'Drones & Violin: Material in Sevenths', piece.editor_locked = 1
WHERE piece.id = 18106 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18790 AND linked.composer_id = 293), 'musicbrainz:aacfa908-f7ea-4985-9d0b-6fb199be2eb6', 3, 'III', 'Material in Two Keys', 'Material in Two Keys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Violin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aacfa908-f7ea-4985-9d0b-6fb199be2eb6'
);

UPDATE pieces piece
SET piece.title = 'Drones & Violin 중 "Material in Two Keys"', piece.title_en = 'Drones & Violin: Material in Two Keys', piece.editor_locked = 1
WHERE piece.id = 18790 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17184 AND linked.composer_id = 293), 'musicbrainz:46fc5e80-b8c4-42c2-8a3c-f58258b492f9', 4, 'IV', 'Material with Shifting Drones', 'Material with Shifting Drones', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Drones & Violin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46fc5e80-b8c4-42c2-8a3c-f58258b492f9'
);

UPDATE pieces piece
SET piece.title = 'Drones & Violin 중 "Material with Shifting Drones"', piece.title_en = 'Drones & Violin: Material with Shifting Drones', piece.editor_locked = 1
WHERE piece.id = 17184 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None Two Boys

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Two Boys', 'Two Boys', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Two Boys'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19453 AND linked.composer_id = 293), 'musicbrainz:d5e1ca25-8d00-4f98-9c99-13f5b344f886', 1, NULL, 'Prologue & Scene 1 (Alley/Police Station): "Help! Help! My friend has been stabbed!"', 'Prologue & Scene 1 (Alley/Police Station): "Help! Help! My friend has been stabbed!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5e1ca25-8d00-4f98-9c99-13f5b344f886'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Prologue & Scene 1 (Alley/Police Station): "Help! Help! My friend has been stabbed!""', piece.title_en = 'Two Boys: Prologue & Scene 1 (Alley/Police Station): "Help! Help! My friend has been stabbed!"', piece.editor_locked = 1
WHERE piece.id = 19453 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19859 AND linked.composer_id = 293), 'musicbrainz:f21def1f-5adb-4587-90e9-8f5446c8a3de', 2, NULL, 'Scene 2 (Hospital): "You understand your son had no pulse…"', 'Scene 2 (Hospital): "You understand your son had no pulse…"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21def1f-5adb-4587-90e9-8f5446c8a3de'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 2 (Hospital): "You understand your son had no pulse…""', piece.title_en = 'Two Boys: Scene 2 (Hospital): "You understand your son had no pulse…"', piece.editor_locked = 1
WHERE piece.id = 19859 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16397 AND linked.composer_id = 293), 'musicbrainz:16ff1a0f-0560-4c2d-8f04-7d5284615aa2', 3, NULL, 'Scene 3 (Police Station): "Brian? I''m detective Sargeant Strawson"', 'Scene 3 (Police Station): "Brian? I''m detective Sargeant Strawson"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16ff1a0f-0560-4c2d-8f04-7d5284615aa2'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 3 (Police Station): "Brian? I''m detective Sargeant Strawson""', piece.title_en = 'Two Boys: Scene 3 (Police Station): "Brian? I''m detective Sargeant Strawson"', piece.editor_locked = 1
WHERE piece.id = 16397 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18857 AND linked.composer_id = 293), 'musicbrainz:af5a7479-8594-4fc0-bdd4-b67fb7c1f231', 4, NULL, 'Scene 4 (Brian''s Bedroom): Chorus: "U there? / Who is this?"', 'Scene 4 (Brian''s Bedroom): Chorus: "U there? / Who is this?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af5a7479-8594-4fc0-bdd4-b67fb7c1f231'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 4 (Brian''s Bedroom): Chorus: "U there? / Who is this?""', piece.title_en = 'Two Boys: Scene 4 (Brian''s Bedroom): Chorus: "U there? / Who is this?"', piece.editor_locked = 1
WHERE piece.id = 18857 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17026 AND linked.composer_id = 293), 'musicbrainz:3d99b7e7-26c5-44b9-bad6-e7f2a5d34775', 5, NULL, 'Scene 5 (Police Station): I''m not! / Brian. There are witnesses', 'Scene 5 (Police Station): I''m not! / Brian. There are witnesses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d99b7e7-26c5-44b9-bad6-e7f2a5d34775'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 5 (Police Station): I''m not! / Brian. There are witnesses"', piece.title_en = 'Two Boys: Scene 5 (Police Station): I''m not! / Brian. There are witnesses', piece.editor_locked = 1
WHERE piece.id = 17026 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17002 AND linked.composer_id = 293), 'musicbrainz:3c98b587-d979-4bca-bffd-27a2c40b139c', 6, NULL, 'Scene 6 (Brian''s Bedroom): "Brian?... Church in ten minutes…" Chorus: "How are u?"', 'Scene 6 (Brian''s Bedroom): "Brian?... Church in ten minutes…" Chorus: "How are u?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c98b587-d979-4bca-bffd-27a2c40b139c'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 6 (Brian''s Bedroom): "Brian?... Church in ten minutes…" Chorus: "How are u?""', piece.title_en = 'Two Boys: Scene 6 (Brian''s Bedroom): "Brian?... Church in ten minutes…" Chorus: "How are u?"', piece.editor_locked = 1
WHERE piece.id = 17002 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18816 AND linked.composer_id = 293), 'musicbrainz:acd7dc4c-90d8-45d1-9932-a9fc432b728c', 7, NULL, 'Scene 7 (Church): "Amen… O Lord, open thou our lips"', 'Scene 7 (Church): "Amen… O Lord, open thou our lips"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acd7dc4c-90d8-45d1-9932-a9fc432b728c'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 7 (Church): "Amen… O Lord, open thou our lips""', piece.title_en = 'Two Boys: Scene 7 (Church): "Amen… O Lord, open thou our lips"', piece.editor_locked = 1
WHERE piece.id = 18816 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18795 AND linked.composer_id = 293), 'musicbrainz:ab226d06-07a9-4348-a81a-8a654c238437', 8, NULL, 'Scene 8 (Brian''s House): Has Brian been in trouble before?', 'Scene 8 (Brian''s House): Has Brian been in trouble before?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab226d06-07a9-4348-a81a-8a654c238437'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 8 (Brian''s House): Has Brian been in trouble before?"', piece.title_en = 'Two Boys: Scene 8 (Brian''s House): Has Brian been in trouble before?', piece.editor_locked = 1
WHERE piece.id = 18795 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16433 AND linked.composer_id = 293), 'musicbrainz:1974803b-40b1-4f83-b97a-c62b76d6e12e', 9, NULL, 'Scene 9 (Police Station): "Copy of the security tape from the shopping centre"', 'Scene 9 (Police Station): "Copy of the security tape from the shopping centre"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1974803b-40b1-4f83-b97a-c62b76d6e12e'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 9 (Police Station): "Copy of the security tape from the shopping centre""', piece.title_en = 'Two Boys: Scene 9 (Police Station): "Copy of the security tape from the shopping centre"', piece.editor_locked = 1
WHERE piece.id = 16433 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19899 AND linked.composer_id = 293), 'musicbrainz:f455d3e6-42c7-49e3-9643-3f44e113da91', 10, NULL, 'Scene 10 (Anne''s Flat): "You should see this boy they''ve stuck me with"', 'Scene 10 (Anne''s Flat): "You should see this boy they''ve stuck me with"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f455d3e6-42c7-49e3-9643-3f44e113da91'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 10 (Anne''s Flat): "You should see this boy they''ve stuck me with""', piece.title_en = 'Two Boys: Scene 10 (Anne''s Flat): "You should see this boy they''ve stuck me with"', piece.editor_locked = 1
WHERE piece.id = 19899 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17177 AND linked.composer_id = 293), 'musicbrainz:466e58d6-ed02-442a-bada-1df563a4df8b', 11, NULL, 'Scene 11 (Police Station): "No one else goes in or out… You stabbed him"', 'Scene 11 (Police Station): "No one else goes in or out… You stabbed him"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:466e58d6-ed02-442a-bada-1df563a4df8b'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 11 (Police Station): "No one else goes in or out… You stabbed him""', piece.title_en = 'Two Boys: Scene 11 (Police Station): "No one else goes in or out… You stabbed him"', piece.editor_locked = 1
WHERE piece.id = 17177 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16558 AND linked.composer_id = 293), 'musicbrainz:2167be76-3e6f-4502-8e35-c3eb8bcb556c', 12, NULL, 'Scene 12 (Brian''s Bedroom): "Brian…You don''t know me… Chorus: Can''t stop talking"', 'Scene 12 (Brian''s Bedroom): "Brian…You don''t know me… Chorus: Can''t stop talking"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2167be76-3e6f-4502-8e35-c3eb8bcb556c'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 12 (Brian''s Bedroom): "Brian…You don''t know me… Chorus: Can''t stop talking""', piece.title_en = 'Two Boys: Scene 12 (Brian''s Bedroom): "Brian…You don''t know me… Chorus: Can''t stop talking"', piece.editor_locked = 1
WHERE piece.id = 16558 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18334 AND linked.composer_id = 293), 'musicbrainz:8ec848f8-f233-415f-a733-727bf7d26c61', 13, NULL, 'Scene 13 (Hallway): "That''s for damn sure"', 'Scene 13 (Hallway): "That''s for damn sure"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ec848f8-f233-415f-a733-727bf7d26c61'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 13 (Hallway): "That''s for damn sure""', piece.title_en = 'Two Boys: Scene 13 (Hallway): "That''s for damn sure"', piece.editor_locked = 1
WHERE piece.id = 18334 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19601 AND linked.composer_id = 293), 'musicbrainz:e077576d-4d49-4b00-a64f-7d14a44d11dc', 14, NULL, 'Scene 14 (Interview Room/Brian''s Room): "You searched for Rebecca…"', 'Scene 14 (Interview Room/Brian''s Room): "You searched for Rebecca…"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e077576d-4d49-4b00-a64f-7d14a44d11dc'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 14 (Interview Room/Brian''s Room): "You searched for Rebecca…""', piece.title_en = 'Two Boys: Scene 14 (Interview Room/Brian''s Room): "You searched for Rebecca…"', piece.editor_locked = 1
WHERE piece.id = 19601 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18638 AND linked.composer_id = 293), 'musicbrainz:a19e5cef-7ad2-4aeb-8a3d-5d9641271b9f', 15, NULL, 'Scene 15 (Hospital): "Mrs. Wilson? / I know he hears us"', 'Scene 15 (Hospital): "Mrs. Wilson? / I know he hears us"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a19e5cef-7ad2-4aeb-8a3d-5d9641271b9f'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 15 (Hospital): "Mrs. Wilson? / I know he hears us""', piece.title_en = 'Two Boys: Scene 15 (Hospital): "Mrs. Wilson? / I know he hears us"', piece.editor_locked = 1
WHERE piece.id = 18638 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18318 AND linked.composer_id = 293), 'musicbrainz:8df6e30f-4d3b-4e9a-b4a7-4cd581163c23', 16, NULL, 'Scene 16 (Police Station): "The transcripts from the server"', 'Scene 16 (Police Station): "The transcripts from the server"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8df6e30f-4d3b-4e9a-b4a7-4cd581163c23'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 16 (Police Station): "The transcripts from the server""', piece.title_en = 'Two Boys: Scene 16 (Police Station): "The transcripts from the server"', piece.editor_locked = 1
WHERE piece.id = 18318 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16371 AND linked.composer_id = 293), 'musicbrainz:15f4ae2f-5662-4bdf-bbc3-94eb31f5785a', 17, NULL, 'Scene 1 (Police Station): "Even senseless crimes make sense"', 'Scene 1 (Police Station): "Even senseless crimes make sense"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15f4ae2f-5662-4bdf-bbc3-94eb31f5785a'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 1 (Police Station): "Even senseless crimes make sense""', piece.title_en = 'Two Boys: Scene 1 (Police Station): "Even senseless crimes make sense"', piece.editor_locked = 1
WHERE piece.id = 16371 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16763 AND linked.composer_id = 293), 'musicbrainz:2e6a46a2-087a-4192-8352-1cae970a0b3b', 18, NULL, 'Scene 2 (Police Station): "Told you. You think I''m smart enough…" Chorus: [Grocery items]', 'Scene 2 (Police Station): "Told you. You think I''m smart enough…" Chorus: [Grocery items]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e6a46a2-087a-4192-8352-1cae970a0b3b'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 2 (Police Station): "Told you. You think I''m smart enough…" Chorus: [Grocery items]"', piece.title_en = 'Two Boys: Scene 2 (Police Station): "Told you. You think I''m smart enough…" Chorus: [Grocery items]', piece.editor_locked = 1
WHERE piece.id = 16763 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16206 AND linked.composer_id = 293), 'musicbrainz:0ce0077d-0111-4163-94e7-e014ef0be074', 19, NULL, 'Scene 3 (Brian''s Bedroom): "It had to be done… I''m sure you understand"', 'Scene 3 (Brian''s Bedroom): "It had to be done… I''m sure you understand"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ce0077d-0111-4163-94e7-e014ef0be074'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 3 (Brian''s Bedroom): "It had to be done… I''m sure you understand""', piece.title_en = 'Two Boys: Scene 3 (Brian''s Bedroom): "It had to be done… I''m sure you understand"', piece.editor_locked = 1
WHERE piece.id = 16206 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19003 AND linked.composer_id = 293), 'musicbrainz:b8d5626d-c2a7-429d-811f-4c9b7190c426', 20, NULL, 'Chorus: "I saw u in algebra…"', 'Chorus: "I saw u in algebra…"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d5626d-c2a7-429d-811f-4c9b7190c426'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Chorus: "I saw u in algebra…""', piece.title_en = 'Two Boys: Chorus: "I saw u in algebra…"', piece.editor_locked = 1
WHERE piece.id = 19003 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19404 AND linked.composer_id = 293), 'musicbrainz:d2ac2e34-08d2-496d-8649-8c8cac9f8980', 21, NULL, 'Scene 4 (Police Station): "Did you have sex?"', 'Scene 4 (Police Station): "Did you have sex?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2ac2e34-08d2-496d-8649-8c8cac9f8980'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 4 (Police Station): "Did you have sex?""', piece.title_en = 'Two Boys: Scene 4 (Police Station): "Did you have sex?"', piece.editor_locked = 1
WHERE piece.id = 19404 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16019 AND linked.composer_id = 293), 'musicbrainz:01ee6a5d-6356-4a36-acb3-23ba0c4e83a8', 22, NULL, 'Scene 5 (Brian''s Bedroom): "Brian… I have a proposition"', 'Scene 5 (Brian''s Bedroom): "Brian… I have a proposition"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01ee6a5d-6356-4a36-acb3-23ba0c4e83a8'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 5 (Brian''s Bedroom): "Brian… I have a proposition""', piece.title_en = 'Two Boys: Scene 5 (Brian''s Bedroom): "Brian… I have a proposition"', piece.editor_locked = 1
WHERE piece.id = 16019 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18203 AND linked.composer_id = 293), 'musicbrainz:86d26880-3c35-4151-bc18-244c82243023', 23, NULL, 'Scene 6 (Police Station): "You refused / He was my friend!"', 'Scene 6 (Police Station): "You refused / He was my friend!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86d26880-3c35-4151-bc18-244c82243023'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 6 (Police Station): "You refused / He was my friend!""', piece.title_en = 'Two Boys: Scene 6 (Police Station): "You refused / He was my friend!"', piece.editor_locked = 1
WHERE piece.id = 18203 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18525 AND linked.composer_id = 293), 'musicbrainz:9a2ec6b6-06ae-40b8-a902-05cf61fb09c3', 24, NULL, 'Scene 7 (Anne''s Flat) & Scene 8 (Police Station): "Mother!... Are you all right?"', 'Scene 7 (Anne''s Flat) & Scene 8 (Police Station): "Mother!... Are you all right?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a2ec6b6-06ae-40b8-a902-05cf61fb09c3'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 7 (Anne''s Flat) & Scene 8 (Police Station): "Mother!... Are you all right?""', piece.title_en = 'Two Boys: Scene 7 (Anne''s Flat) & Scene 8 (Police Station): "Mother!... Are you all right?"', piece.editor_locked = 1
WHERE piece.id = 18525 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18109 AND linked.composer_id = 293), 'musicbrainz:7f73757a-6081-4d29-a08c-8ce3cbf3619c', 25, NULL, 'Scene 9 (Brian''s Bedroom): "What''s up? / U updated your photo"', 'Scene 9 (Brian''s Bedroom): "What''s up? / U updated your photo"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f73757a-6081-4d29-a08c-8ce3cbf3619c'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 9 (Brian''s Bedroom): "What''s up? / U updated your photo""', piece.title_en = 'Two Boys: Scene 9 (Brian''s Bedroom): "What''s up? / U updated your photo"', piece.editor_locked = 1
WHERE piece.id = 18109 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19764 AND linked.composer_id = 293), 'musicbrainz:ec4a2996-7d27-431e-a0ea-4a9a667a32d4', 26, NULL, 'Scene 10 (Police Station): "You taking the piss? / Maybe not"', 'Scene 10 (Police Station): "You taking the piss? / Maybe not"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec4a2996-7d27-431e-a0ea-4a9a667a32d4'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 10 (Police Station): "You taking the piss? / Maybe not""', piece.title_en = 'Two Boys: Scene 10 (Police Station): "You taking the piss? / Maybe not"', piece.editor_locked = 1
WHERE piece.id = 19764 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18872 AND linked.composer_id = 293), 'musicbrainz:b0be83f6-c058-478f-bf65-224bf8d8641a', 27, NULL, 'Scene 11 (Brian''s Bedroom): "If I''m not at the doctor"', 'Scene 11 (Brian''s Bedroom): "If I''m not at the doctor"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0be83f6-c058-478f-bf65-224bf8d8641a'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 11 (Brian''s Bedroom): "If I''m not at the doctor""', piece.title_en = 'Two Boys: Scene 11 (Brian''s Bedroom): "If I''m not at the doctor"', piece.editor_locked = 1
WHERE piece.id = 18872 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16220 AND linked.composer_id = 293), 'musicbrainz:0d8c21ca-bc7b-4e29-9bd0-ebf54f23576d', 28, NULL, 'Scene 12 (Alley): "Do what I say / Okay"', 'Scene 12 (Alley): "Do what I say / Okay"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d8c21ca-bc7b-4e29-9bd0-ebf54f23576d'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 12 (Alley): "Do what I say / Okay""', piece.title_en = 'Two Boys: Scene 12 (Alley): "Do what I say / Okay"', piece.editor_locked = 1
WHERE piece.id = 16220 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17650 AND linked.composer_id = 293), 'musicbrainz:63bd3b5a-b7ac-4114-bf0c-f0d3d43d0850', 29, NULL, 'Scene 13 (Police Station): "Thank you, Brian. Do you understand what''s happened to you?"', 'Scene 13 (Police Station): "Thank you, Brian. Do you understand what''s happened to you?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63bd3b5a-b7ac-4114-bf0c-f0d3d43d0850'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 13 (Police Station): "Thank you, Brian. Do you understand what''s happened to you?""', piece.title_en = 'Two Boys: Scene 13 (Police Station): "Thank you, Brian. Do you understand what''s happened to you?"', piece.editor_locked = 1
WHERE piece.id = 17650 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16587 AND linked.composer_id = 293), 'musicbrainz:23335eae-57e9-4356-b4c8-17347cab9aab', 30, NULL, 'Scene 14 (Hospital): "Detective, this is my daughter, Rebecca…" Chorus: "Kill urself"', 'Scene 14 (Hospital): "Detective, this is my daughter, Rebecca…" Chorus: "Kill urself"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Two Boys' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23335eae-57e9-4356-b4c8-17347cab9aab'
);

UPDATE pieces piece
SET piece.title = 'Two Boys 중 "Scene 14 (Hospital): "Detective, this is my daughter, Rebecca…" Chorus: "Kill urself""', piece.title_en = 'Two Boys: Scene 14 (Hospital): "Detective, this is my daughter, Rebecca…" Chorus: "Kill urself"', piece.editor_locked = 1
WHERE piece.id = 16587 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'piano', piece.form_key = 'piano_other'
WHERE piece.composer_id = 293 AND piece.title = 'Drones & Piano' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 나지 하킴 (composer_id 296) =====
-- 잇기 0, 새 묶음 3(이름) + 0(음반), 숨김 0, 그대로 1

-- None Jonquilles

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Jonquilles', 'Jonquilles', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Jonquilles'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18530 AND linked.composer_id = 296), 'musicbrainz:9a6be11d-8227-42a8-97c2-704083d50c18', 1, NULL, 'Moderato', 'Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Jonquilles' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a6be11d-8227-42a8-97c2-704083d50c18'
);

UPDATE pieces piece
SET piece.title = 'Jonquilles 중 "Moderato"', piece.title_en = 'Jonquilles: Moderato', piece.editor_locked = 1
WHERE piece.id = 18530 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16942 AND linked.composer_id = 296), 'musicbrainz:388d3ebc-91cb-49fb-ab6d-ad27be137e89', 2, NULL, 'Allegro Vivace', 'Allegro Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Jonquilles' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:388d3ebc-91cb-49fb-ab6d-ad27be137e89'
);

UPDATE pieces piece
SET piece.title = 'Jonquilles 중 "Allegro Vivace"', piece.title_en = 'Jonquilles: Allegro Vivace', piece.editor_locked = 1
WHERE piece.id = 16942 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17969 AND linked.composer_id = 296), 'musicbrainz:772e7516-bd8b-4672-865f-da1879edbaff', 3, NULL, 'Maestoso', 'Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Jonquilles' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:772e7516-bd8b-4672-865f-da1879edbaff'
);

UPDATE pieces piece
SET piece.title = 'Jonquilles 중 "Maestoso"', piece.title_en = 'Jonquilles: Maestoso', piece.editor_locked = 1
WHERE piece.id = 17969 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None Mit Seinem Geist

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mit Seinem Geist', 'Mit Seinem Geist', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mit Seinem Geist'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18892 AND linked.composer_id = 296), 'musicbrainz:b1d02fbc-489e-44b5-b80f-62aeb01a62ac', 1, 'I', 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Mit Seinem Geist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1d02fbc-489e-44b5-b80f-62aeb01a62ac'
);

UPDATE pieces piece
SET piece.title = 'Mit Seinem Geist 중 "Allegro"', piece.title_en = 'Mit Seinem Geist: Allegro', piece.editor_locked = 1
WHERE piece.id = 18892 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18839 AND linked.composer_id = 296), 'musicbrainz:ae007e39-4852-45f1-981d-aa4d49c85c2e', 2, 'II', 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Mit Seinem Geist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae007e39-4852-45f1-981d-aa4d49c85c2e'
);

UPDATE pieces piece
SET piece.title = 'Mit Seinem Geist 중 "Andante"', piece.title_en = 'Mit Seinem Geist: Andante', piece.editor_locked = 1
WHERE piece.id = 18839 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18265 AND linked.composer_id = 296), 'musicbrainz:8b20306c-4011-4054-b0c0-13a52c19b725', 3, 'III', 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Mit Seinem Geist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b20306c-4011-4054-b0c0-13a52c19b725'
);

UPDATE pieces piece
SET piece.title = 'Mit Seinem Geist 중 "Andante"', piece.title_en = 'Mit Seinem Geist: Andante', piece.editor_locked = 1
WHERE piece.id = 18265 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16712 AND linked.composer_id = 296), 'musicbrainz:2b510179-203a-4431-ab74-1a01965fd32e', 4, 'IV', 'Grazioso', 'Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Mit Seinem Geist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b510179-203a-4431-ab74-1a01965fd32e'
);

UPDATE pieces piece
SET piece.title = 'Mit Seinem Geist 중 "Grazioso"', piece.title_en = 'Mit Seinem Geist: Grazioso', piece.editor_locked = 1
WHERE piece.id = 16712 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18603 AND linked.composer_id = 296), 'musicbrainz:9faf8479-ffd0-43b7-bc5c-df828a7743b9', 5, 'V', 'Largo', 'Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Mit Seinem Geist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9faf8479-ffd0-43b7-bc5c-df828a7743b9'
);

UPDATE pieces piece
SET piece.title = 'Mit Seinem Geist 중 "Largo"', piece.title_en = 'Mit Seinem Geist: Largo', piece.editor_locked = 1
WHERE piece.id = 18603 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17419 AND linked.composer_id = 296), 'musicbrainz:55653b1b-0249-4b34-b247-0ae09141088a', 6, 'VI', 'Allegro Moderato', 'Allegro Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Mit Seinem Geist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55653b1b-0249-4b34-b247-0ae09141088a'
);

UPDATE pieces piece
SET piece.title = 'Mit Seinem Geist 중 "Allegro Moderato"', piece.title_en = 'Mit Seinem Geist: Allegro Moderato', piece.editor_locked = 1
WHERE piece.id = 17419 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17024 AND linked.composer_id = 296), 'musicbrainz:3d82d33a-f208-4a84-811d-d4aecf9bd6c3', 7, 'VII', 'Largo', 'Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Mit Seinem Geist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d82d33a-f208-4a84-811d-d4aecf9bd6c3'
);

UPDATE pieces piece
SET piece.title = 'Mit Seinem Geist 중 "Largo"', piece.title_en = 'Mit Seinem Geist: Largo', piece.editor_locked = 1
WHERE piece.id = 17024 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18537 AND linked.composer_id = 296), 'musicbrainz:9b0994a8-05ea-4f2c-acd5-b4d2b898093d', 8, 'VIII', 'Allegro Con Spirito', 'Allegro Con Spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Mit Seinem Geist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b0994a8-05ea-4f2c-acd5-b4d2b898093d'
);

UPDATE pieces piece
SET piece.title = 'Mit Seinem Geist 중 "Allegro Con Spirito"', piece.title_en = 'Mit Seinem Geist: Allegro Con Spirito', piece.editor_locked = 1
WHERE piece.id = 18537 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None <Theotokos>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Theotokos>', 'Theotokos', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Theotokos>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17662 AND linked.composer_id = 296), 'musicbrainz:64a29f8b-c456-453f-be7a-95f2481ae22f', 1, NULL, 'Ouverture', 'Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = '<Theotokos>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64a29f8b-c456-453f-be7a-95f2481ae22f'
);

UPDATE pieces piece
SET piece.title = '<Theotokos> 중 "Ouverture"', piece.title_en = 'Theotokos: Ouverture', piece.editor_locked = 1
WHERE piece.id = 17662 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18075 AND linked.composer_id = 296), 'musicbrainz:7d3f197b-ae75-4ae5-9621-bf74e7cf32a3', 2, NULL, 'Méditation', 'Méditation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = '<Theotokos>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d3f197b-ae75-4ae5-9621-bf74e7cf32a3'
);

UPDATE pieces piece
SET piece.title = '<Theotokos> 중 "Méditation"', piece.title_en = 'Theotokos: Méditation', piece.editor_locked = 1
WHERE piece.id = 18075 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16561 AND linked.composer_id = 296), 'musicbrainz:21997582-c8e3-4152-9630-83470fb4922c', 3, NULL, 'Danse', 'Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = '<Theotokos>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21997582-c8e3-4152-9630-83470fb4922c'
);

UPDATE pieces piece
SET piece.title = '<Theotokos> 중 "Danse"', piece.title_en = 'Theotokos: Danse', piece.editor_locked = 1
WHERE piece.id = 16561 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17738 AND linked.composer_id = 296), 'musicbrainz:690108d3-f62a-4a05-acb9-a3578bea91a2', 4, NULL, 'Incantation', 'Incantation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = '<Theotokos>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:690108d3-f62a-4a05-acb9-a3578bea91a2'
);

UPDATE pieces piece
SET piece.title = '<Theotokos> 중 "Incantation"', piece.title_en = 'Theotokos: Incantation', piece.editor_locked = 1
WHERE piece.id = 17738 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17511 AND linked.composer_id = 296), 'musicbrainz:5b215245-2ef5-441e-9d64-81ecbeffac30', 5, NULL, 'Prière', 'Prière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = '<Theotokos>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b215245-2ef5-441e-9d64-81ecbeffac30'
);

UPDATE pieces piece
SET piece.title = '<Theotokos> 중 "Prière"', piece.title_en = 'Theotokos: Prière', piece.editor_locked = 1
WHERE piece.id = 17511 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18457 AND linked.composer_id = 296), 'musicbrainz:962691d5-8aaa-4781-97d8-99ca3e292f9f', 6, NULL, 'Déclamation', 'Déclamation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = '<Theotokos>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:962691d5-8aaa-4781-97d8-99ca3e292f9f'
);

UPDATE pieces piece
SET piece.title = '<Theotokos> 중 "Déclamation"', piece.title_en = 'Theotokos: Déclamation', piece.editor_locked = 1
WHERE piece.id = 18457 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17094 AND linked.composer_id = 296), 'musicbrainz:42166160-aaef-4c3e-ac5e-9e25f555b00c', 7, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = '<Theotokos>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42166160-aaef-4c3e-ac5e-9e25f555b00c'
);

UPDATE pieces piece
SET piece.title = '<Theotokos> 중 "Finale"', piece.title_en = 'Theotokos: Finale', piece.editor_locked = 1
WHERE piece.id = 17094 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== Franck Bedrossian (composer_id 299) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 0

-- None Epigram

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Epigram', 'Epigram', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 299
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Epigram'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17136 AND linked.composer_id = 299), 'musicbrainz:44d1d0d5-5608-4cb0-9638-46eab5cbafb7', 1, 'I', '1악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 299 AND p.title = 'Epigram' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44d1d0d5-5608-4cb0-9638-46eab5cbafb7'
);

UPDATE pieces piece
SET piece.title = 'Epigram 중 "1악장"', piece.title_en = 'Epigram: 1악장', piece.editor_locked = 1
WHERE piece.id = 17136 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18211 AND linked.composer_id = 299), 'musicbrainz:87558e73-b2d9-4f90-b2b0-5729ea3d288d', 2, 'II', '2악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 299 AND p.title = 'Epigram' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87558e73-b2d9-4f90-b2b0-5729ea3d288d'
);

UPDATE pieces piece
SET piece.title = 'Epigram 중 "2악장"', piece.title_en = 'Epigram: 2악장', piece.editor_locked = 1
WHERE piece.id = 18211 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19411 AND linked.composer_id = 299), 'musicbrainz:d3113e6e-452a-4a5d-a318-72362755fb76', 3, 'III', '3악장', '', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 299 AND p.title = 'Epigram' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3113e6e-452a-4a5d-a318-72362755fb76'
);

UPDATE pieces piece
SET piece.title = 'Epigram 중 "3악장"', piece.title_en = 'Epigram: 3악장', piece.editor_locked = 1
WHERE piece.id = 19411 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 피터 맥스웰 데이비스 (composer_id 301) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 2

-- None Five Carols

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Five Carols', 'Five Carols', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 301
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Five Carols'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18907 AND linked.composer_id = 301), 'musicbrainz:b282ba94-0600-4135-977a-f1ab91b2a20d', 1, NULL, 'Goday, my lord Sire Christemas', 'Goday, my lord Sire Christemas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 301 AND p.title = 'Five Carols' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b282ba94-0600-4135-977a-f1ab91b2a20d'
);

UPDATE pieces piece
SET piece.title = 'Five Carols 중 "Goday, my lord Sire Christemas"', piece.title_en = 'Five Carols: Goday, my lord Sire Christemas', piece.editor_locked = 1
WHERE piece.id = 18907 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16627 AND linked.composer_id = 301), 'musicbrainz:25e7c8e7-7c6c-4fab-809d-718cd7baaeb8', 2, NULL, 'Ave domina – for thro our sins', 'Ave domina – for thro our sins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 301 AND p.title = 'Five Carols' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25e7c8e7-7c6c-4fab-809d-718cd7baaeb8'
);

UPDATE pieces piece
SET piece.title = 'Five Carols 중 "Ave domina – for thro our sins"', piece.title_en = 'Five Carols: Ave domina – for thro our sins', piece.editor_locked = 1
WHERE piece.id = 16627 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17571 AND linked.composer_id = 301), 'musicbrainz:5f04c11f-e416-4f81-bbf7-f041b523551b', 3, NULL, 'What tidings bringest thou', 'What tidings bringest thou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 301 AND p.title = 'Five Carols' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f04c11f-e416-4f81-bbf7-f041b523551b'
);

UPDATE pieces piece
SET piece.title = 'Five Carols 중 "What tidings bringest thou"', piece.title_en = 'Five Carols: What tidings bringest thou', piece.editor_locked = 1
WHERE piece.id = 17571 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18484 AND linked.composer_id = 301), 'musicbrainz:979da445-10d7-4f46-9b4d-ba191de5ee91', 4, NULL, 'Ah man, assay', 'Ah man, assay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 301 AND p.title = 'Five Carols' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:979da445-10d7-4f46-9b4d-ba191de5ee91'
);

UPDATE pieces piece
SET piece.title = 'Five Carols 중 "Ah man, assay"', piece.title_en = 'Five Carols: Ah man, assay', piece.editor_locked = 1
WHERE piece.id = 18484 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17841 AND linked.composer_id = 301), 'musicbrainz:6ef968d7-778d-4b2e-8b00-f54e822396c8', 5, NULL, 'Make we joy now in this fest', 'Make we joy now in this fest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 301 AND p.title = 'Five Carols' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ef968d7-778d-4b2e-8b00-f54e822396c8'
);

UPDATE pieces piece
SET piece.title = 'Five Carols 중 "Make we joy now in this fest"', piece.title_en = 'Five Carols: Make we joy now in this fest', piece.editor_locked = 1
WHERE piece.id = 17841 AND piece.composer_id = 301
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 에르네스토 레쿠오나 (composer_id 307) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 0

-- None Three Miniatures

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Three Miniatures', 'Three Miniatures', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 307
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Three Miniatures'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18212 AND linked.composer_id = 307), 'musicbrainz:87941085-f158-4929-b365-9682607c48d9', 1, NULL, 'Bellflower', 'Bellflower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 307 AND p.title = 'Three Miniatures' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87941085-f158-4929-b365-9682607c48d9'
);

UPDATE pieces piece
SET piece.title = 'Three Miniatures 중 "Bellflower"', piece.title_en = 'Three Miniatures: Bellflower', piece.editor_locked = 1
WHERE piece.id = 18212 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17656 AND linked.composer_id = 307), 'musicbrainz:6448c6db-3c4e-4789-b5fb-3fcf20952b6a', 2, NULL, 'Music Box', 'Music Box', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 307 AND p.title = 'Three Miniatures' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6448c6db-3c4e-4789-b5fb-3fcf20952b6a'
);

UPDATE pieces piece
SET piece.title = 'Three Miniatures 중 "Music Box"', piece.title_en = 'Three Miniatures: Music Box', piece.editor_locked = 1
WHERE piece.id = 17656 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19782 AND linked.composer_id = 307), 'musicbrainz:edcda4e2-d37c-4c53-b420-44ae0911af99', 3, NULL, 'Polchinella', 'Polchinella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 307 AND p.title = 'Three Miniatures' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edcda4e2-d37c-4c53-b420-44ae0911af99'
);

UPDATE pieces piece
SET piece.title = 'Three Miniatures 중 "Polchinella"', piece.title_en = 'Three Miniatures: Polchinella', piece.editor_locked = 1
WHERE piece.id = 19782 AND piece.composer_id = 307
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

