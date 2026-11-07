-- 게오르크 프리드리히 하스 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 26개(묶음 2, 다악장 0, 낱곡 24),
-- 새 작품 0개, part 6개, 그 아래 0개.
-- seed 27개 중 26개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.
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

-- None 1. Streichquartett

UPDATE pieces piece
SET piece.title = '1. Streichquartett', piece.title_en = '1. Streichquartett',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25713 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 11.000 Saiten

UPDATE pieces piece
SET piece.title = '11.000 Saiten', piece.title_en = '11.000 Saiten',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24134 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 2. Streichquartett

UPDATE pieces piece
SET piece.title = '2. Streichquartett', piece.title_en = '2. Streichquartett',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25918 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto for Baritone Saxophone

UPDATE pieces piece
SET piece.title = 'Concerto for Baritone Saxophone', piece.title_en = 'Concerto for Baritone Saxophone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25696 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 합주 협주곡 1번

UPDATE pieces piece
SET piece.title = '합주 협주곡 1번', piece.title_en = 'Concerto grosso Nr. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24507 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 합주 협주곡 2번

UPDATE pieces piece
SET piece.title = '합주 협주곡 2번', piece.title_en = 'Concerto grosso Nr. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23729 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Einklang freier Wesen

UPDATE pieces piece
SET piece.title = 'Einklang freier Wesen', piece.title_en = 'Einklang freier Wesen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23349 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hyperion

UPDATE pieces piece
SET piece.title = 'Hyperion', piece.title_en = 'Hyperion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23486 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In nomine

UPDATE pieces piece
SET piece.title = 'In nomine', piece.title_en = 'In nomine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25276 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Introduktion und Transsonation

UPDATE pieces piece
SET piece.title = 'Introduktion und Transsonation', piece.title_en = 'Introduktion und Transsonation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25681 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None LAIR

UPDATE pieces piece
SET piece.title = 'LAIR', piece.title_en = 'LAIR',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25885 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nacht-Schatten

UPDATE pieces piece
SET piece.title = 'Nacht-Schatten', piece.title_en = 'Nacht-Schatten',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25656 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Natures mortes

UPDATE pieces piece
SET piece.title = 'Natures mortes', piece.title_en = 'Natures mortes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24673 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Oktett für 8 Posaunen

UPDATE pieces piece
SET piece.title = 'Oktett für 8 Posaunen', piece.title_en = 'Oktett für 8 Posaunen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24437 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Open Spaces II

UPDATE pieces piece
SET piece.title = 'Open Spaces II', piece.title_en = 'Open Spaces II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25858 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 4중주

UPDATE pieces piece
SET piece.title = '4중주', piece.title_en = 'Quartet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25248 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Saxophone Quartet

UPDATE pieces piece
SET piece.title = 'Saxophone Quartet', piece.title_en = 'Saxophone Quartet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25890 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trois Hommages

UPDATE pieces piece
SET piece.title = 'Trois Hommages', piece.title_en = 'Trois Hommages',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25569 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hommage à Steve Reich', part.name_en = 'Trois Hommages: Hommage à Steve Reich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25569 AND p.composer_id = 407 AND part.part_key = 'musicbrainz:3d6be14a-98ab-4f69-9210-cc68cc24f57e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d6be14a-98ab-4f69-9210-cc68cc24f57e', 1, NULL, 'Hommage à Steve Reich', 'Trois Hommages: Hommage à Steve Reich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25569 AND p.composer_id = 407
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d6be14a-98ab-4f69-9210-cc68cc24f57e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hommage à György Ligeti', part.name_en = 'Trois Hommages: Hommage à György Ligeti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25569 AND p.composer_id = 407 AND part.part_key = 'musicbrainz:41977bb3-ed4c-4246-ba5c-379c3047cca1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41977bb3-ed4c-4246-ba5c-379c3047cca1', 2, NULL, 'Hommage à György Ligeti', 'Trois Hommages: Hommage à György Ligeti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25569 AND p.composer_id = 407
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41977bb3-ed4c-4246-ba5c-379c3047cca1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Hommage à Josef Matthias Hauer', part.name_en = 'Trois Hommages: Hommage à Josef Matthias Hauer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25569 AND p.composer_id = 407 AND part.part_key = 'musicbrainz:819f7674-0fb8-46d7-89d0-fbff40786620' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:819f7674-0fb8-46d7-89d0-fbff40786620', 3, NULL, 'Hommage à Josef Matthias Hauer', 'Trois Hommages: Hommage à Josef Matthias Hauer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25569 AND p.composer_id = 407
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:819f7674-0fb8-46d7-89d0-fbff40786620'
);


-- None Wer, wenn ich schriee, hörte mich…

UPDATE pieces piece
SET piece.title = 'Wer, wenn ich schriee, hörte mich…', piece.title_en = 'Wer, wenn ich schriee, hörte mich…',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25595 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None in vain

UPDATE pieces piece
SET piece.title = 'in vain', piece.title_en = 'in vain',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25952 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None limited approximations

UPDATE pieces piece
SET piece.title = 'limited approximations', piece.title_en = 'limited approximations',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24017 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'limited approximations: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24017 AND p.composer_id = 407 AND part.part_key = 'musicbrainz:d15c5ba4-af08-4911-ae31-6940c912262b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d15c5ba4-af08-4911-ae31-6940c912262b', 1, NULL, 'I', 'limited approximations: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24017 AND p.composer_id = 407
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d15c5ba4-af08-4911-ae31-6940c912262b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'limited approximations: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24017 AND p.composer_id = 407 AND part.part_key = 'musicbrainz:fe8afa7a-fdf2-45af-a6d3-7e5ddd882d88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe8afa7a-fdf2-45af-a6d3-7e5ddd882d88', 2, NULL, 'II', 'limited approximations: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24017 AND p.composer_id = 407
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe8afa7a-fdf2-45af-a6d3-7e5ddd882d88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'limited approximations: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24017 AND p.composer_id = 407 AND part.part_key = 'musicbrainz:9004f802-4aea-45a3-845c-b131693cb574' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9004f802-4aea-45a3-845c-b131693cb574', 3, NULL, 'III', 'limited approximations: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24017 AND p.composer_id = 407
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9004f802-4aea-45a3-845c-b131693cb574'
);


-- None the last minutes of inhumanity

UPDATE pieces piece
SET piece.title = 'the last minutes of inhumanity', piece.title_en = 'the last minutes of inhumanity',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25000 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None “....”

UPDATE pieces piece
SET piece.title = '“....”', piece.title_en = '“....”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25825 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None … aus freier Lust … verbunden …

UPDATE pieces piece
SET piece.title = '… aus freier Lust … verbunden …', piece.title_en = '… aus freier Lust … verbunden …',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25546 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None … und …

UPDATE pieces piece
SET piece.title = '… und …', piece.title_en = '… und …',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25481 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None …über den Atem, die Stille und die Zerbrechlichkeit…

UPDATE pieces piece
SET piece.title = '…über den Atem, die Stille und die Zerbrechlichkeit…', piece.title_en = '…über den Atem, die Stille und die Zerbrechlichkeit…',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24887 AND piece.composer_id = 407
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 407 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    24379
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
