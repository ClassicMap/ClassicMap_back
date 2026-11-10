-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 6/11).
-- 작품 19개(새 13개), seed 145개 중 잇기 136·숨김 9·그대로 0.
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

-- ===== David Chesky (composer_id 220) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 19개 중 음반 묶음 11개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 8개,
-- 새 작품 13개, part 176개, 그 아래 0개.
-- seed 145개 중 130개를 음반 묶음 안 곡으로 잇고, 6개는 낱개 작품으로 두고, 9개를 숨긴다.

-- None 바순 협주곡

UPDATE pieces piece
SET piece.title = '바순 협주곡', piece.title_en = 'Concerto for Bassoon and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16993 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Concerto for Bassoon and Orchestra: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16993 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:08de347d-1b0d-4b07-b9e7-723529a9c361' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08de347d-1b0d-4b07-b9e7-723529a9c361', 1, NULL, 'I', 'Concerto for Bassoon and Orchestra: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16993 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08de347d-1b0d-4b07-b9e7-723529a9c361'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Concerto for Bassoon and Orchestra: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16993 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:fb649258-d126-45c1-84da-aa9f32e8cee6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb649258-d126-45c1-84da-aa9f32e8cee6', 2, NULL, 'II', 'Concerto for Bassoon and Orchestra: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16993 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb649258-d126-45c1-84da-aa9f32e8cee6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Concerto for Bassoon and Orchestra: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16993 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:f3d087a6-6a2a-4983-9088-cd09a67ecf96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3d087a6-6a2a-4983-9088-cd09a67ecf96', 3, NULL, 'III', 'Concerto for Bassoon and Orchestra: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16993 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3d087a6-6a2a-4983-9088-cd09a67ecf96'
);


-- None 가곡 <Forever>

UPDATE pieces piece
SET piece.title = '가곡 <Forever>', piece.title_en = 'Forever',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18864 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Rio After Dark>

UPDATE pieces piece
SET piece.title = '가곡 <Rio After Dark>', piece.title_en = 'Rio After Dark',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17929 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 탱고 1번

UPDATE pieces piece
SET piece.title = '탱고 1번', piece.title_en = 'Tango No.1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17444 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 탱고 2번

UPDATE pieces piece
SET piece.title = '탱고 2번', piece.title_en = 'Tango No.2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19607 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <The Zephyrtine: A Ballet Story>

UPDATE pieces piece
SET piece.title = '발레 <The Zephyrtine: A Ballet Story>', piece.title_en = 'The Zephyrtine: A Ballet Story',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16975 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ben’s Farm in Vermont', part.name_en = 'Ben’s Farm in Vermont',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:2c09ada1-0744-4117-aa7e-dc20e20c4f93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c09ada1-0744-4117-aa7e-dc20e20c4f93', 1, NULL, 'Ben’s Farm in Vermont', 'Ben’s Farm in Vermont', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c09ada1-0744-4117-aa7e-dc20e20c4f93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Zephyrtine Appears', part.name_en = 'The Zephyrtine Appears',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:e3a719d1-abcc-4b0e-a71d-4e4b19fe7b41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3a719d1-abcc-4b0e-a71d-4e4b19fe7b41', 2, NULL, 'The Zephyrtine Appears', 'The Zephyrtine Appears', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3a719d1-abcc-4b0e-a71d-4e4b19fe7b41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'What Is This Magnificent Creature?', part.name_en = 'What Is This Magnificent Creature?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:4d02fdd9-18bd-46fe-bc26-485afff9f5e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d02fdd9-18bd-46fe-bc26-485afff9f5e4', 3, NULL, 'What Is This Magnificent Creature?', 'What Is This Magnificent Creature?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d02fdd9-18bd-46fe-bc26-485afff9f5e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Zephyrtine Meets Ben', part.name_en = 'The Zephyrtine Meets Ben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:7514c506-fac6-425a-a43f-748c624f1456' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7514c506-fac6-425a-a43f-748c624f1456', 4, NULL, 'The Zephyrtine Meets Ben', 'The Zephyrtine Meets Ben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7514c506-fac6-425a-a43f-748c624f1456'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Let’s Visit the Planet Eudora Where the Zephyrtines Live', part.name_en = 'Let’s Visit the Planet Eudora Where the Zephyrtines Live',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:99d4291c-f2df-4f36-ba90-2e4c043106b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99d4291c-f2df-4f36-ba90-2e4c043106b6', 5, NULL, 'Let’s Visit the Planet Eudora Where the Zephyrtines Live', 'Let’s Visit the Planet Eudora Where the Zephyrtines Live', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99d4291c-f2df-4f36-ba90-2e4c043106b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Morning in Eudora', part.name_en = 'Morning in Eudora',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:460b2fd1-aa4a-442b-8f41-7f39c12d1951' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:460b2fd1-aa4a-442b-8f41-7f39c12d1951', 6, NULL, 'Morning in Eudora', 'Morning in Eudora', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:460b2fd1-aa4a-442b-8f41-7f39c12d1951'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Dance of the Ice Cream Trees', part.name_en = 'Dance of the Ice Cream Trees',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:db34c3b6-fb95-4de7-9a3b-c43472eb20b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db34c3b6-fb95-4de7-9a3b-c43472eb20b2', 7, NULL, 'Dance of the Ice Cream Trees', 'Dance of the Ice Cream Trees', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db34c3b6-fb95-4de7-9a3b-c43472eb20b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Dance of the Wingless Birds', part.name_en = 'Dance of the Wingless Birds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:5cfd30b6-3c0c-4fef-9a0f-d6f32941cf27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cfd30b6-3c0c-4fef-9a0f-d6f32941cf27', 8, NULL, 'Dance of the Wingless Birds', 'Dance of the Wingless Birds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cfd30b6-3c0c-4fef-9a0f-d6f32941cf27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Dance of the Zephyrtines', part.name_en = 'Dance of the Zephyrtines',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:04160e7a-94ec-4fc2-b31f-828d7a6f602e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04160e7a-94ec-4fc2-b31f-828d7a6f602e', 9, NULL, 'Dance of the Zephyrtines', 'Dance of the Zephyrtines', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04160e7a-94ec-4fc2-b31f-828d7a6f602e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Dance of the Chocolate Cows', part.name_en = 'Dance of the Chocolate Cows',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:69dcb692-8924-42b8-9600-a20ef23d39e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69dcb692-8924-42b8-9600-a20ef23d39e6', 10, NULL, 'Dance of the Chocolate Cows', 'Dance of the Chocolate Cows', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69dcb692-8924-42b8-9600-a20ef23d39e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Dance of the Vegetable Builders', part.name_en = 'Dance of the Vegetable Builders',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:0d83e9ba-ddce-42db-a2b0-c1889a20180f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d83e9ba-ddce-42db-a2b0-c1889a20180f', 11, NULL, 'Dance of the Vegetable Builders', 'Dance of the Vegetable Builders', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d83e9ba-ddce-42db-a2b0-c1889a20180f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'The Red King Kalek', part.name_en = 'The Red King Kalek',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:8f56098a-5391-44c7-9d15-72264cdf445a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f56098a-5391-44c7-9d15-72264cdf445a', 12, NULL, 'The Red King Kalek', 'The Red King Kalek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f56098a-5391-44c7-9d15-72264cdf445a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Daissa the Green Queen', part.name_en = 'Daissa the Green Queen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:68761a49-ae11-4edc-a600-adf79b12e4a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68761a49-ae11-4edc-a600-adf79b12e4a2', 13, NULL, 'Daissa the Green Queen', 'Daissa the Green Queen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68761a49-ae11-4edc-a600-adf79b12e4a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Chaya the Blue Princess', part.name_en = 'Chaya the Blue Princess',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:57328c6a-7cb6-47e3-91e7-62c0fb212634' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57328c6a-7cb6-47e3-91e7-62c0fb212634', 14, NULL, 'Chaya the Blue Princess', 'Chaya the Blue Princess', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57328c6a-7cb6-47e3-91e7-62c0fb212634'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Ib the Monster Comes down from the Mountains', part.name_en = 'Ib the Monster Comes down from the Mountains',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:5ba8bd8d-c659-452c-befc-489c84c7aee2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ba8bd8d-c659-452c-befc-489c84c7aee2', 15, NULL, 'Ib the Monster Comes down from the Mountains', 'Ib the Monster Comes down from the Mountains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ba8bd8d-c659-452c-befc-489c84c7aee2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Where Is the Blue Princess?', part.name_en = 'Where Is the Blue Princess?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:2a1a589d-f004-4f77-95fa-441bba354925' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a1a589d-f004-4f77-95fa-441bba354925', 16, NULL, 'Where Is the Blue Princess?', 'Where Is the Blue Princess?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a1a589d-f004-4f77-95fa-441bba354925'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'The Sapphire Forest', part.name_en = 'The Sapphire Forest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:501b40c4-923b-472b-8709-10ee32f12257' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:501b40c4-923b-472b-8709-10ee32f12257', 17, NULL, 'The Sapphire Forest', 'The Sapphire Forest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:501b40c4-923b-472b-8709-10ee32f12257'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Gortee the Wise Old Talking Fish', part.name_en = 'Gortee the Wise Old Talking Fish',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:72cb92ea-044e-451e-b6d7-d79e802d0671' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72cb92ea-044e-451e-b6d7-d79e802d0671', 18, NULL, 'Gortee the Wise Old Talking Fish', 'Gortee the Wise Old Talking Fish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72cb92ea-044e-451e-b6d7-d79e802d0671'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Dance of the Fish That Live in the Trees', part.name_en = 'Dance of the Fish That Live in the Trees',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:66067b7f-aa2a-4cef-b355-99ab5dd26169' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66067b7f-aa2a-4cef-b355-99ab5dd26169', 19, NULL, 'Dance of the Fish That Live in the Trees', 'Dance of the Fish That Live in the Trees', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66067b7f-aa2a-4cef-b355-99ab5dd26169'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Ben and the King', part.name_en = 'Ben and the King',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:aaf283c1-9599-41ee-b4b3-78417db68b5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaf283c1-9599-41ee-b4b3-78417db68b5a', 20, NULL, 'Ben and the King', 'Ben and the King', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaf283c1-9599-41ee-b4b3-78417db68b5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Let’s Go Find a Real Pumpkin', part.name_en = 'Let’s Go Find a Real Pumpkin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:833012b0-ff26-4bbb-adb8-cd8d69a5297f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:833012b0-ff26-4bbb-adb8-cd8d69a5297f', 21, NULL, 'Let’s Go Find a Real Pumpkin', 'Let’s Go Find a Real Pumpkin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:833012b0-ff26-4bbb-adb8-cd8d69a5297f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Ib the Monster’s Cave', part.name_en = 'Ib the Monster’s Cave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:0c0ff24c-973b-42ac-ad5d-b64e634f33f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c0ff24c-973b-42ac-ad5d-b64e634f33f0', 22, NULL, 'Ib the Monster’s Cave', 'Ib the Monster’s Cave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c0ff24c-973b-42ac-ad5d-b64e634f33f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Ben and the Blue Princess', part.name_en = 'Ben and the Blue Princess',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:c16aa6e5-1640-4761-83a9-739149e07eb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c16aa6e5-1640-4761-83a9-739149e07eb4', 23, NULL, 'Ben and the Blue Princess', 'Ben and the Blue Princess', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c16aa6e5-1640-4761-83a9-739149e07eb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'The King Gives Billy an Ice Cream Tree', part.name_en = 'The King Gives Billy an Ice Cream Tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:a6e7afbb-1e9e-43ff-874b-e1563e657007' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6e7afbb-1e9e-43ff-874b-e1563e657007', 24, NULL, 'The King Gives Billy an Ice Cream Tree', 'The King Gives Billy an Ice Cream Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6e7afbb-1e9e-43ff-874b-e1563e657007'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'The Grand Celebration', part.name_en = 'The Grand Celebration',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16975 AND p.composer_id = 220 AND part.part_key = 'musicbrainz:a7bcb08f-91a2-41da-a58f-47d6b24272a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7bcb08f-91a2-41da-a58f-47d6b24272a0', 25, NULL, 'The Grand Celebration', 'The Grand Celebration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16975 AND p.composer_id = 220
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7bcb08f-91a2-41da-a58f-47d6b24272a0'
);


