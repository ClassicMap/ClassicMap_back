-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 2/11).
-- 작품 83개(새 32개), seed 402개 중 잇기 321·숨김 81·그대로 0.
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

-- ===== 니노 로타 (composer_id 111) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 83개 중 음반 묶음 31개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 52개,
-- 새 작품 32개, part 514개, 그 아래 0개.
-- seed 402개 중 271개를 음반 묶음 안 곡으로 잇고, 50개는 낱개 작품으로 두고, 81개를 숨긴다.

-- 숨길 seed 가 쥔 카탈로그 제목을 비운다
UPDATE pieces piece
SET piece.title = 'Il furto della Gioconda (Seq. 15 - polka) (중복 10412)'
WHERE piece.id = 10412 AND piece.composer_id = 111 AND piece.title = 'Il furto della Gioconda (Seq. 15 - polka)'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 5 pezzi facili

UPDATE pieces piece
SET piece.title = '5 pezzi facili', piece.title_en = '5 pezzi facili',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10825 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La Passeggiata de Puccettino', part.name_en = '5 pezzi facili: I. La Passeggiata de Puccettino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10825 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:21f26153-6c69-4b36-bcad-de473e01eff1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21f26153-6c69-4b36-bcad-de473e01eff1', 1, 'I', 'La Passeggiata de Puccettino', '5 pezzi facili: I. La Passeggiata de Puccettino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10825 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21f26153-6c69-4b36-bcad-de473e01eff1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Serenata', part.name_en = '5 pezzi facili: II. Serenata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10825 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:2e14c077-dac6-4b22-bd92-cba6b08e9c5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e14c077-dac6-4b22-bd92-cba6b08e9c5c', 2, 'II', 'Serenata', '5 pezzi facili: II. Serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10825 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e14c077-dac6-4b22-bd92-cba6b08e9c5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Pavana', part.name_en = '5 pezzi facili: III. Pavana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10825 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:099f6df2-f6ab-4f3e-91d2-ec985cd5b752' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:099f6df2-f6ab-4f3e-91d2-ec985cd5b752', 3, 'III', 'Pavana', '5 pezzi facili: III. Pavana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10825 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:099f6df2-f6ab-4f3e-91d2-ec985cd5b752'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La Chioccia', part.name_en = '5 pezzi facili: IV. La Chioccia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10825 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:b492e64c-0f80-4ee8-aecc-1332a47f84e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b492e64c-0f80-4ee8-aecc-1332a47f84e9', 4, 'IV', 'La Chioccia', '5 pezzi facili: IV. La Chioccia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10825 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b492e64c-0f80-4ee8-aecc-1332a47f84e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Il Soldatino', part.name_en = '5 pezzi facili: V. Il Soldatino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10825 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:4ee46786-bb08-4fb3-947e-26df76c55613' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ee46786-bb08-4fb3-947e-26df76c55613', 5, 'V', 'Il Soldatino', '5 pezzi facili: V. Il Soldatino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10825 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ee46786-bb08-4fb3-947e-26df76c55613'
);


-- None 영화음악 <8½>

UPDATE pieces piece
SET piece.title = '영화음악 <8½>', piece.title_en = '8½',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7447 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'E poi', part.name_en = 'E poi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7447 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:1cf10095-41e5-49c9-9b2d-01eab2b11cd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cf10095-41e5-49c9-9b2d-01eab2b11cd9', 1, NULL, 'E poi', 'E poi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7447 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cf10095-41e5-49c9-9b2d-01eab2b11cd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La Passerella di « Otto e mezzo »', part.name_en = 'La Passerella di « Otto e mezzo »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7447 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:a8a3837f-591e-4476-abe8-d60d13ee4880' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8a3837f-591e-4476-abe8-d60d13ee4880', 2, NULL, 'La Passerella di « Otto e mezzo »', 'La Passerella di « Otto e mezzo »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7447 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8a3837f-591e-4476-abe8-d60d13ee4880'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Passerella di Addio', part.name_en = 'La Passerella di Addio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7447 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:ccd6313c-18ba-4363-91f7-92b372d65676' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccd6313c-18ba-4363-91f7-92b372d65676', 3, NULL, 'La Passerella di Addio', 'La Passerella di Addio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7447 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccd6313c-18ba-4363-91f7-92b372d65676'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Carlotta''s Galop', part.name_en = 'Carlotta''s Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7447 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f779e7d0-a4f5-4411-90cd-330bfacd9703' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f779e7d0-a4f5-4411-90cd-330bfacd9703', 4, NULL, 'Carlotta''s Galop', 'Carlotta''s Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7447 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f779e7d0-a4f5-4411-90cd-330bfacd9703'
);


-- None 가곡 <Buongiorno Fortunella>

UPDATE pieces piece
SET piece.title = '가곡 <Buongiorno Fortunella>', piece.title_en = 'Buongiorno Fortunella',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9712 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Castel del Monte

UPDATE pieces piece
SET piece.title = 'Castel del Monte', piece.title_en = 'Castel del Monte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10543 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Come Live Your Life With Me>

UPDATE pieces piece
SET piece.title = '가곡 <Come Live Your Life With Me>', piece.title_en = 'Come Live Your Life With Me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10418 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto festivo

UPDATE pieces piece
SET piece.title = 'Concerto festivo', piece.title_en = 'Concerto festivo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9928 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouverture. Allegro', part.name_en = 'Concerto festivo: I. Ouverture. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9928 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:dfacaf50-6670-4908-aafe-f4d2a5336a61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfacaf50-6670-4908-aafe-f4d2a5336a61', 1, 'I', 'Ouverture. Allegro', 'Concerto festivo: I. Ouverture. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9928 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfacaf50-6670-4908-aafe-f4d2a5336a61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Aria. Andante sostenuto e cantabile', part.name_en = 'Concerto festivo: II. Aria. Andante sostenuto e cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9928 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:19e21ba3-4efb-4680-ad91-6755cb3fe383' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19e21ba3-4efb-4680-ad91-6755cb3fe383', 2, 'II', 'Aria. Andante sostenuto e cantabile', 'Concerto festivo: II. Aria. Andante sostenuto e cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9928 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19e21ba3-4efb-4680-ad91-6755cb3fe383'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cabaletta. Andante con moto e scherzando', part.name_en = 'Concerto festivo: III. Cabaletta. Andante con moto e scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9928 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:00c82a0b-e71a-4514-8b88-55ceb0f0a254' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00c82a0b-e71a-4514-8b88-55ceb0f0a254', 3, 'III', 'Cabaletta. Andante con moto e scherzando', 'Concerto festivo: III. Cabaletta. Andante con moto e scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9928 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00c82a0b-e71a-4514-8b88-55ceb0f0a254'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Elegia. Andante sostenuto', part.name_en = 'Concerto festivo: IV. Elegia. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9928 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f15f8d2b-6940-4785-b053-a1fa817b23f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f15f8d2b-6940-4785-b053-a1fa817b23f3', 4, 'IV', 'Elegia. Andante sostenuto', 'Concerto festivo: IV. Elegia. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9928 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f15f8d2b-6940-4785-b053-a1fa817b23f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Finale. Allegro', part.name_en = 'Concerto festivo: V. Finale. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9928 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f3ce9617-3ea9-46d5-b618-2450ac869cf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3ce9617-3ea9-46d5-b618-2450ac869cf3', 5, 'V', 'Finale. Allegro', 'Concerto festivo: V. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9928 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3ce9617-3ea9-46d5-b618-2450ac869cf3'
);


-- None 바순 협주곡

UPDATE pieces piece
SET piece.title = '바순 협주곡', piece.title_en = 'Concerto for Bassoon and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10777 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Toccata. Allegretto vivace', part.name_en = 'Concerto for Bassoon and Orchestra: I. Toccata. Allegretto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10777 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:8adf3f5f-ad2c-4726-b974-2cc570840b3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8adf3f5f-ad2c-4726-b974-2cc570840b3e', 1, 'I', 'Toccata. Allegretto vivace', 'Concerto for Bassoon and Orchestra: I. Toccata. Allegretto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10777 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8adf3f5f-ad2c-4726-b974-2cc570840b3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Recitativo. Lento', part.name_en = 'Concerto for Bassoon and Orchestra: II. Recitativo. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10777 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:893d9132-1ac5-4b24-afa7-984e83ddfeea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:893d9132-1ac5-4b24-afa7-984e83ddfeea', 2, 'II', 'Recitativo. Lento', 'Concerto for Bassoon and Orchestra: II. Recitativo. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10777 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:893d9132-1ac5-4b24-afa7-984e83ddfeea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tema e variazioni', part.name_en = 'Concerto for Bassoon and Orchestra: III. Tema e variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10777 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:4592dd02-2e49-46d2-b961-aee50bb388c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4592dd02-2e49-46d2-b961-aee50bb388c2', 3, 'III', 'Tema e variazioni', 'Concerto for Bassoon and Orchestra: III. Tema e variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10777 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4592dd02-2e49-46d2-b961-aee50bb388c2'
);


-- None 하프 협주곡

UPDATE pieces piece
SET piece.title = '하프 협주곡', piece.title_en = 'Concerto for Harp and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9543 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Concerto for Harp and Orchestra: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9543 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:c3a45cb0-7027-4534-a7aa-6f543638f9f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3a45cb0-7027-4534-a7aa-6f543638f9f9', 1, 'I', 'Allegro moderato', 'Concerto for Harp and Orchestra: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9543 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3a45cb0-7027-4534-a7aa-6f543638f9f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Concerto for Harp and Orchestra: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9543 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:7c80f8da-fe99-4007-8929-708510d8a633' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c80f8da-fe99-4007-8929-708510d8a633', 2, 'II', 'Andante', 'Concerto for Harp and Orchestra: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9543 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c80f8da-fe99-4007-8929-708510d8a633'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Concerto for Harp and Orchestra: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9543 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:98d24144-f9c7-424d-90b3-a0b4bac0d738' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98d24144-f9c7-424d-90b3-a0b4bac0d738', 3, 'III', 'Allegro', 'Concerto for Harp and Orchestra: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9543 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98d24144-f9c7-424d-90b3-a0b4bac0d738'
);


-- None 트롬본 협주곡 C장조

UPDATE pieces piece
SET piece.title = '트롬본 협주곡 C장조', piece.title_en = 'Concerto for Trombone and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10001 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro giusto', part.name_en = 'Concerto for Trombone and Orchestra: I. Allegro giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10001 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:a442eeaf-eeb5-4384-9f5e-4c7c8d0ddc42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a442eeaf-eeb5-4384-9f5e-4c7c8d0ddc42', 1, 'I', 'Allegro giusto', 'Concerto for Trombone and Orchestra: I. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10001 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a442eeaf-eeb5-4384-9f5e-4c7c8d0ddc42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento, ben ritmato', part.name_en = 'Concerto for Trombone and Orchestra: II. Lento, ben ritmato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10001 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:cfedb466-9a45-4e01-ae0c-ecfaf984ae55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfedb466-9a45-4e01-ae0c-ecfaf984ae55', 2, 'II', 'Lento, ben ritmato', 'Concerto for Trombone and Orchestra: II. Lento, ben ritmato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10001 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfedb466-9a45-4e01-ae0c-ecfaf984ae55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato', part.name_en = 'Concerto for Trombone and Orchestra: III. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10001 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:134658a1-1e4b-4ae4-9bea-76fe3ec7ff7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:134658a1-1e4b-4ae4-9bea-76fe3ec7ff7b', 3, 'III', 'Allegro moderato', 'Concerto for Trombone and Orchestra: III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10001 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:134658a1-1e4b-4ae4-9bea-76fe3ec7ff7b'
);


-- None Concerto per archi

UPDATE pieces piece
SET piece.title = 'Concerto per archi', piece.title_en = 'Concerto per archi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7607 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio (Allegro ben moderato e cantabile)', part.name_en = 'Concerto per archi: I. Preludio (Allegro ben moderato e cantabile)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7607 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:8e6f9629-cdaf-4099-a534-52f38cc03423' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e6f9629-cdaf-4099-a534-52f38cc03423', 1, 'I', 'Preludio (Allegro ben moderato e cantabile)', 'Concerto per archi: I. Preludio (Allegro ben moderato e cantabile)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7607 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e6f9629-cdaf-4099-a534-52f38cc03423'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo (Allegretto comodo)', part.name_en = 'Concerto per archi: II. Scherzo (Allegretto comodo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7607 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:ef4b8e31-d716-4471-8785-d5125b6f40b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef4b8e31-d716-4471-8785-d5125b6f40b6', 2, 'II', 'Scherzo (Allegretto comodo)', 'Concerto per archi: II. Scherzo (Allegretto comodo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7607 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef4b8e31-d716-4471-8785-d5125b6f40b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Aria (Andante quasi adagio)', part.name_en = 'Concerto per archi: III. Aria (Andante quasi adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7607 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:3c1c3be1-4688-4df4-9716-4c7c85933902' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c1c3be1-4688-4df4-9716-4c7c85933902', 3, 'III', 'Aria (Andante quasi adagio)', 'Concerto per archi: III. Aria (Andante quasi adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7607 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c1c3be1-4688-4df4-9716-4c7c85933902'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale (Allegrissimo)', part.name_en = 'Concerto per archi: IV. Finale (Allegrissimo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7607 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:bd1fad82-9c00-4157-853d-50025b7168b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd1fad82-9c00-4157-853d-50025b7168b6', 4, 'IV', 'Finale (Allegrissimo)', 'Concerto per archi: IV. Finale (Allegrissimo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7607 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd1fad82-9c00-4157-853d-50025b7168b6'
);


-- None Concerto per violoncello n. 2

UPDATE pieces piece
SET piece.title = 'Concerto per violoncello n. 2', piece.title_en = 'Concerto per violoncello n. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9023 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Concerto per violoncello n. 2: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9023 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:0299c0f8-62c3-45aa-8833-cacb94af2d33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0299c0f8-62c3-45aa-8833-cacb94af2d33', 1, 'I', 'Allegro moderato', 'Concerto per violoncello n. 2: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9023 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0299c0f8-62c3-45aa-8833-cacb94af2d33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tema e variazioni: Andantino cantabile, con grazia', part.name_en = 'Concerto per violoncello n. 2: II. Tema e variazioni: Andantino cantabile, con grazia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9023 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f398d8ab-cd53-4d9f-81bf-d93b773a1a4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f398d8ab-cd53-4d9f-81bf-d93b773a1a4f', 2, 'II', 'Tema e variazioni: Andantino cantabile, con grazia', 'Concerto per violoncello n. 2: II. Tema e variazioni: Andantino cantabile, con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9023 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f398d8ab-cd53-4d9f-81bf-d93b773a1a4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivo', part.name_en = 'Concerto per violoncello n. 2: III. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9023 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:2a9688b8-b306-460e-b332-095c8a386978' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a9688b8-b306-460e-b332-095c8a386978', 3, 'III', 'Allegro vivo', 'Concerto per violoncello n. 2: III. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9023 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a9688b8-b306-460e-b332-095c8a386978'
);


-- None Concerto soirée

UPDATE pieces piece
SET piece.title = 'Concerto soirée', piece.title_en = 'Concerto soirée',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7753 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Valzer-Fantasia', part.name_en = 'Concerto soirée: I. Valzer-Fantasia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7753 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:82d32b80-6dc9-473c-bf94-966a7f3d1df9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82d32b80-6dc9-473c-bf94-966a7f3d1df9', 1, 'I', 'Valzer-Fantasia', 'Concerto soirée: I. Valzer-Fantasia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7753 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82d32b80-6dc9-473c-bf94-966a7f3d1df9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ballo figurato', part.name_en = 'Concerto soirée: II. Ballo figurato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7753 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:c83d2cfc-11ee-44f0-8270-e30c83d53a76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c83d2cfc-11ee-44f0-8270-e30c83d53a76', 2, 'II', 'Ballo figurato', 'Concerto soirée: II. Ballo figurato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7753 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c83d2cfc-11ee-44f0-8270-e30c83d53a76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Romanza', part.name_en = 'Concerto soirée: III. Romanza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7753 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:5956fe94-8bce-43ab-9b53-a56e4dc4e01a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5956fe94-8bce-43ab-9b53-a56e4dc4e01a', 3, 'III', 'Romanza', 'Concerto soirée: III. Romanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7753 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5956fe94-8bce-43ab-9b53-a56e4dc4e01a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Quadriglia', part.name_en = 'Concerto soirée: IV. Quadriglia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7753 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:2066835d-51f5-47ea-8c9e-fbec67389128' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2066835d-51f5-47ea-8c9e-fbec67389128', 4, 'IV', 'Quadriglia', 'Concerto soirée: IV. Quadriglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7753 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2066835d-51f5-47ea-8c9e-fbec67389128'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Can-can', part.name_en = 'Concerto soirée: V. Can-can',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7753 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:5d5d445d-702a-4c82-bfa2-9cad153492f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d5d445d-702a-4c82-bfa2-9cad153492f0', 5, 'V', 'Can-can', 'Concerto soirée: V. Can-can', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7753 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d5d445d-702a-4c82-bfa2-9cad153492f0'
);


-- None 영화 <나일 강의 죽음> 사운드트랙

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙', piece.title_en = 'Death on the Nile',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11289 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Main Titles', part.name_en = 'Main Titles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:cedfddd9-a230-469a-b4a5-427bfec892a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cedfddd9-a230-469a-b4a5-427bfec892a9', 1, NULL, 'Main Titles', 'Main Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cedfddd9-a230-469a-b4a5-427bfec892a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11131 AND linked.composer_id = 111),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Arrival at Wode Hall', part.name_en = 'Arrival at Wode Hall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f57a6fec-0263-4efd-ae45-085494397f7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11131 AND linked.composer_id = 111), 'musicbrainz:f57a6fec-0263-4efd-ae45-085494397f7b', 2, NULL, 'Arrival at Wode Hall', 'Arrival at Wode Hall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f57a6fec-0263-4efd-ae45-085494397f7b'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "Arrival at Wode Hall"', piece.title_en = 'Death on the Nile: Arrival at Wode Hall', piece.editor_locked = 1
WHERE piece.id = 11131 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11035 AND linked.composer_id = 111),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Steambot Departs', part.name_en = 'The Steambot Departs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:edef5719-e773-41c7-9c22-4c8e98882398' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11035 AND linked.composer_id = 111), 'musicbrainz:edef5719-e773-41c7-9c22-4c8e98882398', 3, NULL, 'The Steambot Departs', 'The Steambot Departs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edef5719-e773-41c7-9c22-4c8e98882398'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Steambot Departs"', piece.title_en = 'Death on the Nile: The Steambot Departs', piece.editor_locked = 1
WHERE piece.id = 11035 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9039 AND linked.composer_id = 111),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Camels and Donkeys', part.name_en = 'Camels and Donkeys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:5c7d0284-677e-45bc-ba0e-2040dfff0a58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9039 AND linked.composer_id = 111), 'musicbrainz:5c7d0284-677e-45bc-ba0e-2040dfff0a58', 4, NULL, 'Camels and Donkeys', 'Camels and Donkeys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c7d0284-677e-45bc-ba0e-2040dfff0a58'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "Camels and Donkeys"', piece.title_en = 'Death on the Nile: Camels and Donkeys', piece.editor_locked = 1
WHERE piece.id = 9039 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11056 AND linked.composer_id = 111),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Duet (main Love Theme)', part.name_en = 'Duet (main Love Theme)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:ef79a51a-db9b-491e-9cb0-5008ef5c9166' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11056 AND linked.composer_id = 111), 'musicbrainz:ef79a51a-db9b-491e-9cb0-5008ef5c9166', 5, NULL, 'Duet (main Love Theme)', 'Duet (main Love Theme)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef79a51a-db9b-491e-9cb0-5008ef5c9166'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "Duet (main Love Theme)"', piece.title_en = 'Death on the Nile: Duet (main Love Theme)', piece.editor_locked = 1
WHERE piece.id = 11056 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9596 AND linked.composer_id = 111),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Great Pyramids', part.name_en = 'The Great Pyramids',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:83f2a7eb-3679-4fd1-b986-34586f71b59f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9596 AND linked.composer_id = 111), 'musicbrainz:83f2a7eb-3679-4fd1-b986-34586f71b59f', 6, NULL, 'The Great Pyramids', 'The Great Pyramids', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83f2a7eb-3679-4fd1-b986-34586f71b59f'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Great Pyramids"', piece.title_en = 'Death on the Nile: The Great Pyramids', piece.editor_locked = 1
WHERE piece.id = 9596 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11258 AND linked.composer_id = 111),
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'I Love My Baby', part.name_en = 'I Love My Baby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:fdc152a1-4870-4ea8-804a-63d2070cb48d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11258 AND linked.composer_id = 111), 'musicbrainz:fdc152a1-4870-4ea8-804a-63d2070cb48d', 7, NULL, 'I Love My Baby', 'I Love My Baby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdc152a1-4870-4ea8-804a-63d2070cb48d'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "I Love My Baby"', piece.title_en = 'Death on the Nile: I Love My Baby', piece.editor_locked = 1
WHERE piece.id = 11258 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9682 AND linked.composer_id = 111),
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Statues of Rameses', part.name_en = 'The Statues of Rameses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:8a77e70b-26e8-4b16-abe3-39776b9149b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9682 AND linked.composer_id = 111), 'musicbrainz:8a77e70b-26e8-4b16-abe3-39776b9149b4', 8, NULL, 'The Statues of Rameses', 'The Statues of Rameses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a77e70b-26e8-4b16-abe3-39776b9149b4'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Statues of Rameses"', piece.title_en = 'Death on the Nile: The Statues of Rameses', piece.editor_locked = 1
WHERE piece.id = 9682 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11037 AND linked.composer_id = 111),
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Journey on the Nile', part.name_en = 'Journey on the Nile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:ee46578c-8305-4b23-a1eb-3208d7d365cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11037 AND linked.composer_id = 111), 'musicbrainz:ee46578c-8305-4b23-a1eb-3208d7d365cd', 9, NULL, 'Journey on the Nile', 'Journey on the Nile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee46578c-8305-4b23-a1eb-3208d7d365cd'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "Journey on the Nile"', piece.title_en = 'Death on the Nile: Journey on the Nile', piece.editor_locked = 1
WHERE piece.id = 11037 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8178 AND linked.composer_id = 111),
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Temple of Karnak', part.name_en = 'The Temple of Karnak',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:1ebb1bd0-4d06-49ce-800a-afd1b62eee5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8178 AND linked.composer_id = 111), 'musicbrainz:1ebb1bd0-4d06-49ce-800a-afd1b62eee5e', 10, NULL, 'The Temple of Karnak', 'The Temple of Karnak', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebb1bd0-4d06-49ce-800a-afd1b62eee5e'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Temple of Karnak"', piece.title_en = 'Death on the Nile: The Temple of Karnak', piece.editor_locked = 1
WHERE piece.id = 8178 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8904 AND linked.composer_id = 111),
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Carriage Ride', part.name_en = 'The Carriage Ride',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:53ec12a3-3bc9-428c-aeb1-4a818cbf143a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8904 AND linked.composer_id = 111), 'musicbrainz:53ec12a3-3bc9-428c-aeb1-4a818cbf143a', 11, NULL, 'The Carriage Ride', 'The Carriage Ride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53ec12a3-3bc9-428c-aeb1-4a818cbf143a'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Carriage Ride"', piece.title_en = 'Death on the Nile: The Carriage Ride', piece.editor_locked = 1
WHERE piece.id = 8904 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10643 AND linked.composer_id = 111),
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Jackie''s Theme', part.name_en = 'Jackie''s Theme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:d10cdb7f-e4fd-4e38-8d7c-a92161b2bd6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10643 AND linked.composer_id = 111), 'musicbrainz:d10cdb7f-e4fd-4e38-8d7c-a92161b2bd6f', 12, NULL, 'Jackie''s Theme', 'Jackie''s Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d10cdb7f-e4fd-4e38-8d7c-a92161b2bd6f'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "Jackie''s Theme"', piece.title_en = 'Death on the Nile: Jackie''s Theme', piece.editor_locked = 1
WHERE piece.id = 10643 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10557 AND linked.composer_id = 111),
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Fox-Trot - Don''t Say No to Rain', part.name_en = 'Fox-Trot - Don''t Say No to Rain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:ca6ab590-37a6-49d4-9c43-5e987eebbd6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10557 AND linked.composer_id = 111), 'musicbrainz:ca6ab590-37a6-49d4-9c43-5e987eebbd6a', 13, NULL, 'Fox-Trot - Don''t Say No to Rain', 'Fox-Trot - Don''t Say No to Rain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca6ab590-37a6-49d4-9c43-5e987eebbd6a'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "Fox-Trot - Don''t Say No to Rain"', piece.title_en = 'Death on the Nile: Fox-Trot - Don''t Say No to Rain', piece.editor_locked = 1
WHERE piece.id = 10557 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11209 AND linked.composer_id = 111),
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Linnet''s Pearls', part.name_en = 'Linnet''s Pearls',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:fad3479d-1b8f-42da-bae3-2eac4527c38a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11209 AND linked.composer_id = 111), 'musicbrainz:fad3479d-1b8f-42da-bae3-2eac4527c38a', 14, NULL, 'Linnet''s Pearls', 'Linnet''s Pearls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad3479d-1b8f-42da-bae3-2eac4527c38a'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "Linnet''s Pearls"', piece.title_en = 'Death on the Nile: Linnet''s Pearls', piece.editor_locked = 1
WHERE piece.id = 11209 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10961 AND linked.composer_id = 111),
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Waltz - The White Nile', part.name_en = 'Waltz - The White Nile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:e8af0b1e-6d90-4715-a6f2-e630baa418ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10961 AND linked.composer_id = 111), 'musicbrainz:e8af0b1e-6d90-4715-a6f2-e630baa418ae', 15, NULL, 'Waltz - The White Nile', 'Waltz - The White Nile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8af0b1e-6d90-4715-a6f2-e630baa418ae'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "Waltz - The White Nile"', piece.title_en = 'Death on the Nile: Waltz - The White Nile', piece.editor_locked = 1
WHERE piece.id = 10961 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9332 AND linked.composer_id = 111),
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Conclusive Evidence', part.name_en = 'The Conclusive Evidence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:717c6cc8-1da3-4184-82a9-685ca71159b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9332 AND linked.composer_id = 111), 'musicbrainz:717c6cc8-1da3-4184-82a9-685ca71159b1', 16, NULL, 'The Conclusive Evidence', 'The Conclusive Evidence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:717c6cc8-1da3-4184-82a9-685ca71159b1'
);

UPDATE pieces piece
SET piece.title = '영화 <나일 강의 죽음> 사운드트랙 중 "The Conclusive Evidence"', piece.title_en = 'Death on the Nile: The Conclusive Evidence', piece.editor_locked = 1
WHERE piece.id = 9332 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'End Titles', part.name_en = 'End Titles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:b4a77f21-0935-428e-bf20-53cdaf60be00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4a77f21-0935-428e-bf20-53cdaf60be00', 17, NULL, 'End Titles', 'End Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4a77f21-0935-428e-bf20-53cdaf60be00'
);


-- None 가곡 <Die Rose von Nowgorod>

UPDATE pieces piece
SET piece.title = '가곡 <Die Rose von Nowgorod>', piece.title_en = 'Die Rose von Nowgorod',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9980 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Divertimento concertante

UPDATE pieces piece
SET piece.title = 'Divertimento concertante', piece.title_en = 'Divertimento concertante',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10818 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Divertimento concertante: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10818 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:4502aaf9-0f76-4990-9789-b0852a38f2d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4502aaf9-0f76-4990-9789-b0852a38f2d2', 1, 'I', 'Allegro', 'Divertimento concertante: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10818 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4502aaf9-0f76-4990-9789-b0852a38f2d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Marcia', part.name_en = 'Divertimento concertante: II. Marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10818 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:95720178-8ae1-4d46-b320-e75681f33a49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95720178-8ae1-4d46-b320-e75681f33a49', 2, 'II', 'Marcia', 'Divertimento concertante: II. Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10818 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95720178-8ae1-4d46-b320-e75681f33a49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Aria', part.name_en = 'Divertimento concertante: III. Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10818 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:c2f0b985-f783-4107-8fd5-9fb08dfc68f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2f0b985-f783-4107-8fd5-9fb08dfc68f0', 3, 'III', 'Aria', 'Divertimento concertante: III. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10818 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2f0b985-f783-4107-8fd5-9fb08dfc68f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale', part.name_en = 'Divertimento concertante: IV. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10818 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:b54c652f-1e57-4d6c-9935-d469d4bdb2cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b54c652f-1e57-4d6c-9935-d469d4bdb2cf', 4, 'IV', 'Finale', 'Divertimento concertante: IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10818 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b54c652f-1e57-4d6c-9935-d469d4bdb2cf'
);


-- None Fantasia in sol

UPDATE pieces piece
SET piece.title = 'Fantasia in sol', piece.title_en = 'Fantasia in sol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7617 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I clowns

UPDATE pieces piece
SET piece.title = 'I clowns', piece.title_en = 'I clowns',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10676 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Il Casanova di Federico Fellini - Suite sinfonica