-- None 관현악 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 협주곡', 'Concerto for Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '232a87bc-989d-4402-9f2d-7ca4b0283608'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '232a87bc-989d-4402-9f2d-7ca4b0283608'
FROM pieces p
WHERE p.composer_id = 220 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '232a87bc-989d-4402-9f2d-7ca4b0283608'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:353c5719-7f28-4e39-a411-f85d514dbc91', 1, NULL, 'I', 'Concerto for Orchestra: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:353c5719-7f28-4e39-a411-f85d514dbc91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df49a7a5-b52e-4774-97d7-f55a0d29e37b', 2, NULL, 'II', 'Concerto for Orchestra: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df49a7a5-b52e-4774-97d7-f55a0d29e37b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:578c00b8-4c2d-4db8-8047-8d52a37cf42c', 3, NULL, 'III', 'Concerto for Orchestra: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:578c00b8-4c2d-4db8-8047-8d52a37cf42c'
);


-- None 피아노 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡', 'Concerto for Piano and Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f3366e4-d78d-4bf8-963c-140c9a17f439'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f3366e4-d78d-4bf8-963c-140c9a17f439'
FROM pieces p
WHERE p.composer_id = 220 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f3366e4-d78d-4bf8-963c-140c9a17f439'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1ce51de-0d08-492d-aebe-469e06f5b6d2', 1, NULL, 'I', 'Concerto for Piano and Orchestra: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1ce51de-0d08-492d-aebe-469e06f5b6d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9c276cb-9116-436b-b887-a8b9f041fe22', 2, NULL, 'II', 'Concerto for Piano and Orchestra: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9c276cb-9116-436b-b887-a8b9f041fe22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71f404f5-085b-4313-8682-12fbcf9f1656', 3, NULL, 'III', 'Concerto for Piano and Orchestra: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71f404f5-085b-4313-8682-12fbcf9f1656'
);