UPDATE pieces piece
SET piece.title = 'Il Casanova di Federico Fellini - Suite sinfonica', piece.title_en = 'Il Casanova di Federico Fellini - Suite sinfonica',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10206 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O Venezia, Venaga, Venusia', part.name_en = 'Il Casanova di Federico Fellini - Suite sinfonica: 1. O Venezia, Venaga, Venusia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10206 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:eebbefa0-b6f1-4418-9877-c5bc388c66b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eebbefa0-b6f1-4418-9877-c5bc388c66b3', 1, NULL, 'O Venezia, Venaga, Venusia', 'Il Casanova di Federico Fellini - Suite sinfonica: 1. O Venezia, Venaga, Venusia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10206 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eebbefa0-b6f1-4418-9877-c5bc388c66b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L’uccello magico', part.name_en = 'Il Casanova di Federico Fellini - Suite sinfonica: 2. L’uccello magico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10206 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:bb09475e-f989-4498-be37-c92644dc1a36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb09475e-f989-4498-be37-c92644dc1a36', 2, NULL, 'L’uccello magico', 'Il Casanova di Federico Fellini - Suite sinfonica: 2. L’uccello magico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10206 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb09475e-f989-4498-be37-c92644dc1a36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Intermezzo della mantide religiosa', part.name_en = 'Il Casanova di Federico Fellini - Suite sinfonica: 3. Intermezzo della mantide religiosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10206 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:e1d265f9-f46c-4e8e-9625-a389fc6e2180' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1d265f9-f46c-4e8e-9625-a389fc6e2180', 3, NULL, 'Intermezzo della mantide religiosa', 'Il Casanova di Federico Fellini - Suite sinfonica: 3. Intermezzo della mantide religiosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10206 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1d265f9-f46c-4e8e-9625-a389fc6e2180'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The great Mouna', part.name_en = 'Il Casanova di Federico Fellini - Suite sinfonica: 4. The great Mouna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10206 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:2ae01116-bbdf-4f6f-a338-9cf9874124cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ae01116-bbdf-4f6f-a338-9cf9874124cc', 4, NULL, 'The great Mouna', 'Il Casanova di Federico Fellini - Suite sinfonica: 4. The great Mouna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10206 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ae01116-bbdf-4f6f-a338-9cf9874124cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Il Duca di Württenberg', part.name_en = 'Il Casanova di Federico Fellini - Suite sinfonica: 5. Il Duca di Württenberg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10206 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:d11ac2c1-72e5-40f7-98a1-e3a999f299d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d11ac2c1-72e5-40f7-98a1-e3a999f299d9', 5, NULL, 'Il Duca di Württenberg', 'Il Casanova di Federico Fellini - Suite sinfonica: 5. Il Duca di Württenberg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10206 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d11ac2c1-72e5-40f7-98a1-e3a999f299d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'La poupée automate', part.name_en = 'Il Casanova di Federico Fellini - Suite sinfonica: 6. La poupée automate',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10206 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:25962006-dcca-413d-91b8-d083cc0a37b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25962006-dcca-413d-91b8-d083cc0a37b1', 6, NULL, 'La poupée automate', 'Il Casanova di Federico Fellini - Suite sinfonica: 6. La poupée automate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10206 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25962006-dcca-413d-91b8-d083cc0a37b1'
);


-- None 영화 <표범> 사운드트랙

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙', piece.title_en = 'Il gattopardo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9047 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10410 AND linked.composer_id = 111),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Partenza di Tancredi', part.name_en = 'Partenza di Tancredi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:bf9d45a2-f472-488e-8b43-136a15c3b745' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10410 AND linked.composer_id = 111), 'musicbrainz:bf9d45a2-f472-488e-8b43-136a15c3b745', 1, NULL, 'Partenza di Tancredi', 'Partenza di Tancredi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf9d45a2-f472-488e-8b43-136a15c3b745'
);

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙 중 "Partenza di Tancredi"', piece.title_en = 'Il gattopardo: Partenza di Tancredi', piece.editor_locked = 1
WHERE piece.id = 10410 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9432 AND linked.composer_id = 111),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tancredi garibaldino', part.name_en = 'Tancredi garibaldino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:78d63db7-d2d1-476e-9a32-a0bd87b4af34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9432 AND linked.composer_id = 111), 'musicbrainz:78d63db7-d2d1-476e-9a32-a0bd87b4af34', 2, NULL, 'Tancredi garibaldino', 'Tancredi garibaldino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78d63db7-d2d1-476e-9a32-a0bd87b4af34'
);

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙 중 "Tancredi garibaldino"', piece.title_en = 'Il gattopardo: Tancredi garibaldino', piece.editor_locked = 1
WHERE piece.id = 9432 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8938 AND linked.composer_id = 111),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Viaggio a Donnafugata', part.name_en = 'Viaggio a Donnafugata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:5601fc9b-837d-40a1-a112-1e5743dafde9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8938 AND linked.composer_id = 111), 'musicbrainz:5601fc9b-837d-40a1-a112-1e5743dafde9', 3, NULL, 'Viaggio a Donnafugata', 'Viaggio a Donnafugata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5601fc9b-837d-40a1-a112-1e5743dafde9'
);

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙 중 "Viaggio a Donnafugata"', piece.title_en = 'Il gattopardo: Viaggio a Donnafugata', piece.editor_locked = 1
WHERE piece.id = 8938 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8706 AND linked.composer_id = 111),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Giovani eroi (marchetta)', part.name_en = 'Giovani eroi (marchetta)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:4603e99c-a10d-4c71-9f71-54fab9d711f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8706 AND linked.composer_id = 111), 'musicbrainz:4603e99c-a10d-4c71-9f71-54fab9d711f7', 4, NULL, 'Giovani eroi (marchetta)', 'Giovani eroi (marchetta)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4603e99c-a10d-4c71-9f71-54fab9d711f7'
);

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙 중 "Giovani eroi (marchetta)"', piece.title_en = 'Il gattopardo: Giovani eroi (marchetta)', piece.editor_locked = 1
WHERE piece.id = 8706 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9775 AND linked.composer_id = 111),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La Locanda (il pic-nic)', part.name_en = 'La Locanda (il pic-nic)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:911d1fe0-8831-4295-b395-33e8ddedfbe9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9775 AND linked.composer_id = 111), 'musicbrainz:911d1fe0-8831-4295-b395-33e8ddedfbe9', 5, NULL, 'La Locanda (il pic-nic)', 'La Locanda (il pic-nic)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:911d1fe0-8831-4295-b395-33e8ddedfbe9'
);

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙 중 "La Locanda (il pic-nic)"', piece.title_en = 'Il gattopardo: La Locanda (il pic-nic)', piece.editor_locked = 1
WHERE piece.id = 9775 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9197 AND linked.composer_id = 111),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Entrata di Angelica, L''amore di Tancredi e Angelica, Finale', part.name_en = 'Entrata di Angelica, L''amore di Tancredi e Angelica, Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:688cfb69-8601-4724-91ad-54238d4b85bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9197 AND linked.composer_id = 111), 'musicbrainz:688cfb69-8601-4724-91ad-54238d4b85bd', 6, NULL, 'Entrata di Angelica, L''amore di Tancredi e Angelica, Finale', 'Entrata di Angelica, L''amore di Tancredi e Angelica, Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:688cfb69-8601-4724-91ad-54238d4b85bd'
);

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙 중 "Entrata di Angelica, L''amore di Tancredi e Angelica, Finale"', piece.title_en = 'Il gattopardo: Entrata di Angelica, L''amore di Tancredi e Angelica, Finale', piece.editor_locked = 1
WHERE piece.id = 9197 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Mazurka', part.name_en = 'Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:3170f81a-880b-41c1-ad01-2897ce657f44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3170f81a-880b-41c1-ad01-2897ce657f44', 7, NULL, 'Mazurka', 'Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3170f81a-880b-41c1-ad01-2897ce657f44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11061 AND linked.composer_id = 111),
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Controdanza', part.name_en = 'Controdanza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:efb3c4a0-2afc-4859-8c59-ec36d34e542e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11061 AND linked.composer_id = 111), 'musicbrainz:efb3c4a0-2afc-4859-8c59-ec36d34e542e', 8, NULL, 'Controdanza', 'Controdanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efb3c4a0-2afc-4859-8c59-ec36d34e542e'
);

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙 중 "Controdanza"', piece.title_en = 'Il gattopardo: Controdanza', piece.editor_locked = 1
WHERE piece.id = 11061 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Polka', part.name_en = 'Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:c02b1b41-4fb2-4292-941c-f81d7f45ce64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c02b1b41-4fb2-4292-941c-f81d7f45ce64', 9, NULL, 'Polka', 'Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c02b1b41-4fb2-4292-941c-f81d7f45ce64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10223 AND linked.composer_id = 111),
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Quadriglia', part.name_en = 'Quadriglia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:b0f84b6f-d602-437c-b6bb-d39dc9d1964e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10223 AND linked.composer_id = 111), 'musicbrainz:b0f84b6f-d602-437c-b6bb-d39dc9d1964e', 10, NULL, 'Quadriglia', 'Quadriglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0f84b6f-d602-437c-b6bb-d39dc9d1964e'
);

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙 중 "Quadriglia"', piece.title_en = 'Il gattopardo: Quadriglia', piece.editor_locked = 1
WHERE piece.id = 10223 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Galop', part.name_en = 'Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:48007459-77db-49a4-a460-9f8d8734f2fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48007459-77db-49a4-a460-9f8d8734f2fa', 11, NULL, 'Galop', 'Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48007459-77db-49a4-a460-9f8d8734f2fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8936 AND linked.composer_id = 111),
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Valzer del commiato', part.name_en = 'Valzer del commiato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9047 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:55dd9253-2422-42a5-b15b-fb4dfa399663' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8936 AND linked.composer_id = 111), 'musicbrainz:55dd9253-2422-42a5-b15b-fb4dfa399663', 12, NULL, 'Valzer del commiato', 'Valzer del commiato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9047 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55dd9253-2422-42a5-b15b-fb4dfa399663'
);

UPDATE pieces piece
SET piece.title = '영화 <표범> 사운드트랙 중 "Valzer del commiato"', piece.title_en = 'Il gattopardo: Valzer del commiato', piece.editor_locked = 1
WHERE piece.id = 8936 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Il furto della Gioconda (Seq. 15 - polka)

UPDATE pieces piece
SET piece.title = 'Il furto della Gioconda (Seq. 15 - polka)', piece.title_en = 'Il furto della Gioconda (Seq. 15 - polka)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10580 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La dolce vita - Suite

UPDATE pieces piece
SET piece.title = 'La dolce vita - Suite', piece.title_en = 'La dolce vita - Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8477 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La dolce vita', part.name_en = 'La dolce vita - Suite: 9. La dolce vita',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8477 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:07bae02c-ebd1-43fe-a575-6db60dd7cd5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07bae02c-ebd1-43fe-a575-6db60dd7cd5a', 1, NULL, 'La dolce vita', 'La dolce vita - Suite: 9. La dolce vita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8477 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07bae02c-ebd1-43fe-a575-6db60dd7cd5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Notturno o mattutino', part.name_en = 'La dolce vita - Suite: 8. Notturno o mattutino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8477 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:2b2cccba-594b-4a97-b975-d52bb0ed39d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b2cccba-594b-4a97-b975-d52bb0ed39d2', 2, NULL, 'Notturno o mattutino', 'La dolce vita - Suite: 8. Notturno o mattutino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8477 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b2cccba-594b-4a97-b975-d52bb0ed39d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Titoli - 2. Festoso', part.name_en = 'La dolce vita - Suite: 1. Titoli - 2. Festoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8477 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:92d0e032-c48b-4fe4-afec-d37fc10016dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92d0e032-c48b-4fe4-afec-d37fc10016dc', 3, NULL, 'Titoli - 2. Festoso', 'La dolce vita - Suite: 1. Titoli - 2. Festoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8477 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d0e032-c48b-4fe4-afec-d37fc10016dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Via Veneto', part.name_en = 'La dolce vita - Suite: 4. Via Veneto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8477 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:acacd1cd-6c36-4896-ac7c-a1f410a3ed04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acacd1cd-6c36-4896-ac7c-a1f410a3ed04', 4, NULL, 'Via Veneto', 'La dolce vita - Suite: 4. Via Veneto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8477 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acacd1cd-6c36-4896-ac7c-a1f410a3ed04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Parlami di me', part.name_en = 'La dolce vita - Suite: 7. Parlami di me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8477 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:bbb26c14-580e-44d1-8661-93a6c1f9e013' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbb26c14-580e-44d1-8661-93a6c1f9e013', 5, NULL, 'Parlami di me', 'La dolce vita - Suite: 7. Parlami di me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8477 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbb26c14-580e-44d1-8661-93a6c1f9e013'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Parlami di me (a la Circus)', part.name_en = 'La dolce vita - Suite: 6. Parlami di me (a la Circus)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8477 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:bca5acf8-1063-4f6e-beaf-570cf02d7c6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bca5acf8-1063-4f6e-beaf-570cf02d7c6f', 6, NULL, 'Parlami di me (a la Circus)', 'La dolce vita - Suite: 6. Parlami di me (a la Circus)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8477 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bca5acf8-1063-4f6e-beaf-570cf02d7c6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Notturno', part.name_en = 'La dolce vita - Suite: 3. Notturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8477 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f06c413c-e663-4f27-a02f-623d779d7f5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f06c413c-e663-4f27-a02f-623d779d7f5b', 7, NULL, 'Notturno', 'La dolce vita - Suite: 3. Notturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8477 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f06c413c-e663-4f27-a02f-623d779d7f5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Cavallino Canzonetta', part.name_en = 'La dolce vita - Suite: 5. Cavallino Canzonetta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8477 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:fca43508-a45d-4ffd-b3df-42a9fda4169d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fca43508-a45d-4ffd-b3df-42a9fda4169d', 8, NULL, 'Cavallino Canzonetta', 'La dolce vita - Suite: 5. Cavallino Canzonetta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8477 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fca43508-a45d-4ffd-b3df-42a9fda4169d'
);


-- None 오페라 <La notte di un nevrastenico>

UPDATE pieces piece
SET piece.title = '오페라 <La notte di un nevrastenico>', piece.title_en = 'La notte di un nevrastenico',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11246 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Molière imaginaire – Ballet Suite

UPDATE pieces piece
SET piece.title = 'Le Molière imaginaire – Ballet Suite', piece.title_en = 'Le Molière imaginaire – Ballet Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8263 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouverture. Un poco lento – Allegro marcato – Un poco maestoso – Tempo I – Allegro marcato – Vivacissimo', part.name_en = 'Le Molière imaginaire – Ballet Suite: I. Ouverture. Un poco lento – Allegro marcato – Un poco maestoso – Tempo I – Allegro marcato – Vivacissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8263 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:0f0a6cce-61cc-481b-9704-cf06654fdbe5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f0a6cce-61cc-481b-9704-cf06654fdbe5', 1, 'I', 'Ouverture. Un poco lento – Allegro marcato – Un poco maestoso – Tempo I – Allegro marcato – Vivacissimo', 'Le Molière imaginaire – Ballet Suite: I. Ouverture. Un poco lento – Allegro marcato – Un poco maestoso – Tempo I – Allegro marcato – Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8263 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f0a6cce-61cc-481b-9704-cf06654fdbe5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Danse des comédiens. Allegro', part.name_en = 'Le Molière imaginaire – Ballet Suite: III. Danse des comédiens. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8263 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:46a196a5-c1c9-4ec6-a679-2ba0092714bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46a196a5-c1c9-4ec6-a679-2ba0092714bc', 2, 'III', 'Danse des comédiens. Allegro', 'Le Molière imaginaire – Ballet Suite: III. Danse des comédiens. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8263 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46a196a5-c1c9-4ec6-a679-2ba0092714bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'Danse du roi. Allegretto sostenuto', part.name_en = 'Le Molière imaginaire – Ballet Suite: V. Danse du roi. Allegretto sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8263 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:6604a9ed-8e17-4f33-b0a3-6754a45202c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6604a9ed-8e17-4f33-b0a3-6754a45202c6', 3, 'V', 'Danse du roi. Allegretto sostenuto', 'Le Molière imaginaire – Ballet Suite: V. Danse du roi. Allegretto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8263 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6604a9ed-8e17-4f33-b0a3-6754a45202c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Armande. Allegretto calmo', part.name_en = 'Le Molière imaginaire – Ballet Suite: IV. Armande. Allegretto calmo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8263 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:6da6abbb-cdfd-49b3-92be-0f7cd9db6fa0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6da6abbb-cdfd-49b3-92be-0f7cd9db6fa0', 4, 'IV', 'Armande. Allegretto calmo', 'Le Molière imaginaire – Ballet Suite: IV. Armande. Allegretto calmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8263 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6da6abbb-cdfd-49b3-92be-0f7cd9db6fa0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VI',
    part.name_ko = 'La Nature. Quasi Adagio – Un poco più animato, ma cantabile e rubato – Tempo I – Con maestà', part.name_en = 'Le Molière imaginaire – Ballet Suite: VI. La Nature. Quasi Adagio – Un poco più animato, ma cantabile e rubato – Tempo I – Con maestà',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8263 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:90f82171-b5e2-4703-9402-a6a18507cd94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90f82171-b5e2-4703-9402-a6a18507cd94', 5, 'VI', 'La Nature. Quasi Adagio – Un poco più animato, ma cantabile e rubato – Tempo I – Con maestà', 'Le Molière imaginaire – Ballet Suite: VI. La Nature. Quasi Adagio – Un poco più animato, ma cantabile e rubato – Tempo I – Con maestà', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8263 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90f82171-b5e2-4703-9402-a6a18507cd94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VII',
    part.name_ko = 'Pont Neuf, le Roi. Galop – Andante maestoso – Con solennità', part.name_en = 'Le Molière imaginaire – Ballet Suite: VII. Pont Neuf, le Roi. Galop – Andante maestoso – Con solennità',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8263 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:e82ec607-205a-490c-93e3-c1b76f1de7f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e82ec607-205a-490c-93e3-c1b76f1de7f5', 6, 'VII', 'Pont Neuf, le Roi. Galop – Andante maestoso – Con solennità', 'Le Molière imaginaire – Ballet Suite: VII. Pont Neuf, le Roi. Galop – Andante maestoso – Con solennità', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8263 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e82ec607-205a-490c-93e3-c1b76f1de7f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'II',
    part.name_ko = 'Molière. Andante – Animato non troppo – Tempo I – Animatissimo', part.name_en = 'Le Molière imaginaire – Ballet Suite: II. Molière. Andante – Animato non troppo – Tempo I – Animatissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8263 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:ff0b7860-7b7e-4f60-ace5-8accf5d071c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff0b7860-7b7e-4f60-ace5-8accf5d071c8', 7, 'II', 'Molière. Andante – Animato non troppo – Tempo I – Animatissimo', 'Le Molière imaginaire – Ballet Suite: II. Molière. Andante – Animato non troppo – Tempo I – Animatissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8263 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff0b7860-7b7e-4f60-ace5-8accf5d071c8'
);


-- None 영화음악 <Le notti di Cabiria>

UPDATE pieces piece
SET piece.title = '영화음악 <Le notti di Cabiria>', piece.title_en = 'Le notti di Cabiria',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9407 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nights of Cabiria', part.name_en = 'Nights of Cabiria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9407 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:13ce27d9-09c1-4033-a07c-9c4f7a7b33db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13ce27d9-09c1-4033-a07c-9c4f7a7b33db', 1, NULL, 'Nights of Cabiria', 'Nights of Cabiria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9407 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ce27d9-09c1-4033-a07c-9c4f7a7b33db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L’Illusionista (From "Le notti di Cabiria")', part.name_en = 'L’Illusionista (From "Le notti di Cabiria")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9407 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:df4856b5-a303-4635-812c-dc17e49394cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df4856b5-a303-4635-812c-dc17e49394cc', 2, NULL, 'L’Illusionista (From "Le notti di Cabiria")', 'L’Illusionista (From "Le notti di Cabiria")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9407 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df4856b5-a303-4635-812c-dc17e49394cc'
);


-- None 가곡 <Les Touristes>

UPDATE pieces piece
SET piece.title = '가곡 <Les Touristes>', piece.title_en = 'Les Touristes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7888 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lo Spiritismo nella vecchia casa

UPDATE pieces piece
SET piece.title = 'Lo Spiritismo nella vecchia casa', piece.title_en = 'Lo Spiritismo nella vecchia casa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9936 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Otto e mezzo - Suite

UPDATE pieces piece
SET piece.title = 'Otto e mezzo - Suite', piece.title_en = 'Otto e mezzo - Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11113 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sogno (Il cimitero)', part.name_en = 'Otto e mezzo - Suite: 2. Sogno (Il cimitero)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11113 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:1b3c2a5e-d6c2-48c1-9eb3-700bb31c3171' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b3c2a5e-d6c2-48c1-9eb3-700bb31c3171', 1, NULL, 'Sogno (Il cimitero)', 'Otto e mezzo - Suite: 2. Sogno (Il cimitero)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11113 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b3c2a5e-d6c2-48c1-9eb3-700bb31c3171'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Titoli', part.name_en = 'Otto e mezzo - Suite: 1. Titoli',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11113 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:3e860ac0-7bd2-40a0-9555-65e784bedfd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e860ac0-7bd2-40a0-9555-65e784bedfd1', 2, NULL, 'Titoli', 'Otto e mezzo - Suite: 1. Titoli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11113 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e860ac0-7bd2-40a0-9555-65e784bedfd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lo Sceicco d’Arabia', part.name_en = 'Otto e mezzo - Suite: 4. Lo Sceicco d’Arabia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11113 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:6e80c07b-a686-44ac-89cf-52847fe14397' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e80c07b-a686-44ac-89cf-52847fe14397', 3, NULL, 'Lo Sceicco d’Arabia', 'Otto e mezzo - Suite: 4. Lo Sceicco d’Arabia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11113 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e80c07b-a686-44ac-89cf-52847fe14397'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Carlotta’s gallop', part.name_en = 'Otto e mezzo - Suite: 5. Carlotta’s gallop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11113 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:babdfa6d-995a-48ac-9bb8-71054375977f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:babdfa6d-995a-48ac-9bb8-71054375977f', 4, NULL, 'Carlotta’s gallop', 'Otto e mezzo - Suite: 5. Carlotta’s gallop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11113 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:babdfa6d-995a-48ac-9bb8-71054375977f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Discesa ai fanghi', part.name_en = 'Otto e mezzo - Suite: 3. Discesa ai fanghi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11113 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:c8172489-cd70-4328-ad4f-53b903f59d33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8172489-cd70-4328-ad4f-53b903f59d33', 5, NULL, 'Discesa ai fanghi', 'Otto e mezzo - Suite: 3. Discesa ai fanghi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11113 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8172489-cd70-4328-ad4f-53b903f59d33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Passerella d’addio', part.name_en = 'Otto e mezzo - Suite: 6. Passerella d’addio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11113 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f63300c7-0068-4c42-8353-2768fd6ada71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f63300c7-0068-4c42-8353-2768fd6ada71', 6, NULL, 'Passerella d’addio', 'Otto e mezzo - Suite: 6. Passerella d’addio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11113 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f63300c7-0068-4c42-8353-2768fd6ada71'
);


-- None 피아노 협주곡 E단조 "Piccolo mondo antico"

UPDATE pieces piece
SET piece.title = '피아노 협주곡 E단조 "Piccolo mondo antico"', piece.title_en = 'Piano Concerto in E minor "Piccolo mondo antico"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8865 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro tranquillo', part.name_en = 'Piano Concerto in E minor "Piccolo mondo antico": I. Allegro tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8865 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:36e3267d-93f8-4c0a-b9dc-47b5837e6c1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36e3267d-93f8-4c0a-b9dc-47b5837e6c1c', 1, 'I', 'Allegro tranquillo', 'Piano Concerto in E minor "Piccolo mondo antico": I. Allegro tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8865 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36e3267d-93f8-4c0a-b9dc-47b5837e6c1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Piano Concerto in E minor "Piccolo mondo antico": II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8865 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:9817b768-8521-48b6-a9da-5c498e4722b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9817b768-8521-48b6-a9da-5c498e4722b3', 2, 'II', 'Andante sostenuto', 'Piano Concerto in E minor "Piccolo mondo antico": II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8865 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9817b768-8521-48b6-a9da-5c498e4722b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Piano Concerto in E minor "Piccolo mondo antico": III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8865 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:bed6ba3f-4225-4269-aa3b-e6667c3c6fbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bed6ba3f-4225-4269-aa3b-e6667c3c6fbf', 3, 'III', 'Allegro', 'Piano Concerto in E minor "Piccolo mondo antico": III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8865 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bed6ba3f-4225-4269-aa3b-e6667c3c6fbf'
);


-- None 폴카

UPDATE pieces piece
SET piece.title = '폴카', piece.title_en = 'Polka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10420 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Preludi per pianoforte

UPDATE pieces piece
SET piece.title = 'Preludi per pianoforte', piece.title_en = 'Preludi per pianoforte',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7568 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Preludi per pianoforte: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:104adde2-492c-4662-af4e-5b45694d9b03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:104adde2-492c-4662-af4e-5b45694d9b03', 1, NULL, 'No. 1', 'Preludi per pianoforte: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:104adde2-492c-4662-af4e-5b45694d9b03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Preludi per pianoforte: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:a4939198-5a2d-42ef-8af5-c1ab19906c0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4939198-5a2d-42ef-8af5-c1ab19906c0a', 2, NULL, 'No. 2', 'Preludi per pianoforte: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4939198-5a2d-42ef-8af5-c1ab19906c0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Preludi per pianoforte: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:e79737ba-79f9-4454-b38d-f1ba411038de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e79737ba-79f9-4454-b38d-f1ba411038de', 3, NULL, 'No. 3', 'Preludi per pianoforte: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e79737ba-79f9-4454-b38d-f1ba411038de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Preludi per pianoforte: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:2939712f-83e3-48e0-b887-583f82a02475' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2939712f-83e3-48e0-b887-583f82a02475', 4, NULL, 'No. 4', 'Preludi per pianoforte: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2939712f-83e3-48e0-b887-583f82a02475'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Preludi per pianoforte: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:8bc286db-e8d5-4de5-9586-65a362e29620' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bc286db-e8d5-4de5-9586-65a362e29620', 5, NULL, 'No. 5', 'Preludi per pianoforte: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bc286db-e8d5-4de5-9586-65a362e29620'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'Preludi per pianoforte: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:485d565e-8d8d-428e-b70e-041a3c154dbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:485d565e-8d8d-428e-b70e-041a3c154dbe', 6, NULL, 'No. 6', 'Preludi per pianoforte: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:485d565e-8d8d-428e-b70e-041a3c154dbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'No. 7', part.name_en = 'Preludi per pianoforte: No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:d8f8146b-6662-4d16-89bc-01738e1ac03e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8f8146b-6662-4d16-89bc-01738e1ac03e', 7, NULL, 'No. 7', 'Preludi per pianoforte: No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8f8146b-6662-4d16-89bc-01738e1ac03e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'No. 8', part.name_en = 'Preludi per pianoforte: No. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f216b9b2-9449-4d8b-9aac-6ca181d71990' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f216b9b2-9449-4d8b-9aac-6ca181d71990', 8, NULL, 'No. 8', 'Preludi per pianoforte: No. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f216b9b2-9449-4d8b-9aac-6ca181d71990'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'No. 9', part.name_en = 'Preludi per pianoforte: No. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:8dbb3b2b-7a69-4d77-8f03-22e60171b348' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dbb3b2b-7a69-4d77-8f03-22e60171b348', 9, NULL, 'No. 9', 'Preludi per pianoforte: No. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dbb3b2b-7a69-4d77-8f03-22e60171b348'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'No. 10', part.name_en = 'Preludi per pianoforte: No. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:e75238b3-adf4-4846-b99a-c8fd75fdcde1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e75238b3-adf4-4846-b99a-c8fd75fdcde1', 10, NULL, 'No. 10', 'Preludi per pianoforte: No. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e75238b3-adf4-4846-b99a-c8fd75fdcde1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'No. 11', part.name_en = 'Preludi per pianoforte: No. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:bae955cb-4082-45bb-a761-917c584a6b7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bae955cb-4082-45bb-a761-917c584a6b7f', 11, NULL, 'No. 11', 'Preludi per pianoforte: No. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bae955cb-4082-45bb-a761-917c584a6b7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'No. 12', part.name_en = 'Preludi per pianoforte: No. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:6795dcfd-2030-427a-9b5d-48767125051d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6795dcfd-2030-427a-9b5d-48767125051d', 12, NULL, 'No. 12', 'Preludi per pianoforte: No. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6795dcfd-2030-427a-9b5d-48767125051d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'No. 13', part.name_en = 'Preludi per pianoforte: No. 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:a246bb80-b677-4b20-b66f-407988fe0a55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a246bb80-b677-4b20-b66f-407988fe0a55', 13, NULL, 'No. 13', 'Preludi per pianoforte: No. 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a246bb80-b677-4b20-b66f-407988fe0a55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'No. 14', part.name_en = 'Preludi per pianoforte: No. 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:ffe3bc03-08bb-4544-a6b8-c4c22cda0435' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffe3bc03-08bb-4544-a6b8-c4c22cda0435', 14, NULL, 'No. 14', 'Preludi per pianoforte: No. 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffe3bc03-08bb-4544-a6b8-c4c22cda0435'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'No. 15', part.name_en = 'Preludi per pianoforte: No. 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7568 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:283ee5af-1359-4281-ae37-41d3a6dcf4b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:283ee5af-1359-4281-ae37-41d3a6dcf4b7', 15, NULL, 'No. 15', 'Preludi per pianoforte: No. 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7568 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:283ee5af-1359-4281-ae37-41d3a6dcf4b7'
);


-- None 플루트 5중주

UPDATE pieces piece
SET piece.title = '플루트 5중주', piece.title_en = 'Quintet for Flute, Oboe, Viola, Cello and Harp',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9325 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Quintet for Flute, Oboe, Viola, Cello and Harp - I. Allegro ben moderato', part.name_en = 'Quintet for Flute, Oboe, Viola, Cello and Harp - I. Allegro ben moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9325 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:1d03101f-6870-4f87-90c0-16bd94e9d143' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d03101f-6870-4f87-90c0-16bd94e9d143', 1, NULL, 'Quintet for Flute, Oboe, Viola, Cello and Harp - I. Allegro ben moderato', 'Quintet for Flute, Oboe, Viola, Cello and Harp - I. Allegro ben moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9325 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d03101f-6870-4f87-90c0-16bd94e9d143'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Quintet for Flute, Oboe, Viola, Cello and Harp - II. Adagio', part.name_en = 'Quintet for Flute, Oboe, Viola, Cello and Harp - II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9325 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:96745d2b-ac9d-46d5-82f6-0cef277873f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96745d2b-ac9d-46d5-82f6-0cef277873f4', 2, NULL, 'Quintet for Flute, Oboe, Viola, Cello and Harp - II. Adagio', 'Quintet for Flute, Oboe, Viola, Cello and Harp - II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9325 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96745d2b-ac9d-46d5-82f6-0cef277873f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Quintet for Flute, Oboe, Viola, Cello and Harp - III. Allegro vivace', part.name_en = 'Quintet for Flute, Oboe, Viola, Cello and Harp - III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9325 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f31d335d-b17f-4083-8e13-897352f32838' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f31d335d-b17f-4083-8e13-897352f32838', 3, NULL, 'Quintet for Flute, Oboe, Viola, Cello and Harp - III. Allegro vivace', 'Quintet for Flute, Oboe, Viola, Cello and Harp - III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9325 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f31d335d-b17f-4083-8e13-897352f32838'
);


-- None 영화 <로코와 그 형제들> 사운드트랙

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙', piece.title_en = 'Rocco e i suoi fratelli',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8843 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10021 AND linked.composer_id = 111),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduzione e canzone', part.name_en = 'Introduzione e canzone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:a2fda7b6-bd80-4c6e-94f1-f0b12779c812' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10021 AND linked.composer_id = 111), 'musicbrainz:a2fda7b6-bd80-4c6e-94f1-f0b12779c812', 1, NULL, 'Introduzione e canzone', 'Introduzione e canzone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2fda7b6-bd80-4c6e-94f1-f0b12779c812'
);

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙 중 "Introduzione e canzone"', piece.title_en = 'Rocco e i suoi fratelli: Introduzione e canzone', piece.editor_locked = 1
WHERE piece.id = 10021 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Terra lontana', part.name_en = 'Terra lontana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:13fa33d8-18c3-4e89-a5a0-944d40dbb7ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13fa33d8-18c3-4e89-a5a0-944d40dbb7ab', 2, NULL, 'Terra lontana', 'Terra lontana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13fa33d8-18c3-4e89-a5a0-944d40dbb7ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9051 AND linked.composer_id = 111),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Milano e Nadia', part.name_en = 'Milano e Nadia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:5d4899eb-7469-4738-ad4c-0270aba846f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9051 AND linked.composer_id = 111), 'musicbrainz:5d4899eb-7469-4738-ad4c-0270aba846f9', 3, NULL, 'Milano e Nadia', 'Milano e Nadia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d4899eb-7469-4738-ad4c-0270aba846f9'
);

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙 중 "Milano e Nadia"', piece.title_en = 'Rocco e i suoi fratelli: Milano e Nadia', piece.editor_locked = 1
WHERE piece.id = 9051 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9571 AND linked.composer_id = 111),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Valzer ai laghi', part.name_en = 'Valzer ai laghi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:82670571-5ea1-4108-8125-fa76e328c1b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9571 AND linked.composer_id = 111), 'musicbrainz:82670571-5ea1-4108-8125-fa76e328c1b8', 4, NULL, 'Valzer ai laghi', 'Valzer ai laghi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82670571-5ea1-4108-8125-fa76e328c1b8'
);

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙 중 "Valzer ai laghi"', piece.title_en = 'Rocco e i suoi fratelli: Valzer ai laghi', piece.editor_locked = 1
WHERE piece.id = 9571 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11137 AND linked.composer_id = 111),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'L’amore di Rocco', part.name_en = 'L’amore di Rocco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f5c92c76-cbae-48d8-bfeb-aa2a7d3b97a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11137 AND linked.composer_id = 111), 'musicbrainz:f5c92c76-cbae-48d8-bfeb-aa2a7d3b97a4', 5, NULL, 'L’amore di Rocco', 'L’amore di Rocco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5c92c76-cbae-48d8-bfeb-aa2a7d3b97a4'
);

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙 중 "L’amore di Rocco"', piece.title_en = 'Rocco e i suoi fratelli: L’amore di Rocco', piece.editor_locked = 1
WHERE piece.id = 11137 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11115 AND linked.composer_id = 111),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'La gelosia di Simone', part.name_en = 'La gelosia di Simone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f49e1cb6-2542-478e-a82d-b203ea4fa030' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11115 AND linked.composer_id = 111), 'musicbrainz:f49e1cb6-2542-478e-a82d-b203ea4fa030', 6, NULL, 'La gelosia di Simone', 'La gelosia di Simone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f49e1cb6-2542-478e-a82d-b203ea4fa030'
);

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙 중 "La gelosia di Simone"', piece.title_en = 'Rocco e i suoi fratelli: La gelosia di Simone', piece.editor_locked = 1
WHERE piece.id = 11115 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10795 AND linked.composer_id = 111),
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Come tu vuoi', part.name_en = 'Come tu vuoi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:dc51d6ef-1812-4dcb-9c56-ffdd9f342e30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10795 AND linked.composer_id = 111), 'musicbrainz:dc51d6ef-1812-4dcb-9c56-ffdd9f342e30', 7, NULL, 'Come tu vuoi', 'Come tu vuoi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc51d6ef-1812-4dcb-9c56-ffdd9f342e30'
);

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙 중 "Come tu vuoi"', piece.title_en = 'Rocco e i suoi fratelli: Come tu vuoi', piece.editor_locked = 1
WHERE piece.id = 10795 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11064 AND linked.composer_id = 111),
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'L’amore dei due fratelli', part.name_en = 'L’amore dei due fratelli',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:effbd668-066a-468c-8aa3-ebaa62bb40d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11064 AND linked.composer_id = 111), 'musicbrainz:effbd668-066a-468c-8aa3-ebaa62bb40d1', 8, NULL, 'L’amore dei due fratelli', 'L’amore dei due fratelli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:effbd668-066a-468c-8aa3-ebaa62bb40d1'
);

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙 중 "L’amore dei due fratelli"', piece.title_en = 'Rocco e i suoi fratelli: L’amore dei due fratelli', piece.editor_locked = 1
WHERE piece.id = 11064 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8316 AND linked.composer_id = 111),
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Il delitto di Simone', part.name_en = 'Il delitto di Simone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:2a740a0f-7a58-40e4-a636-c9b55e3f0477' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8316 AND linked.composer_id = 111), 'musicbrainz:2a740a0f-7a58-40e4-a636-c9b55e3f0477', 9, NULL, 'Il delitto di Simone', 'Il delitto di Simone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a740a0f-7a58-40e4-a636-c9b55e3f0477'
);

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙 중 "Il delitto di Simone"', piece.title_en = 'Rocco e i suoi fratelli: Il delitto di Simone', piece.editor_locked = 1
WHERE piece.id = 8316 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10790 AND linked.composer_id = 111),
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Paese mio', part.name_en = 'Paese mio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:db81e9c6-28c8-4b5e-9660-a6d35db12afd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10790 AND linked.composer_id = 111), 'musicbrainz:db81e9c6-28c8-4b5e-9660-a6d35db12afd', 10, NULL, 'Paese mio', 'Paese mio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db81e9c6-28c8-4b5e-9660-a6d35db12afd'
);

UPDATE pieces piece
SET piece.title = '영화 <로코와 그 형제들> 사운드트랙 중 "Paese mio"', piece.title_en = 'Rocco e i suoi fratelli: Paese mio', piece.editor_locked = 1
WHERE piece.id = 10790 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Terra lontana', part.name_en = 'Terra lontana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8843 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:101c1497-4435-4627-92b4-fae73db5ce0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:101c1497-4435-4627-92b4-fae73db5ce0f', 11, NULL, 'Terra lontana', 'Terra lontana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8843 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:101c1497-4435-4627-92b4-fae73db5ce0f'
);


-- None 영화 <로미오와 줄리엣 (1968)> 사운드트랙

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A Renaissance Timepiece', part.name_en = 'Romeo and Juliet: A Renaissance Timepiece',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 417 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:b416d7b8-71a4-4a93-ad5d-832fb25f8a64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b416d7b8-71a4-4a93-ad5d-832fb25f8a64', 1, NULL, 'A Renaissance Timepiece', 'Romeo and Juliet: A Renaissance Timepiece', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 417 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b416d7b8-71a4-4a93-ad5d-832fb25f8a64'
);


-- None 가곡 <Romeo e Giulietta>

UPDATE pieces piece
SET piece.title = '가곡 <Romeo e Giulietta>', piece.title_en = 'Romeo e Giulietta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9930 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sarabanda e Toccata per Arpa

UPDATE pieces piece
SET piece.title = 'Sarabanda e Toccata per Arpa', piece.title_en = 'Sarabanda e Toccata per Arpa',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10428 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sarabanda', part.name_en = 'Sarabanda e Toccata per Arpa: Sarabanda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10428 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:d99be9c0-ccd0-4285-9dc4-439e9623509b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d99be9c0-ccd0-4285-9dc4-439e9623509b', 1, NULL, 'Sarabanda', 'Sarabanda e Toccata per Arpa: Sarabanda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10428 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d99be9c0-ccd0-4285-9dc4-439e9623509b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Toccata', part.name_en = 'Sarabanda e Toccata per Arpa: Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10428 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:df962713-90cb-418a-9da8-4c5e10bdbd9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df962713-90cb-418a-9da8-4c5e10bdbd9b', 2, NULL, 'Toccata', 'Sarabanda e Toccata per Arpa: Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10428 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df962713-90cb-418a-9da8-4c5e10bdbd9b'
);


-- None Sette Pezzi Difficili per Bambini

UPDATE pieces piece
SET piece.title = 'Sette Pezzi Difficili per Bambini', piece.title_en = 'Sette Pezzi Difficili per Bambini',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10359 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Salti e gioci', part.name_en = 'Sette Pezzi Difficili per Bambini: No. 1. Salti e gioci',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10359 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:14f6232b-279b-40e3-bbf7-2ab56f64e4ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14f6232b-279b-40e3-bbf7-2ab56f64e4ca', 1, NULL, 'Salti e gioci', 'Sette Pezzi Difficili per Bambini: No. 1. Salti e gioci', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10359 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14f6232b-279b-40e3-bbf7-2ab56f64e4ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Grillo notturno', part.name_en = 'Sette Pezzi Difficili per Bambini: No. 2. Grillo notturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10359 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:3201501f-e398-4d14-92e6-8af8e958fa16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3201501f-e398-4d14-92e6-8af8e958fa16', 2, NULL, 'Grillo notturno', 'Sette Pezzi Difficili per Bambini: No. 2. Grillo notturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10359 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3201501f-e398-4d14-92e6-8af8e958fa16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Capriccio, Cantilena', part.name_en = 'Sette Pezzi Difficili per Bambini: No. 3. Capriccio, Cantilena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10359 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:c245eab5-90c1-44a9-9366-babfa3b16dc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c245eab5-90c1-44a9-9366-babfa3b16dc5', 3, NULL, 'Capriccio, Cantilena', 'Sette Pezzi Difficili per Bambini: No. 3. Capriccio, Cantilena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10359 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c245eab5-90c1-44a9-9366-babfa3b16dc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le scalette', part.name_en = 'Sette Pezzi Difficili per Bambini: No. 4. Le scalette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10359 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f296e3e0-cb9a-4a98-9bc5-adac2cee983e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f296e3e0-cb9a-4a98-9bc5-adac2cee983e', 4, NULL, 'Le scalette', 'Sette Pezzi Difficili per Bambini: No. 4. Le scalette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10359 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f296e3e0-cb9a-4a98-9bc5-adac2cee983e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Puccettino nella giungla', part.name_en = 'Sette Pezzi Difficili per Bambini: No. 5. Puccettino nella giungla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10359 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:a3efd27d-042b-499b-8056-ed4ab9c0910f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3efd27d-042b-499b-8056-ed4ab9c0910f', 5, NULL, 'Puccettino nella giungla', 'Sette Pezzi Difficili per Bambini: No. 5. Puccettino nella giungla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10359 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3efd27d-042b-499b-8056-ed4ab9c0910f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'L''acrobata', part.name_en = 'Sette Pezzi Difficili per Bambini: No. 6. L''acrobata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10359 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:dde007a0-43ee-486d-b086-251da4cae3f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dde007a0-43ee-486d-b086-251da4cae3f1', 6, NULL, 'L''acrobata', 'Sette Pezzi Difficili per Bambini: No. 6. L''acrobata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10359 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dde007a0-43ee-486d-b086-251da4cae3f1'
);


-- None Sinfonia sopra una canzone d'amore

UPDATE pieces piece
SET piece.title = 'Sinfonia sopra una canzone d''amore', piece.title_en = 'Sinfonia sopra una canzone d''amore',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8770 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sinfonia sopra una canzone d''amore: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8770 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:c418ad64-3976-464a-962c-6ca58ce73eaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c418ad64-3976-464a-962c-6ca58ce73eaa', 1, 'I', 'Allegro', 'Sinfonia sopra una canzone d''amore: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8770 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c418ad64-3976-464a-962c-6ca58ce73eaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo. Allegro vivace', part.name_en = 'Sinfonia sopra una canzone d''amore: II. Scherzo. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8770 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:5fe662d0-eaaa-49ce-bc3d-289390ced1ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fe662d0-eaaa-49ce-bc3d-289390ced1ff', 2, 'II', 'Scherzo. Allegro vivace', 'Sinfonia sopra una canzone d''amore: II. Scherzo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8770 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fe662d0-eaaa-49ce-bc3d-289390ced1ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Sinfonia sopra una canzone d''amore: III. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8770 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:c1d7d3ff-6de1-41d2-89fd-0d4624c33c3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1d7d3ff-6de1-41d2-89fd-0d4624c33c3b', 3, 'III', 'Andante sostenuto', 'Sinfonia sopra una canzone d''amore: III. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8770 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1d7d3ff-6de1-41d2-89fd-0d4624c33c3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro impetuoso', part.name_en = 'Sinfonia sopra una canzone d''amore: IV. Finale. Allegro impetuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8770 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:2528dce4-4a84-4b1a-8afd-9f7d80429ad3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2528dce4-4a84-4b1a-8afd-9f7d80429ad3', 4, 'IV', 'Finale. Allegro impetuoso', 'Sinfonia sopra una canzone d''amore: IV. Finale. Allegro impetuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8770 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2528dce4-4a84-4b1a-8afd-9f7d80429ad3'
);


-- None 플루트와 하프를 위한 소나타

UPDATE pieces piece
SET piece.title = '플루트와 하프를 위한 소나타', piece.title_en = 'Sonata for Flute and Harp',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11149 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto moderato', part.name_en = 'Sonata for Flute and Harp: I. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11149 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:9fc3e874-3d8f-4ce4-a531-7849ffe2c467' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fc3e874-3d8f-4ce4-a531-7849ffe2c467', 1, 'I', 'Allegro molto moderato', 'Sonata for Flute and Harp: I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11149 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc3e874-3d8f-4ce4-a531-7849ffe2c467'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Sonata for Flute and Harp: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11149 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:9d113b5b-cf3c-4dd0-88be-e0c8c7d4f793' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d113b5b-cf3c-4dd0-88be-e0c8c7d4f793', 2, 'II', 'Andante sostenuto', 'Sonata for Flute and Harp: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11149 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d113b5b-cf3c-4dd0-88be-e0c8c7d4f793'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro festoso', part.name_en = 'Sonata for Flute and Harp: III. Allegro festoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11149 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:566e1e60-78e7-4078-8901-f4726ed33bbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:566e1e60-78e7-4078-8901-f4726ed33bbe', 3, 'III', 'Allegro festoso', 'Sonata for Flute and Harp: III. Allegro festoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11149 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:566e1e60-78e7-4078-8901-f4726ed33bbe'
);


-- None 비올라와 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '비올라와 피아노를 위한 소나타', piece.title_en = 'Sonata for Viola and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8816 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto scorrevole', part.name_en = 'Sonata for Viola and Piano: I. Allegretto scorrevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8816 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:840dffb2-8a67-423c-9734-c9b9572c72ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:840dffb2-8a67-423c-9734-c9b9572c72ad', 1, 'I', 'Allegretto scorrevole', 'Sonata for Viola and Piano: I. Allegretto scorrevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8816 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:840dffb2-8a67-423c-9734-c9b9572c72ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Sonata for Viola and Piano: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8816 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:4958f185-dcef-4732-9a6c-1e07247552dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4958f185-dcef-4732-9a6c-1e07247552dd', 2, 'II', 'Andante sostenuto', 'Sonata for Viola and Piano: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8816 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4958f185-dcef-4732-9a6c-1e07247552dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro scorrevole', part.name_en = 'Sonata for Viola and Piano: III. Allegro scorrevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8816 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:d0724991-bb03-417f-a270-4d41115c9a28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0724991-bb03-417f-a270-4d41115c9a28', 3, 'III', 'Allegro scorrevole', 'Sonata for Viola and Piano: III. Allegro scorrevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8816 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0724991-bb03-417f-a270-4d41115c9a28'
);


-- None Sonata in re per clarinetto e pianoforte

UPDATE pieces piece
SET piece.title = 'Sonata in re per clarinetto e pianoforte', piece.title_en = 'Sonata in re per clarinetto e pianoforte',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10384 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto scorrevole', part.name_en = 'Sonata in re per clarinetto e pianoforte: I. Allegretto scorrevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10384 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:80d4cd8d-53bc-4839-87fd-346a34f65621' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80d4cd8d-53bc-4839-87fd-346a34f65621', 1, 'I', 'Allegretto scorrevole', 'Sonata in re per clarinetto e pianoforte: I. Allegretto scorrevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10384 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80d4cd8d-53bc-4839-87fd-346a34f65621'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante (quasi adagio)', part.name_en = 'Sonata in re per clarinetto e pianoforte: II. Andante (quasi adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10384 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:9803742d-74f2-40c4-affe-f5cddad8d6ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9803742d-74f2-40c4-affe-f5cddad8d6ae', 2, 'II', 'Andante (quasi adagio)', 'Sonata in re per clarinetto e pianoforte: II. Andante (quasi adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10384 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9803742d-74f2-40c4-affe-f5cddad8d6ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro scorrevole', part.name_en = 'Sonata in re per clarinetto e pianoforte: III. Allegro scorrevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10384 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:8ccb88bb-5087-4385-a91e-6c2f79b741a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ccb88bb-5087-4385-a91e-6c2f79b741a8', 3, 'III', 'Allegro scorrevole', 'Sonata in re per clarinetto e pianoforte: III. Allegro scorrevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10384 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ccb88bb-5087-4385-a91e-6c2f79b741a8'
);


-- None Sonata per Organo

UPDATE pieces piece
SET piece.title = 'Sonata per Organo', piece.title_en = 'Sonata per Organo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8444 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro giusto', part.name_en = 'Sonata per Organo: I. Allegro giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8444 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:7271a300-3922-40a9-9d50-a9b53739466e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7271a300-3922-40a9-9d50-a9b53739466e', 1, 'I', 'Allegro giusto', 'Sonata per Organo: I. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8444 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7271a300-3922-40a9-9d50-a9b53739466e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Sonata per Organo: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8444 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:2ec7da8f-e059-40a0-b02b-7e5dd4dfb669' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ec7da8f-e059-40a0-b02b-7e5dd4dfb669', 2, 'II', 'Adagio', 'Sonata per Organo: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8444 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ec7da8f-e059-40a0-b02b-7e5dd4dfb669'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto calmo con grazia', part.name_en = 'Sonata per Organo: III. Allegretto calmo con grazia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8444 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:e9ce263f-9655-42da-a0e6-1144dad62e30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9ce263f-9655-42da-a0e6-1144dad62e30', 3, 'III', 'Allegretto calmo con grazia', 'Sonata per Organo: III. Allegretto calmo con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8444 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9ce263f-9655-42da-a0e6-1144dad62e30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Sonata per Organo: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8444 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:ba205ba1-3a06-4e07-a098-80a49543ae3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba205ba1-3a06-4e07-a098-80a49543ae3a', 4, 'IV', 'Allegro', 'Sonata per Organo: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8444 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba205ba1-3a06-4e07-a098-80a49543ae3a'
);


-- None 현악 4중주

UPDATE pieces piece
SET piece.title = '현악 4중주', piece.title_en = 'String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8345 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'String Quartet - I. Allegro moderato', part.name_en = 'String Quartet - I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8345 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:010fa722-3ab6-4cc8-9a8c-2fad49f2725b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:010fa722-3ab6-4cc8-9a8c-2fad49f2725b', 1, NULL, 'String Quartet - I. Allegro moderato', 'String Quartet - I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8345 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:010fa722-3ab6-4cc8-9a8c-2fad49f2725b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'String Quartet - II. Adagio', part.name_en = 'String Quartet - II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8345 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:7a0af111-32d8-472a-a450-c9678f73c7a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a0af111-32d8-472a-a450-c9678f73c7a3', 2, NULL, 'String Quartet - II. Adagio', 'String Quartet - II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8345 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a0af111-32d8-472a-a450-c9678f73c7a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'String Quartet - III. Allegro robusto', part.name_en = 'String Quartet - III. Allegro robusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8345 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:d423cdbd-eb4b-43f4-b6ac-79fb9af0ed54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d423cdbd-eb4b-43f4-b6ac-79fb9af0ed54', 3, NULL, 'String Quartet - III. Allegro robusto', 'String Quartet - III. Allegro robusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8345 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d423cdbd-eb4b-43f4-b6ac-79fb9af0ed54'
);


-- None 교향곡 1번 G장조

UPDATE pieces piece
SET piece.title = '교향곡 1번 G장조', piece.title_en = 'Symphony no. 1 in G major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11140 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con moto', part.name_en = 'Symphony no. 1 in G major: I. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11140 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:a6afb4e0-d262-4e81-b722-b63eef4547f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6afb4e0-d262-4e81-b722-b63eef4547f0', 1, 'I', 'Allegro con moto', 'Symphony no. 1 in G major: I. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11140 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6afb4e0-d262-4e81-b722-b63eef4547f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 1 in G major: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11140 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:cb85d5d3-4d62-4a18-abcf-b9832feb1c61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb85d5d3-4d62-4a18-abcf-b9832feb1c61', 2, 'II', 'Andante', 'Symphony no. 1 in G major: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11140 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb85d5d3-4d62-4a18-abcf-b9832feb1c61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace', part.name_en = 'Symphony no. 1 in G major: III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11140 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:6756b778-e0b7-4378-973b-872d97cc9058' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6756b778-e0b7-4378-973b-872d97cc9058', 3, 'III', 'Allegro vivace', 'Symphony no. 1 in G major: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11140 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6756b778-e0b7-4378-973b-872d97cc9058'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Largo maestoso - Poco più andante - Allegro', part.name_en = 'Symphony no. 1 in G major: IV. Largo maestoso - Poco più andante - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11140 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:f6d538d0-de2f-4ed4-88e2-46fbb3a7f1ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6d538d0-de2f-4ed4-88e2-46fbb3a7f1ac', 4, 'IV', 'Largo maestoso - Poco più andante - Allegro', 'Symphony no. 1 in G major: IV. Largo maestoso - Poco più andante - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11140 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6d538d0-de2f-4ed4-88e2-46fbb3a7f1ac'
);


-- None 교향곡 3번 C장조

UPDATE pieces piece
SET piece.title = '교향곡 3번 C장조', piece.title_en = 'Symphony no. 3 in C major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8999 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 3 in C major: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8999 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:1ca3e7cc-3efb-4199-b0cd-bafd7bcf2d4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ca3e7cc-3efb-4199-b0cd-bafd7bcf2d4e', 1, 'I', 'Allegro', 'Symphony no. 3 in C major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8999 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ca3e7cc-3efb-4199-b0cd-bafd7bcf2d4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio con moto – Poco più mosso – Calmando – Tempo I', part.name_en = 'Symphony no. 3 in C major: II. Adagio con moto – Poco più mosso – Calmando – Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8999 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:08f8e4ab-57bd-4b8f-8b9f-2704e46dd69b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08f8e4ab-57bd-4b8f-8b9f-2704e46dd69b', 2, 'II', 'Adagio con moto – Poco più mosso – Calmando – Tempo I', 'Symphony no. 3 in C major: II. Adagio con moto – Poco più mosso – Calmando – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8999 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08f8e4ab-57bd-4b8f-8b9f-2704e46dd69b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Allegretto mosso – Trio – Con anima – [Scherzo. Allegretto mosso]', part.name_en = 'Symphony no. 3 in C major: III. Scherzo. Allegretto mosso – Trio – Con anima – [Scherzo. Allegretto mosso]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8999 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:e61ce3a4-4a02-4747-8fb6-4307562f7c7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e61ce3a4-4a02-4747-8fb6-4307562f7c7d', 3, 'III', 'Scherzo. Allegretto mosso – Trio – Con anima – [Scherzo. Allegretto mosso]', 'Symphony no. 3 in C major: III. Scherzo. Allegretto mosso – Trio – Con anima – [Scherzo. Allegretto mosso]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8999 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e61ce3a4-4a02-4747-8fb6-4307562f7c7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace con spirito', part.name_en = 'Symphony no. 3 in C major: IV. Vivace con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8999 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:c882f92f-f429-4eb4-a9e9-e36a9b3cf481' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c882f92f-f429-4eb4-a9e9-e36a9b3cf481', 4, 'IV', 'Vivace con spirito', 'Symphony no. 3 in C major: IV. Vivace con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8999 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c882f92f-f429-4eb4-a9e9-e36a9b3cf481'
);


-- None 영화음악 <The Glass Mountain>

UPDATE pieces piece
SET piece.title = '영화음악 <The Glass Mountain>', piece.title_en = 'The Glass Mountain',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7503 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Legend of the Glass Mountain', part.name_en = 'Legend of the Glass Mountain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7503 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:0313aa14-d3e9-4b74-99c8-6880a1efab14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0313aa14-d3e9-4b74-99c8-6880a1efab14', 1, NULL, 'Legend of the Glass Mountain', 'Legend of the Glass Mountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7503 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0313aa14-d3e9-4b74-99c8-6880a1efab14'
);


-- None 영화 <대부> 사운드트랙

UPDATE pieces piece
SET piece.title = '영화 <대부> 사운드트랙', piece.title_en = 'The Godfather: Music From the Original Motion Picture Soundtrack',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10553 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Godfather Waltz', part.name_en = 'The Godfather Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10553 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:a91b7fc7-959d-3808-b866-7d8cf1388130' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a91b7fc7-959d-3808-b866-7d8cf1388130', 1, NULL, 'The Godfather Waltz', 'The Godfather Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10553 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a91b7fc7-959d-3808-b866-7d8cf1388130'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9189 AND linked.composer_id = 111),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Pickup', part.name_en = 'The Pickup',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10553 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:67d896ef-0bda-3d02-833a-bc7634330751' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9189 AND linked.composer_id = 111), 'musicbrainz:67d896ef-0bda-3d02-833a-bc7634330751', 2, NULL, 'The Pickup', 'The Pickup', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10553 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67d896ef-0bda-3d02-833a-bc7634330751'
);

UPDATE pieces piece
SET piece.title = '영화 <대부> 사운드트랙 중 "The Pickup"', piece.title_en = 'The Godfather: Music From the Original Motion Picture Soundtrack: The Pickup', piece.editor_locked = 1
WHERE piece.id = 9189 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 7830 AND linked.composer_id = 111),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Halls of Fear', part.name_en = 'The Halls of Fear',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10553 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:0699e848-9509-3885-bed6-a5d0e4d9de6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7830 AND linked.composer_id = 111), 'musicbrainz:0699e848-9509-3885-bed6-a5d0e4d9de6c', 3, NULL, 'The Halls of Fear', 'The Halls of Fear', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10553 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0699e848-9509-3885-bed6-a5d0e4d9de6c'
);

UPDATE pieces piece
SET piece.title = '영화 <대부> 사운드트랙 중 "The Halls of Fear"', piece.title_en = 'The Godfather: Music From the Original Motion Picture Soundtrack: The Halls of Fear', piece.editor_locked = 1
WHERE piece.id = 7830 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10933 AND linked.composer_id = 111),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sicilian Pastorale', part.name_en = 'Sicilian Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10553 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:e6f95136-82bc-387f-9a94-26d65ee7d7c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10933 AND linked.composer_id = 111), 'musicbrainz:e6f95136-82bc-387f-9a94-26d65ee7d7c9', 4, NULL, 'Sicilian Pastorale', 'Sicilian Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10553 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6f95136-82bc-387f-9a94-26d65ee7d7c9'
);