-- None Dr. Chesky's Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show', 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18015 AND linked.composer_id = 220), 'musicbrainz:79ff7e95-1ccb-47a3-b383-459b284a1688', 1, NULL, 'Blast Off', 'Blast Off', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79ff7e95-1ccb-47a3-b383-459b284a1688'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Blast Off"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Blast Off', piece.editor_locked = 1
WHERE piece.id = 18015 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18337 AND linked.composer_id = 220), 'musicbrainz:8f02cb9e-b301-4caf-977e-914666f7a5ac', 2, NULL, 'Welcome to the Show', 'Welcome to the Show', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f02cb9e-b301-4caf-977e-914666f7a5ac'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Welcome to the Show"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Welcome to the Show', piece.editor_locked = 1
WHERE piece.id = 18337 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20010 AND linked.composer_id = 220), 'musicbrainz:fa1e388d-bd0d-4aa4-9e1c-2b6bc0ab51ee', 3, NULL, 'Dancing Tympani', 'Dancing Tympani', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa1e388d-bd0d-4aa4-9e1c-2b6bc0ab51ee'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Dancing Tympani"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Dancing Tympani', piece.editor_locked = 1
WHERE piece.id = 20010 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17451 AND linked.composer_id = 220), 'musicbrainz:57e0f4b7-564a-4fec-975c-9e3a17d715b4', 4, NULL, 'Circle of Voices', 'Circle of Voices', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57e0f4b7-564a-4fec-975c-9e3a17d715b4'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Circle of Voices"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Circle of Voices', piece.editor_locked = 1
WHERE piece.id = 17451 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18228 AND linked.composer_id = 220), 'musicbrainz:88aa6227-ac19-4c63-a857-b093e3646efc', 5, NULL, 'Fire Drums', 'Fire Drums', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88aa6227-ac19-4c63-a857-b093e3646efc'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Fire Drums"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Fire Drums', piece.editor_locked = 1
WHERE piece.id = 18228 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b134fa4-b7d8-42a5-b9f0-dc1cc18b848b', 6, NULL, 'The Storm', 'The Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b134fa4-b7d8-42a5-b9f0-dc1cc18b848b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16463 AND linked.composer_id = 220), 'musicbrainz:1aad0200-fe61-44c2-9d36-edf8294e7ea7', 7, NULL, 'Chimes of Serenity', 'Chimes of Serenity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aad0200-fe61-44c2-9d36-edf8294e7ea7'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Chimes of Serenity"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Chimes of Serenity', piece.editor_locked = 1
WHERE piece.id = 16463 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16471 AND linked.composer_id = 220), 'musicbrainz:1b317906-b849-4cf1-8711-3a4cf0161229', 8, NULL, 'Music for Cello, Helicopter and Cars', 'Music for Cello, Helicopter and Cars', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b317906-b849-4cf1-8711-3a4cf0161229'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Music for Cello, Helicopter and Cars"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Music for Cello, Helicopter and Cars', piece.editor_locked = 1
WHERE piece.id = 16471 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19477 AND linked.composer_id = 220), 'musicbrainz:d7a1844a-f8b6-48dc-b70e-805910b2cb00', 9, NULL, 'Bass Drum March', 'Bass Drum March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7a1844a-f8b6-48dc-b70e-805910b2cb00'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Bass Drum March"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Bass Drum March', piece.editor_locked = 1
WHERE piece.id = 19477 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17726 AND linked.composer_id = 220), 'musicbrainz:6864610f-51ce-41ed-beb6-036d5c5cece1', 10, NULL, 'Tibet', 'Tibet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6864610f-51ce-41ed-beb6-036d5c5cece1'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Tibet"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Tibet', piece.editor_locked = 1
WHERE piece.id = 17726 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16211 AND linked.composer_id = 220), 'musicbrainz:0d02a613-38d2-457d-ae8b-55614049cf5e', 11, NULL, 'Arabian Nights', 'Arabian Nights', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d02a613-38d2-457d-ae8b-55614049cf5e'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Arabian Nights"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Arabian Nights', piece.editor_locked = 1
WHERE piece.id = 16211 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18092 AND linked.composer_id = 220), 'musicbrainz:7e64d9c7-2383-45fe-8348-eb975f788c1e', 12, NULL, 'Wild Nights', 'Wild Nights', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e64d9c7-2383-45fe-8348-eb975f788c1e'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Wild Nights"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Wild Nights', piece.editor_locked = 1
WHERE piece.id = 18092 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19115 AND linked.composer_id = 220), 'musicbrainz:bfdc6dcc-ce84-40b1-aef7-170a0b9a210b', 13, NULL, 'The New York Subway Ride', 'The New York Subway Ride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfdc6dcc-ce84-40b1-aef7-170a0b9a210b'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "The New York Subway Ride"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: The New York Subway Ride', piece.editor_locked = 1
WHERE piece.id = 19115 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19446 AND linked.composer_id = 220), 'musicbrainz:d55fe181-cdcb-47f3-a75c-138fa724f03c', 14, NULL, 'The Minimalist', 'The Minimalist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d55fe181-cdcb-47f3-a75c-138fa724f03c'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "The Minimalist"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: The Minimalist', piece.editor_locked = 1
WHERE piece.id = 19446 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16412 AND linked.composer_id = 220), 'musicbrainz:17fe30e9-d52b-4b9d-948d-974d20e9aa30', 15, NULL, 'Basketball Court', 'Basketball Court', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17fe30e9-d52b-4b9d-948d-974d20e9aa30'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Basketball Court"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Basketball Court', piece.editor_locked = 1
WHERE piece.id = 16412 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16927 AND linked.composer_id = 220), 'musicbrainz:37c3b323-ace1-4802-bd14-b062f4614274', 16, NULL, 'Music for Western Percussion', 'Music for Western Percussion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37c3b323-ace1-4802-bd14-b062f4614274'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Music for Western Percussion"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Music for Western Percussion', piece.editor_locked = 1
WHERE piece.id = 16927 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19904 AND linked.composer_id = 220), 'musicbrainz:f4b8e467-a879-4a9d-bcd4-039c88dc78fd', 17, NULL, 'Ping Pong', 'Ping Pong', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4b8e467-a879-4a9d-bcd4-039c88dc78fd'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Ping Pong"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Ping Pong', piece.editor_locked = 1
WHERE piece.id = 19904 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15923 AND linked.composer_id = 220), 'musicbrainz:c9d9b14d-98a5-4a50-8779-150d1cdeba88', 18, NULL, 'Africa Morning', 'Africa Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9d9b14d-98a5-4a50-8779-150d1cdeba88'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Africa Morning"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Africa Morning', piece.editor_locked = 1
WHERE piece.id = 15923 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17381 AND linked.composer_id = 220), 'musicbrainz:53cef85f-06a3-472c-aead-e57de4446b2d', 19, NULL, 'The Forest Song', 'The Forest Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53cef85f-06a3-472c-aead-e57de4446b2d'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "The Forest Song"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: The Forest Song', piece.editor_locked = 1
WHERE piece.id = 17381 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59242824-13ca-469d-9298-4c74a33b18f5', 20, NULL, 'Africa', 'Africa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59242824-13ca-469d-9298-4c74a33b18f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18885 AND linked.composer_id = 220), 'musicbrainz:b17145cb-9cdd-438b-ae94-d41ccf866dc6', 21, NULL, 'Kenya', 'Kenya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17145cb-9cdd-438b-ae94-d41ccf866dc6'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Kenya"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Kenya', piece.editor_locked = 1
WHERE piece.id = 18885 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19128 AND linked.composer_id = 220), 'musicbrainz:c0b364f6-dbbe-4839-8079-40af3c3f9275', 22, NULL, 'Cars & Horses', 'Cars & Horses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0b364f6-dbbe-4839-8079-40af3c3f9275'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Cars & Horses"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Cars & Horses', piece.editor_locked = 1
WHERE piece.id = 19128 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19884 AND linked.composer_id = 220), 'musicbrainz:f367f6cf-73b8-4c93-986b-068b00b97706', 23, NULL, 'Circle of Drums', 'Circle of Drums', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f367f6cf-73b8-4c93-986b-068b00b97706'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Circle of Drums"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Circle of Drums', piece.editor_locked = 1
WHERE piece.id = 19884 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19181 AND linked.composer_id = 220), 'musicbrainz:c4051f87-b0d4-44fd-a55d-f4a61175ee18', 24, NULL, 'Organ & Chimes', 'Organ & Chimes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4051f87-b0d4-44fd-a55d-f4a61175ee18'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Organ & Chimes"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Organ & Chimes', piece.editor_locked = 1
WHERE piece.id = 19181 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17698 AND linked.composer_id = 220), 'musicbrainz:66d084f7-3cf7-4744-9bda-67553d60df4b', 25, NULL, 'The Carousel Ride', 'The Carousel Ride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66d084f7-3cf7-4744-9bda-67553d60df4b'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "The Carousel Ride"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: The Carousel Ride', piece.editor_locked = 1
WHERE piece.id = 17698 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16390 AND linked.composer_id = 220), 'musicbrainz:16be7c64-f464-4bd6-bd90-365b4f691e35', 26, NULL, 'Caribbean Drum Song', 'Caribbean Drum Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16be7c64-f464-4bd6-bd90-365b4f691e35'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Caribbean Drum Song"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Caribbean Drum Song', piece.editor_locked = 1
WHERE piece.id = 16390 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16684 AND linked.composer_id = 220), 'musicbrainz:299bacbb-2547-49a4-9306-04b9a866c99a', 27, NULL, 'Heartbeat Announcement - 50 Hz', 'Heartbeat Announcement - 50 Hz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:299bacbb-2547-49a4-9306-04b9a866c99a'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Heartbeat Announcement - 50 Hz"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Heartbeat Announcement - 50 Hz', piece.editor_locked = 1
WHERE piece.id = 16684 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:716432e7-1d47-4548-ac36-7eda1db81a18', 28, NULL, '50 Hz Heartbeat', '50 Hz Heartbeat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:716432e7-1d47-4548-ac36-7eda1db81a18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19735 AND linked.composer_id = 220), 'musicbrainz:ea303cae-51b8-4b22-b6cf-631d59aab65a', 29, NULL, 'Heartbeat Announcement - 40 Hz', 'Heartbeat Announcement - 40 Hz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea303cae-51b8-4b22-b6cf-631d59aab65a'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Heartbeat Announcement - 40 Hz"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Heartbeat Announcement - 40 Hz', piece.editor_locked = 1
WHERE piece.id = 19735 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17674 AND linked.composer_id = 220), 'musicbrainz:65879080-3311-4c17-bf2c-bc973e2ac690', 30, NULL, '40 Hz Heartbeat', '40 Hz Heartbeat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65879080-3311-4c17-bf2c-bc973e2ac690'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "40 Hz Heartbeat"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: 40 Hz Heartbeat', piece.editor_locked = 1
WHERE piece.id = 17674 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18108 AND linked.composer_id = 220), 'musicbrainz:7f691c48-5dd2-4689-adcb-a43ca33f3fe9', 31, NULL, 'Heartbeat Announcement - 30 Hz', 'Heartbeat Announcement - 30 Hz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f691c48-5dd2-4689-adcb-a43ca33f3fe9'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Heartbeat Announcement - 30 Hz"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Heartbeat Announcement - 30 Hz', piece.editor_locked = 1
WHERE piece.id = 18108 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7af217ba-ac52-4143-b329-16a2ebe24127', 32, NULL, '30 Hz Heartbeat', '30 Hz Heartbeat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7af217ba-ac52-4143-b329-16a2ebe24127'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16569 AND linked.composer_id = 220), 'musicbrainz:22285b50-33bb-478b-83ba-6443d3c42606', 33, NULL, 'Heartbeat Announcement - 20 Hz', 'Heartbeat Announcement - 20 Hz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22285b50-33bb-478b-83ba-6443d3c42606'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Heartbeat Announcement - 20 Hz"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Heartbeat Announcement - 20 Hz', piece.editor_locked = 1
WHERE piece.id = 16569 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d26b96df-6f39-402f-b730-1e860574d469', 34, NULL, '20 Hz Heartbeat', '20 Hz Heartbeat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26b96df-6f39-402f-b730-1e860574d469'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18926 AND linked.composer_id = 220), 'musicbrainz:b3df8e9b-f0f2-490c-9087-e6704d8cb79a', 35, NULL, 'Church Mice', 'Church Mice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3df8e9b-f0f2-490c-9087-e6704d8cb79a'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Church Mice"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Church Mice', piece.editor_locked = 1
WHERE piece.id = 18926 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17932 AND linked.composer_id = 220), 'musicbrainz:741dab12-c0ec-4a67-8188-d9dfa4c69754', 36, NULL, 'Thank You for Coming to Our Show', 'Thank You for Coming to Our Show', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:741dab12-c0ec-4a67-8188-d9dfa4c69754'
);

UPDATE pieces piece
SET piece.title = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show 중 "Thank You for Coming to Our Show"', piece.title_en = 'Dr. Chesky''s Magnificent, Fabulous, Absurd & Insane Musical 5.1 Surround Show: Thank You for Coming to Our Show', piece.editor_locked = 1
WHERE piece.id = 17932 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The New York Rags

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The New York Rags', 'The New York Rags', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The New York Rags'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19289 AND linked.composer_id = 220), 'musicbrainz:caf49260-d661-4ee3-b2ae-ae1f1b6600b4', 1, NULL, 'Rag No. 1 "The New Yorker"', 'Rag No. 1 "The New Yorker"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caf49260-d661-4ee3-b2ae-ae1f1b6600b4'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 1 "The New Yorker""', piece.title_en = 'The New York Rags: Rag No. 1 "The New Yorker"', piece.editor_locked = 1
WHERE piece.id = 19289 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19092 AND linked.composer_id = 220), 'musicbrainz:beb8eb66-6944-4868-a08a-17006145cfe4', 2, NULL, 'Rag No. 2 "The Bernstein"', 'Rag No. 2 "The Bernstein"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beb8eb66-6944-4868-a08a-17006145cfe4'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 2 "The Bernstein""', piece.title_en = 'The New York Rags: Rag No. 2 "The Bernstein"', piece.editor_locked = 1
WHERE piece.id = 19092 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18162 AND linked.composer_id = 220), 'musicbrainz:83e6213f-a5e2-47aa-88e4-9121f1a8ec6a', 3, NULL, 'Rag No. 3 "The Duke"', 'Rag No. 3 "The Duke"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83e6213f-a5e2-47aa-88e4-9121f1a8ec6a'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 3 "The Duke""', piece.title_en = 'The New York Rags: Rag No. 3 "The Duke"', piece.editor_locked = 1
WHERE piece.id = 18162 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18918 AND linked.composer_id = 220), 'musicbrainz:b37862c6-1c6e-4461-b160-6d4aabff0e8a', 4, NULL, 'Rag No. 4 "Times Square"', 'Rag No. 4 "Times Square"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b37862c6-1c6e-4461-b160-6d4aabff0e8a'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 4 "Times Square""', piece.title_en = 'The New York Rags: Rag No. 4 "Times Square"', piece.editor_locked = 1
WHERE piece.id = 18918 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18649 AND linked.composer_id = 220), 'musicbrainz:a2a39bd9-659b-4c5d-85b1-a03b78c9552d', 5, NULL, 'Rag No. 5 "Fourth Street"', 'Rag No. 5 "Fourth Street"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a39bd9-659b-4c5d-85b1-a03b78c9552d'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 5 "Fourth Street""', piece.title_en = 'The New York Rags: Rag No. 5 "Fourth Street"', piece.editor_locked = 1
WHERE piece.id = 18649 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19359 AND linked.composer_id = 220), 'musicbrainz:cfd7a13e-0bd8-4b0c-8d2c-6ed374b23e73', 6, NULL, 'Rag No. 6 "Third Avenue"', 'Rag No. 6 "Third Avenue"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfd7a13e-0bd8-4b0c-8d2c-6ed374b23e73'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 6 "Third Avenue""', piece.title_en = 'The New York Rags: Rag No. 6 "Third Avenue"', piece.editor_locked = 1
WHERE piece.id = 19359 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18895 AND linked.composer_id = 220), 'musicbrainz:b200c177-5997-49c7-bb96-089dd287ec51', 7, NULL, 'Rag No. 7 "Broadway Boogie Woogie"', 'Rag No. 7 "Broadway Boogie Woogie"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b200c177-5997-49c7-bb96-089dd287ec51'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 7 "Broadway Boogie Woogie""', piece.title_en = 'The New York Rags: Rag No. 7 "Broadway Boogie Woogie"', piece.editor_locked = 1
WHERE piece.id = 18895 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19410 AND linked.composer_id = 220), 'musicbrainz:d30afca3-35cd-4959-8ec4-780de740f76f', 8, NULL, 'Rag No. 8 "Fifth Avenue"', 'Rag No. 8 "Fifth Avenue"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d30afca3-35cd-4959-8ec4-780de740f76f'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 8 "Fifth Avenue""', piece.title_en = 'The New York Rags: Rag No. 8 "Fifth Avenue"', piece.editor_locked = 1
WHERE piece.id = 19410 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17658 AND linked.composer_id = 220), 'musicbrainz:645cb00e-180d-4b0b-b3c5-b3df2f204f9e', 9, NULL, 'Rag No. 9 "Grand Central Morning"', 'Rag No. 9 "Grand Central Morning"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:645cb00e-180d-4b0b-b3c5-b3df2f204f9e'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 9 "Grand Central Morning""', piece.title_en = 'The New York Rags: Rag No. 9 "Grand Central Morning"', piece.editor_locked = 1
WHERE piece.id = 17658 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16430 AND linked.composer_id = 220), 'musicbrainz:1950da7d-9a7d-4103-9d3e-b845b620f960', 10, NULL, 'Rag No. 10 "Seventh Avenue"', 'Rag No. 10 "Seventh Avenue"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1950da7d-9a7d-4103-9d3e-b845b620f960'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 10 "Seventh Avenue""', piece.title_en = 'The New York Rags: Rag No. 10 "Seventh Avenue"', piece.editor_locked = 1
WHERE piece.id = 16430 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19285 AND linked.composer_id = 220), 'musicbrainz:ca8dcbc7-f87c-419e-9d39-cb61bf7bd523', 11, NULL, 'Rag No. 11 "The Circle at Fifth"', 'Rag No. 11 "The Circle at Fifth"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca8dcbc7-f87c-419e-9d39-cb61bf7bd523'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 11 "The Circle at Fifth""', piece.title_en = 'The New York Rags: Rag No. 11 "The Circle at Fifth"', piece.editor_locked = 1
WHERE piece.id = 19285 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16710 AND linked.composer_id = 220), 'musicbrainz:2b40e989-6b06-4f2a-b1b5-feea5c815d78', 12, NULL, 'Rag No. 12 "The Park Avenue Rag"', 'Rag No. 12 "The Park Avenue Rag"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b40e989-6b06-4f2a-b1b5-feea5c815d78'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 12 "The Park Avenue Rag""', piece.title_en = 'The New York Rags: Rag No. 12 "The Park Avenue Rag"', piece.editor_locked = 1
WHERE piece.id = 16710 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19748 AND linked.composer_id = 220), 'musicbrainz:eb0a698a-6481-4b3f-95c7-66d7b1111c39', 13, NULL, 'Rag No. 13 "The Thanksgiving Day Parade Rag in 7/4"', 'Rag No. 13 "The Thanksgiving Day Parade Rag in 7/4"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb0a698a-6481-4b3f-95c7-66d7b1111c39'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 13 "The Thanksgiving Day Parade Rag in 7/4""', piece.title_en = 'The New York Rags: Rag No. 13 "The Thanksgiving Day Parade Rag in 7/4"', piece.editor_locked = 1
WHERE piece.id = 19748 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16943 AND linked.composer_id = 220), 'musicbrainz:38c0323f-49b2-4154-b10d-f18c18ed960a', 14, NULL, 'Rag No. 14 "Kids You''re Late for School Rag"', 'Rag No. 14 "Kids You''re Late for School Rag"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38c0323f-49b2-4154-b10d-f18c18ed960a'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 14 "Kids You''re Late for School Rag""', piece.title_en = 'The New York Rags: Rag No. 14 "Kids You''re Late for School Rag"', piece.editor_locked = 1
WHERE piece.id = 16943 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19137 AND linked.composer_id = 220), 'musicbrainz:c194c636-57cb-47f7-bde2-648cfdab33ff', 15, NULL, 'Rag No. 15 "The Manhattan Blues Variations Rag"', 'Rag No. 15 "The Manhattan Blues Variations Rag"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c194c636-57cb-47f7-bde2-648cfdab33ff'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 15 "The Manhattan Blues Variations Rag""', piece.title_en = 'The New York Rags: Rag No. 15 "The Manhattan Blues Variations Rag"', piece.editor_locked = 1
WHERE piece.id = 19137 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19905 AND linked.composer_id = 220), 'musicbrainz:f4d65419-3329-410d-8746-4238a9e34ed6', 16, NULL, 'Rag No. 16 "Penn Station"', 'Rag No. 16 "Penn Station"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4d65419-3329-410d-8746-4238a9e34ed6'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 16 "Penn Station""', piece.title_en = 'The New York Rags: Rag No. 16 "Penn Station"', piece.editor_locked = 1
WHERE piece.id = 19905 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16759 AND linked.composer_id = 220), 'musicbrainz:2e53d801-a30f-45c7-aa7a-6ecdb64c4556', 17, NULL, 'Rag No. 17 "The J Walker Rag"', 'Rag No. 17 "The J Walker Rag"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e53d801-a30f-45c7-aa7a-6ecdb64c4556'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 17 "The J Walker Rag""', piece.title_en = 'The New York Rags: Rag No. 17 "The J Walker Rag"', piece.editor_locked = 1
WHERE piece.id = 16759 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18563 AND linked.composer_id = 220), 'musicbrainz:9c7f69c0-e4c3-4c8b-bd65-f0628362e8d8', 18, NULL, 'Rag No. 18 "The Coney Island Rag"', 'Rag No. 18 "The Coney Island Rag"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Rags' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c7f69c0-e4c3-4c8b-bd65-f0628362e8d8'
);