UPDATE pieces piece
SET piece.title = '영화 <대부> 사운드트랙 중 "Sicilian Pastorale"', piece.title_en = 'The Godfather: Music From the Original Motion Picture Soundtrack: Sicilian Pastorale', piece.editor_locked = 1
WHERE piece.id = 10933 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 416 AND linked.composer_id = 111),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Love Theme from The Godfather', part.name_en = 'Love Theme from The Godfather',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10553 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:4b89cae1-775a-3fae-b74c-564b87a3681f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 416 AND linked.composer_id = 111), 'musicbrainz:4b89cae1-775a-3fae-b74c-564b87a3681f', 5, NULL, 'Love Theme from The Godfather', 'Love Theme from The Godfather', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10553 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b89cae1-775a-3fae-b74c-564b87a3681f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9117 AND linked.composer_id = 111),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Apollonia', part.name_en = 'Apollonia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10553 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:61f96976-6733-3b17-8407-9c3f38ab9e14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9117 AND linked.composer_id = 111), 'musicbrainz:61f96976-6733-3b17-8407-9c3f38ab9e14', 6, NULL, 'Apollonia', 'Apollonia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10553 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61f96976-6733-3b17-8407-9c3f38ab9e14'
);

UPDATE pieces piece
SET piece.title = '영화 <대부> 사운드트랙 중 "Apollonia"', piece.title_en = 'The Godfather: Music From the Original Motion Picture Soundtrack: Apollonia', piece.editor_locked = 1
WHERE piece.id = 9117 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 7911 AND linked.composer_id = 111),
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The New Godfather', part.name_en = 'The New Godfather',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10553 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:0bd835d2-d9cd-3689-8b1d-5765c6259989' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7911 AND linked.composer_id = 111), 'musicbrainz:0bd835d2-d9cd-3689-8b1d-5765c6259989', 7, NULL, 'The New Godfather', 'The New Godfather', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10553 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bd835d2-d9cd-3689-8b1d-5765c6259989'
);

UPDATE pieces piece
SET piece.title = '영화 <대부> 사운드트랙 중 "The New Godfather"', piece.title_en = 'The Godfather: Music From the Original Motion Picture Soundtrack: The New Godfather', piece.editor_locked = 1
WHERE piece.id = 7911 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9843 AND linked.composer_id = 111),
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Baptism', part.name_en = 'The Baptism',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10553 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:967c53f2-5346-38cf-90c0-1b5efa1b058f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9843 AND linked.composer_id = 111), 'musicbrainz:967c53f2-5346-38cf-90c0-1b5efa1b058f', 8, NULL, 'The Baptism', 'The Baptism', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10553 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:967c53f2-5346-38cf-90c0-1b5efa1b058f'
);

UPDATE pieces piece
SET piece.title = '영화 <대부> 사운드트랙 중 "The Baptism"', piece.title_en = 'The Godfather: Music From the Original Motion Picture Soundtrack: The Baptism', piece.editor_locked = 1
WHERE piece.id = 9843 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Godfather Finale', part.name_en = 'The Godfather Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10553 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:06cd0194-bf50-3698-81e3-7d4e6d03c4c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06cd0194-bf50-3698-81e3-7d4e6d03c4c6', 9, NULL, 'The Godfather Finale', 'The Godfather Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10553 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06cd0194-bf50-3698-81e3-7d4e6d03c4c6'
);


-- None Trio for Clarinet, Cello and Piano

UPDATE pieces piece
SET piece.title = 'Trio for Clarinet, Cello and Piano', piece.title_en = 'Trio for Clarinet, Cello and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10289 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Trio for Clarinet, Cello and Piano: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:b00230fe-6d36-40b4-8f75-9f9fa2acf1f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b00230fe-6d36-40b4-8f75-9f9fa2acf1f1', 1, 'I', 'Allegro', 'Trio for Clarinet, Cello and Piano: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b00230fe-6d36-40b4-8f75-9f9fa2acf1f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Trio for Clarinet, Cello and Piano: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:68cceb63-a88d-4a0f-a15b-c32d9652b8df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68cceb63-a88d-4a0f-a15b-c32d9652b8df', 2, 'II', 'Andante', 'Trio for Clarinet, Cello and Piano: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68cceb63-a88d-4a0f-a15b-c32d9652b8df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegrissimo', part.name_en = 'Trio for Clarinet, Cello and Piano: III. Allegrissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10289 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:152c2c88-94e2-4ec7-8f15-77fdf87539f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:152c2c88-94e2-4ec7-8f15-77fdf87539f9', 3, 'III', 'Allegrissimo', 'Trio for Clarinet, Cello and Piano: III. Allegrissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10289 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:152c2c88-94e2-4ec7-8f15-77fdf87539f9'
);


-- None Trio per Flauto, Violino e Pianoforte

UPDATE pieces piece
SET piece.title = 'Trio per Flauto, Violino e Pianoforte', piece.title_en = 'Trio per Flauto, Violino e Pianoforte',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7626 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'Trio per Flauto, Violino e Pianoforte: I. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7626 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:8bc9a409-8520-425d-ba30-88fed58e43aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bc9a409-8520-425d-ba30-88fed58e43aa', 1, 'I', 'Allegro ma non troppo', 'Trio per Flauto, Violino e Pianoforte: I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7626 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bc9a409-8520-425d-ba30-88fed58e43aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Trio per Flauto, Violino e Pianoforte: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7626 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:9be29db0-e222-4209-a66a-82215c57c986' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9be29db0-e222-4209-a66a-82215c57c986', 2, 'II', 'Andante sostenuto', 'Trio per Flauto, Violino e Pianoforte: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7626 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9be29db0-e222-4209-a66a-82215c57c986'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace con spirito', part.name_en = 'Trio per Flauto, Violino e Pianoforte: III. Allegro vivace con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7626 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:89338a14-9030-445b-9322-144ecfaf8486' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89338a14-9030-445b-9322-144ecfaf8486', 3, 'III', 'Allegro vivace con spirito', 'Trio per Flauto, Violino e Pianoforte: III. Allegro vivace con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7626 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89338a14-9030-445b-9322-144ecfaf8486'
);


-- None Valzer sul nome Bach

UPDATE pieces piece
SET piece.title = 'Valzer sul nome Bach', piece.title_en = 'Valzer sul nome Bach',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10446 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Circus‐Valzer', part.name_en = 'Valzer sul nome Bach: No. 1. Circus‐Valzer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10446 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:76920a7e-192b-447e-81f2-d456989a3fcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76920a7e-192b-447e-81f2-d456989a3fcb', 1, NULL, 'Circus‐Valzer', 'Valzer sul nome Bach: No. 1. Circus‐Valzer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10446 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76920a7e-192b-447e-81f2-d456989a3fcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Valzer‐Carillon', part.name_en = 'Valzer sul nome Bach: No. 2. Valzer‐Carillon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10446 AND p.composer_id = 111 AND part.part_key = 'musicbrainz:8b766361-98ec-4219-9b73-f633601f040d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b766361-98ec-4219-9b73-f633601f040d', 2, NULL, 'Valzer‐Carillon', 'Valzer sul nome Bach: No. 2. Valzer‐Carillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10446 AND p.composer_id = 111
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b766361-98ec-4219-9b73-f633601f040d'
);


-- None 가곡 <Yol Ver>

UPDATE pieces piece
SET piece.title = '가곡 <Yol Ver>', piece.title_en = 'Yol Ver',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11071 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Скажи, что любишь>

UPDATE pieces piece
SET piece.title = '가곡 <Скажи, что любишь>', piece.title_en = 'Скажи, что любишь',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8418 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 갤럽

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽', 'Galop', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48007459-77db-49a4-a460-9f8d8734f2fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48007459-77db-49a4-a460-9f8d8734f2fa'
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '갤럽' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48007459-77db-49a4-a460-9f8d8734f2fa'
);


-- None 마주르카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마주르카', 'Mazurka', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마주르카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3170f81a-880b-41c1-ad01-2897ce657f44'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3170f81a-880b-41c1-ad01-2897ce657f44'
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '마주르카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3170f81a-880b-41c1-ad01-2897ce657f44'
);


-- None Nonetto

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Nonetto', 'Nonetto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Nonetto'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a3d9c3f-8481-488f-a3a4-7e7314736aa1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a3d9c3f-8481-488f-a3a4-7e7314736aa1'
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Nonetto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a3d9c3f-8481-488f-a3a4-7e7314736aa1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6745f856-6968-4566-acc5-72bbe83327d1', 1, 'I', 'Allegro', 'Nonetto: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Nonetto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6745f856-6968-4566-acc5-72bbe83327d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b17e3dca-1bb7-42cf-bc46-bb85139f15a9', 2, 'II', 'Andante', 'Nonetto: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Nonetto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17e3dca-1bb7-42cf-bc46-bb85139f15a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c12957dc-a94f-4d01-a08c-cfcfa0d46eaa', 3, 'III', 'Allegro con spirito', 'Nonetto: III. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Nonetto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c12957dc-a94f-4d01-a08c-cfcfa0d46eaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7feebe7-ab70-4ab1-98f3-e109044777f0', 4, 'IV', 'Canzone con variazoni', 'Nonetto: IV. Canzone con variazoni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Nonetto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7feebe7-ab70-4ab1-98f3-e109044777f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f878cdde-2ecf-4eb2-a9c5-c70a2c000853', 5, 'V', 'Vivacissimo', 'Nonetto: V. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Nonetto' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f878cdde-2ecf-4eb2-a9c5-c70a2c000853'
);


-- None 피아노 협주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 C장조', 'Piano Concerto in C major', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdc0c606-473d-4295-a486-7d96a95f0530'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fdc0c606-473d-4295-a486-7d96a95f0530'
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdc0c606-473d-4295-a486-7d96a95f0530'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73f39d93-2ec1-4ef9-8adb-d614e5556955', 1, 'I', 'Allegro moderato e cantabile', 'Piano Concerto in C major: I. Allegro moderato e cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73f39d93-2ec1-4ef9-8adb-d614e5556955'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b164195-db60-4e88-82e5-f372a6d37971', 2, 'II', 'Arietta con variazioni. Andantino cantabile', 'Piano Concerto in C major: II. Arietta con variazioni. Andantino cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b164195-db60-4e88-82e5-f372a6d37971'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74b3ee05-afe9-4fa3-9eef-7e7a1b54cc7e', 3, 'III', 'Allegro non troppo', 'Piano Concerto in C major: III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '피아노 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74b3ee05-afe9-4fa3-9eef-7e7a1b54cc7e'
);


-- None 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡', 'Prelude', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04e146ae-1c17-456c-bbe0-958dcf4c278d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '04e146ae-1c17-456c-bbe0-958dcf4c278d'
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04e146ae-1c17-456c-bbe0-958dcf4c278d'
);


-- None 바이올린과 피아노를 위한 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 소나타', 'Sonata for Violin and Piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b3c2f9d-ae24-4069-a8a0-8e0704dfad25'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b3c2f9d-ae24-4069-a8a0-8e0704dfad25'
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '바이올린과 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b3c2f9d-ae24-4069-a8a0-8e0704dfad25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d59d28a-ae72-44eb-9ba0-7dbc7c61d420', 1, 'I', 'Allegretto cantabile con moto', 'Sonata for Violin and Piano: I. Allegretto cantabile con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '바이올린과 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d59d28a-ae72-44eb-9ba0-7dbc7c61d420'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd2efe9a-2eb7-4831-87d2-b71101483dcb', 2, 'II', 'Largo sostenuto', 'Sonata for Violin and Piano: II. Largo sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '바이올린과 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd2efe9a-2eb7-4831-87d2-b71101483dcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3bf18c8-c7e7-4171-b99e-22d258d4bb5a', 3, 'III', 'Allegro assai moderato', 'Sonata for Violin and Piano: III. Allegro assai moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '바이올린과 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3bf18c8-c7e7-4171-b99e-22d258d4bb5a'
);


-- None 영화 <The Abdication> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <The Abdication> 사운드트랙', 'The Abdication', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <The Abdication> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7755 AND linked.composer_id = 111), 'musicbrainz:01e5e3ab-d0d5-4816-a834-9881e5c5e060', 1, NULL, 'Christina, the Queen', 'Christina, the Queen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01e5e3ab-d0d5-4816-a834-9881e5c5e060'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Christina, the Queen"', piece.title_en = 'The Abdication: Christina, the Queen', piece.editor_locked = 1
WHERE piece.id = 7755 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10055 AND linked.composer_id = 111), 'musicbrainz:a4d64a86-a538-41ae-8e01-392c0b4a9aa2', 2, NULL, 'The Abdication', 'The Abdication', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4d64a86-a538-41ae-8e01-392c0b4a9aa2'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "The Abdication"', piece.title_en = 'The Abdication: The Abdication', piece.editor_locked = 1
WHERE piece.id = 10055 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8898 AND linked.composer_id = 111), 'musicbrainz:536aac8a-75cb-4189-87ae-0b2cecb49e50', 3, NULL, 'The Vatican', 'The Vatican', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:536aac8a-75cb-4189-87ae-0b2cecb49e50'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "The Vatican"', piece.title_en = 'The Abdication: The Vatican', piece.editor_locked = 1
WHERE piece.id = 8898 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8576 AND linked.composer_id = 111), 'musicbrainz:3c9ca757-2083-4cac-91a9-f6c1d87cbb41', 4, NULL, 'Birgitto, the Dwarf', 'Birgitto, the Dwarf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c9ca757-2083-4cac-91a9-f6c1d87cbb41'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Birgitto, the Dwarf"', piece.title_en = 'The Abdication: Birgitto, the Dwarf', piece.editor_locked = 1
WHERE piece.id = 8576 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8759 AND linked.composer_id = 111), 'musicbrainz:4a11a88b-658d-4eaa-bbc8-ad530975acd0', 5, NULL, 'Cardinals', 'Cardinals', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a11a88b-658d-4eaa-bbc8-ad530975acd0'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Cardinals"', piece.title_en = 'The Abdication: Cardinals', piece.editor_locked = 1
WHERE piece.id = 8759 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8222 AND linked.composer_id = 111), 'musicbrainz:224fc7cb-8adf-48a5-b11a-87853062c505', 6, NULL, 'The Doll Queen', 'The Doll Queen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:224fc7cb-8adf-48a5-b11a-87853062c505'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "The Doll Queen"', piece.title_en = 'The Abdication: The Doll Queen', piece.editor_locked = 1
WHERE piece.id = 8222 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10679 AND linked.composer_id = 111), 'musicbrainz:d39f9f1d-ccef-4725-a613-4d867235f16b', 7, NULL, 'Children''s Plays', 'Children''s Plays', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d39f9f1d-ccef-4725-a613-4d867235f16b'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Children''s Plays"', piece.title_en = 'The Abdication: Children''s Plays', piece.editor_locked = 1
WHERE piece.id = 10679 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7809 AND linked.composer_id = 111), 'musicbrainz:0501a630-a3ab-4f26-8ca8-9e1676cb6b9d', 8, NULL, 'Nightmare', 'Nightmare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0501a630-a3ab-4f26-8ca8-9e1676cb6b9d'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Nightmare"', piece.title_en = 'The Abdication: Nightmare', piece.editor_locked = 1
WHERE piece.id = 7809 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9611 AND linked.composer_id = 111), 'musicbrainz:851cb6e0-21e5-4838-8910-495c1551af21', 9, NULL, 'Thoughts', 'Thoughts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:851cb6e0-21e5-4838-8910-495c1551af21'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Thoughts"', piece.title_en = 'The Abdication: Thoughts', piece.editor_locked = 1
WHERE piece.id = 9611 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11057 AND linked.composer_id = 111), 'musicbrainz:ef7f0706-73f9-4d82-8175-e85b97c511b3', 10, NULL, 'Deer Hunting', 'Deer Hunting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef7f0706-73f9-4d82-8175-e85b97c511b3'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Deer Hunting"', piece.title_en = 'The Abdication: Deer Hunting', piece.editor_locked = 1
WHERE piece.id = 11057 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9888 AND linked.composer_id = 111), 'musicbrainz:999befae-2007-4698-ba75-2bd3d3bb63c4', 11, NULL, 'Holy Mother Church', 'Holy Mother Church', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:999befae-2007-4698-ba75-2bd3d3bb63c4'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Holy Mother Church"', piece.title_en = 'The Abdication: Holy Mother Church', piece.editor_locked = 1
WHERE piece.id = 9888 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10158 AND linked.composer_id = 111), 'musicbrainz:acf7e0bf-d23b-4c13-b85a-2a41db066f60', 12, NULL, 'Cardinal Azzolino', 'Cardinal Azzolino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acf7e0bf-d23b-4c13-b85a-2a41db066f60'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Cardinal Azzolino"', piece.title_en = 'The Abdication: Cardinal Azzolino', piece.editor_locked = 1
WHERE piece.id = 10158 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8555 AND linked.composer_id = 111), 'musicbrainz:3a918db2-7817-4ed4-830b-cb8eec865196', 13, NULL, 'Christina and the Drawn Up Troops', 'Christina and the Drawn Up Troops', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a918db2-7817-4ed4-830b-cb8eec865196'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Christina and the Drawn Up Troops"', piece.title_en = 'The Abdication: Christina and the Drawn Up Troops', piece.editor_locked = 1
WHERE piece.id = 8555 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9330 AND linked.composer_id = 111), 'musicbrainz:7167fe1a-d959-4a52-a0a2-cadcfcdd40e1', 14, NULL, 'De La Garde: Love Remembered', 'De La Garde: Love Remembered', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7167fe1a-d959-4a52-a0a2-cadcfcdd40e1'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "De La Garde: Love Remembered"', piece.title_en = 'The Abdication: De La Garde: Love Remembered', piece.editor_locked = 1
WHERE piece.id = 9330 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9898 AND linked.composer_id = 111), 'musicbrainz:9a17d66a-680d-4e48-a4ef-71ada4f22b62', 15, NULL, 'Despair', 'Despair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a17d66a-680d-4e48-a4ef-71ada4f22b62'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Despair"', piece.title_en = 'The Abdication: Despair', piece.editor_locked = 1
WHERE piece.id = 9898 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10829 AND linked.composer_id = 111), 'musicbrainz:deb7a9d7-5887-419b-92e8-78b60906a799', 16, NULL, 'Solitude', 'Solitude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deb7a9d7-5887-419b-92e8-78b60906a799'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Solitude"', piece.title_en = 'The Abdication: Solitude', piece.editor_locked = 1
WHERE piece.id = 10829 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9274 AND linked.composer_id = 111), 'musicbrainz:6de67b5a-e7e4-45f4-963d-ede4976c3471', 17, NULL, 'Gloria in Excelsis Deo - Oath', 'Gloria in Excelsis Deo - Oath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6de67b5a-e7e4-45f4-963d-ede4976c3471'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Gloria in Excelsis Deo - Oath"', piece.title_en = 'The Abdication: Gloria in Excelsis Deo - Oath', piece.editor_locked = 1
WHERE piece.id = 9274 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11153 AND linked.composer_id = 111), 'musicbrainz:f77be64e-71c5-4086-ab65-e9fe697dcfd7', 18, NULL, 'Impossible Love', 'Impossible Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f77be64e-71c5-4086-ab65-e9fe697dcfd7'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Impossible Love"', piece.title_en = 'The Abdication: Impossible Love', piece.editor_locked = 1
WHERE piece.id = 11153 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8583 AND linked.composer_id = 111), 'musicbrainz:3d5ce329-3f9b-4013-9d0e-119d3e436fb0', 19, NULL, 'Christina''s Decision', 'Christina''s Decision', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d5ce329-3f9b-4013-9d0e-119d3e436fb0'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Christina''s Decision"', piece.title_en = 'The Abdication: Christina''s Decision', piece.editor_locked = 1
WHERE piece.id = 8583 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8366 AND linked.composer_id = 111), 'musicbrainz:2e1f9b2a-fd0e-4a34-888d-9cf74b84a856', 20, NULL, 'Night Delirium', 'Night Delirium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e1f9b2a-fd0e-4a34-888d-9cf74b84a856'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Night Delirium"', piece.title_en = 'The Abdication: Night Delirium', piece.editor_locked = 1
WHERE piece.id = 8366 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9673 AND linked.composer_id = 111), 'musicbrainz:89c7d7b7-b081-4f84-874a-225ed347b813', 21, NULL, 'Procession', 'Procession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89c7d7b7-b081-4f84-874a-225ed347b813'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "Procession"', piece.title_en = 'The Abdication: Procession', piece.editor_locked = 1
WHERE piece.id = 9673 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8591 AND linked.composer_id = 111), 'musicbrainz:3e8371db-9bdc-4e31-b2bc-ddadfb098e88', 22, NULL, 'The Renouncement', 'The Renouncement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <The Abdication> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e8371db-9bdc-4e31-b2bc-ddadfb098e88'
);

UPDATE pieces piece
SET piece.title = '영화 <The Abdication> 사운드트랙 중 "The Renouncement"', piece.title_en = 'The Abdication: The Renouncement', piece.editor_locked = 1
WHERE piece.id = 8591 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <사티리콘> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <사티리콘> 사운드트랙', 'Fellini Satyricon', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <사티리콘> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9307 AND linked.composer_id = 111), 'musicbrainz:7031227b-3d74-49e6-a99f-a0429082d68d', 1, NULL, 'Teatrino di vernacchio', 'Teatrino di vernacchio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7031227b-3d74-49e6-a99f-a0429082d68d'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Teatrino di vernacchio"', piece.title_en = 'Fellini Satyricon: Teatrino di vernacchio', piece.editor_locked = 1
WHERE piece.id = 9307 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10674 AND linked.composer_id = 111), 'musicbrainz:d34a0ba9-a968-434a-b13a-902dec30a765', 2, NULL, 'Il giardino delle delizie', 'Il giardino delle delizie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d34a0ba9-a968-434a-b13a-902dec30a765'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Il giardino delle delizie"', piece.title_en = 'Fellini Satyricon: Il giardino delle delizie', piece.editor_locked = 1
WHERE piece.id = 10674 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9475 AND linked.composer_id = 111), 'musicbrainz:7b50b43b-9bea-4e3e-8709-a6535ac144f4', 3, NULL, 'Notturni nelle suburra', 'Notturni nelle suburra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b50b43b-9bea-4e3e-8709-a6535ac144f4'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Notturni nelle suburra"', piece.title_en = 'Fellini Satyricon: Notturni nelle suburra', piece.editor_locked = 1
WHERE piece.id = 9475 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11221 AND linked.composer_id = 111), 'musicbrainz:fba984da-22a0-45e3-88d0-94ee0443a419', 4, NULL, 'La schiavetta innamorata', 'La schiavetta innamorata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba984da-22a0-45e3-88d0-94ee0443a419'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "La schiavetta innamorata"', piece.title_en = 'Fellini Satyricon: La schiavetta innamorata', piece.editor_locked = 1
WHERE piece.id = 11221 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e79a2fc-b9f8-41e5-9f31-fd7019608b0a', 5, NULL, 'La cena de trimalcione', 'La cena de trimalcione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e79a2fc-b9f8-41e5-9f31-fd7019608b0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9234 AND linked.composer_id = 111), 'musicbrainz:6b3f13c2-3a47-4d0c-b878-c661b83a5062', 6, NULL, 'Madejà-periamdejà', 'Madejà-periamdejà', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b3f13c2-3a47-4d0c-b878-c661b83a5062'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Madejà-periamdejà"', piece.title_en = 'Fellini Satyricon: Madejà-periamdejà', piece.editor_locked = 1
WHERE piece.id = 9234 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8401 AND linked.composer_id = 111), 'musicbrainz:309ce76a-c308-4a27-8409-19d5d8ac5127', 7, NULL, 'Mio amato gitone', 'Mio amato gitone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:309ce76a-c308-4a27-8409-19d5d8ac5127'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Mio amato gitone"', piece.title_en = 'Fellini Satyricon: Mio amato gitone', piece.editor_locked = 1
WHERE piece.id = 8401 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b66d3c01-232f-43ee-942b-be7e69232bce', 8, NULL, 'La cena de trimalcione', 'La cena de trimalcione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b66d3c01-232f-43ee-942b-be7e69232bce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10941 AND linked.composer_id = 111), 'musicbrainz:e7aafcfe-4159-4a8f-a5c5-22caa33b4ce9', 9, NULL, 'Tema di gitone', 'Tema di gitone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7aafcfe-4159-4a8f-a5c5-22caa33b4ce9'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Tema di gitone"', piece.title_en = 'Fellini Satyricon: Tema di gitone', piece.editor_locked = 1
WHERE piece.id = 10941 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7927 AND linked.composer_id = 111), 'musicbrainz:0d212f27-c692-437c-a6e3-8ad8dce857b4', 10, NULL, 'Il trionfo del nuovo cesare', 'Il trionfo del nuovo cesare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d212f27-c692-437c-a6e3-8ad8dce857b4'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Il trionfo del nuovo cesare"', piece.title_en = 'Fellini Satyricon: Il trionfo del nuovo cesare', piece.editor_locked = 1
WHERE piece.id = 7927 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10211 AND linked.composer_id = 111), 'musicbrainz:b02054a0-a6d9-48e6-9835-9f6b5c47f08a', 11, NULL, 'Encolpio e ascilto prigioneri', 'Encolpio e ascilto prigioneri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b02054a0-a6d9-48e6-9835-9f6b5c47f08a'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Encolpio e ascilto prigioneri"', piece.title_en = 'Fellini Satyricon: Encolpio e ascilto prigioneri', piece.editor_locked = 1
WHERE piece.id = 10211 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9947 AND linked.composer_id = 111), 'musicbrainz:9cfe4434-7d0c-422a-bc63-bd47ee69aa5b', 12, NULL, 'Sulla nave di lica', 'Sulla nave di lica', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cfe4434-7d0c-422a-bc63-bd47ee69aa5b'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Sulla nave di lica"', piece.title_en = 'Fellini Satyricon: Sulla nave di lica', piece.editor_locked = 1
WHERE piece.id = 9947 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9763 AND linked.composer_id = 111), 'musicbrainz:900a8fb7-d1b9-4a76-bbd7-29bdbe6f5a2f', 13, NULL, 'Le nozze sul mare', 'Le nozze sul mare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:900a8fb7-d1b9-4a76-bbd7-29bdbe6f5a2f'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Le nozze sul mare"', piece.title_en = 'Fellini Satyricon: Le nozze sul mare', piece.editor_locked = 1
WHERE piece.id = 9763 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9854 AND linked.composer_id = 111), 'musicbrainz:9792cc2d-ccaa-4c98-8a6f-363c7ba90d99', 14, NULL, 'Il fuoco delle vestali', 'Il fuoco delle vestali', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9792cc2d-ccaa-4c98-8a6f-363c7ba90d99'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Il fuoco delle vestali"', piece.title_en = 'Fellini Satyricon: Il fuoco delle vestali', piece.editor_locked = 1
WHERE piece.id = 9854 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10030 AND linked.composer_id = 111), 'musicbrainz:a37e8d3c-6e2d-4100-83b2-2f3b6de8fca1', 15, NULL, 'L'' oracolo salmodiante', 'L'' oracolo salmodiante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a37e8d3c-6e2d-4100-83b2-2f3b6de8fca1'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "L'' oracolo salmodiante"', piece.title_en = 'Fellini Satyricon: L'' oracolo salmodiante', piece.editor_locked = 1
WHERE piece.id = 10030 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9027 AND linked.composer_id = 111), 'musicbrainz:5bad19c8-57e6-4eae-a350-92e638e24143', 16, NULL, 'Mi ascolti, gitone?', 'Mi ascolti, gitone?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bad19c8-57e6-4eae-a350-92e638e24143'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Mi ascolti, gitone?"', piece.title_en = 'Fellini Satyricon: Mi ascolti, gitone?', piece.editor_locked = 1
WHERE piece.id = 9027 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9473 AND linked.composer_id = 111), 'musicbrainz:7b442840-e869-4a3c-9e3b-1d4e6b42c98c', 17, NULL, 'Storia della matrona de efeso', 'Storia della matrona de efeso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b442840-e869-4a3c-9e3b-1d4e6b42c98c'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Storia della matrona de efeso"', piece.title_en = 'Fellini Satyricon: Storia della matrona de efeso', piece.editor_locked = 1
WHERE piece.id = 9473 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10893 AND linked.composer_id = 111), 'musicbrainz:e4557dc6-732a-476b-95a4-13e61958df0e', 18, NULL, 'Encolpio ha perduto la sua spada', 'Encolpio ha perduto la sua spada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4557dc6-732a-476b-95a4-13e61958df0e'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Encolpio ha perduto la sua spada"', piece.title_en = 'Fellini Satyricon: Encolpio ha perduto la sua spada', piece.editor_locked = 1
WHERE piece.id = 10893 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8891 AND linked.composer_id = 111), 'musicbrainz:52ebc84d-fcb9-4293-b869-39a3928f62db', 19, NULL, 'Il minotauro', 'Il minotauro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52ebc84d-fcb9-4293-b869-39a3928f62db'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "Il minotauro"', piece.title_en = 'Fellini Satyricon: Il minotauro', piece.editor_locked = 1
WHERE piece.id = 8891 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8544 AND linked.composer_id = 111), 'musicbrainz:39d51b1b-172d-4506-8b0a-80463bd61355', 20, NULL, 'La nuova isola', 'La nuova isola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사티리콘> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39d51b1b-172d-4506-8b0a-80463bd61355'
);