UPDATE pieces piece
SET piece.title = 'The New York Rags 중 "Rag No. 18 "The Coney Island Rag""', piece.title_en = 'The New York Rags: Rag No. 18 "The Coney Island Rag"', piece.editor_locked = 1
WHERE piece.id = 18563 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The New York Chorinhos

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The New York Chorinhos', 'The New York Chorinhos', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The New York Chorinhos'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19372 AND linked.composer_id = 220), 'musicbrainz:d0d59131-3059-4e15-86e4-79cf88212bbf', 1, NULL, 'Chorinho No. 4 "Washington Heights"', 'Chorinho No. 4 "Washington Heights"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0d59131-3059-4e15-86e4-79cf88212bbf'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 4 "Washington Heights""', piece.title_en = 'The New York Chorinhos: Chorinho No. 4 "Washington Heights"', piece.editor_locked = 1
WHERE piece.id = 19372 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16992 AND linked.composer_id = 220), 'musicbrainz:3c161b77-a0d5-4b80-b299-be1d3cadfd29', 2, NULL, 'Chorinho No. 2 "Brooklyn Bridge"', 'Chorinho No. 2 "Brooklyn Bridge"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c161b77-a0d5-4b80-b299-be1d3cadfd29'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 2 "Brooklyn Bridge""', piece.title_en = 'The New York Chorinhos: Chorinho No. 2 "Brooklyn Bridge"', piece.editor_locked = 1
WHERE piece.id = 16992 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19381 AND linked.composer_id = 220), 'musicbrainz:d170017a-30af-4e37-b347-896b00e22338', 3, NULL, 'Chorinho no. 3 "Sheep Meadow"', 'Chorinho no. 3 "Sheep Meadow"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d170017a-30af-4e37-b347-896b00e22338'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho no. 3 "Sheep Meadow""', piece.title_en = 'The New York Chorinhos: Chorinho no. 3 "Sheep Meadow"', piece.editor_locked = 1
WHERE piece.id = 19381 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17975 AND linked.composer_id = 220), 'musicbrainz:77923eb4-7ae5-4308-a584-70cc2d721a32', 4, NULL, 'Chorinho No. 13 "Latin Fugue"', 'Chorinho No. 13 "Latin Fugue"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77923eb4-7ae5-4308-a584-70cc2d721a32'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 13 "Latin Fugue""', piece.title_en = 'The New York Chorinhos: Chorinho No. 13 "Latin Fugue"', piece.editor_locked = 1
WHERE piece.id = 17975 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18978 AND linked.composer_id = 220), 'musicbrainz:b70dce2b-1c8d-46a6-b2b4-11bc57a37e37', 5, NULL, 'Chorinho No. 5 "Sutton Place"', 'Chorinho No. 5 "Sutton Place"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b70dce2b-1c8d-46a6-b2b4-11bc57a37e37'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 5 "Sutton Place""', piece.title_en = 'The New York Chorinhos: Chorinho No. 5 "Sutton Place"', piece.editor_locked = 1
WHERE piece.id = 18978 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18896 AND linked.composer_id = 220), 'musicbrainz:b24fed74-a8e4-4433-9012-cc88defb2b42', 6, NULL, 'Chorinho No. 10 "Soho Waltz"', 'Chorinho No. 10 "Soho Waltz"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b24fed74-a8e4-4433-9012-cc88defb2b42'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 10 "Soho Waltz""', piece.title_en = 'The New York Chorinhos: Chorinho No. 10 "Soho Waltz"', piece.editor_locked = 1
WHERE piece.id = 18896 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17092 AND linked.composer_id = 220), 'musicbrainz:41f5dc3e-d8b0-49a0-aedf-463c679ca90d', 7, NULL, 'Chorinho No. 15 "Summer Days"', 'Chorinho No. 15 "Summer Days"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41f5dc3e-d8b0-49a0-aedf-463c679ca90d'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 15 "Summer Days""', piece.title_en = 'The New York Chorinhos: Chorinho No. 15 "Summer Days"', piece.editor_locked = 1
WHERE piece.id = 17092 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19328 AND linked.composer_id = 220), 'musicbrainz:cddb0e83-e4ce-4f6f-9a53-5876ca18a358', 8, NULL, 'Chorinho no. 12 "Park Avenue"', 'Chorinho no. 12 "Park Avenue"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cddb0e83-e4ce-4f6f-9a53-5876ca18a358'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho no. 12 "Park Avenue""', piece.title_en = 'The New York Chorinhos: Chorinho no. 12 "Park Avenue"', piece.editor_locked = 1
WHERE piece.id = 19328 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18968 AND linked.composer_id = 220), 'musicbrainz:b67d4cd6-d94a-4dd5-955c-aa495e3f2372', 9, NULL, 'Chorinho No. 14 "Hudson Street"', 'Chorinho No. 14 "Hudson Street"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b67d4cd6-d94a-4dd5-955c-aa495e3f2372'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 14 "Hudson Street""', piece.title_en = 'The New York Chorinhos: Chorinho No. 14 "Hudson Street"', piece.editor_locked = 1
WHERE piece.id = 18968 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19470 AND linked.composer_id = 220), 'musicbrainz:d76324b1-aacf-46c5-ad06-b166eb4c91eb', 10, NULL, 'Chorinho No. 17 "Times Square"', 'Chorinho No. 17 "Times Square"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d76324b1-aacf-46c5-ad06-b166eb4c91eb'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 17 "Times Square""', piece.title_en = 'The New York Chorinhos: Chorinho No. 17 "Times Square"', piece.editor_locked = 1
WHERE piece.id = 19470 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18774 AND linked.composer_id = 220), 'musicbrainz:a9f881b5-1bc7-4e8b-8e55-8d0073196f70', 11, NULL, 'Chorinho No. 8 "Manhattan"', 'Chorinho No. 8 "Manhattan"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9f881b5-1bc7-4e8b-8e55-8d0073196f70'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 8 "Manhattan""', piece.title_en = 'The New York Chorinhos: Chorinho No. 8 "Manhattan"', piece.editor_locked = 1
WHERE piece.id = 18774 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17335 AND linked.composer_id = 220), 'musicbrainz:50d19a28-8c71-4ce8-8f84-821d95c5b5d4', 12, NULL, 'Chorinho No. 1 "New York"', 'Chorinho No. 1 "New York"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50d19a28-8c71-4ce8-8f84-821d95c5b5d4'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 1 "New York""', piece.title_en = 'The New York Chorinhos: Chorinho No. 1 "New York"', piece.editor_locked = 1
WHERE piece.id = 17335 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17345 AND linked.composer_id = 220), 'musicbrainz:51a16ace-0e34-4e6a-97da-86e6f609f22c', 13, NULL, 'Chorinho No. 6 "Broadway"', 'Chorinho No. 6 "Broadway"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51a16ace-0e34-4e6a-97da-86e6f609f22c'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 6 "Broadway""', piece.title_en = 'The New York Chorinhos: Chorinho No. 6 "Broadway"', piece.editor_locked = 1
WHERE piece.id = 17345 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19129 AND linked.composer_id = 220), 'musicbrainz:c0bcc8dc-dd2c-4334-b9b4-5b681acdb0d0', 14, NULL, 'Chorinho No. 9 "Madison Avenue"', 'Chorinho No. 9 "Madison Avenue"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0bcc8dc-dd2c-4334-b9b4-5b681acdb0d0'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 9 "Madison Avenue""', piece.title_en = 'The New York Chorinhos: Chorinho No. 9 "Madison Avenue"', piece.editor_locked = 1
WHERE piece.id = 19129 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17951 AND linked.composer_id = 220), 'musicbrainz:75ad660b-15db-482f-8c74-83c4ecb6a62a', 15, NULL, 'Chorinho No. 11 "Columbus Avenue"', 'Chorinho No. 11 "Columbus Avenue"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75ad660b-15db-482f-8c74-83c4ecb6a62a'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 11 "Columbus Avenue""', piece.title_en = 'The New York Chorinhos: Chorinho No. 11 "Columbus Avenue"', piece.editor_locked = 1
WHERE piece.id = 17951 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19367 AND linked.composer_id = 220), 'musicbrainz:d097f440-baf1-4c30-9571-1f8bfa7ffb1f', 16, NULL, 'Chorinho No. 16 "The Boat Pond"', 'Chorinho No. 16 "The Boat Pond"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The New York Chorinhos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d097f440-baf1-4c30-9571-1f8bfa7ffb1f'
);

UPDATE pieces piece
SET piece.title = 'The New York Chorinhos 중 "Chorinho No. 16 "The Boat Pond""', piece.title_en = 'The New York Chorinhos: Chorinho No. 16 "The Boat Pond"', piece.editor_locked = 1
WHERE piece.id = 19367 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Victory (음반)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Victory (음반)', 'Victory', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Victory (음반)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16452 AND linked.composer_id = 220), 'musicbrainz:1a1eb3c4-ffa4-4a7f-92eb-0415d9db1ca4', 1, NULL, 'Compression', 'Compression', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a1eb3c4-ffa4-4a7f-92eb-0415d9db1ca4'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Compression"', piece.title_en = 'Victory: Compression', piece.editor_locked = 1
WHERE piece.id = 16452 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19380 AND linked.composer_id = 220), 'musicbrainz:d1503ffc-41fa-44ee-adb1-a95c074ac76d', 2, NULL, 'Compression II', 'Compression II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1503ffc-41fa-44ee-adb1-a95c074ac76d'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Compression II"', piece.title_en = 'Victory: Compression II', piece.editor_locked = 1
WHERE piece.id = 19380 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17106 AND linked.composer_id = 220), 'musicbrainz:42eade67-4d85-4c91-a79d-ad2b9a05e73f', 3, NULL, 'Stretch Run', 'Stretch Run', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42eade67-4d85-4c91-a79d-ad2b9a05e73f'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Stretch Run"', piece.title_en = 'Victory: Stretch Run', piece.editor_locked = 1
WHERE piece.id = 17106 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17670 AND linked.composer_id = 220), 'musicbrainz:65218f97-80d7-4dc0-a0f9-9d55c3b8507c', 4, NULL, 'Stretch Run II', 'Stretch Run II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65218f97-80d7-4dc0-a0f9-9d55c3b8507c'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Stretch Run II"', piece.title_en = 'Victory: Stretch Run II', piece.editor_locked = 1
WHERE piece.id = 17670 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16002 AND linked.composer_id = 220), 'musicbrainz:011fd227-b45b-4c99-b27d-4d717517dac0', 5, NULL, 'Grandeur', 'Grandeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:011fd227-b45b-4c99-b27d-4d717517dac0'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Grandeur"', piece.title_en = 'Victory: Grandeur', piece.editor_locked = 1
WHERE piece.id = 16002 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19799 AND linked.composer_id = 220), 'musicbrainz:ee577e9a-35e2-41bc-b6e0-396af61dcba2', 6, NULL, 'Grandeur II', 'Grandeur II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee577e9a-35e2-41bc-b6e0-396af61dcba2'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Grandeur II"', piece.title_en = 'Victory: Grandeur II', piece.editor_locked = 1
WHERE piece.id = 19799 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18948 AND linked.composer_id = 220), 'musicbrainz:b4deb077-580e-49e2-8588-cd9659be9e62', 7, NULL, 'Victory', 'Victory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4deb077-580e-49e2-8588-cd9659be9e62'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Victory"', piece.title_en = 'Victory: Victory', piece.editor_locked = 1
WHERE piece.id = 18948 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18805 AND linked.composer_id = 220), 'musicbrainz:ab950ce0-e30a-4101-b1df-f4fd095cb7b6', 8, NULL, 'Victory II', 'Victory II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab950ce0-e30a-4101-b1df-f4fd095cb7b6'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Victory II"', piece.title_en = 'Victory: Victory II', piece.editor_locked = 1
WHERE piece.id = 18805 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16098 AND linked.composer_id = 220), 'musicbrainz:063a3288-2d81-46cf-b22e-f6ce07fe9a27', 9, NULL, 'Lazer Pulse', 'Lazer Pulse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:063a3288-2d81-46cf-b22e-f6ce07fe9a27'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Lazer Pulse"', piece.title_en = 'Victory: Lazer Pulse', piece.editor_locked = 1
WHERE piece.id = 16098 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16977 AND linked.composer_id = 220), 'musicbrainz:3b428db9-9820-49a9-a86a-b7f27c7940ce', 10, NULL, 'Lazer Pulse II', 'Lazer Pulse II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b428db9-9820-49a9-a86a-b7f27c7940ce'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Lazer Pulse II"', piece.title_en = 'Victory: Lazer Pulse II', piece.editor_locked = 1
WHERE piece.id = 16977 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18201 AND linked.composer_id = 220), 'musicbrainz:86c09592-d360-4b7e-adbb-2043d6a88c10', 11, NULL, 'Burning Up', 'Burning Up', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86c09592-d360-4b7e-adbb-2043d6a88c10'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Burning Up"', piece.title_en = 'Victory: Burning Up', piece.editor_locked = 1
WHERE piece.id = 18201 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18462 AND linked.composer_id = 220), 'musicbrainz:965fcce1-6356-4b1d-8945-adb8af9fb9ad', 12, NULL, 'Burning Up II', 'Burning Up II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:965fcce1-6356-4b1d-8945-adb8af9fb9ad'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Burning Up II"', piece.title_en = 'Victory: Burning Up II', piece.editor_locked = 1
WHERE piece.id = 18462 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:990e5b2d-b458-437e-812d-a9e0568d40fa', 13, NULL, 'Rising', 'Rising', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:990e5b2d-b458-437e-812d-a9e0568d40fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18691 AND linked.composer_id = 220), 'musicbrainz:a4ea5035-003a-4ab9-b33c-95923ffe3f00', 14, NULL, 'Rising II', 'Rising II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4ea5035-003a-4ab9-b33c-95923ffe3f00'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Rising II"', piece.title_en = 'Victory: Rising II', piece.editor_locked = 1
WHERE piece.id = 18691 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16270 AND linked.composer_id = 220), 'musicbrainz:103d91de-e6b3-4540-b1b1-bccd1c892691', 15, NULL, 'Acceleration', 'Acceleration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:103d91de-e6b3-4540-b1b1-bccd1c892691'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Acceleration"', piece.title_en = 'Victory: Acceleration', piece.editor_locked = 1
WHERE piece.id = 16270 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19070 AND linked.composer_id = 220), 'musicbrainz:bd7ae8e4-5dd3-4e2a-8e43-05fdf8d56816', 16, NULL, 'Acceleration II', 'Acceleration II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Victory (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd7ae8e4-5dd3-4e2a-8e43-05fdf8d56816'
);

UPDATE pieces piece
SET piece.title = 'Victory (음반) 중 "Acceleration II"', piece.title_en = 'Victory: Acceleration II', piece.editor_locked = 1
WHERE piece.id = 19070 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Club de sol (음반)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Club de sol (음반)', 'Club de sol', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Club de sol (음반)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15907 AND linked.composer_id = 220), 'musicbrainz:53f099bb-123c-46f2-a9c6-75d45fa114e0', 1, NULL, 'Club de sol', 'Club de sol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53f099bb-123c-46f2-a9c6-75d45fa114e0'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "Club de sol"', piece.title_en = 'Club de sol: Club de sol', piece.editor_locked = 1
WHERE piece.id = 15907 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16475 AND linked.composer_id = 220), 'musicbrainz:1bae6baa-6a1a-4cee-aad6-541b1ea4729b', 2, NULL, 'White Water', 'White Water', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bae6baa-6a1a-4cee-aad6-541b1ea4729b'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "White Water"', piece.title_en = 'Club de sol: White Water', piece.editor_locked = 1
WHERE piece.id = 16475 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18447 AND linked.composer_id = 220), 'musicbrainz:954c55f3-25ea-43f7-99c2-4f3504888822', 3, NULL, '리비를 위한 왈츠', 'Waltz for Libby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:954c55f3-25ea-43f7-99c2-4f3504888822'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "리비를 위한 왈츠"', piece.title_en = 'Club de sol: Waltz for Libby', piece.editor_locked = 1
WHERE piece.id = 18447 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16655 AND linked.composer_id = 220), 'musicbrainz:27ae5c89-bd24-4859-8e1c-02b066f52db4', 4, NULL, 'Marina', 'Marina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27ae5c89-bd24-4859-8e1c-02b066f52db4'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "Marina"', piece.title_en = 'Club de sol: Marina', piece.editor_locked = 1
WHERE piece.id = 16655 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17402 AND linked.composer_id = 220), 'musicbrainz:54b9ebec-890e-4a62-93b4-ab4c2cbafdc1', 5, NULL, 'Sunrise', 'Sunrise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54b9ebec-890e-4a62-93b4-ab4c2cbafdc1'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "Sunrise"', piece.title_en = 'Club de sol: Sunrise', piece.editor_locked = 1
WHERE piece.id = 17402 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16276 AND linked.composer_id = 220), 'musicbrainz:10a02e44-186f-4158-b726-a25beceb0286', 6, NULL, 'Morning Mist', 'Morning Mist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10a02e44-186f-4158-b726-a25beceb0286'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "Morning Mist"', piece.title_en = 'Club de sol: Morning Mist', piece.editor_locked = 1
WHERE piece.id = 16276 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16101 AND linked.composer_id = 220), 'musicbrainz:067dc69b-32ca-46f4-95c8-479fdd6bf35a', 7, NULL, 'Desert Island', 'Desert Island', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:067dc69b-32ca-46f4-95c8-479fdd6bf35a'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "Desert Island"', piece.title_en = 'Club de sol: Desert Island', piece.editor_locked = 1
WHERE piece.id = 16101 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17144 AND linked.composer_id = 220), 'musicbrainz:4518a6d8-3889-4bf0-ab70-fcb73c5c1935', 8, NULL, 'Sugar Loaf', 'Sugar Loaf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4518a6d8-3889-4bf0-ab70-fcb73c5c1935'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "Sugar Loaf"', piece.title_en = 'Club de sol: Sugar Loaf', piece.editor_locked = 1
WHERE piece.id = 17144 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19102 AND linked.composer_id = 220), 'musicbrainz:bf46e1a8-dfc7-4638-88de-744c95b59a24', 9, NULL, 'Swan’s Point', 'Swan’s Point', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf46e1a8-dfc7-4638-88de-744c95b59a24'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "Swan’s Point"', piece.title_en = 'Club de sol: Swan’s Point', piece.editor_locked = 1
WHERE piece.id = 19102 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17593 AND linked.composer_id = 220), 'musicbrainz:60a4fafc-950b-46df-ae15-45b8dd2f8ec4', 10, NULL, 'Back Again', 'Back Again', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60a4fafc-950b-46df-ae15-45b8dd2f8ec4'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "Back Again"', piece.title_en = 'Club de sol: Back Again', piece.editor_locked = 1
WHERE piece.id = 17593 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19488 AND linked.composer_id = 220), 'musicbrainz:d8405a04-68c5-4cea-9fee-bb32e3287301', 11, NULL, 'Central Park Morning', 'Central Park Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Club de sol (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8405a04-68c5-4cea-9fee-bb32e3287301'
);