UPDATE pieces piece
SET piece.title = '영화 <사티리콘> 사운드트랙 중 "La nuova isola"', piece.title_en = 'Fellini Satyricon: La nuova isola', piece.editor_locked = 1
WHERE piece.id = 8544 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <허리케인> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <허리케인> 사운드트랙', 'Hurricane', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <허리케인> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52f00605-8b86-40fd-b544-9a4882eb4e65', 1, NULL, 'Main Title', 'Main Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52f00605-8b86-40fd-b544-9a4882eb4e65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10559 AND linked.composer_id = 111), 'musicbrainz:ca935e1e-8c3f-4557-be50-a9ce25690d96', 2, NULL, 'Guitar From the Quayside', 'Guitar From the Quayside', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca935e1e-8c3f-4557-be50-a9ce25690d96'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Guitar From the Quayside"', piece.title_en = 'Hurricane: Guitar From the Quayside', piece.editor_locked = 1
WHERE piece.id = 10559 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8082 AND linked.composer_id = 111), 'musicbrainz:179bc7a3-44de-46e4-96cd-fbea295c019c', 3, NULL, 'Katopua', 'Katopua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:179bc7a3-44de-46e4-96cd-fbea295c019c'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Katopua"', piece.title_en = 'Hurricane: Katopua', piece.editor_locked = 1
WHERE piece.id = 8082 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8862 AND linked.composer_id = 111), 'musicbrainz:51293d27-8165-44fa-97b8-8623f785fc90', 4, NULL, 'Coronation Percussion', 'Coronation Percussion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51293d27-8165-44fa-97b8-8623f785fc90'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Coronation Percussion"', piece.title_en = 'Hurricane: Coronation Percussion', piece.editor_locked = 1
WHERE piece.id = 8862 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7797 AND linked.composer_id = 111), 'musicbrainz:0477e907-6e92-405e-82ab-29bb1b881297', 5, NULL, 'Pago-Pago Jazz', 'Pago-Pago Jazz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0477e907-6e92-405e-82ab-29bb1b881297'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Pago-Pago Jazz"', piece.title_en = 'Hurricane: Pago-Pago Jazz', piece.editor_locked = 1
WHERE piece.id = 7797 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9654 AND linked.composer_id = 111), 'musicbrainz:88058b14-7fff-4650-a58a-8518009b6cfb', 6, NULL, 'Moana''s Dance', 'Moana''s Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88058b14-7fff-4650-a58a-8518009b6cfb'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Moana''s Dance"', piece.title_en = 'Hurricane: Moana''s Dance', piece.editor_locked = 1
WHERE piece.id = 9654 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8857 AND linked.composer_id = 111), 'musicbrainz:50f8f44f-2b39-4129-b8f5-fcb0086a6c85', 7, NULL, 'Love in Blossom', 'Love in Blossom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50f8f44f-2b39-4129-b8f5-fcb0086a6c85'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Love in Blossom"', piece.title_en = 'Hurricane: Love in Blossom', piece.editor_locked = 1
WHERE piece.id = 8857 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10185 AND linked.composer_id = 111), 'musicbrainz:ae5a7554-997a-4f59-bd56-468652adda57', 8, NULL, 'Joy of Love in Alava', 'Joy of Love in Alava', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae5a7554-997a-4f59-bd56-468652adda57'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Joy of Love in Alava"', piece.title_en = 'Hurricane: Joy of Love in Alava', piece.editor_locked = 1
WHERE piece.id = 10185 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9795 AND linked.composer_id = 111), 'musicbrainz:929ed49f-f4f6-4cc5-93c3-36d6100c951e', 9, NULL, 'Delusion', 'Delusion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:929ed49f-f4f6-4cc5-93c3-36d6100c951e'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Delusion"', piece.title_en = 'Hurricane: Delusion', piece.editor_locked = 1
WHERE piece.id = 9795 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10813 AND linked.composer_id = 111), 'musicbrainz:dda7bee7-1aee-4250-bf2f-250b3edc6d5f', 10, NULL, 'Moana''s Death', 'Moana''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dda7bee7-1aee-4250-bf2f-250b3edc6d5f'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Moana''s Death"', piece.title_en = 'Hurricane: Moana''s Death', piece.editor_locked = 1
WHERE piece.id = 10813 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9124 AND linked.composer_id = 111), 'musicbrainz:62716d8c-bb95-4502-bf5a-8095e8b59df0', 11, NULL, 'Matangi''s Escape', 'Matangi''s Escape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62716d8c-bb95-4502-bf5a-8095e8b59df0'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Matangi''s Escape"', piece.title_en = 'Hurricane: Matangi''s Escape', piece.editor_locked = 1
WHERE piece.id = 9124 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10996 AND linked.composer_id = 111), 'musicbrainz:eaec8b31-372b-47c7-a1b8-e2315fcc942b', 12, NULL, 'Matangi''s Love Theme', 'Matangi''s Love Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaec8b31-372b-47c7-a1b8-e2315fcc942b'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Matangi''s Love Theme"', piece.title_en = 'Hurricane: Matangi''s Love Theme', piece.editor_locked = 1
WHERE piece.id = 10996 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7978 AND linked.composer_id = 111), 'musicbrainz:10db1f4e-3a45-42ea-a3fa-428a36f8efec', 13, NULL, 'Jazz in Dockland', 'Jazz in Dockland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10db1f4e-3a45-42ea-a3fa-428a36f8efec'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Jazz in Dockland"', piece.title_en = 'Hurricane: Jazz in Dockland', piece.editor_locked = 1
WHERE piece.id = 7978 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8915 AND linked.composer_id = 111), 'musicbrainz:54dd9a10-79f3-4008-be51-4385fc37de13', 14, NULL, 'Matangi and Charlotte''s Escape', 'Matangi and Charlotte''s Escape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54dd9a10-79f3-4008-be51-4385fc37de13'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Matangi and Charlotte''s Escape"', piece.title_en = 'Hurricane: Matangi and Charlotte''s Escape', piece.editor_locked = 1
WHERE piece.id = 8915 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9204 AND linked.composer_id = 111), 'musicbrainz:69612ffd-ab60-4309-ba7b-600fea773cbd', 15, NULL, 'Bruckner''s Death', 'Bruckner''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69612ffd-ab60-4309-ba7b-600fea773cbd'
);

UPDATE pieces piece
SET piece.title = '영화 <허리케인> 사운드트랙 중 "Bruckner''s Death"', piece.title_en = 'Hurricane: Bruckner''s Death', piece.editor_locked = 1
WHERE piece.id = 9204 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2efd988c-51ac-46b5-86d2-86d3921a5f05', 16, NULL, 'End Title', 'End Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <허리케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2efd988c-51ac-46b5-86d2-86d3921a5f05'
);


-- None 영화 <카사노바> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <카사노바> 사운드트랙', 'Il Casanova di Federico Fellini', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <카사노바> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10102 AND linked.composer_id = 111), 'musicbrainz:a87b0a7d-9876-42c2-8993-46922cab46cb', 1, NULL, 'O Venise, Venaga, Venus', 'O Venise, Venaga, Venus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a87b0a7d-9876-42c2-8993-46922cab46cb'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "O Venise, Venaga, Venus"', piece.title_en = 'Il Casanova di Federico Fellini: O Venise, Venaga, Venus', piece.editor_locked = 1
WHERE piece.id = 10102 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8686 AND linked.composer_id = 111), 'musicbrainz:450d0d3c-722c-4a3a-8d85-48c2e915a2ae', 2, NULL, 'L''Oiseau magique', 'L''Oiseau magique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:450d0d3c-722c-4a3a-8d85-48c2e915a2ae'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "L''Oiseau magique"', piece.title_en = 'Il Casanova di Federico Fellini: L''Oiseau magique', piece.editor_locked = 1
WHERE piece.id = 8686 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8950 AND linked.composer_id = 111), 'musicbrainz:56dfed55-702c-4836-b25f-2d6a14fa8733', 3, NULL, 'Déjeuner chez la Marquise Durfé', 'Déjeuner chez la Marquise Durfé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56dfed55-702c-4836-b25f-2d6a14fa8733'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "Déjeuner chez la Marquise Durfé"', piece.title_en = 'Il Casanova di Federico Fellini: Déjeuner chez la Marquise Durfé', piece.editor_locked = 1
WHERE piece.id = 8950 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11218 AND linked.composer_id = 111), 'musicbrainz:fb850e73-d900-4c1e-a957-13a813e352ec', 4, NULL, 'La Grande Moune', 'La Grande Moune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb850e73-d900-4c1e-a957-13a813e352ec'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "La Grande Moune"', piece.title_en = 'Il Casanova di Federico Fellini: La Grande Moune', piece.editor_locked = 1
WHERE piece.id = 11218 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8122 AND linked.composer_id = 111), 'musicbrainz:1a22d77a-735a-4a84-8b10-b67841ff33b5', 5, NULL, 'Chant de la Buranella', 'Chant de la Buranella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a22d77a-735a-4a84-8b10-b67841ff33b5'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "Chant de la Buranella"', piece.title_en = 'Il Casanova di Federico Fellini: Chant de la Buranella', piece.editor_locked = 1
WHERE piece.id = 8122 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7850 AND linked.composer_id = 111), 'musicbrainz:07d6bf6a-ce81-491e-a801-521a31ebbaa8', 6, NULL, 'L''Oiseau magique à Paris', 'L''Oiseau magique à Paris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07d6bf6a-ce81-491e-a801-521a31ebbaa8'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "L''Oiseau magique à Paris"', piece.title_en = 'Il Casanova di Federico Fellini: L''Oiseau magique à Paris', piece.editor_locked = 1
WHERE piece.id = 7850 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10291 AND linked.composer_id = 111), 'musicbrainz:b68fa3d9-c792-42fa-8bdb-e188e975330e', 7, NULL, 'Intermezzo de la mante religieuse', 'Intermezzo de la mante religieuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b68fa3d9-c792-42fa-8bdb-e188e975330e'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "Intermezzo de la mante religieuse"', piece.title_en = 'Il Casanova di Federico Fellini: Intermezzo de la mante religieuse', piece.editor_locked = 1
WHERE piece.id = 10291 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8856 AND linked.composer_id = 111), 'musicbrainz:50f35df3-acb1-4c75-b1d1-6f2bf511e1fc', 8, NULL, 'Pin Penin', 'Pin Penin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50f35df3-acb1-4c75-b1d1-6f2bf511e1fc'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "Pin Penin"', piece.title_en = 'Il Casanova di Federico Fellini: Pin Penin', piece.editor_locked = 1
WHERE piece.id = 8856 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9075 AND linked.composer_id = 111), 'musicbrainz:5f4c1688-154e-4d09-9d63-dcd5e0fcc5d4', 9, NULL, 'L''Oiseau magique à Dresde', 'L''Oiseau magique à Dresde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f4c1688-154e-4d09-9d63-dcd5e0fcc5d4'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "L''Oiseau magique à Dresde"', piece.title_en = 'Il Casanova di Federico Fellini: L''Oiseau magique à Dresde', piece.editor_locked = 1
WHERE piece.id = 9075 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9698 AND linked.composer_id = 111), 'musicbrainz:8b067bc9-d3ed-4b09-b10d-dd6695f4e2d1', 10, NULL, 'Souvenir d''Henriette', 'Souvenir d''Henriette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b067bc9-d3ed-4b09-b10d-dd6695f4e2d1'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "Souvenir d''Henriette"', piece.title_en = 'Il Casanova di Federico Fellini: Souvenir d''Henriette', piece.editor_locked = 1
WHERE piece.id = 9698 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10694 AND linked.composer_id = 111), 'musicbrainz:d4973003-5b85-480e-a541-03d7dfcae66b', 11, NULL, 'L''Oiseau magique à Rome', 'L''Oiseau magique à Rome', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4973003-5b85-480e-a541-03d7dfcae66b'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "L''Oiseau magique à Rome"', piece.title_en = 'Il Casanova di Federico Fellini: L''Oiseau magique à Rome', piece.editor_locked = 1
WHERE piece.id = 10694 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8379 AND linked.composer_id = 111), 'musicbrainz:2eeb8610-1058-4521-84ae-7a59ebcfb868', 12, NULL, 'Le Duc de Wurttemberg', 'Le Duc de Wurttemberg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2eeb8610-1058-4521-84ae-7a59ebcfb868'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "Le Duc de Wurttemberg"', piece.title_en = 'Il Casanova di Federico Fellini: Le Duc de Wurttemberg', piece.editor_locked = 1
WHERE piece.id = 8379 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10145 AND linked.composer_id = 111), 'musicbrainz:abe6930c-9109-4e61-aed4-80d0a974479f', 13, NULL, 'La Poupée automate', 'La Poupée automate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <카사노바> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abe6930c-9109-4e61-aed4-80d0a974479f'
);

UPDATE pieces piece
SET piece.title = '영화 <카사노바> 사운드트랙 중 "La Poupée automate"', piece.title_en = 'Il Casanova di Federico Fellini: La Poupée automate', piece.editor_locked = 1
WHERE piece.id = 10145 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Plein soleil

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Plein soleil', 'Plein soleil', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Plein soleil'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:272fce01-4ad2-4953-a9ef-ed7f7c7a67f8', 1, NULL, 'Plein soleil', 'Plein soleil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:272fce01-4ad2-4953-a9ef-ed7f7c7a67f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88455c21-6d8c-4e6c-a10c-cd914a835e46', 2, NULL, 'Via Veneto', 'Via Veneto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88455c21-6d8c-4e6c-a10c-cd914a835e46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8490 AND linked.composer_id = 111), 'musicbrainz:364f41f4-19b9-487f-b04a-4578793c8e0f', 3, NULL, 'Falsification', 'Falsification', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:364f41f4-19b9-487f-b04a-4578793c8e0f'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Falsification"', piece.title_en = 'Plein soleil: Falsification', piece.editor_locked = 1
WHERE piece.id = 8490 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8830 AND linked.composer_id = 111), 'musicbrainz:4f879e5f-832d-4dd1-9659-71f44a5e752e', 4, NULL, 'Tarentelle meurtrière', 'Tarentelle meurtrière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f879e5f-832d-4dd1-9659-71f44a5e752e'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Tarentelle meurtrière"', piece.title_en = 'Plein soleil: Tarentelle meurtrière', piece.editor_locked = 1
WHERE piece.id = 8830 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7997 AND linked.composer_id = 111), 'musicbrainz:11b26ba9-f3b1-4f30-94ed-4af735e2fd80', 5, NULL, 'Le Yacht', 'Le Yacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11b26ba9-f3b1-4f30-94ed-4af735e2fd80'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Le Yacht"', piece.title_en = 'Plein soleil: Le Yacht', piece.editor_locked = 1
WHERE piece.id = 7997 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10450 AND linked.composer_id = 111), 'musicbrainz:c2ff0268-8a63-4e97-9f41-e5097edaf41d', 6, NULL, 'Mongibello', 'Mongibello', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2ff0268-8a63-4e97-9f41-e5097edaf41d'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Mongibello"', piece.title_en = 'Plein soleil: Mongibello', piece.editor_locked = 1
WHERE piece.id = 10450 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9705 AND linked.composer_id = 111), 'musicbrainz:8b6778f1-30b3-4df1-861a-27f9ecd975cc', 7, NULL, 'Meurtre de Philippe', 'Meurtre de Philippe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b6778f1-30b3-4df1-861a-27f9ecd975cc'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Meurtre de Philippe"', piece.title_en = 'Plein soleil: Meurtre de Philippe', piece.editor_locked = 1
WHERE piece.id = 9705 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9413 AND linked.composer_id = 111), 'musicbrainz:774c252b-d271-42d6-986e-ba1ca0baf570', 8, NULL, 'Haute-mer', 'Haute-mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:774c252b-d271-42d6-986e-ba1ca0baf570'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Haute-mer"', piece.title_en = 'Plein soleil: Haute-mer', piece.editor_locked = 1
WHERE piece.id = 9413 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c35067eb-a925-4a25-ba2f-6f272f49b67e', 9, NULL, 'Le Baiser', 'Le Baiser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c35067eb-a925-4a25-ba2f-6f272f49b67e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9723 AND linked.composer_id = 111), 'musicbrainz:8d510b40-2c23-433c-ac8d-6830b78fea0a', 10, NULL, 'Contrefaçon', 'Contrefaçon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d510b40-2c23-433c-ac8d-6830b78fea0a'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Contrefaçon"', piece.title_en = 'Plein soleil: Contrefaçon', piece.editor_locked = 1
WHERE piece.id = 9723 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9976 AND linked.composer_id = 111), 'musicbrainz:a003676c-8fe8-4f23-91cf-628b7ae9b1c5', 11, NULL, 'L''Absence', 'L''Absence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a003676c-8fe8-4f23-91cf-628b7ae9b1c5'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "L''Absence"', piece.title_en = 'Plein soleil: L''Absence', piece.editor_locked = 1
WHERE piece.id = 9976 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10440 AND linked.composer_id = 111), 'musicbrainz:c215a6c0-7fb1-42cf-b19b-97b4b7c294cf', 12, NULL, 'Arrivée à Taormine', 'Arrivée à Taormine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c215a6c0-7fb1-42cf-b19b-97b4b7c294cf'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Arrivée à Taormine"', piece.title_en = 'Plein soleil: Arrivée à Taormine', piece.editor_locked = 1
WHERE piece.id = 10440 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9437 AND linked.composer_id = 111), 'musicbrainz:7932195b-721d-4da6-ad7c-54d6111fb75f', 13, NULL, 'La Gémissante', 'La Gémissante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7932195b-721d-4da6-ad7c-54d6111fb75f'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "La Gémissante"', piece.title_en = 'Plein soleil: La Gémissante', piece.editor_locked = 1
WHERE piece.id = 9437 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8811 AND linked.composer_id = 111), 'musicbrainz:4dd11068-375f-4895-9904-7fe638e17cb8', 14, NULL, 'Face au miroir', 'Face au miroir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dd11068-375f-4895-9904-7fe638e17cb8'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Face au miroir"', piece.title_en = 'Plein soleil: Face au miroir', piece.editor_locked = 1
WHERE piece.id = 8811 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9464 AND linked.composer_id = 111), 'musicbrainz:7ace58f2-97da-4ac1-9780-345e08c5ccc9', 15, NULL, 'La Plage', 'La Plage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ace58f2-97da-4ac1-9780-345e08c5ccc9'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "La Plage"', piece.title_en = 'Plein soleil: La Plage', piece.editor_locked = 1
WHERE piece.id = 9464 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9021 AND linked.composer_id = 111), 'musicbrainz:5b3caa42-d9a8-42cf-b173-e75b90a99f11', 16, NULL, '영화음악 모음곡 <태양은 가득히>', 'Plein soleil (Suite)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b3caa42-d9a8-42cf-b173-e75b90a99f11'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "영화음악 모음곡 <태양은 가득히>"', piece.title_en = 'Plein soleil: Plein soleil (Suite)', piece.editor_locked = 1
WHERE piece.id = 9021 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8356 AND linked.composer_id = 111), 'musicbrainz:2d94792e-b051-4d4a-bf7c-d25b14834e7c', 17, NULL, 'Générique', 'Générique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d94792e-b051-4d4a-bf7c-d25b14834e7c'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Générique"', piece.title_en = 'Plein soleil: Générique', piece.editor_locked = 1
WHERE piece.id = 8356 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55c8685f-b761-4507-b049-3bd4b48000da', 18, NULL, 'Via Veneto', 'Via Veneto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55c8685f-b761-4507-b049-3bd4b48000da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be184000-261c-457f-8c00-7e0b2306a9a8', 19, NULL, 'Le Baiser', 'Le Baiser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be184000-261c-457f-8c00-7e0b2306a9a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7851 AND linked.composer_id = 111), 'musicbrainz:07f3e4b6-9900-4ae8-ab97-b1cd25e16449', 20, NULL, 'Thème de marge', 'Thème de marge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07f3e4b6-9900-4ae8-ab97-b1cd25e16449'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Thème de marge"', piece.title_en = 'Plein soleil: Thème de marge', piece.editor_locked = 1
WHERE piece.id = 7851 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8230 AND linked.composer_id = 111), 'musicbrainz:234a036c-13ce-49b6-8a9d-02aecee18621', 21, NULL, 'Final', 'Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Plein soleil' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:234a036c-13ce-49b6-8a9d-02aecee18621'
);

UPDATE pieces piece
SET piece.title = 'Plein soleil 중 "Final"', piece.title_en = 'Plein soleil: Final', piece.editor_locked = 1
WHERE piece.id = 8230 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <전쟁과 평화> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <전쟁과 평화> 사운드트랙', 'War and Peace', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <전쟁과 평화> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04e146ae-1c17-456c-bbe0-958dcf4c278d', 1, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04e146ae-1c17-456c-bbe0-958dcf4c278d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8618 AND linked.composer_id = 111), 'musicbrainz:4099af85-8479-453e-851f-61c8fb7299bb', 2, NULL, 'The Orgy', 'The Orgy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4099af85-8479-453e-851f-61c8fb7299bb'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "The Orgy"', piece.title_en = 'War and Peace: The Orgy', piece.editor_locked = 1
WHERE piece.id = 8618 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9302 AND linked.composer_id = 111), 'musicbrainz:6fa3a533-ff56-4d29-b491-316f7f6c83e1', 3, NULL, 'Pierre and Natasha', 'Pierre and Natasha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fa3a533-ff56-4d29-b491-316f7f6c83e1'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "Pierre and Natasha"', piece.title_en = 'War and Peace: Pierre and Natasha', piece.editor_locked = 1
WHERE piece.id = 9302 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10539 AND linked.composer_id = 111), 'musicbrainz:c909b903-4189-4083-a61f-9fead694956c', 4, NULL, 'The Battle of Austerlitz', 'The Battle of Austerlitz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c909b903-4189-4083-a61f-9fead694956c'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "The Battle of Austerlitz"', piece.title_en = 'War and Peace: The Battle of Austerlitz', piece.editor_locked = 1
WHERE piece.id = 10539 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9319 AND linked.composer_id = 111), 'musicbrainz:70f3aef1-f28b-4697-aa78-e5231a7b99a8', 5, NULL, 'Andrei and Natasha - The Hunt', 'Andrei and Natasha - The Hunt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70f3aef1-f28b-4697-aa78-e5231a7b99a8'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "Andrei and Natasha - The Hunt"', piece.title_en = 'War and Peace: Andrei and Natasha - The Hunt', piece.editor_locked = 1
WHERE piece.id = 9319 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9415 AND linked.composer_id = 111), 'musicbrainz:77792509-fda9-42fb-b01e-c1aa8869b5b2', 6, NULL, 'War and Peace (Natasha''s Waltz)', 'War and Peace (Natasha''s Waltz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77792509-fda9-42fb-b01e-c1aa8869b5b2'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "War and Peace (Natasha''s Waltz)"', piece.title_en = 'War and Peace: War and Peace (Natasha''s Waltz)', piece.editor_locked = 1
WHERE piece.id = 9415 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10710 AND linked.composer_id = 111), 'musicbrainz:d6db8f56-6a53-4fb6-ba8f-77082b4f9dd3', 7, NULL, 'Anatole and Natasha', 'Anatole and Natasha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6db8f56-6a53-4fb6-ba8f-77082b4f9dd3'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "Anatole and Natasha"', piece.title_en = 'War and Peace: Anatole and Natasha', piece.editor_locked = 1
WHERE piece.id = 10710 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8823 AND linked.composer_id = 111), 'musicbrainz:4ece51cd-1885-4814-b59e-c9a79bde4cc2', 8, NULL, 'Winter and the Remembrance of Andrei', 'Winter and the Remembrance of Andrei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ece51cd-1885-4814-b59e-c9a79bde4cc2'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "Winter and the Remembrance of Andrei"', piece.title_en = 'War and Peace: Winter and the Remembrance of Andrei', piece.editor_locked = 1
WHERE piece.id = 8823 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7881 AND linked.composer_id = 111), 'musicbrainz:09f47a0a-d1a6-4867-9879-56aec45d2fc7', 9, NULL, 'The Charge of the Cavalry and the Wounded', 'The Charge of the Cavalry and the Wounded', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09f47a0a-d1a6-4867-9879-56aec45d2fc7'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "The Charge of the Cavalry and the Wounded"', piece.title_en = 'War and Peace: The Charge of the Cavalry and the Wounded', piece.editor_locked = 1
WHERE piece.id = 7881 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9652 AND linked.composer_id = 111), 'musicbrainz:87add3b9-98af-412f-9f64-78282e0ee75c', 10, NULL, 'Exodus From Moscow', 'Exodus From Moscow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87add3b9-98af-412f-9f64-78282e0ee75c'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "Exodus From Moscow"', piece.title_en = 'War and Peace: Exodus From Moscow', piece.editor_locked = 1
WHERE piece.id = 9652 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10298 AND linked.composer_id = 111), 'musicbrainz:b707f06d-1ffc-44f7-90bd-f0ab52924a6f', 11, NULL, 'Napoleon''s Retreat', 'Napoleon''s Retreat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b707f06d-1ffc-44f7-90bd-f0ab52924a6f'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "Napoleon''s Retreat"', piece.title_en = 'War and Peace: Napoleon''s Retreat', piece.editor_locked = 1
WHERE piece.id = 10298 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10017 AND linked.composer_id = 111), 'musicbrainz:a29d0cd4-140c-4d02-9eea-591cb8ca321f', 12, NULL, 'The Homecoming at Moscow', 'The Homecoming at Moscow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <전쟁과 평화> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a29d0cd4-140c-4d02-9eea-591cb8ca321f'
);

UPDATE pieces piece
SET piece.title = '영화 <전쟁과 평화> 사운드트랙 중 "The Homecoming at Moscow"', piece.title_en = 'War and Peace: The Homecoming at Moscow', piece.editor_locked = 1
WHERE piece.id = 10017 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <Il brigante> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <Il brigante> 사운드트랙', 'Il brigante', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <Il brigante> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10874 AND linked.composer_id = 111), 'musicbrainz:e29eb620-60e2-44f1-a79a-99d8f6d9e5da', 1, NULL, 'La lunga strada - in casa della nonna', 'La lunga strada - in casa della nonna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e29eb620-60e2-44f1-a79a-99d8f6d9e5da'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "La lunga strada - in casa della nonna"', piece.title_en = 'Il brigante: La lunga strada - in casa della nonna', piece.editor_locked = 1
WHERE piece.id = 10874 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11220 AND linked.composer_id = 111), 'musicbrainz:fb9a274b-4721-4aec-b5d1-cc776bce1eda', 2, NULL, 'Michele cacciatore', 'Michele cacciatore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb9a274b-4721-4aec-b5d1-cc776bce1eda'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "Michele cacciatore"', piece.title_en = 'Il brigante: Michele cacciatore', piece.editor_locked = 1
WHERE piece.id = 11220 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11110 AND linked.composer_id = 111), 'musicbrainz:f41f7fc2-0ea9-4e31-ba95-6cf561d90544', 3, NULL, 'La processione nel paese', 'La processione nel paese', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f41f7fc2-0ea9-4e31-ba95-6cf561d90544'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "La processione nel paese"', piece.title_en = 'Il brigante: La processione nel paese', piece.editor_locked = 1
WHERE piece.id = 11110 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11101 AND linked.composer_id = 111), 'musicbrainz:f36740f2-dc57-4fba-a69a-5b909aed9f5f', 4, NULL, 'Echi dei canti di Calabria', 'Echi dei canti di Calabria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f36740f2-dc57-4fba-a69a-5b909aed9f5f'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "Echi dei canti di Calabria"', piece.title_en = 'Il brigante: Echi dei canti di Calabria', piece.editor_locked = 1
WHERE piece.id = 11101 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8551 AND linked.composer_id = 111), 'musicbrainz:3a5032ac-9f75-479a-8396-15ccaa65321d', 5, NULL, 'Pataro', 'Pataro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a5032ac-9f75-479a-8396-15ccaa65321d'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "Pataro"', piece.title_en = 'Il brigante: Pataro', piece.editor_locked = 1
WHERE piece.id = 8551 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9425 AND linked.composer_id = 111), 'musicbrainz:78238091-7533-46cf-bb61-ba4a64a468a0', 6, NULL, 'Michele soldato americano', 'Michele soldato americano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78238091-7533-46cf-bb61-ba4a64a468a0'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "Michele soldato americano"', piece.title_en = 'Il brigante: Michele soldato americano', piece.editor_locked = 1
WHERE piece.id = 9425 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8988 AND linked.composer_id = 111), 'musicbrainz:5922f1de-477a-45e7-b3d8-0b3f691b0512', 7, NULL, 'La vigilia della rivolta', 'La vigilia della rivolta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5922f1de-477a-45e7-b3d8-0b3f691b0512'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "La vigilia della rivolta"', piece.title_en = 'Il brigante: La vigilia della rivolta', piece.editor_locked = 1
WHERE piece.id = 8988 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8111 AND linked.composer_id = 111), 'musicbrainz:19a64821-7b90-4362-8445-c1afaac0bf07', 8, NULL, 'Risveglio notturno e attesa nei campi', 'Risveglio notturno e attesa nei campi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19a64821-7b90-4362-8445-c1afaac0bf07'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "Risveglio notturno e attesa nei campi"', piece.title_en = 'Il brigante: Risveglio notturno e attesa nei campi', piece.editor_locked = 1
WHERE piece.id = 8111 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8556 AND linked.composer_id = 111), 'musicbrainz:3a9eeb71-df5e-48f4-be28-d4a5ee40231e', 9, NULL, 'Miliella', 'Miliella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a9eeb71-df5e-48f4-be28-d4a5ee40231e'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "Miliella"', piece.title_en = 'Il brigante: Miliella', piece.editor_locked = 1
WHERE piece.id = 8556 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10794 AND linked.composer_id = 111), 'musicbrainz:dc504424-d0d0-4ac9-a327-015b2b71b060', 10, NULL, '''mmazzato a tradimento', '''mmazzato a tradimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc504424-d0d0-4ac9-a327-015b2b71b060'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "''mmazzato a tradimento"', piece.title_en = 'Il brigante: ''mmazzato a tradimento', piece.editor_locked = 1
WHERE piece.id = 10794 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11287 AND linked.composer_id = 111), 'musicbrainz:ffc9ff02-0951-4f27-b498-9c58926c9f1d', 11, NULL, 'La fuga disperata - finale', 'La fuga disperata - finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Il brigante> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffc9ff02-0951-4f27-b498-9c58926c9f1d'
);

UPDATE pieces piece
SET piece.title = '영화 <Il brigante> 사운드트랙 중 "La fuga disperata - finale"', piece.title_en = 'Il brigante: La fuga disperata - finale', piece.editor_locked = 1
WHERE piece.id = 11287 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <아마코드> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <아마코드> 사운드트랙', 'Amarcord', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <아마코드> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39a82321-b288-3e4d-a8b5-4967372f70fa', 1, NULL, 'Amarcord', 'Amarcord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39a82321-b288-3e4d-a8b5-4967372f70fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9821 AND linked.composer_id = 111), 'musicbrainz:9468e9ad-c2fb-4e0a-92c8-d97eb183fec6', 2, NULL, 'La "fogaraccia"', 'La "fogaraccia"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9468e9ad-c2fb-4e0a-92c8-d97eb183fec6'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "La "fogaraccia""', piece.title_en = 'Amarcord: La "fogaraccia"', piece.editor_locked = 1
WHERE piece.id = 9821 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10333 AND linked.composer_id = 111), 'musicbrainz:b9b524d1-14ec-41d1-8fff-98931086c42a', 3, NULL, 'Le "manine" di primavera', 'Le "manine" di primavera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9b524d1-14ec-41d1-8fff-98931086c42a'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "Le "manine" di primavera"', piece.title_en = 'Amarcord: Le "manine" di primavera', piece.editor_locked = 1
WHERE piece.id = 10333 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9240 AND linked.composer_id = 111), 'musicbrainz:6b95d49c-e75a-445a-83c9-f6d382e389a1', 4, NULL, 'Lo "struscio" / Quel motivetto che mi piace tanto / Stormy Weather / La cucaracha / Stormy Weather', 'Lo "struscio" / Quel motivetto che mi piace tanto / Stormy Weather / La cucaracha / Stormy Weather', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b95d49c-e75a-445a-83c9-f6d382e389a1'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "Lo "struscio" / Quel motivetto che mi piace tanto / Stormy Weather / La cucaracha / Stormy Weather"', piece.title_en = 'Amarcord: Lo "struscio" / Quel motivetto che mi piace tanto / Stormy Weather / La cucaracha / Stormy Weather', piece.editor_locked = 1
WHERE piece.id = 9240 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9268 AND linked.composer_id = 111), 'musicbrainz:6d7d0e63-cab0-497a-9e97-97b9a83a9d90', 5, NULL, 'L''emiro e le sue odalische', 'L''emiro e le sue odalische', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7d0e63-cab0-497a-9e97-97b9a83a9d90'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "L''emiro e le sue odalische"', piece.title_en = 'Amarcord: L''emiro e le sue odalische', piece.editor_locked = 1
WHERE piece.id = 9268 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10697 AND linked.composer_id = 111), 'musicbrainz:d4cd8bc3-c50e-454f-bbc3-d52c653c5d61', 6, NULL, 'Gary Cooper', 'Gary Cooper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4cd8bc3-c50e-454f-bbc3-d52c653c5d61'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "Gary Cooper"', piece.title_en = 'Amarcord: Gary Cooper', piece.editor_locked = 1
WHERE piece.id = 10697 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10633 AND linked.composer_id = 111), 'musicbrainz:d02ffdd4-deea-404b-8abd-9050e1e539f9', 7, NULL, 'La Gradisca e il principe', 'La Gradisca e il principe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d02ffdd4-deea-404b-8abd-9050e1e539f9'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "La Gradisca e il principe"', piece.title_en = 'Amarcord: La Gradisca e il principe', piece.editor_locked = 1
WHERE piece.id = 10633 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9729 AND linked.composer_id = 111), 'musicbrainz:8dd7da97-3010-41ab-9ffd-aa26c6862e2e', 8, NULL, 'Ti ricordi di "Siboney"? / Siboney', 'Ti ricordi di "Siboney"? / Siboney', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dd7da97-3010-41ab-9ffd-aa26c6862e2e'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "Ti ricordi di "Siboney"? / Siboney"', piece.title_en = 'Amarcord: Ti ricordi di "Siboney"? / Siboney', piece.editor_locked = 1
WHERE piece.id = 9729 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11027 AND linked.composer_id = 111), 'musicbrainz:ed518789-c011-470e-8d72-764b1656a6d2', 9, NULL, 'Danzando nella nebbia', 'Danzando nella nebbia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed518789-c011-470e-8d72-764b1656a6d2'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "Danzando nella nebbia"', piece.title_en = 'Amarcord: Danzando nella nebbia', piece.editor_locked = 1
WHERE piece.id = 11027 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9695 AND linked.composer_id = 111), 'musicbrainz:8aec0680-a34d-471d-a2b7-eb2c2614d299', 10, NULL, 'Tutti a vedere il Rex', 'Tutti a vedere il Rex', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aec0680-a34d-471d-a2b7-eb2c2614d299'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "Tutti a vedere il Rex"', piece.title_en = 'Amarcord: Tutti a vedere il Rex', piece.editor_locked = 1
WHERE piece.id = 9695 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8350 AND linked.composer_id = 111), 'musicbrainz:2d20f52a-975b-4b5f-9bf7-1114f06e69fa', 11, NULL, 'Quanto mi piace la Gradisca', 'Quanto mi piace la Gradisca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d20f52a-975b-4b5f-9bf7-1114f06e69fa'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "Quanto mi piace la Gradisca"', piece.title_en = 'Amarcord: Quanto mi piace la Gradisca', piece.editor_locked = 1
WHERE piece.id = 8350 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9889 AND linked.composer_id = 111), 'musicbrainz:99a06059-73b4-4c8e-8f6f-d08f05bbf356', 12, NULL, 'La Gradisca si sposa e se ne va', 'La Gradisca si sposa e se ne va', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <아마코드> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a06059-73b4-4c8e-8f6f-d08f05bbf356'
);

UPDATE pieces piece
SET piece.title = '영화 <아마코드> 사운드트랙 중 "La Gradisca si sposa e se ne va"', piece.title_en = 'Amarcord: La Gradisca si sposa e se ne va', piece.editor_locked = 1
WHERE piece.id = 9889 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <Fortunella> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <Fortunella> 사운드트랙', 'Fortunella', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <Fortunella> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8814 AND linked.composer_id = 111), 'musicbrainz:4e06edb6-6e68-4d05-9214-8ddefc9e1216', 1, NULL, 'Titoli', 'Titoli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e06edb6-6e68-4d05-9214-8ddefc9e1216'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "Titoli"', piece.title_en = 'Fortunella: Titoli', piece.editor_locked = 1
WHERE piece.id = 8814 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10284 AND linked.composer_id = 111), 'musicbrainz:b62b3bf4-3c49-42bc-9b91-0a37e98ca359', 2, NULL, 'Dialogo fortunella', 'Dialogo fortunella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b62b3bf4-3c49-42bc-9b91-0a37e98ca359'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "Dialogo fortunella"', piece.title_en = 'Fortunella: Dialogo fortunella', piece.editor_locked = 1
WHERE piece.id = 10284 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7954 AND linked.composer_id = 111), 'musicbrainz:0f0b8052-1fd0-4959-893a-df94bbb04b49', 3, NULL, 'Fortunella all''ospedale', 'Fortunella all''ospedale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f0b8052-1fd0-4959-893a-df94bbb04b49'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "Fortunella all''ospedale"', piece.title_en = 'Fortunella: Fortunella all''ospedale', piece.editor_locked = 1
WHERE piece.id = 7954 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7788 AND linked.composer_id = 111), 'musicbrainz:04016e88-9a47-4a4b-9934-967ae6d396ba', 4, NULL, 'Fortunella scappa da casa', 'Fortunella scappa da casa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04016e88-9a47-4a4b-9934-967ae6d396ba'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "Fortunella scappa da casa"', piece.title_en = 'Fortunella: Fortunella scappa da casa', piece.editor_locked = 1
WHERE piece.id = 7788 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9329 AND linked.composer_id = 111), 'musicbrainz:7166b1e3-4fe7-440b-bf57-5dcc63885e7b', 5, NULL, 'I tre a letto', 'I tre a letto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7166b1e3-4fe7-440b-bf57-5dcc63885e7b'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "I tre a letto"', piece.title_en = 'Fortunella: I tre a letto', piece.editor_locked = 1
WHERE piece.id = 9329 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7966 AND linked.composer_id = 111), 'musicbrainz:0ff0011b-da41-4cd7-b113-714f72dc2d92', 6, NULL, 'La corona della pricipessa', 'La corona della pricipessa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ff0011b-da41-4cd7-b113-714f72dc2d92'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "La corona della pricipessa"', piece.title_en = 'Fortunella: La corona della pricipessa', piece.editor_locked = 1
WHERE piece.id = 7966 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11238 AND linked.composer_id = 111), 'musicbrainz:fce231ca-72f1-4dcf-952d-740d55b332a4', 7, NULL, 'Il ritratto della principessa', 'Il ritratto della principessa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fce231ca-72f1-4dcf-952d-740d55b332a4'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "Il ritratto della principessa"', piece.title_en = 'Fortunella: Il ritratto della principessa', piece.editor_locked = 1
WHERE piece.id = 11238 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8274 AND linked.composer_id = 111), 'musicbrainz:274a6f92-6412-4cb4-ad6e-a2999ee5ab02', 8, NULL, 'Fortunella e professore', 'Fortunella e professore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:274a6f92-6412-4cb4-ad6e-a2999ee5ab02'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "Fortunella e professore"', piece.title_en = 'Fortunella: Fortunella e professore', piece.editor_locked = 1
WHERE piece.id = 8274 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8159 AND linked.composer_id = 111), 'musicbrainz:1d5b8348-be95-4aec-a56d-e53b4cb15d46', 9, NULL, 'Al mercato', 'Al mercato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d5b8348-be95-4aec-a56d-e53b4cb15d46'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "Al mercato"', piece.title_en = 'Fortunella: Al mercato', piece.editor_locked = 1
WHERE piece.id = 8159 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10157 AND linked.composer_id = 111), 'musicbrainz:acda4491-3a9a-424a-93b1-b8da03a7003f', 10, NULL, 'Ingresso nel palazzo del principe', 'Ingresso nel palazzo del principe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acda4491-3a9a-424a-93b1-b8da03a7003f'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "Ingresso nel palazzo del principe"', piece.title_en = 'Fortunella: Ingresso nel palazzo del principe', piece.editor_locked = 1
WHERE piece.id = 10157 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8600 AND linked.composer_id = 111), 'musicbrainz:3f4dfcfe-43dc-4dd0-ac7a-4169c25da62b', 11, NULL, 'Evviva la principessa!', 'Evviva la principessa!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Fortunella> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f4dfcfe-43dc-4dd0-ac7a-4169c25da62b'
);

UPDATE pieces piece
SET piece.title = '영화 <Fortunella> 사운드트랙 중 "Evviva la principessa!"', piece.title_en = 'Fortunella: Evviva la principessa!', piece.editor_locked = 1
WHERE piece.id = 8600 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <Shoot Loud, Louder. . . I Don't Understand> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙', 'Shoot Loud, Louder. . . I Don''t Understand', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec9a1ceb-d907-4616-8ded-56960e2fcd94', 1, NULL, 'Raquel', 'Raquel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec9a1ceb-d907-4616-8ded-56960e2fcd94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9364 AND linked.composer_id = 111), 'musicbrainz:740437cc-b99c-49eb-a478-c557a0e9cbd7', 2, NULL, 'Mistero (Mystery)', 'Mistero (Mystery)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:740437cc-b99c-49eb-a478-c557a0e9cbd7'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Mistero (Mystery)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Mistero (Mystery)', piece.editor_locked = 1
WHERE piece.id = 9364 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:132365c3-4597-460e-90a2-8be5f280d977', 3, NULL, 'La Bandina (The Little Band)', 'La Bandina (The Little Band)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:132365c3-4597-460e-90a2-8be5f280d977'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8547 AND linked.composer_id = 111), 'musicbrainz:39f14412-1c09-4987-b792-f5505d4a8676', 4, NULL, '아라베스크', 'Arabesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39f14412-1c09-4987-b792-f5505d4a8676'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "아라베스크"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Arabesque', piece.editor_locked = 1
WHERE piece.id = 8547 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4032ded0-84ff-4e0c-beb7-7bb59488611f', 5, NULL, 'Raquel', 'Raquel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4032ded0-84ff-4e0c-beb7-7bb59488611f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9855 AND linked.composer_id = 111), 'musicbrainz:9792df68-7812-4ded-921c-96303aa7dabb', 6, NULL, 'Tarantella Grottesca (Grotesque Tarantella)', 'Tarantella Grottesca (Grotesque Tarantella)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9792df68-7812-4ded-921c-96303aa7dabb'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Tarantella Grottesca (Grotesque Tarantella)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Tarantella Grottesca (Grotesque Tarantella)', piece.editor_locked = 1
WHERE piece.id = 9855 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10067 AND linked.composer_id = 111), 'musicbrainz:a613202e-eac4-4a7b-8673-a6961923ef01', 7, NULL, 'Sospettoso Alberto (Suspicious Alberto)', 'Sospettoso Alberto (Suspicious Alberto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a613202e-eac4-4a7b-8673-a6961923ef01'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Sospettoso Alberto (Suspicious Alberto)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Sospettoso Alberto (Suspicious Alberto)', piece.editor_locked = 1
WHERE piece.id = 10067 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09483578-fc4f-4811-8297-53f862e82b30', 8, NULL, 'Raquel', 'Raquel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09483578-fc4f-4811-8297-53f862e82b30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9549 AND linked.composer_id = 111), 'musicbrainz:8087ad98-d032-4fe7-a94a-077a255fba7b', 9, NULL, 'Spara Fore! (Shoot Loud)', 'Spara Fore! (Shoot Loud)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8087ad98-d032-4fe7-a94a-077a255fba7b'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Spara Fore! (Shoot Loud)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Spara Fore! (Shoot Loud)', piece.editor_locked = 1
WHERE piece.id = 9549 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27b53e43-0ad2-46ca-9ed7-956ddc1ed17a', 10, NULL, 'Alberto And Raquel', 'Alberto And Raquel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27b53e43-0ad2-46ca-9ed7-956ddc1ed17a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10888 AND linked.composer_id = 111), 'musicbrainz:e3cb75aa-6795-447c-8dd5-a6e85097e65f', 11, NULL, 'I Guai Di Alberto (The Troubles Of Alberto)', 'I Guai Di Alberto (The Troubles Of Alberto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3cb75aa-6795-447c-8dd5-a6e85097e65f'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "I Guai Di Alberto (The Troubles Of Alberto)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: I Guai Di Alberto (The Troubles Of Alberto)', piece.editor_locked = 1
WHERE piece.id = 10888 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f53b1ae-7eec-4f84-8ac8-e409806d6da2', 12, NULL, 'Raquel', 'Raquel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f53b1ae-7eec-4f84-8ac8-e409806d6da2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10495 AND linked.composer_id = 111), 'musicbrainz:c5dbba2d-96cd-47b0-a93f-d9d67d760e8c', 13, NULL, 'Ballando Con Raquel (Dancing With Raquel)', 'Ballando Con Raquel (Dancing With Raquel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5dbba2d-96cd-47b0-a93f-d9d67d760e8c'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Ballando Con Raquel (Dancing With Raquel)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Ballando Con Raquel (Dancing With Raquel)', piece.editor_locked = 1
WHERE piece.id = 10495 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10318 AND linked.composer_id = 111), 'musicbrainz:b86e0f74-b7df-4a12-9f9a-821a3f804e6c', 14, NULL, 'Alberto Investiga (Alberto Investigates)', 'Alberto Investiga (Alberto Investigates)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b86e0f74-b7df-4a12-9f9a-821a3f804e6c'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Alberto Investiga (Alberto Investigates)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Alberto Investiga (Alberto Investigates)', piece.editor_locked = 1
WHERE piece.id = 10318 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61c77f57-9064-4295-b3f0-2fad0f68630b', 15, NULL, 'Raquel', 'Raquel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61c77f57-9064-4295-b3f0-2fad0f68630b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10016 AND linked.composer_id = 111), 'musicbrainz:a29aefbe-abb9-430d-8978-441bc7a74687', 16, NULL, 'Mistero II (Mystery #2)', 'Mistero II (Mystery #2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a29aefbe-abb9-430d-8978-441bc7a74687'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Mistero II (Mystery #2)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Mistero II (Mystery #2)', piece.editor_locked = 1
WHERE piece.id = 10016 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4240c5d2-e53b-4832-b44e-a6d9e0cd0054', 17, NULL, 'Alberto And Raquel', 'Alberto And Raquel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4240c5d2-e53b-4832-b44e-a6d9e0cd0054'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9920 AND linked.composer_id = 111), 'musicbrainz:9b8142d7-6f25-42a5-b318-9ca306c9aa47', 18, NULL, 'Mistero III (Mystery #3)', 'Mistero III (Mystery #3)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b8142d7-6f25-42a5-b318-9ca306c9aa47'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Mistero III (Mystery #3)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Mistero III (Mystery #3)', piece.editor_locked = 1
WHERE piece.id = 9920 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25128141-50c7-4d7b-a563-e474dca2a8d6', 19, NULL, 'Alberto And Raquel', 'Alberto And Raquel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25128141-50c7-4d7b-a563-e474dca2a8d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9ae291-54a8-4365-a639-951e73f7b291', 20, NULL, 'La Bandina (The Little Band)', 'La Bandina (The Little Band)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9ae291-54a8-4365-a639-951e73f7b291'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8743 AND linked.composer_id = 111), 'musicbrainz:48efe7d1-d1e8-4e58-bd55-22104fa8fa3b', 21, NULL, 'Raquel (End Credits)', 'Raquel (End Credits)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48efe7d1-d1e8-4e58-bd55-22104fa8fa3b'
);

UPDATE pieces piece
SET piece.title = '영화 <Shoot Loud, Louder. . . I Don''t Understand> 사운드트랙 중 "Raquel (End Credits)"', piece.title_en = 'Shoot Loud, Louder. . . I Don''t Understand: Raquel (End Credits)', piece.editor_locked = 1
WHERE piece.id = 8743 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <영혼의 줄리에타> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <영혼의 줄리에타> 사운드트랙', 'Giulietta degli spiriti', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <영혼의 줄리에타> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba8f985a-0226-4caf-a095-113c6480cfb7', 1, NULL, 'Amore per tutti', 'Amore per tutti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba8f985a-0226-4caf-a095-113c6480cfb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4218d27b-9083-437b-be42-69a6fbc5c806', 2, NULL, 'Faccette scintillanti', 'Faccette scintillanti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4218d27b-9083-437b-be42-69a6fbc5c806'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11099 AND linked.composer_id = 111), 'musicbrainz:f33d3acd-7193-4fc8-b713-94c96afc7947', 3, NULL, 'Rugiada sui ranocchi', 'Rugiada sui ranocchi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f33d3acd-7193-4fc8-b713-94c96afc7947'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Rugiada sui ranocchi"', piece.title_en = 'Giulietta degli spiriti: Rugiada sui ranocchi', piece.editor_locked = 1
WHERE piece.id = 11099 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9295 AND linked.composer_id = 111), 'musicbrainz:6f2b2c19-6da6-4cd0-b80e-de21caf8375d', 4, NULL, 'Vascello di Susi', 'Vascello di Susi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f2b2c19-6da6-4cd0-b80e-de21caf8375d'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Vascello di Susi"', piece.title_en = 'Giulietta degli spiriti: Vascello di Susi', piece.editor_locked = 1
WHERE piece.id = 9295 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10232 AND linked.composer_id = 111), 'musicbrainz:b1aeb4cc-fbfc-4906-ad7a-09133b1400f7', 5, NULL, 'Rosa aurata - la ballerina del circo snap', 'Rosa aurata - la ballerina del circo snap', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1aeb4cc-fbfc-4906-ad7a-09133b1400f7'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Rosa aurata - la ballerina del circo snap"', piece.title_en = 'Giulietta degli spiriti: Rosa aurata - la ballerina del circo snap', piece.editor_locked = 1
WHERE piece.id = 10232 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8621 AND linked.composer_id = 111), 'musicbrainz:40ab6262-5d8e-45c9-92c5-92ad1d1c74a7', 6, NULL, 'Il teatrino delle suore', 'Il teatrino delle suore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40ab6262-5d8e-45c9-92c5-92ad1d1c74a7'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Il teatrino delle suore"', piece.title_en = 'Giulietta degli spiriti: Il teatrino delle suore', piece.editor_locked = 1
WHERE piece.id = 8621 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9020 AND linked.composer_id = 111), 'musicbrainz:5b25783c-45c1-4c93-82fd-1b6f7cf0f469', 7, NULL, 'Valzerino del nonno', 'Valzerino del nonno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b25783c-45c1-4c93-82fd-1b6f7cf0f469'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Valzerino del nonno"', piece.title_en = 'Giulietta degli spiriti: Valzerino del nonno', piece.editor_locked = 1
WHERE piece.id = 9020 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10648 AND linked.composer_id = 111), 'musicbrainz:d17b1401-8c36-4316-99c9-35029dcec7a9', 8, NULL, 'Cupido ha sonno - la maestra d''amore', 'Cupido ha sonno - la maestra d''amore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d17b1401-8c36-4316-99c9-35029dcec7a9'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Cupido ha sonno - la maestra d''amore"', piece.title_en = 'Giulietta degli spiriti: Cupido ha sonno - la maestra d''amore', piece.editor_locked = 1
WHERE piece.id = 10648 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9055 AND linked.composer_id = 111), 'musicbrainz:5d8b8cd4-472b-4608-a94e-b16855cbe926', 9, NULL, 'Mi basta chiudere gli occhi - ecco i diavoli', 'Mi basta chiudere gli occhi - ecco i diavoli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d8b8cd4-472b-4608-a94e-b16855cbe926'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Mi basta chiudere gli occhi - ecco i diavoli"', piece.title_en = 'Giulietta degli spiriti: Mi basta chiudere gli occhi - ecco i diavoli', piece.editor_locked = 1
WHERE piece.id = 9055 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9229 AND linked.composer_id = 111), 'musicbrainz:6b2000b6-0e97-4d73-a9fc-4b24b6ecd16a', 10, NULL, 'Il giardino delle fate', 'Il giardino delle fate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b2000b6-0e97-4d73-a9fc-4b24b6ecd16a'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Il giardino delle fate"', piece.title_en = 'Giulietta degli spiriti: Il giardino delle fate', piece.editor_locked = 1
WHERE piece.id = 9229 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9428 AND linked.composer_id = 111), 'musicbrainz:7844021a-4cc9-4893-affc-3b75c8d6f0db', 11, NULL, 'Il charleston di Giulietta', 'Il charleston di Giulietta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7844021a-4cc9-4893-affc-3b75c8d6f0db'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "Il charleston di Giulietta"', piece.title_en = 'Giulietta degli spiriti: Il charleston di Giulietta', piece.editor_locked = 1
WHERE piece.id = 9428 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8329 AND linked.composer_id = 111), 'musicbrainz:2b74c206-01c8-4385-a2fd-fab9d1c1ac16', 12, NULL, 'L''arcobaleno per Giulietta', 'L''arcobaleno per Giulietta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <영혼의 줄리에타> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b74c206-01c8-4385-a2fd-fab9d1c1ac16'
);

UPDATE pieces piece
SET piece.title = '영화 <영혼의 줄리에타> 사운드트랙 중 "L''arcobaleno per Giulietta"', piece.title_en = 'Giulietta degli spiriti: L''arcobaleno per Giulietta', piece.editor_locked = 1
WHERE piece.id = 8329 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <나폴레옹> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <나폴레옹> 사운드트랙', 'Waterloo', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <나폴레옹> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10111 AND linked.composer_id = 111), 'musicbrainz:a90d7000-3c43-4c9b-841a-5e80074a77ed', 1, NULL, 'Titoli: Ritorno dall''Elba', 'Titoli: Ritorno dall''Elba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <나폴레옹> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a90d7000-3c43-4c9b-841a-5e80074a77ed'
);

UPDATE pieces piece
SET piece.title = '영화 <나폴레옹> 사운드트랙 중 "Titoli: Ritorno dall''Elba"', piece.title_en = 'Waterloo: Titoli: Ritorno dall''Elba', piece.editor_locked = 1
WHERE piece.id = 10111 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9024 AND linked.composer_id = 111), 'musicbrainz:5b6bd5e8-1942-4e17-9f9b-067d8c69e969', 2, NULL, 'Medley: Marcia scozzese / Saluto a Wellington e Promenade-Music', 'Medley: Marcia scozzese / Saluto a Wellington e Promenade-Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <나폴레옹> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b6bd5e8-1942-4e17-9f9b-067d8c69e969'
);

UPDATE pieces piece
SET piece.title = '영화 <나폴레옹> 사운드트랙 중 "Medley: Marcia scozzese / Saluto a Wellington e Promenade-Music"', piece.title_en = 'Waterloo: Medley: Marcia scozzese / Saluto a Wellington e Promenade-Music', piece.editor_locked = 1
WHERE piece.id = 9024 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8362 AND linked.composer_id = 111), 'musicbrainz:2dedfecf-472d-4da6-bb95-bd7abc4c14af', 3, NULL, 'Waterloo-Waltz', 'Waterloo-Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <나폴레옹> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dedfecf-472d-4da6-bb95-bd7abc4c14af'
);

UPDATE pieces piece
SET piece.title = '영화 <나폴레옹> 사운드트랙 중 "Waterloo-Waltz"', piece.title_en = 'Waterloo: Waterloo-Waltz', piece.editor_locked = 1
WHERE piece.id = 8362 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11206 AND linked.composer_id = 111), 'musicbrainz:fa5cf797-2d24-4adf-a19f-ea4bbc2b8825', 4, NULL, 'Medley: Notte di vigilia / Parata delle truppe napoleoniche', 'Medley: Notte di vigilia / Parata delle truppe napoleoniche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <나폴레옹> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa5cf797-2d24-4adf-a19f-ea4bbc2b8825'
);

UPDATE pieces piece
SET piece.title = '영화 <나폴레옹> 사운드트랙 중 "Medley: Notte di vigilia / Parata delle truppe napoleoniche"', piece.title_en = 'Waterloo: Medley: Notte di vigilia / Parata delle truppe napoleoniche', piece.editor_locked = 1
WHERE piece.id = 11206 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8983 AND linked.composer_id = 111), 'musicbrainz:58e8b489-718d-4028-a465-50230647a0d8', 5, NULL, 'Gli Scots Greys', 'Gli Scots Greys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <나폴레옹> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58e8b489-718d-4028-a465-50230647a0d8'
);

UPDATE pieces piece
SET piece.title = '영화 <나폴레옹> 사운드트랙 중 "Gli Scots Greys"', piece.title_en = 'Waterloo: Gli Scots Greys', piece.editor_locked = 1
WHERE piece.id = 8983 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7890 AND linked.composer_id = 111), 'musicbrainz:0a84be82-c1a0-4718-926b-e9bf93b630b0', 6, NULL, 'Medley: La voce della guerra / I tredici quadrati / How Can It Be?', 'Medley: La voce della guerra / I tredici quadrati / How Can It Be?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <나폴레옹> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a84be82-c1a0-4718-926b-e9bf93b630b0'
);

UPDATE pieces piece
SET piece.title = '영화 <나폴레옹> 사운드트랙 중 "Medley: La voce della guerra / I tredici quadrati / How Can It Be?"', piece.title_en = 'Waterloo: Medley: La voce della guerra / I tredici quadrati / How Can It Be?', piece.editor_locked = 1
WHERE piece.id = 7890 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9004 AND linked.composer_id = 111), 'musicbrainz:5a1ff0d0-adf0-43de-853a-e2c7d5ebe62e', 7, NULL, 'Medley: La Vieille Garde / I prussiani / Wellington (Now It''s Your Time!)', 'Medley: La Vieille Garde / I prussiani / Wellington (Now It''s Your Time!)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <나폴레옹> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a1ff0d0-adf0-43de-853a-e2c7d5ebe62e'
);