UPDATE pieces piece
SET piece.title = 'Club de sol (음반) 중 "Central Park Morning"', piece.title_en = 'Club de sol: Central Park Morning', piece.editor_locked = 1
WHERE piece.id = 19488 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Olympian

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Olympian', 'The Olympian', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Olympian'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19907 AND linked.composer_id = 220), 'musicbrainz:f4f71f59-0e01-4ef1-aa21-8d5472fa0700', 1, NULL, 'Olympic Fever', 'Olympic Fever', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4f71f59-0e01-4ef1-aa21-8d5472fa0700'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "Olympic Fever"', piece.title_en = 'The Olympian: Olympic Fever', piece.editor_locked = 1
WHERE piece.id = 19907 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16334 AND linked.composer_id = 220), 'musicbrainz:13f5b8bd-b4ca-402f-8293-58da2ae10b7c', 2, NULL, 'Intensity', 'Intensity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13f5b8bd-b4ca-402f-8293-58da2ae10b7c'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "Intensity"', piece.title_en = 'The Olympian: Intensity', piece.editor_locked = 1
WHERE piece.id = 16334 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d18d7c7-fac8-4034-862a-3bbac934b631', 3, NULL, 'Intensity (short version)', 'Intensity (short version)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d18d7c7-fac8-4034-862a-3bbac934b631'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19415 AND linked.composer_id = 220), 'musicbrainz:d3790231-16cf-4443-b662-4cd0bba965c0', 4, NULL, 'Personal Pride', 'Personal Pride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3790231-16cf-4443-b662-4cd0bba965c0'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "Personal Pride"', piece.title_en = 'The Olympian: Personal Pride', piece.editor_locked = 1
WHERE piece.id = 19415 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17333 AND linked.composer_id = 220), 'musicbrainz:50a506e5-ce71-4337-a829-75f47b148bdd', 5, NULL, 'Track Time', 'Track Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50a506e5-ce71-4337-a829-75f47b148bdd'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "Track Time"', piece.title_en = 'The Olympian: Track Time', piece.editor_locked = 1
WHERE piece.id = 17333 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16470 AND linked.composer_id = 220), 'musicbrainz:1b2ce64a-5b24-4108-9633-700cda22ffa2', 6, NULL, 'Power', 'Power', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b2ce64a-5b24-4108-9633-700cda22ffa2'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "Power"', piece.title_en = 'The Olympian: Power', piece.editor_locked = 1
WHERE piece.id = 16470 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16041 AND linked.composer_id = 220), 'musicbrainz:0315fecd-7505-401b-9135-d63c46f669ac', 7, NULL, 'Final Movement', 'Final Movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0315fecd-7505-401b-9135-d63c46f669ac'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "Final Movement"', piece.title_en = 'The Olympian: Final Movement', piece.editor_locked = 1
WHERE piece.id = 16041 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f57efd7-92e0-4725-849b-7b463ab9e712', 8, NULL, 'Rush Hour', 'Rush Hour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f57efd7-92e0-4725-849b-7b463ab9e712'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2e1dfc4-c452-4609-a5e2-9d88b7c24569', 9, NULL, 'Born to Be Champ', 'Born to Be Champ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2e1dfc4-c452-4609-a5e2-9d88b7c24569'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18657 AND linked.composer_id = 220), 'musicbrainz:a313d686-d133-4fc8-94ba-1c891cd815b2', 10, NULL, 'Born to Be Champ (instrumental)', 'Born to Be Champ (instrumental)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a313d686-d133-4fc8-94ba-1c891cd815b2'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "Born to Be Champ (instrumental)"', piece.title_en = 'The Olympian: Born to Be Champ (instrumental)', piece.editor_locked = 1
WHERE piece.id = 18657 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d778d96e-61bf-4f05-8be4-f13031ba2c92', 11, NULL, 'Olympian Fanfare', 'Olympian Fanfare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d778d96e-61bf-4f05-8be4-f13031ba2c92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16812 AND linked.composer_id = 220), 'musicbrainz:31a1702a-c6dd-40a8-9168-448fbd444390', 12, NULL, 'Olympian Fanfare (No Guitar)', 'Olympian Fanfare (No Guitar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31a1702a-c6dd-40a8-9168-448fbd444390'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "Olympian Fanfare (No Guitar)"', piece.title_en = 'The Olympian: Olympian Fanfare (No Guitar)', piece.editor_locked = 1
WHERE piece.id = 16812 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18372 AND linked.composer_id = 220), 'musicbrainz:90eb43b7-6db0-4f21-8d68-23f849846b51', 13, NULL, 'The Torch', 'The Torch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90eb43b7-6db0-4f21-8d68-23f849846b51'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "The Torch"', piece.title_en = 'The Olympian: The Torch', piece.editor_locked = 1
WHERE piece.id = 18372 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16251 AND linked.composer_id = 220), 'musicbrainz:0f321b22-7d52-4844-bea4-5d2d6035d536', 14, NULL, 'Majesty', 'Majesty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Olympian' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f321b22-7d52-4844-bea4-5d2d6035d536'
);

UPDATE pieces piece
SET piece.title = 'The Olympian 중 "Majesty"', piece.title_en = 'The Olympian: Majesty', piece.editor_locked = 1
WHERE piece.id = 16251 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Tangos and Dances

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Tangos and Dances', 'The Tangos and Dances', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Tangos and Dances'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19476 AND linked.composer_id = 220), 'musicbrainz:d7927abf-552d-4aad-87a9-c1c3ae72ac65', 1, NULL, '춤곡 3번', 'Dance No.3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7927abf-552d-4aad-87a9-c1c3ae72ac65'
);

UPDATE pieces piece
SET piece.title = 'The Tangos and Dances 중 "춤곡 3번"', piece.title_en = 'The Tangos and Dances: Dance No.3', piece.editor_locked = 1
WHERE piece.id = 19476 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0b8e392-c801-400c-b37f-6faa886e63d8', 2, NULL, 'Tango No.2', 'Tango No.2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0b8e392-c801-400c-b37f-6faa886e63d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16689 AND linked.composer_id = 220), 'musicbrainz:29ece50d-5e56-4e69-b959-6e5673075b2d', 3, NULL, '춤곡 4번', 'Dance No.4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29ece50d-5e56-4e69-b959-6e5673075b2d'
);

UPDATE pieces piece
SET piece.title = 'The Tangos and Dances 중 "춤곡 4번"', piece.title_en = 'The Tangos and Dances: Dance No.4', piece.editor_locked = 1
WHERE piece.id = 16689 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18016 AND linked.composer_id = 220), 'musicbrainz:7a0fc798-ac9d-4a08-ab7e-ef6a3ea04062', 4, NULL, 'Chorinho No.19', 'Chorinho No.19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a0fc798-ac9d-4a08-ab7e-ef6a3ea04062'
);

UPDATE pieces piece
SET piece.title = 'The Tangos and Dances 중 "Chorinho No.19"', piece.title_en = 'The Tangos and Dances: Chorinho No.19', piece.editor_locked = 1
WHERE piece.id = 18016 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18599 AND linked.composer_id = 220), 'musicbrainz:9f2206a1-3385-4955-bf99-b648549c1576', 5, NULL, '춤곡 1번', 'Dance No.1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f2206a1-3385-4955-bf99-b648549c1576'
);

UPDATE pieces piece
SET piece.title = 'The Tangos and Dances 중 "춤곡 1번"', piece.title_en = 'The Tangos and Dances: Dance No.1', piece.editor_locked = 1
WHERE piece.id = 18599 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19708 AND linked.composer_id = 220), 'musicbrainz:e7e813bc-7db1-4c0a-b28f-758ab046c8fc', 6, NULL, 'Chorinho No.7', 'Chorinho No.7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7e813bc-7db1-4c0a-b28f-758ab046c8fc'
);

UPDATE pieces piece
SET piece.title = 'The Tangos and Dances 중 "Chorinho No.7"', piece.title_en = 'The Tangos and Dances: Chorinho No.7', piece.editor_locked = 1
WHERE piece.id = 19708 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16960 AND linked.composer_id = 220), 'musicbrainz:3a17b3bc-44d8-41ec-aa32-38b8839b052c', 7, NULL, '춤곡 2번', 'Dance No.2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a17b3bc-44d8-41ec-aa32-38b8839b052c'
);

UPDATE pieces piece
SET piece.title = 'The Tangos and Dances 중 "춤곡 2번"', piece.title_en = 'The Tangos and Dances: Dance No.2', piece.editor_locked = 1
WHERE piece.id = 16960 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:574d9bd7-3dd8-4671-a46e-9462d07f7a01', 8, NULL, 'Tango No.1', 'Tango No.1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:574d9bd7-3dd8-4671-a46e-9462d07f7a01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16201 AND linked.composer_id = 220), 'musicbrainz:0c9ca90d-4d00-4349-af1c-ee4873eb2106', 9, NULL, 'Chorinho No.18', 'Chorinho No.18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c9ca90d-4d00-4349-af1c-ee4873eb2106'
);

UPDATE pieces piece
SET piece.title = 'The Tangos and Dances 중 "Chorinho No.18"', piece.title_en = 'The Tangos and Dances: Chorinho No.18', piece.editor_locked = 1
WHERE piece.id = 16201 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19589 AND linked.composer_id = 220), 'musicbrainz:df894239-ed09-46af-bd9b-57b8f96bdb5c', 10, NULL, '춤곡 5번', 'Dance No.5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'The Tangos and Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df894239-ed09-46af-bd9b-57b8f96bdb5c'
);

UPDATE pieces piece
SET piece.title = 'The Tangos and Dances 중 "춤곡 5번"', piece.title_en = 'The Tangos and Dances: Dance No.5', piece.editor_locked = 1
WHERE piece.id = 19589 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jazz in the New Harmonic (음반)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Jazz in the New Harmonic (음반)', 'Jazz in the New Harmonic', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Jazz in the New Harmonic (음반)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18254 AND linked.composer_id = 220), 'musicbrainz:8a7ce4bb-5958-4d41-9e9b-a8180da2c205', 1, NULL, 'Jazz in the New Harmonic', 'Jazz in the New Harmonic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Jazz in the New Harmonic (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a7ce4bb-5958-4d41-9e9b-a8180da2c205'
);

UPDATE pieces piece
SET piece.title = 'Jazz in the New Harmonic (음반) 중 "Jazz in the New Harmonic"', piece.title_en = 'Jazz in the New Harmonic: Jazz in the New Harmonic', piece.editor_locked = 1
WHERE piece.id = 18254 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17927 AND linked.composer_id = 220), 'musicbrainz:73c2fcc2-1db9-4915-9941-2363a82a3637', 2, NULL, 'Broadway', 'Broadway', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Jazz in the New Harmonic (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73c2fcc2-1db9-4915-9941-2363a82a3637'
);

UPDATE pieces piece
SET piece.title = 'Jazz in the New Harmonic (음반) 중 "Broadway"', piece.title_en = 'Jazz in the New Harmonic: Broadway', piece.editor_locked = 1
WHERE piece.id = 17927 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16843 AND linked.composer_id = 220), 'musicbrainz:3332951a-8f38-4a95-b7f2-c1f1d2381a83', 3, NULL, 'American Culture X', 'American Culture X', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Jazz in the New Harmonic (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3332951a-8f38-4a95-b7f2-c1f1d2381a83'
);

UPDATE pieces piece
SET piece.title = 'Jazz in the New Harmonic (음반) 중 "American Culture X"', piece.title_en = 'Jazz in the New Harmonic: American Culture X', piece.editor_locked = 1
WHERE piece.id = 16843 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17631 AND linked.composer_id = 220), 'musicbrainz:62a46867-3db6-442b-9ba4-953e7985062b', 4, NULL, 'Duke''s Groove', 'Duke''s Groove', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Jazz in the New Harmonic (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62a46867-3db6-442b-9ba4-953e7985062b'
);

UPDATE pieces piece
SET piece.title = 'Jazz in the New Harmonic (음반) 중 "Duke''s Groove"', piece.title_en = 'Jazz in the New Harmonic: Duke''s Groove', piece.editor_locked = 1
WHERE piece.id = 17631 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17242 AND linked.composer_id = 220), 'musicbrainz:4a2e07c0-b3ac-4744-9be2-0f33b95305ef', 5, NULL, 'Grooves From the Underground', 'Grooves From the Underground', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Jazz in the New Harmonic (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a2e07c0-b3ac-4744-9be2-0f33b95305ef'
);

UPDATE pieces piece
SET piece.title = 'Jazz in the New Harmonic (음반) 중 "Grooves From the Underground"', piece.title_en = 'Jazz in the New Harmonic: Grooves From the Underground', piece.editor_locked = 1
WHERE piece.id = 17242 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16367 AND linked.composer_id = 220), 'musicbrainz:15b90393-4a3a-43cc-9ed3-4cdb94478fc9', 6, NULL, 'Deconstruction', 'Deconstruction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Jazz in the New Harmonic (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15b90393-4a3a-43cc-9ed3-4cdb94478fc9'
);

UPDATE pieces piece
SET piece.title = 'Jazz in the New Harmonic (음반) 중 "Deconstruction"', piece.title_en = 'Jazz in the New Harmonic: Deconstruction', piece.editor_locked = 1
WHERE piece.id = 16367 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17936 AND linked.composer_id = 220), 'musicbrainz:746a1ed0-2d64-4d16-8eff-bbfacc4f23e8', 7, NULL, 'Burnout', 'Burnout', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Jazz in the New Harmonic (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:746a1ed0-2d64-4d16-8eff-bbfacc4f23e8'
);

UPDATE pieces piece
SET piece.title = 'Jazz in the New Harmonic (음반) 중 "Burnout"', piece.title_en = 'Jazz in the New Harmonic: Burnout', piece.editor_locked = 1
WHERE piece.id = 17936 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19694 AND linked.composer_id = 220), 'musicbrainz:e6f3f51b-651d-46ae-9d71-53f50d412fd2', 8, NULL, 'Transcendental Tripping', 'Transcendental Tripping', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Jazz in the New Harmonic (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6f3f51b-651d-46ae-9d71-53f50d412fd2'
);

UPDATE pieces piece
SET piece.title = 'Jazz in the New Harmonic (음반) 중 "Transcendental Tripping"', piece.title_en = 'Jazz in the New Harmonic: Transcendental Tripping', piece.editor_locked = 1
WHERE piece.id = 19694 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Primal Scream (음반)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Primal Scream (음반)', 'Primal Scream', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Primal Scream (음반)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18141 AND linked.composer_id = 220), 'musicbrainz:821e317e-3f4c-4f23-b1b0-d1349895b17d', 1, NULL, 'Check Point Charlie', 'Check Point Charlie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Primal Scream (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:821e317e-3f4c-4f23-b1b0-d1349895b17d'
);

UPDATE pieces piece
SET piece.title = 'Primal Scream (음반) 중 "Check Point Charlie"', piece.title_en = 'Primal Scream: Check Point Charlie', piece.editor_locked = 1
WHERE piece.id = 18141 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19370 AND linked.composer_id = 220), 'musicbrainz:d0bd0a54-f05d-496a-a9e9-e1dba6a922c1', 2, NULL, 'Cultural Treason', 'Cultural Treason', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Primal Scream (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0bd0a54-f05d-496a-a9e9-e1dba6a922c1'
);

UPDATE pieces piece
SET piece.title = 'Primal Scream (음반) 중 "Cultural Treason"', piece.title_en = 'Primal Scream: Cultural Treason', piece.editor_locked = 1
WHERE piece.id = 19370 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17317 AND linked.composer_id = 220), 'musicbrainz:4fdc7e31-88da-4b82-acb3-39061a12699a', 3, NULL, 'Quiet Desperation', 'Quiet Desperation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Primal Scream (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fdc7e31-88da-4b82-acb3-39061a12699a'
);

UPDATE pieces piece
SET piece.title = 'Primal Scream (음반) 중 "Quiet Desperation"', piece.title_en = 'Primal Scream: Quiet Desperation', piece.editor_locked = 1
WHERE piece.id = 17317 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16488 AND linked.composer_id = 220), 'musicbrainz:1c62351f-1f0a-4568-a4ae-6ff4c4c36e1d', 4, NULL, 'Kill the Philharmonic', 'Kill the Philharmonic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Primal Scream (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c62351f-1f0a-4568-a4ae-6ff4c4c36e1d'
);

UPDATE pieces piece
SET piece.title = 'Primal Scream (음반) 중 "Kill the Philharmonic"', piece.title_en = 'Primal Scream: Kill the Philharmonic', piece.editor_locked = 1
WHERE piece.id = 16488 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16213 AND linked.composer_id = 220), 'musicbrainz:0d05badb-8618-4a7e-b772-1ab77a75570c', 5, NULL, 'Primal Scream', 'Primal Scream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Primal Scream (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d05badb-8618-4a7e-b772-1ab77a75570c'
);

UPDATE pieces piece
SET piece.title = 'Primal Scream (음반) 중 "Primal Scream"', piece.title_en = 'Primal Scream: Primal Scream', piece.editor_locked = 1
WHERE piece.id = 16213 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16790 AND linked.composer_id = 220), 'musicbrainz:30458b5f-75bd-4a43-8026-b6762f91625b', 6, NULL, 'Isolation', 'Isolation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Primal Scream (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30458b5f-75bd-4a43-8026-b6762f91625b'
);

UPDATE pieces piece
SET piece.title = 'Primal Scream (음반) 중 "Isolation"', piece.title_en = 'Primal Scream: Isolation', piece.editor_locked = 1
WHERE piece.id = 16790 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17959 AND linked.composer_id = 220), 'musicbrainz:762a6445-63af-4cde-a736-c3b0306292e8', 7, NULL, 'Sleepless in New York', 'Sleepless in New York', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Primal Scream (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:762a6445-63af-4cde-a736-c3b0306292e8'
);

UPDATE pieces piece
SET piece.title = 'Primal Scream (음반) 중 "Sleepless in New York"', piece.title_en = 'Primal Scream: Sleepless in New York', piece.editor_locked = 1
WHERE piece.id = 17959 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Psalms For String Orchestra

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Three Psalms For String Orchestra', 'Three Psalms For String Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Three Psalms For String Orchestra'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19021 AND linked.composer_id = 220), 'musicbrainz:ba9ab702-f04b-4656-8d02-043314986140', 1, NULL, '시편 I', 'Psalm I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Three Psalms For String Orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba9ab702-f04b-4656-8d02-043314986140'
);

UPDATE pieces piece
SET piece.title = 'Three Psalms For String Orchestra 중 "시편 I"', piece.title_en = 'Three Psalms For String Orchestra: Psalm I', piece.editor_locked = 1
WHERE piece.id = 19021 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16320 AND linked.composer_id = 220), 'musicbrainz:1300d332-3185-488c-ba0c-b893ea1a8313', 2, NULL, '시편 II', 'Psalm II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Three Psalms For String Orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1300d332-3185-488c-ba0c-b893ea1a8313'
);

UPDATE pieces piece
SET piece.title = 'Three Psalms For String Orchestra 중 "시편 II"', piece.title_en = 'Three Psalms For String Orchestra: Psalm II', piece.editor_locked = 1
WHERE piece.id = 16320 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16409 AND linked.composer_id = 220), 'musicbrainz:17d5b8d2-c111-442a-850f-25b7b88d2482', 3, NULL, '시편 III', 'Psalm III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Three Psalms For String Orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17d5b8d2-c111-442a-850f-25b7b88d2482'
);

UPDATE pieces piece
SET piece.title = 'Three Psalms For String Orchestra 중 "시편 III"', piece.title_en = 'Three Psalms For String Orchestra: Psalm III', piece.editor_locked = 1
WHERE piece.id = 16409 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts', 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 220
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16664 AND linked.composer_id = 220), 'musicbrainz:2800d04a-fab4-47d7-9898-e16322631815', 1, NULL, '시편 IV "Sorrow"', 'Psalm IV: Sorrow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2800d04a-fab4-47d7-9898-e16322631815'
);

UPDATE pieces piece
SET piece.title = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts 중 "시편 IV "Sorrow""', piece.title_en = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts: Psalm IV: Sorrow', piece.editor_locked = 1
WHERE piece.id = 16664 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18593 AND linked.composer_id = 220), 'musicbrainz:9ed07efe-af5c-4b9b-99d5-1e06370e17dc', 2, NULL, '시편 V "Aftermath"', 'Psalm V: Aftermath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed07efe-af5c-4b9b-99d5-1e06370e17dc'
);

UPDATE pieces piece
SET piece.title = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts 중 "시편 V "Aftermath""', piece.title_en = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts: Psalm V: Aftermath', piece.editor_locked = 1
WHERE piece.id = 18593 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17338 AND linked.composer_id = 220), 'musicbrainz:5104aebb-fa73-47ed-92b3-8f9811e9aa31', 3, NULL, '시편 VI "Rage and Despair"', 'Psalm VI: Rage and Despair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 220 AND p.title = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5104aebb-fa73-47ed-92b3-8f9811e9aa31'
);

UPDATE pieces piece
SET piece.title = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts 중 "시편 VI "Rage and Despair""', piece.title_en = 'Psalms 4, 5 & 6: Remembrance for the Victims of the Modern Holocausts: Psalm VI: Rage and Despair', piece.editor_locked = 1
WHERE piece.id = 17338 AND piece.composer_id = 220
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 9개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 220 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15906, 15924, 17885, 18034, 18464, 18569, 19158, 19397, 19473
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