UPDATE pieces piece
SET piece.title = '영화 <나폴레옹> 사운드트랙 중 "Medley: La Vieille Garde / I prussiani / Wellington (Now It''s Your Time!)"', piece.title_en = 'Waterloo: Medley: La Vieille Garde / I prussiani / Wellington (Now It''s Your Time!)', piece.editor_locked = 1
WHERE piece.id = 9004 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8863 AND linked.composer_id = 111), 'musicbrainz:51521c55-6d97-4f22-87fa-1e7098a9da1e', 8, NULL, 'Il campo dei morti', 'Il campo dei morti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <나폴레옹> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51521c55-6d97-4f22-87fa-1e7098a9da1e'
);

UPDATE pieces piece
SET piece.title = '영화 <나폴레옹> 사운드트랙 중 "Il campo dei morti"', piece.title_en = 'Waterloo: Il campo dei morti', piece.editor_locked = 1
WHERE piece.id = 8863 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8746 AND linked.composer_id = 111), 'musicbrainz:4917fde2-f572-4490-bd2f-b15016e2f32c', 9, NULL, 'E la guerra continua (titoli finali)', 'E la guerra continua (titoli finali)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <나폴레옹> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4917fde2-f572-4490-bd2f-b15016e2f32c'
);

UPDATE pieces piece
SET piece.title = '영화 <나폴레옹> 사운드트랙 중 "E la guerra continua (titoli finali)"', piece.title_en = 'Waterloo: E la guerra continua (titoli finali)', piece.editor_locked = 1
WHERE piece.id = 8746 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <대부 2> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <대부 2> 사운드트랙', 'The Godfather, Part II', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <대부 2> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10780 AND linked.composer_id = 111), 'musicbrainz:daf41deb-125b-3817-b2ba-e6fea4e48619', 1, NULL, 'Main Title / The Immigrant', 'Main Title / The Immigrant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daf41deb-125b-3817-b2ba-e6fea4e48619'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 2> 사운드트랙 중 "Main Title / The Immigrant"', piece.title_en = 'The Godfather, Part II: Main Title / The Immigrant', piece.editor_locked = 1
WHERE piece.id = 10780 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:787b9164-8e5c-3fe2-8565-0367249fec34', 2, NULL, 'A New Carpet', 'A New Carpet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:787b9164-8e5c-3fe2-8565-0367249fec34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9609 AND linked.composer_id = 111), 'musicbrainz:84ed0ec6-81cd-3fc0-8543-b783e0d20470', 3, NULL, 'Kay', 'Kay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84ed0ec6-81cd-3fc0-8543-b783e0d20470'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 2> 사운드트랙 중 "Kay"', piece.title_en = 'The Godfather, Part II: Kay', piece.editor_locked = 1
WHERE piece.id = 9609 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10755 AND linked.composer_id = 111), 'musicbrainz:d914c298-ccf1-473c-9668-7ec7fd19ca48', 4, NULL, 'After the Party', 'After the Party', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d914c298-ccf1-473c-9668-7ec7fd19ca48'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 2> 사운드트랙 중 "After the Party"', piece.title_en = 'The Godfather, Part II: After the Party', piece.editor_locked = 1
WHERE piece.id = 10755 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10047 AND linked.composer_id = 111), 'musicbrainz:a45e93d9-e461-314c-9424-4509dcd132eb', 5, NULL, 'Vito and Abbandando', 'Vito and Abbandando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a45e93d9-e461-314c-9424-4509dcd132eb'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 2> 사운드트랙 중 "Vito and Abbandando"', piece.title_en = 'The Godfather, Part II: Vito and Abbandando', piece.editor_locked = 1
WHERE piece.id = 10047 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9322 AND linked.composer_id = 111), 'musicbrainz:7123afda-6663-3484-b1cc-df59e7c281d9', 6, NULL, 'The Godfathers at Home', 'The Godfathers at Home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7123afda-6663-3484-b1cc-df59e7c281d9'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 2> 사운드트랙 중 "The Godfathers at Home"', piece.title_en = 'The Godfather, Part II: The Godfathers at Home', piece.editor_locked = 1
WHERE piece.id = 9322 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8564 AND linked.composer_id = 111), 'musicbrainz:3af1df47-44e1-34bb-9354-8d88dedc8a81', 7, NULL, 'Remember Vito Andolini', 'Remember Vito Andolini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3af1df47-44e1-34bb-9354-8d88dedc8a81'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 2> 사운드트랙 중 "Remember Vito Andolini"', piece.title_en = 'The Godfather, Part II: Remember Vito Andolini', piece.editor_locked = 1
WHERE piece.id = 8564 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9900 AND linked.composer_id = 111), 'musicbrainz:9a4d3bf9-8756-37d7-a42b-86e182174a52', 8, NULL, 'Michael Comes Home', 'Michael Comes Home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a4d3bf9-8756-37d7-a42b-86e182174a52'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 2> 사운드트랙 중 "Michael Comes Home"', piece.title_en = 'The Godfather, Part II: Michael Comes Home', piece.editor_locked = 1
WHERE piece.id = 9900 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9953280d-a602-3a5d-8714-5a717937a058', 9, NULL, 'Ninna Nanna a Michele', 'Ninna Nanna a Michele', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9953280d-a602-3a5d-8714-5a717937a058'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10415 AND linked.composer_id = 111), 'musicbrainz:bfda9317-638a-35a1-a440-8049427f1e0a', 10, NULL, 'The Brothers Mourn', 'The Brothers Mourn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfda9317-638a-35a1-a440-8049427f1e0a'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 2> 사운드트랙 중 "The Brothers Mourn"', piece.title_en = 'The Godfather, Part II: The Brothers Mourn', piece.editor_locked = 1
WHERE piece.id = 10415 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad29b8b7-fcc9-3304-afc7-734e08805463', 11, NULL, 'End Title', 'End Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 2> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad29b8b7-fcc9-3304-afc7-734e08805463'
);


-- None 영화 <사기꾼들> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <사기꾼들> 사운드트랙', 'Il bidone', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <사기꾼들> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b508619a-973a-4dd3-98b5-7cffb4abd6a2', 1, NULL, 'Il bidone', 'Il bidone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사기꾼들> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b508619a-973a-4dd3-98b5-7cffb4abd6a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9822 AND linked.composer_id = 111), 'musicbrainz:94719ba6-ab71-4446-940b-7da72abe37a3', 2, NULL, 'La moglie del bidonista', 'La moglie del bidonista', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사기꾼들> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94719ba6-ab71-4446-940b-7da72abe37a3'
);

UPDATE pieces piece
SET piece.title = '영화 <사기꾼들> 사운드트랙 중 "La moglie del bidonista"', piece.title_en = 'Il bidone: La moglie del bidonista', piece.editor_locked = 1
WHERE piece.id = 9822 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10343 AND linked.composer_id = 111), 'musicbrainz:ba402bef-7837-4d06-9f38-ccf0ba49c936', 3, NULL, 'Il tesoro nascosto', 'Il tesoro nascosto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사기꾼들> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba402bef-7837-4d06-9f38-ccf0ba49c936'
);

UPDATE pieces piece
SET piece.title = '영화 <사기꾼들> 사운드트랙 중 "Il tesoro nascosto"', piece.title_en = 'Il bidone: Il tesoro nascosto', piece.editor_locked = 1
WHERE piece.id = 10343 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11073 AND linked.composer_id = 111), 'musicbrainz:f12a3784-4db3-4523-a0a7-87d2306ac9d4', 4, NULL, 'Coimbra / La festa dei bidonisti', 'Coimbra / La festa dei bidonisti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사기꾼들> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f12a3784-4db3-4523-a0a7-87d2306ac9d4'
);

UPDATE pieces piece
SET piece.title = '영화 <사기꾼들> 사운드트랙 중 "Coimbra / La festa dei bidonisti"', piece.title_en = 'Il bidone: Coimbra / La festa dei bidonisti', piece.editor_locked = 1
WHERE piece.id = 11073 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9038 AND linked.composer_id = 111), 'musicbrainz:5c664c9d-aac3-4bdd-9ef0-5df3b5c9a03d', 5, NULL, 'In viaggio per un bidone', 'In viaggio per un bidone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사기꾼들> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c664c9d-aac3-4bdd-9ef0-5df3b5c9a03d'
);

UPDATE pieces piece
SET piece.title = '영화 <사기꾼들> 사운드트랙 중 "In viaggio per un bidone"', piece.title_en = 'Il bidone: In viaggio per un bidone', piece.editor_locked = 1
WHERE piece.id = 9038 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9081 AND linked.composer_id = 111), 'musicbrainz:5fa0f0fd-3e7e-4980-a0a1-410b8582bba2', 6, NULL, 'Al cinema', 'Al cinema', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사기꾼들> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa0f0fd-3e7e-4980-a0a1-410b8582bba2'
);

UPDATE pieces piece
SET piece.title = '영화 <사기꾼들> 사운드트랙 중 "Al cinema"', piece.title_en = 'Il bidone: Al cinema', piece.editor_locked = 1
WHERE piece.id = 9081 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10964 AND linked.composer_id = 111), 'musicbrainz:e8d99616-f40e-4b3c-9c2e-c6d1f324c70c', 7, NULL, 'Cara bambina', 'Cara bambina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사기꾼들> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8d99616-f40e-4b3c-9c2e-c6d1f324c70c'
);

UPDATE pieces piece
SET piece.title = '영화 <사기꾼들> 사운드트랙 중 "Cara bambina"', piece.title_en = 'Il bidone: Cara bambina', piece.editor_locked = 1
WHERE piece.id = 10964 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9469 AND linked.composer_id = 111), 'musicbrainz:7b0fc23a-8ba6-4343-af22-c5882e7c7746', 8, NULL, 'Ballerina night', 'Ballerina night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사기꾼들> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b0fc23a-8ba6-4343-af22-c5882e7c7746'
);

UPDATE pieces piece
SET piece.title = '영화 <사기꾼들> 사운드트랙 중 "Ballerina night"', piece.title_en = 'Il bidone: Ballerina night', piece.editor_locked = 1
WHERE piece.id = 9469 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9859 AND linked.composer_id = 111), 'musicbrainz:97dc5136-2602-431b-a084-2b4663ea489a', 9, NULL, 'L''ultimo bidone', 'L''ultimo bidone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <사기꾼들> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97dc5136-2602-431b-a084-2b4663ea489a'
);

UPDATE pieces piece
SET piece.title = '영화 <사기꾼들> 사운드트랙 중 "L''ultimo bidone"', piece.title_en = 'Il bidone: L''ultimo bidone', piece.editor_locked = 1
WHERE piece.id = 9859 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <Film D'Amore e D'Anarchia> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <Film D''Amore e D''Anarchia> 사운드트랙', 'Film D''Amore e D''Anarchia', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8026 AND linked.composer_id = 111), 'musicbrainz:138322d3-4fe0-3bf4-9f00-eaa00850aeb6', 1, NULL, 'Canzone arrabbiata', 'Canzone arrabbiata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:138322d3-4fe0-3bf4-9f00-eaa00850aeb6'
);

UPDATE pieces piece
SET piece.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Canzone arrabbiata"', piece.title_en = 'Film D''Amore e D''Anarchia: Canzone arrabbiata', piece.editor_locked = 1
WHERE piece.id = 8026 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10287 AND linked.composer_id = 111), 'musicbrainz:b643e787-980b-3b64-aec7-a4028127e042', 2, NULL, 'Antonio Soffiantini detto "Tunin"', 'Antonio Soffiantini detto "Tunin"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b643e787-980b-3b64-aec7-a4028127e042'
);

UPDATE pieces piece
SET piece.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Antonio Soffiantini detto "Tunin""', piece.title_en = 'Film D''Amore e D''Anarchia: Antonio Soffiantini detto "Tunin"', piece.editor_locked = 1
WHERE piece.id = 10287 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9891 AND linked.composer_id = 111), 'musicbrainz:99c44b3c-4d46-37b2-85ee-957f7bef6a49', 3, NULL, 'Ninna nanna', 'Ninna nanna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99c44b3c-4d46-37b2-85ee-957f7bef6a49'
);

UPDATE pieces piece
SET piece.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Ninna nanna"', piece.title_en = 'Film D''Amore e D''Anarchia: Ninna nanna', piece.editor_locked = 1
WHERE piece.id = 9891 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10116 AND linked.composer_id = 111), 'musicbrainz:a98aa5c9-649f-3600-928d-f6a75f2682df', 4, NULL, 'Passeggiata', 'Passeggiata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a98aa5c9-649f-3600-928d-f6a75f2682df'
);

UPDATE pieces piece
SET piece.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Passeggiata"', piece.title_en = 'Film D''Amore e D''Anarchia: Passeggiata', piece.editor_locked = 1
WHERE piece.id = 10116 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10929 AND linked.composer_id = 111), 'musicbrainz:e6b1ebed-4cbd-3b6f-9c69-b31f72038534', 5, NULL, 'Voci casa tolleranza', 'Voci casa tolleranza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6b1ebed-4cbd-3b6f-9c69-b31f72038534'
);

UPDATE pieces piece
SET piece.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Voci casa tolleranza"', piece.title_en = 'Film D''Amore e D''Anarchia: Voci casa tolleranza', piece.editor_locked = 1
WHERE piece.id = 10929 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8774 AND linked.composer_id = 111), 'musicbrainz:4ac8bd93-68cf-39f5-935d-a380fde12759', 6, NULL, 'Amara me', 'Amara me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ac8bd93-68cf-39f5-935d-a380fde12759'
);

UPDATE pieces piece
SET piece.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Amara me"', piece.title_en = 'Film D''Amore e D''Anarchia: Amara me', piece.editor_locked = 1
WHERE piece.id = 8774 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7955 AND linked.composer_id = 111), 'musicbrainz:0f0cacc1-7b0b-3153-9e4d-8ebaa2edabdc', 7, NULL, 'Canzone appassionata', 'Canzone appassionata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f0cacc1-7b0b-3153-9e4d-8ebaa2edabdc'
);

UPDATE pieces piece
SET piece.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Canzone appassionata"', piece.title_en = 'Film D''Amore e D''Anarchia: Canzone appassionata', piece.editor_locked = 1
WHERE piece.id = 7955 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10167 AND linked.composer_id = 111), 'musicbrainz:ad77f73e-7c91-3184-98f3-b5370f047fee', 8, NULL, 'Canzone arrabbiata finale', 'Canzone arrabbiata finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad77f73e-7c91-3184-98f3-b5370f047fee'
);

UPDATE pieces piece
SET piece.title = '영화 <Film D''Amore e D''Anarchia> 사운드트랙 중 "Canzone arrabbiata finale"', piece.title_en = 'Film D''Amore e D''Anarchia: Canzone arrabbiata finale', piece.editor_locked = 1
WHERE piece.id = 10167 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <로마> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <로마> 사운드트랙', 'Roma', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <로마> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8317 AND linked.composer_id = 111), 'musicbrainz:2ab4d3d1-c8dd-4666-8b33-f2adcb7200c9', 1, NULL, 'Aria di Roma', 'Aria di Roma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <로마> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ab4d3d1-c8dd-4666-8b33-f2adcb7200c9'
);

UPDATE pieces piece
SET piece.title = '영화 <로마> 사운드트랙 중 "Aria di Roma"', piece.title_en = 'Roma: Aria di Roma', piece.editor_locked = 1
WHERE piece.id = 8317 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7806 AND linked.composer_id = 111), 'musicbrainz:04cd7708-d389-4080-abc8-9712e7415217', 2, NULL, 'Feast of the Snails', 'Feast of the Snails', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <로마> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04cd7708-d389-4080-abc8-9712e7415217'
);

UPDATE pieces piece
SET piece.title = '영화 <로마> 사운드트랙 중 "Feast of the Snails"', piece.title_en = 'Roma: Feast of the Snails', piece.editor_locked = 1
WHERE piece.id = 7806 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8836 AND linked.composer_id = 111), 'musicbrainz:4fcb85aa-fa9c-4b1c-a01c-2fd4ed09b2c8', 3, NULL, 'Vitelloni''s Bar', 'Vitelloni''s Bar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <로마> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fcb85aa-fa9c-4b1c-a01c-2fd4ed09b2c8'
);

UPDATE pieces piece
SET piece.title = '영화 <로마> 사운드트랙 중 "Vitelloni''s Bar"', piece.title_en = 'Roma: Vitelloni''s Bar', piece.editor_locked = 1
WHERE piece.id = 8836 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10540 AND linked.composer_id = 111), 'musicbrainz:c941c4a1-c927-453c-b986-66700c7bc1a5', 4, NULL, 'Barafonda Theatre', 'Barafonda Theatre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <로마> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c941c4a1-c927-453c-b986-66700c7bc1a5'
);

UPDATE pieces piece
SET piece.title = '영화 <로마> 사운드트랙 중 "Barafonda Theatre"', piece.title_en = 'Roma: Barafonda Theatre', piece.editor_locked = 1
WHERE piece.id = 10540 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9284 AND linked.composer_id = 111), 'musicbrainz:6e943e75-7598-433d-82b3-0a48f9bac9e9', 5, NULL, 'Trasteverina (Reprise)', 'Trasteverina (Reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <로마> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e943e75-7598-433d-82b3-0a48f9bac9e9'
);

UPDATE pieces piece
SET piece.title = '영화 <로마> 사운드트랙 중 "Trasteverina (Reprise)"', piece.title_en = 'Roma: Trasteverina (Reprise)', piece.editor_locked = 1
WHERE piece.id = 9284 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8325 AND linked.composer_id = 111), 'musicbrainz:2b4765a4-7f17-455d-be2e-738d4707f034', 6, NULL, 'Ecclesiastical Fashion Show', 'Ecclesiastical Fashion Show', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <로마> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b4765a4-7f17-455d-be2e-738d4707f034'
);

UPDATE pieces piece
SET piece.title = '영화 <로마> 사운드트랙 중 "Ecclesiastical Fashion Show"', piece.title_en = 'Roma: Ecclesiastical Fashion Show', piece.editor_locked = 1
WHERE piece.id = 8325 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10332 AND linked.composer_id = 111), 'musicbrainz:b9af5f58-08ad-4abe-905e-047cfb079279', 7, NULL, 'Roman Festival', 'Roman Festival', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <로마> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9af5f58-08ad-4abe-905e-047cfb079279'
);

UPDATE pieces piece
SET piece.title = '영화 <로마> 사운드트랙 중 "Roman Festival"', piece.title_en = 'Roma: Roman Festival', piece.editor_locked = 1
WHERE piece.id = 10332 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mysterium Catholicum

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mysterium Catholicum', 'Mysterium Catholicum', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mysterium Catholicum'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9128 AND linked.composer_id = 111), 'musicbrainz:63012b96-14e4-401b-9b7e-b6b428a2b36a', 1, NULL, 'I - in principio erat verbum', 'I - in principio erat verbum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Mysterium Catholicum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63012b96-14e4-401b-9b7e-b6b428a2b36a'
);

UPDATE pieces piece
SET piece.title = 'Mysterium Catholicum 중 "I - in principio erat verbum"', piece.title_en = 'Mysterium Catholicum: I - in principio erat verbum', piece.editor_locked = 1
WHERE piece.id = 9128 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11215 AND linked.composer_id = 111), 'musicbrainz:fb11856d-4ac5-49f9-a71c-ab32dd68f669', 2, NULL, 'II e III - quoniam unus est panis', 'II e III - quoniam unus est panis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Mysterium Catholicum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb11856d-4ac5-49f9-a71c-ab32dd68f669'
);

UPDATE pieces piece
SET piece.title = 'Mysterium Catholicum 중 "II e III - quoniam unus est panis"', piece.title_en = 'Mysterium Catholicum: II e III - quoniam unus est panis', piece.editor_locked = 1
WHERE piece.id = 11215 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10836 AND linked.composer_id = 111), 'musicbrainz:df314ebb-8b69-4526-9c11-35fa9851e570', 3, NULL, 'IV - duae viae sunt', 'IV - duae viae sunt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Mysterium Catholicum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df314ebb-8b69-4526-9c11-35fa9851e570'
);

UPDATE pieces piece
SET piece.title = 'Mysterium Catholicum 중 "IV - duae viae sunt"', piece.title_en = 'Mysterium Catholicum: IV - duae viae sunt', piece.editor_locked = 1
WHERE piece.id = 10836 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8991 AND linked.composer_id = 111), 'musicbrainz:5949dc2e-c4a9-495c-9527-7ddfde0c53ef', 4, NULL, 'V - venit hora ut clarificetur', 'V - venit hora ut clarificetur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Mysterium Catholicum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5949dc2e-c4a9-495c-9527-7ddfde0c53ef'
);

UPDATE pieces piece
SET piece.title = 'Mysterium Catholicum 중 "V - venit hora ut clarificetur"', piece.title_en = 'Mysterium Catholicum: V - venit hora ut clarificetur', piece.editor_locked = 1
WHERE piece.id = 8991 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9940 AND linked.composer_id = 111), 'musicbrainz:9c6ec0a0-f62e-40e1-a84e-8ae85f3941c7', 5, NULL, 'VI - quemadmodum fuit hoc molitum far', 'VI - quemadmodum fuit hoc molitum far', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Mysterium Catholicum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c6ec0a0-f62e-40e1-a84e-8ae85f3941c7'
);

UPDATE pieces piece
SET piece.title = 'Mysterium Catholicum 중 "VI - quemadmodum fuit hoc molitum far"', piece.title_en = 'Mysterium Catholicum: VI - quemadmodum fuit hoc molitum far', piece.editor_locked = 1
WHERE piece.id = 9940 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10175 AND linked.composer_id = 111), 'musicbrainz:adc5a01e-f663-42fc-98e2-6ede23cc66eb', 6, NULL, 'VII - quotquot autem receperunt eum', 'VII - quotquot autem receperunt eum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Mysterium Catholicum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adc5a01e-f663-42fc-98e2-6ede23cc66eb'
);

UPDATE pieces piece
SET piece.title = 'Mysterium Catholicum 중 "VII - quotquot autem receperunt eum"', piece.title_en = 'Mysterium Catholicum: VII - quotquot autem receperunt eum', piece.editor_locked = 1
WHERE piece.id = 10175 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <달콤한 인생> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <달콤한 인생> 사운드트랙', 'La dolce vita', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <달콤한 인생> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10685 AND linked.composer_id = 111), 'musicbrainz:d3efd514-9ce6-4a91-b8ea-9ca3f6e26434', 1, NULL, 'Via Veneto', 'La dolce vita – Via Veneto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3efd514-9ce6-4a91-b8ea-9ca3f6e26434'
);

UPDATE pieces piece
SET piece.title = '영화 <달콤한 인생> 사운드트랙 중 "Via Veneto"', piece.title_en = 'La dolce vita: La dolce vita – Via Veneto', piece.editor_locked = 1
WHERE piece.id = 10685 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9279 AND linked.composer_id = 111), 'musicbrainz:6e55f3ae-db68-49ee-9457-184fa0c4f1d7', 2, NULL, 'Valzer (Parlami di me)', 'Valzer (Parlami di me)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e55f3ae-db68-49ee-9457-184fa0c4f1d7'
);

UPDATE pieces piece
SET piece.title = '영화 <달콤한 인생> 사운드트랙 중 "Valzer (Parlami di me)"', piece.title_en = 'La dolce vita: Valzer (Parlami di me)', piece.editor_locked = 1
WHERE piece.id = 9279 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7983 AND linked.composer_id = 111), 'musicbrainz:111b2574-2397-4129-ac0b-de9c8b0556cf', 3, NULL, 'Via Veneto e i nobili', 'Via Veneto e i nobili', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:111b2574-2397-4129-ac0b-de9c8b0556cf'
);

UPDATE pieces piece
SET piece.title = '영화 <달콤한 인생> 사운드트랙 중 "Via Veneto e i nobili"', piece.title_en = 'La dolce vita: Via Veneto e i nobili', piece.editor_locked = 1
WHERE piece.id = 7983 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8952 AND linked.composer_id = 111), 'musicbrainz:56f9c831-a3df-4789-8139-0e314e5c8d37', 4, NULL, 'Blues – La dolce vita dei nobili', 'Blues – La dolce vita dei nobili', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56f9c831-a3df-4789-8139-0e314e5c8d37'
);

UPDATE pieces piece
SET piece.title = '영화 <달콤한 인생> 사운드트랙 중 "Blues – La dolce vita dei nobili"', piece.title_en = 'La dolce vita: Blues – La dolce vita dei nobili', piece.editor_locked = 1
WHERE piece.id = 8952 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07bae02c-ebd1-43fe-a575-6db60dd7cd5a', 5, NULL, 'Suite: 9. La dolce vita', 'La dolce vita - Suite: 9. La dolce vita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07bae02c-ebd1-43fe-a575-6db60dd7cd5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10239 AND linked.composer_id = 111), 'musicbrainz:b29c0b8e-7f06-46c0-9649-cfc283ae557f', 6, NULL, 'finale', 'La dolce vita: finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b29c0b8e-7f06-46c0-9649-cfc283ae557f'
);

UPDATE pieces piece
SET piece.title = '영화 <달콤한 인생> 사운드트랙 중 "finale"', piece.title_en = 'La dolce vita: La dolce vita: finale', piece.editor_locked = 1
WHERE piece.id = 10239 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9956 AND linked.composer_id = 111), 'musicbrainz:9e09ac78-ce22-40a2-868f-a2465723bea8', 7, NULL, 'Titoli di testa – Canzonetta – Notturno – Cadillac', 'Titoli di testa – Canzonetta – Notturno – Cadillac', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e09ac78-ce22-40a2-868f-a2465723bea8'
);

UPDATE pieces piece
SET piece.title = '영화 <달콤한 인생> 사운드트랙 중 "Titoli di testa – Canzonetta – Notturno – Cadillac"', piece.title_en = 'La dolce vita: Titoli di testa – Canzonetta – Notturno – Cadillac', piece.editor_locked = 1
WHERE piece.id = 9956 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11020 AND linked.composer_id = 111), 'musicbrainz:ecb81c54-404a-4bdd-bb34-f7a65adbf94f', 8, NULL, 'Notturno o mattutino', 'Notturno o mattutino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecb81c54-404a-4bdd-bb34-f7a65adbf94f'
);

UPDATE pieces piece
SET piece.title = '영화 <달콤한 인생> 사운드트랙 중 "Notturno o mattutino"', piece.title_en = 'La dolce vita: Notturno o mattutino', piece.editor_locked = 1
WHERE piece.id = 11020 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d43dd5f-6ccd-4bcf-b993-31f642b21029', 9, NULL, 'La dolce vita', 'La dolce vita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d43dd5f-6ccd-4bcf-b993-31f642b21029'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b508619a-973a-4dd3-98b5-7cffb4abd6a2', 10, NULL, 'Il bidone', 'Il bidone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b508619a-973a-4dd3-98b5-7cffb4abd6a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94719ba6-ab71-4446-940b-7da72abe37a3', 11, NULL, 'La moglie del bidonista', 'La moglie del bidonista', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94719ba6-ab71-4446-940b-7da72abe37a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba402bef-7837-4d06-9f38-ccf0ba49c936', 12, NULL, 'Il tesoro nascosto', 'Il tesoro nascosto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba402bef-7837-4d06-9f38-ccf0ba49c936'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f12a3784-4db3-4523-a0a7-87d2306ac9d4', 13, NULL, 'Coimbra / La festa dei bidonisti', 'Coimbra / La festa dei bidonisti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f12a3784-4db3-4523-a0a7-87d2306ac9d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c664c9d-aac3-4bdd-9ef0-5df3b5c9a03d', 14, NULL, 'In viaggio per un bidone', 'In viaggio per un bidone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c664c9d-aac3-4bdd-9ef0-5df3b5c9a03d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fa0f0fd-3e7e-4980-a0a1-410b8582bba2', 15, NULL, 'Al cinema', 'Al cinema', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa0f0fd-3e7e-4980-a0a1-410b8582bba2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8d99616-f40e-4b3c-9c2e-c6d1f324c70c', 16, NULL, 'Cara bambina', 'Cara bambina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8d99616-f40e-4b3c-9c2e-c6d1f324c70c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b0fc23a-8ba6-4343-af22-c5882e7c7746', 17, NULL, 'Ballerina night', 'Ballerina night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b0fc23a-8ba6-4343-af22-c5882e7c7746'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97dc5136-2602-431b-a084-2b4663ea489a', 18, NULL, 'L''ultimo bidone', 'L''ultimo bidone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <달콤한 인생> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97dc5136-2602-431b-a084-2b4663ea489a'
);


-- None 영화 <오케스트라 리허설> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <오케스트라 리허설> 사운드트랙', 'Prova d''orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <오케스트라 리허설> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7657 AND linked.composer_id = 111), 'musicbrainz:76a82803-032b-463e-b0ca-4a504c47aa56', 1, NULL, 'I gemelli allo specchio', 'I gemelli allo specchio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <오케스트라 리허설> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76a82803-032b-463e-b0ca-4a504c47aa56'
);

UPDATE pieces piece
SET piece.title = '영화 <오케스트라 리허설> 사운드트랙 중 "I gemelli allo specchio"', piece.title_en = 'Prova d''orchestra: I gemelli allo specchio', piece.editor_locked = 1
WHERE piece.id = 7657 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9530 AND linked.composer_id = 111), 'musicbrainz:7ec17729-fb8e-459b-bd92-1e13a5a96cfc', 2, NULL, 'Risatine maliziose', 'Risatine maliziose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <오케스트라 리허설> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ec17729-fb8e-459b-bd92-1e13a5a96cfc'
);

UPDATE pieces piece
SET piece.title = '영화 <오케스트라 리허설> 사운드트랙 중 "Risatine maliziose"', piece.title_en = 'Prova d''orchestra: Risatine maliziose', piece.editor_locked = 1
WHERE piece.id = 9530 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7658 AND linked.composer_id = 111), 'musicbrainz:a1095989-ac8c-44e6-bddf-e12253ad6aeb', 3, NULL, 'Valzerino n. 72', 'Valzerino n. 72', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <오케스트라 리허설> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1095989-ac8c-44e6-bddf-e12253ad6aeb'
);

UPDATE pieces piece
SET piece.title = '영화 <오케스트라 리허설> 사운드트랙 중 "Valzerino n. 72"', piece.title_en = 'Prova d''orchestra: Valzerino n. 72', piece.editor_locked = 1
WHERE piece.id = 7658 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7684 AND linked.composer_id = 111), 'musicbrainz:4f04ea56-f4af-4950-b327-3b2b7c97d7d5', 4, NULL, 'Orchestra in attesa', 'Orchestra in attesa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <오케스트라 리허설> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f04ea56-f4af-4950-b327-3b2b7c97d7d5'
);

UPDATE pieces piece
SET piece.title = '영화 <오케스트라 리허설> 사운드트랙 중 "Orchestra in attesa"', piece.title_en = 'Prova d''orchestra: Orchestra in attesa', piece.editor_locked = 1
WHERE piece.id = 7684 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7656 AND linked.composer_id = 111), 'musicbrainz:f6f0f1f5-d94f-4f33-83cf-56c1e8c50a73', 5, NULL, 'Galopp', 'Galopp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <오케스트라 리허설> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6f0f1f5-d94f-4f33-83cf-56c1e8c50a73'
);

UPDATE pieces piece
SET piece.title = '영화 <오케스트라 리허설> 사운드트랙 중 "Galopp"', piece.title_en = 'Prova d''orchestra: Galopp', piece.editor_locked = 1
WHERE piece.id = 7656 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chamber Music

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Chamber Music', 'Chamber Music', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Chamber Music'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7945 AND linked.composer_id = 111), 'musicbrainz:0e6449b0-ff01-4806-ab07-1e12a74c809d', 1, NULL, 'Piccola offerta musicale', 'Piccola offerta musicale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e6449b0-ff01-4806-ab07-1e12a74c809d'
);

UPDATE pieces piece
SET piece.title = 'Chamber Music 중 "Piccola offerta musicale"', piece.title_en = 'Chamber Music: Piccola offerta musicale', piece.editor_locked = 1
WHERE piece.id = 7945 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d99be9c0-ccd0-4285-9dc4-439e9623509b', 2, NULL, 'Sarabanda e Toccata per Arpa: Sarabanda', 'Sarabanda e Toccata per Arpa: Sarabanda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d99be9c0-ccd0-4285-9dc4-439e9623509b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df962713-90cb-418a-9da8-4c5e10bdbd9b', 3, NULL, 'Sarabanda e Toccata per Arpa: Toccata', 'Sarabanda e Toccata per Arpa: Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df962713-90cb-418a-9da8-4c5e10bdbd9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bc9a409-8520-425d-ba30-88fed58e43aa', 4, NULL, 'Trio per Flauto, Violino e Pianoforte: I. Allegro ma non troppo', 'Trio per Flauto, Violino e Pianoforte: I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bc9a409-8520-425d-ba30-88fed58e43aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9be29db0-e222-4209-a66a-82215c57c986', 5, NULL, 'Trio per Flauto, Violino e Pianoforte: II. Andante sostenuto', 'Trio per Flauto, Violino e Pianoforte: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9be29db0-e222-4209-a66a-82215c57c986'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89338a14-9030-445b-9322-144ecfaf8486', 6, NULL, 'Trio per Flauto, Violino e Pianoforte: III. Allegro vivace con spirito', 'Trio per Flauto, Violino e Pianoforte: III. Allegro vivace con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89338a14-9030-445b-9322-144ecfaf8486'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9591 AND linked.composer_id = 111), 'musicbrainz:83b49d27-8b1d-4cee-be05-38497d9f9abe', 7, NULL, 'Ippolito gioca per Pianoforte', 'Ippolito gioca per Pianoforte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83b49d27-8b1d-4cee-be05-38497d9f9abe'
);

UPDATE pieces piece
SET piece.title = 'Chamber Music 중 "Ippolito gioca per Pianoforte"', piece.title_en = 'Chamber Music: Ippolito gioca per Pianoforte', piece.editor_locked = 1
WHERE piece.id = 9591 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8139 AND linked.composer_id = 111), 'musicbrainz:1bd8b349-bc88-406c-a99d-d04a5b065afc', 8, NULL, 'Il Presepio', 'Il Presepio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd8b349-bc88-406c-a99d-d04a5b065afc'
);

UPDATE pieces piece
SET piece.title = 'Chamber Music 중 "Il Presepio"', piece.title_en = 'Chamber Music: Il Presepio', piece.editor_locked = 1
WHERE piece.id = 8139 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c245eab5-90c1-44a9-9366-babfa3b16dc5', 9, NULL, 'Sette Pezzi Difficili per Bambini: No. 3. Capriccio, Cantilena', 'Sette Pezzi Difficili per Bambini: No. 3. Capriccio, Cantilena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c245eab5-90c1-44a9-9366-babfa3b16dc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9063 AND linked.composer_id = 111), 'musicbrainz:5e221754-2453-4dbe-88a2-a4a6c23dcb0d', 10, NULL, '비올라와 피아노를 위한 간주곡', 'Intermezzo per viola e pianoforte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e221754-2453-4dbe-88a2-a4a6c23dcb0d'
);

UPDATE pieces piece
SET piece.title = 'Chamber Music 중 "비올라와 피아노를 위한 간주곡"', piece.title_en = 'Chamber Music: Intermezzo per viola e pianoforte', piece.editor_locked = 1
WHERE piece.id = 9063 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3efd27d-042b-499b-8056-ed4ab9c0910f', 11, NULL, 'Sette Pezzi Difficili per Bambini: No. 5. Puccettino nella giungla', 'Sette Pezzi Difficili per Bambini: No. 5. Puccettino nella giungla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3efd27d-042b-499b-8056-ed4ab9c0910f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6745f856-6968-4566-acc5-72bbe83327d1', 12, NULL, 'Nonetto: I. Allegro', 'Nonetto: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6745f856-6968-4566-acc5-72bbe83327d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b17e3dca-1bb7-42cf-bc46-bb85139f15a9', 13, NULL, 'Nonetto: II. Andante', 'Nonetto: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17e3dca-1bb7-42cf-bc46-bb85139f15a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c12957dc-a94f-4d01-a08c-cfcfa0d46eaa', 14, NULL, 'Nonetto: III. Allegro con spirito', 'Nonetto: III. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c12957dc-a94f-4d01-a08c-cfcfa0d46eaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7feebe7-ab70-4ab1-98f3-e109044777f0', 15, NULL, 'Nonetto: IV. Canzone con variazoni', 'Nonetto: IV. Canzone con variazoni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7feebe7-ab70-4ab1-98f3-e109044777f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f878cdde-2ecf-4eb2-a9c5-c70a2c000853', 16, NULL, 'Nonetto: V. Vivacissimo', 'Nonetto: V. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Music' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f878cdde-2ecf-4eb2-a9c5-c70a2c000853'
);


-- None 영화 <말괄량이 길들이기> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <말괄량이 길들이기> 사운드트랙', 'The Taming of the Shrew', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <말괄량이 길들이기> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82874cfb-a139-45b6-8ed0-eb840743816f', 1, NULL, 'The Argument', 'The Argument', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <말괄량이 길들이기> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82874cfb-a139-45b6-8ed0-eb840743816f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10143 AND linked.composer_id = 111), 'musicbrainz:ab5b85f8-f26e-494a-8e84-7cbe71465c5e', 2, NULL, 'The Wooing', 'The Wooing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <말괄량이 길들이기> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab5b85f8-f26e-494a-8e84-7cbe71465c5e'
);

UPDATE pieces piece
SET piece.title = '영화 <말괄량이 길들이기> 사운드트랙 중 "The Wooing"', piece.title_en = 'The Taming of the Shrew: The Wooing', piece.editor_locked = 1
WHERE piece.id = 10143 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d31632dc-6960-4ef1-8f04-21ce50fdfa9b', 3, NULL, 'The Wedding', 'The Wedding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <말괄량이 길들이기> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d31632dc-6960-4ef1-8f04-21ce50fdfa9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9607 AND linked.composer_id = 111), 'musicbrainz:84d64f14-ba5e-469f-95e2-ac8abb8f1e7d', 4, NULL, 'The Taming', 'The Taming', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <말괄량이 길들이기> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84d64f14-ba5e-469f-95e2-ac8abb8f1e7d'
);

UPDATE pieces piece
SET piece.title = '영화 <말괄량이 길들이기> 사운드트랙 중 "The Taming"', piece.title_en = 'The Taming of the Shrew: The Taming', piece.editor_locked = 1
WHERE piece.id = 9607 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11050 AND linked.composer_id = 111), 'musicbrainz:eefd3167-0432-4af4-b88e-6901f565ff6f', 5, NULL, 'The Banquet', 'The Banquet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <말괄량이 길들이기> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eefd3167-0432-4af4-b88e-6901f565ff6f'
);

UPDATE pieces piece
SET piece.title = '영화 <말괄량이 길들이기> 사운드트랙 중 "The Banquet"', piece.title_en = 'The Taming of the Shrew: The Banquet', piece.editor_locked = 1
WHERE piece.id = 11050 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <대부 3> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <대부 3> 사운드트랙', 'The Godfather, Part III: Music From the Original Motion Picture Soundtrack', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <대부 3> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a91b7fc7-959d-3808-b866-7d8cf1388130', 1, NULL, 'The Godfather Waltz', 'The Godfather Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a91b7fc7-959d-3808-b866-7d8cf1388130'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8460 AND linked.composer_id = 111), 'musicbrainz:33d260fc-fc85-3e21-9ffd-2d40014b3e40', 2, NULL, 'Michael''s Letter', 'Michael''s Letter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33d260fc-fc85-3e21-9ffd-2d40014b3e40'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 3> 사운드트랙 중 "Michael''s Letter"', piece.title_en = 'The Godfather, Part III: Music From the Original Motion Picture Soundtrack: Michael''s Letter', piece.editor_locked = 1
WHERE piece.id = 8460 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7822 AND linked.composer_id = 111), 'musicbrainz:062e70ae-c257-375e-8d65-18d93743afb0', 3, NULL, 'The Immigrant', 'The Immigrant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:062e70ae-c257-375e-8d65-18d93743afb0'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 3> 사운드트랙 중 "The Immigrant"', piece.title_en = 'The Godfather, Part III: Music From the Original Motion Picture Soundtrack: The Immigrant', piece.editor_locked = 1
WHERE piece.id = 7822 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3696ac82-37db-3d04-bc42-522dcd13e77e', 4, NULL, 'Vincent''s Theme', 'Vincent''s Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3696ac82-37db-3d04-bc42-522dcd13e77e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1f4dee9-cff5-3bd3-9d9f-cf862ef0ca29', 5, NULL, 'Altobello', 'Altobello', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1f4dee9-cff5-3bd3-9d9f-cf862ef0ca29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c06c144-3e86-37b8-aa92-eebb0f7a6890', 6, NULL, 'The Godfather Intermezzo', 'The Godfather Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c06c144-3e86-37b8-aa92-eebb0f7a6890'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9998 AND linked.composer_id = 111), 'musicbrainz:a1b99245-f163-3c0d-8159-0ca21228f4d3', 7, NULL, 'Coda: The Godfather Finale', 'Coda: The Godfather Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = '영화 <대부 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1b99245-f163-3c0d-8159-0ca21228f4d3'
);

UPDATE pieces piece
SET piece.title = '영화 <대부 3> 사운드트랙 중 "Coda: The Godfather Finale"', piece.title_en = 'The Godfather, Part III: Music From the Original Motion Picture Soundtrack: Coda: The Godfather Finale', piece.editor_locked = 1
WHERE piece.id = 9998 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Works for Harp

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Works for Harp', 'Works for Harp', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Works for Harp'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3a45cb0-7027-4534-a7aa-6f543638f9f9', 1, NULL, 'Concerto for Harp and Orchestra: I. Allegro moderato', 'Concerto for Harp and Orchestra: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3a45cb0-7027-4534-a7aa-6f543638f9f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c80f8da-fe99-4007-8929-708510d8a633', 2, NULL, 'Concerto for Harp and Orchestra: II. Andante', 'Concerto for Harp and Orchestra: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c80f8da-fe99-4007-8929-708510d8a633'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98d24144-f9c7-424d-90b3-a0b4bac0d738', 3, NULL, 'Concerto for Harp and Orchestra: III. Allegro', 'Concerto for Harp and Orchestra: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98d24144-f9c7-424d-90b3-a0b4bac0d738'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fc3e874-3d8f-4ce4-a531-7849ffe2c467', 4, NULL, 'Sonata for Flute and Harp: I. Allegro molto moderato', 'Sonata for Flute and Harp: I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc3e874-3d8f-4ce4-a531-7849ffe2c467'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d113b5b-cf3c-4dd0-88be-e0c8c7d4f793', 5, NULL, 'Sonata for Flute and Harp: II. Andante sostenuto', 'Sonata for Flute and Harp: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d113b5b-cf3c-4dd0-88be-e0c8c7d4f793'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:566e1e60-78e7-4078-8901-f4726ed33bbe', 6, NULL, 'Sonata for Flute and Harp: III. Allegro festoso', 'Sonata for Flute and Harp: III. Allegro festoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:566e1e60-78e7-4078-8901-f4726ed33bbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d99be9c0-ccd0-4285-9dc4-439e9623509b', 7, NULL, 'Sarabanda e Toccata per Arpa: Sarabanda', 'Sarabanda e Toccata per Arpa: Sarabanda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d99be9c0-ccd0-4285-9dc4-439e9623509b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df962713-90cb-418a-9da8-4c5e10bdbd9b', 8, NULL, 'Sarabanda e Toccata per Arpa: Toccata', 'Sarabanda e Toccata per Arpa: Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df962713-90cb-418a-9da8-4c5e10bdbd9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b89cae1-775a-3fae-b74c-564b87a3681f', 9, NULL, 'Love Theme from The Godfather', 'Love Theme from The Godfather', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b89cae1-775a-3fae-b74c-564b87a3681f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3b09a82-3212-4b9b-886b-60822feab1e0', 10, NULL, 'Michael''s Theme', 'Michael''s Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b09a82-3212-4b9b-886b-60822feab1e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a91b7fc7-959d-3808-b866-7d8cf1388130', 11, NULL, 'The Godfather Waltz', 'The Godfather Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a91b7fc7-959d-3808-b866-7d8cf1388130'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71cf0734-5c84-443d-ae80-596d10581552', 12, NULL, 'Death on the Nile: Journey on the Nile', 'Death on the Nile: Journey on the Nile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71cf0734-5c84-443d-ae80-596d10581552'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10310 AND linked.composer_id = 111), 'musicbrainz:b7e7f9da-bbaf-47cd-a5a0-3ec4c975ec0a', 13, NULL, '영화음악 모음곡 <La Dolce Vita>', 'La Dolce Vita Suite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7e7f9da-bbaf-47cd-a5a0-3ec4c975ec0a'
);

UPDATE pieces piece
SET piece.title = 'Works for Harp 중 "영화음악 모음곡 <La Dolce Vita>"', piece.title_en = 'Works for Harp: La Dolce Vita Suite', piece.editor_locked = 1
WHERE piece.id = 10310 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7532 AND linked.composer_id = 111), 'musicbrainz:7fba664e-a1ee-3073-9021-3b033ff3e688', 14, NULL, 'What Is a Youth', 'What Is a Youth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fba664e-a1ee-3073-9021-3b033ff3e688'
);

UPDATE pieces piece
SET piece.title = 'Works for Harp 중 "What Is a Youth"', piece.title_en = 'Works for Harp: What Is a Youth', piece.editor_locked = 1
WHERE piece.id = 7532 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10320 AND linked.composer_id = 111), 'musicbrainz:b8ab2cb1-75e0-42db-8963-31f228f7557a', 15, NULL, 'The Taming of the Shrew: Overture', 'The Taming of the Shrew: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Works for Harp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8ab2cb1-75e0-42db-8963-31f228f7557a'
);

UPDATE pieces piece
SET piece.title = 'Works for Harp 중 "The Taming of the Shrew: Overture"', piece.title_en = 'Works for Harp: The Taming of the Shrew: Overture', piece.editor_locked = 1
WHERE piece.id = 10320 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chamber Works

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Chamber Works', 'Chamber Works', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Chamber Works'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d59d28a-ae72-44eb-9ba0-7dbc7c61d420', 1, NULL, 'Sonata for Violin and Piano: I. Allegretto cantabile con moto', 'Sonata for Violin and Piano: I. Allegretto cantabile con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d59d28a-ae72-44eb-9ba0-7dbc7c61d420'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd2efe9a-2eb7-4831-87d2-b71101483dcb', 2, NULL, 'Sonata for Violin and Piano: II. Largo sostenuto', 'Sonata for Violin and Piano: II. Largo sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd2efe9a-2eb7-4831-87d2-b71101483dcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3bf18c8-c7e7-4171-b99e-22d258d4bb5a', 3, NULL, 'Sonata for Violin and Piano: III. Allegro assai moderato', 'Sonata for Violin and Piano: III. Allegro assai moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3bf18c8-c7e7-4171-b99e-22d258d4bb5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8733 AND linked.composer_id = 111), 'musicbrainz:47ec663e-a92b-4bdf-922a-06180348810f', 4, NULL, 'Improvviso in re minore', 'Improvviso in re minore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47ec663e-a92b-4bdf-922a-06180348810f'
);

UPDATE pieces piece
SET piece.title = 'Chamber Works 중 "Improvviso in re minore"', piece.title_en = 'Chamber Works: Improvviso in re minore', piece.editor_locked = 1
WHERE piece.id = 8733 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9125 AND linked.composer_id = 111), 'musicbrainz:62ba506d-7828-41dd-936a-cd32e7291f25', 5, NULL, 'Improvviso for Violin and Piano “Un diavolo sentimentale”', 'Improvviso for Violin and Piano “Un diavolo sentimentale”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62ba506d-7828-41dd-936a-cd32e7291f25'
);

UPDATE pieces piece
SET piece.title = 'Chamber Works 중 "Improvviso for Violin and Piano “Un diavolo sentimentale”"', piece.title_en = 'Chamber Works: Improvviso for Violin and Piano “Un diavolo sentimentale”', piece.editor_locked = 1
WHERE piece.id = 9125 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ee99b26-3510-402e-820d-167da6a5597e', 6, NULL, 'Legend of the Glass Mountain', 'Legend of the Glass Mountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ee99b26-3510-402e-820d-167da6a5597e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fc3e874-3d8f-4ce4-a531-7849ffe2c467', 7, NULL, 'Sonata for Flute and Harp: I. Allegro molto moderato', 'Sonata for Flute and Harp: I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc3e874-3d8f-4ce4-a531-7849ffe2c467'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d113b5b-cf3c-4dd0-88be-e0c8c7d4f793', 8, NULL, 'Sonata for Flute and Harp: II. Andante sostenuto', 'Sonata for Flute and Harp: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d113b5b-cf3c-4dd0-88be-e0c8c7d4f793'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:566e1e60-78e7-4078-8901-f4726ed33bbe', 9, NULL, 'Sonata for Flute and Harp: III. Allegro festoso', 'Sonata for Flute and Harp: III. Allegro festoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:566e1e60-78e7-4078-8901-f4726ed33bbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bc9a409-8520-425d-ba30-88fed58e43aa', 10, NULL, 'Trio per Flauto, Violino e Pianoforte: I. Allegro ma non troppo', 'Trio per Flauto, Violino e Pianoforte: I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bc9a409-8520-425d-ba30-88fed58e43aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9be29db0-e222-4209-a66a-82215c57c986', 11, NULL, 'Trio per Flauto, Violino e Pianoforte: II. Andante sostenuto', 'Trio per Flauto, Violino e Pianoforte: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9be29db0-e222-4209-a66a-82215c57c986'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89338a14-9030-445b-9322-144ecfaf8486', 12, NULL, 'Trio per Flauto, Violino e Pianoforte: III. Allegro vivace con spirito', 'Trio per Flauto, Violino e Pianoforte: III. Allegro vivace con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chamber Works' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89338a14-9030-445b-9322-144ecfaf8486'
);


-- None Chansons pour Fellini

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Chansons pour Fellini', 'Chansons pour Fellini', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Chansons pour Fellini'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11179 AND linked.composer_id = 111), 'musicbrainz:f8e93b61-552f-4728-ae1c-fb89a08ba7cf', 1, NULL, 'Lo sceicco bianco', 'Lo sceicco bianco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8e93b61-552f-4728-ae1c-fb89a08ba7cf'
);

UPDATE pieces piece
SET piece.title = 'Chansons pour Fellini 중 "Lo sceicco bianco"', piece.title_en = 'Chansons pour Fellini: Lo sceicco bianco', piece.editor_locked = 1
WHERE piece.id = 11179 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41d44491-aaee-4162-b7be-62c14902c72d', 2, NULL, 'I vitelloni', 'I vitelloni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41d44491-aaee-4162-b7be-62c14902c72d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f2845df-5ef3-4383-addc-fb19320ea7f9', 3, NULL, 'La strada', 'La strada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f2845df-5ef3-4383-addc-fb19320ea7f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f88c5c6e-8370-4b1f-801d-ce9be997711e', 4, NULL, 'Gelsomina', 'Gelsomina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f88c5c6e-8370-4b1f-801d-ce9be997711e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9072 AND linked.composer_id = 111), 'musicbrainz:5f2320ee-a390-4fed-a58c-51a7437ee753', 5, NULL, 'Maggie', 'Maggie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f2320ee-a390-4fed-a58c-51a7437ee753'
);

UPDATE pieces piece
SET piece.title = 'Chansons pour Fellini 중 "Maggie"', piece.title_en = 'Chansons pour Fellini: Maggie', piece.editor_locked = 1
WHERE piece.id = 9072 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9730 AND linked.composer_id = 111), 'musicbrainz:8de7e29a-525b-4a2a-af7e-ef0f4c87baa1', 6, NULL, 'Cabiria', 'Cabiria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8de7e29a-525b-4a2a-af7e-ef0f4c87baa1'
);

UPDATE pieces piece
SET piece.title = 'Chansons pour Fellini 중 "Cabiria"', piece.title_en = 'Chansons pour Fellini: Cabiria', piece.editor_locked = 1
WHERE piece.id = 9730 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9082 AND linked.composer_id = 111), 'musicbrainz:5fa9f830-351c-4e70-a05c-83eeb5c25d90', 7, NULL, 'Lla ri llira', 'Lla ri llira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa9f830-351c-4e70-a05c-83eeb5c25d90'
);

UPDATE pieces piece
SET piece.title = 'Chansons pour Fellini 중 "Lla ri llira"', piece.title_en = 'Chansons pour Fellini: Lla ri llira', piece.editor_locked = 1
WHERE piece.id = 9082 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32e49475-81f1-4be4-a9f0-5225235cc44c', 8, NULL, 'Come tu mi vuoi', 'Come tu mi vuoi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32e49475-81f1-4be4-a9f0-5225235cc44c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af73a547-aad6-415e-9b6e-28447d3001e7', 9, NULL, 'La Dolce Vita', 'La Dolce Vita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af73a547-aad6-415e-9b6e-28447d3001e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10225 AND linked.composer_id = 111), 'musicbrainz:b1549c0d-0b3b-49ec-8431-7d1be4015807', 10, NULL, 'Il tempo passa', 'Il tempo passa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1549c0d-0b3b-49ec-8431-7d1be4015807'
);

UPDATE pieces piece
SET piece.title = 'Chansons pour Fellini 중 "Il tempo passa"', piece.title_en = 'Chansons pour Fellini: Il tempo passa', piece.editor_locked = 1
WHERE piece.id = 10225 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8445 AND linked.composer_id = 111), 'musicbrainz:32c2b79a-3260-4145-b360-f836ba80ae97', 11, NULL, 'Otto e mezzo', 'Otto e mezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32c2b79a-3260-4145-b360-f836ba80ae97'
);

UPDATE pieces piece
SET piece.title = 'Chansons pour Fellini 중 "Otto e mezzo"', piece.title_en = 'Chansons pour Fellini: Otto e mezzo', piece.editor_locked = 1
WHERE piece.id = 8445 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10054 AND linked.composer_id = 111), 'musicbrainz:a4bd21a7-4433-45ad-b68e-423681ff3ad9', 12, NULL, 'Giulietta degli spiriti', 'Giulietta degli spiriti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4bd21a7-4433-45ad-b68e-423681ff3ad9'
);

UPDATE pieces piece
SET piece.title = 'Chansons pour Fellini 중 "Giulietta degli spiriti"', piece.title_en = 'Chansons pour Fellini: Giulietta degli spiriti', piece.editor_locked = 1
WHERE piece.id = 10054 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac2fa6d0-3981-4160-a0d0-a4f60f677af0', 13, NULL, 'Amarcord', 'Amarcord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac2fa6d0-3981-4160-a0d0-a4f60f677af0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8041 AND linked.composer_id = 111), 'musicbrainz:14578fc6-cde6-4157-8996-a220c40c990d', 14, NULL, 'Il canto della buranella', 'Il canto della buranella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14578fc6-cde6-4157-8996-a220c40c990d'
);

UPDATE pieces piece
SET piece.title = 'Chansons pour Fellini 중 "Il canto della buranella"', piece.title_en = 'Chansons pour Fellini: Il canto della buranella', piece.editor_locked = 1
WHERE piece.id = 8041 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10681 AND linked.composer_id = 111), 'musicbrainz:d3adbc24-62e4-4360-8748-c55623b7caad', 15, NULL, 'Casanova', 'Casanova', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3adbc24-62e4-4360-8748-c55623b7caad'
);

UPDATE pieces piece
SET piece.title = 'Chansons pour Fellini 중 "Casanova"', piece.title_en = 'Chansons pour Fellini: Casanova', piece.editor_locked = 1
WHERE piece.id = 10681 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:781d491e-e2ec-4eed-8040-591c13c02599', 16, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Chansons pour Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:781d491e-e2ec-4eed-8040-591c13c02599'
);


-- None Musiques de films de Federico Fellini

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Musiques de films de Federico Fellini', 'Musiques de films de Federico Fellini', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 111
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Musiques de films de Federico Fellini'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39a82321-b288-3e4d-a8b5-4967372f70fa', 1, NULL, 'Amarcord', 'Amarcord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Musiques de films de Federico Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39a82321-b288-3e4d-a8b5-4967372f70fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8028 AND linked.composer_id = 111), 'musicbrainz:1391ef21-f555-4bc9-81ba-b9ca7200b2c7', 2, NULL, 'Roma (1972)', 'Roma (1972)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Musiques de films de Federico Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1391ef21-f555-4bc9-81ba-b9ca7200b2c7'
);

UPDATE pieces piece
SET piece.title = 'Musiques de films de Federico Fellini 중 "Roma (1972)"', piece.title_en = 'Musiques de films de Federico Fellini: Roma (1972)', piece.editor_locked = 1
WHERE piece.id = 8028 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9727 AND linked.composer_id = 111), 'musicbrainz:8dc2d3a9-eb2f-4725-a19c-dcb6252da8c5', 3, NULL, '발레 모음곡 <La Strada>', 'Suite from the Ballet "La Strada"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Musiques de films de Federico Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dc2d3a9-eb2f-4725-a19c-dcb6252da8c5'
);

UPDATE pieces piece
SET piece.title = 'Musiques de films de Federico Fellini 중 "발레 모음곡 <La Strada>"', piece.title_en = 'Musiques de films de Federico Fellini: Suite from the Ballet "La Strada"', piece.editor_locked = 1
WHERE piece.id = 9727 AND piece.composer_id = 111
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13170843-c018-4adc-a067-2489e43c3ee4', 4, NULL, '8½', '8½', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 111 AND p.title = 'Musiques de films de Federico Fellini' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13170843-c018-4adc-a067-2489e43c3ee4'
);

-- 카탈로그에 대응이 없는 seed 작품 81개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 111 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7454, 7594, 7675, 7683, 7710, 7711, 7718, 7719, 7749, 7758, 7808, 7831, 7930, 7933, 8006, 8044, 8085, 8130, 8188, 8276,
    8322, 8361, 8382, 8384, 8661, 8668, 8689, 8786, 8791, 8793, 8893, 8913, 8954, 8971, 9037, 9054, 9077, 9094, 9097, 9108,
    9116, 9133, 9134, 9136, 9163, 9320, 9408, 9472, 9474, 9690, 9716, 9788, 9809, 9904, 9951, 9955, 9992, 9999, 10090, 10092,
    10120, 10179, 10220, 10269, 10351, 10412, 10466, 10481, 10511, 10573, 10575, 10611, 10667, 10731, 10805, 10846, 10861, 11054, 11059, 11134,
    11286
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
