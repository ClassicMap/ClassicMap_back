-- 프란츠 슈미트 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 34개(묶음 3, 다악장 15, 낱곡 16),
-- 새 작품 1개, part 72개, 그 아래 5개.
-- seed 34개 중 33개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.
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

-- None 샤콘 C♯단조

UPDATE pieces piece
SET piece.title = '샤콘 C♯단조', piece.title_en = 'Chaconne in C sharp minor (1925)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15758 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Langsam (Aeolian)', part.name_en = 'Chaconne in C sharp minor (1925): Langsam (Aeolian)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15758 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:484686ed-858c-4391-b5c4-1513e88d1cde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:484686ed-858c-4391-b5c4-1513e88d1cde', 1, NULL, 'Langsam (Aeolian)', 'Chaconne in C sharp minor (1925): Langsam (Aeolian)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15758 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:484686ed-858c-4391-b5c4-1513e88d1cde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Weider Im Ersten Zeitmaß', part.name_en = 'Chaconne in C sharp minor (1925): Weider Im Ersten Zeitmaß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15758 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:fb408ae4-d628-43c2-9936-4778794e13e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb408ae4-d628-43c2-9936-4778794e13e9', 2, NULL, 'Weider Im Ersten Zeitmaß', 'Chaconne in C sharp minor (1925): Weider Im Ersten Zeitmaß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15758 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb408ae4-d628-43c2-9936-4778794e13e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Bedeutend Langsamer', part.name_en = 'Chaconne in C sharp minor (1925): Bedeutend Langsamer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15758 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:826518f5-b17d-4cf3-b0a7-097b30397006' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:826518f5-b17d-4cf3-b0a7-097b30397006', 3, NULL, 'Bedeutend Langsamer', 'Chaconne in C sharp minor (1925): Bedeutend Langsamer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15758 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:826518f5-b17d-4cf3-b0a7-097b30397006'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Erstes Zeitmaß', part.name_en = 'Chaconne in C sharp minor (1925): Erstes Zeitmaß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15758 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:70c0dcc9-a5a5-4462-95af-83614ee7544c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70c0dcc9-a5a5-4462-95af-83614ee7544c', 4, NULL, 'Erstes Zeitmaß', 'Chaconne in C sharp minor (1925): Erstes Zeitmaß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15758 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70c0dcc9-a5a5-4462-95af-83614ee7544c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Lebhaft (Dorian)', part.name_en = 'Chaconne in C sharp minor (1925): Lebhaft (Dorian)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15758 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:39adcef2-d654-4a37-8302-ce3022d7a2c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39adcef2-d654-4a37-8302-ce3022d7a2c2', 5, NULL, 'Lebhaft (Dorian)', 'Chaconne in C sharp minor (1925): Lebhaft (Dorian)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15758 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39adcef2-d654-4a37-8302-ce3022d7a2c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Etwas breiter', part.name_en = 'Chaconne in C sharp minor (1925): Etwas breiter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15758 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:ea0e0cf8-efea-4867-aa0c-efb1a1369fff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea0e0cf8-efea-4867-aa0c-efb1a1369fff', 6, NULL, 'Etwas breiter', 'Chaconne in C sharp minor (1925): Etwas breiter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15758 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea0e0cf8-efea-4867-aa0c-efb1a1369fff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Bedeutend langsamer', part.name_en = 'Chaconne in C sharp minor (1925): Bedeutend langsamer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15758 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:db871cf5-780f-4437-a3d2-90ee5472a002' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db871cf5-780f-4437-a3d2-90ee5472a002', 7, NULL, 'Bedeutend langsamer', 'Chaconne in C sharp minor (1925): Bedeutend langsamer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15758 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db871cf5-780f-4437-a3d2-90ee5472a002'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Im Ersten Zeitmaß (Ionian)', part.name_en = 'Chaconne in C sharp minor (1925): Im Ersten Zeitmaß (Ionian)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15758 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:7163b93e-d47c-4bfc-9ff4-049f6dad326c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7163b93e-d47c-4bfc-9ff4-049f6dad326c', 8, NULL, 'Im Ersten Zeitmaß (Ionian)', 'Chaconne in C sharp minor (1925): Im Ersten Zeitmaß (Ionian)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15758 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7163b93e-d47c-4bfc-9ff4-049f6dad326c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Erstes Zeitmaß', part.name_en = 'Chaconne in C sharp minor (1925): Erstes Zeitmaß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15758 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:7078097b-edc9-4627-a319-78976cba48ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7078097b-edc9-4627-a319-78976cba48ff', 9, NULL, 'Erstes Zeitmaß', 'Chaconne in C sharp minor (1925): Erstes Zeitmaß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15758 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7078097b-edc9-4627-a319-78976cba48ff'
);


-- None Choralvorspiel zu Joseph Haydns "Gott erhalte"

UPDATE pieces piece
SET piece.title = 'Choralvorspiel zu Joseph Haydns "Gott erhalte"', piece.title_en = 'Choralvorspiel zu Joseph Haydns "Gott erhalte"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19435 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 클라리넷 5중주 A장조

UPDATE pieces piece
SET piece.title = '클라리넷 5중주 A장조', piece.title_en = 'Clarinet Quintet in A major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19135 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Clarinet Quintet in A major: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19135 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:67e6f6a3-0f87-4a4a-b41c-9be043e33f88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67e6f6a3-0f87-4a4a-b41c-9be043e33f88', 1, 'I', 'Allegro moderato', 'Clarinet Quintet in A major: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19135 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67e6f6a3-0f87-4a4a-b41c-9be043e33f88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo', part.name_en = 'Clarinet Quintet in A major: II. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19135 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:9ed971aa-4491-4485-a650-64d77a9c292c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ed971aa-4491-4485-a650-64d77a9c292c', 2, 'II', 'Intermezzo', 'Clarinet Quintet in A major: II. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19135 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed971aa-4491-4485-a650-64d77a9c292c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Trio', part.name_en = 'Clarinet Quintet in A major: III. Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19135 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:f8d4e6e0-48aa-49e5-8e7c-9430d62182dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8d4e6e0-48aa-49e5-8e7c-9430d62182dd', 3, 'III', 'Trio', 'Clarinet Quintet in A major: III. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19135 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8d4e6e0-48aa-49e5-8e7c-9430d62182dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'Clarinet Quintet in A major: IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19135 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:a35f717b-babf-4c7e-b639-bc5460d303d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a35f717b-babf-4c7e-b639-bc5460d303d3', 4, 'IV', 'Adagio', 'Clarinet Quintet in A major: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19135 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a35f717b-babf-4c7e-b639-bc5460d303d3'
);


-- None 클라리넷 5중주 B♭장조

UPDATE pieces piece
SET piece.title = '클라리넷 5중주 B♭장조', piece.title_en = 'Clarinet Quintet in B-flat major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19805 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante tranquillo', part.name_en = 'Clarinet Quintet in B-flat major: I. Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19805 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:8245aecd-cc49-48b0-b271-235426a18ee1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8245aecd-cc49-48b0-b271-235426a18ee1', 1, 'I', 'Andante tranquillo', 'Clarinet Quintet in B-flat major: I. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19805 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8245aecd-cc49-48b0-b271-235426a18ee1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Clarinet Quintet in B-flat major: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19805 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:1aec3c53-4775-4cdf-ab20-1ea4e70f55a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aec3c53-4775-4cdf-ab20-1ea4e70f55a3', 2, 'II', 'Lento', 'Clarinet Quintet in B-flat major: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19805 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aec3c53-4775-4cdf-ab20-1ea4e70f55a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'Clarinet Quintet in B-flat major: III. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19805 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:6cb4a699-ca34-42f0-a916-502f0342781e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cb4a699-ca34-42f0-a916-502f0342781e', 3, 'III', 'Allegro ma non troppo', 'Clarinet Quintet in B-flat major: III. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19805 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cb4a699-ca34-42f0-a916-502f0342781e'
);


-- None 오라토리오 <Das Buch mit sieben Siegeln>

UPDATE pieces piece
SET piece.title = '오라토리오 <Das Buch mit sieben Siegeln>', piece.title_en = 'Das Buch mit sieben Siegeln',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18866 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prolog', part.name_en = 'Das Buch mit sieben Siegeln: Prolog',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18866 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:f8d35c53-465a-4040-a470-d855e01e0c29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8d35c53-465a-4040-a470-d855e01e0c29', 1, NULL, 'Prolog', 'Das Buch mit sieben Siegeln: Prolog', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18866 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8d35c53-465a-4040-a470-d855e01e0c29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Teil', part.name_en = 'Das Buch mit sieben Siegeln: 1. Teil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18866 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:8a82ee8b-3d01-4cc5-9519-670a86b35d63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a82ee8b-3d01-4cc5-9519-670a86b35d63', 2, NULL, 'Teil', 'Das Buch mit sieben Siegeln: 1. Teil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18866 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a82ee8b-3d01-4cc5-9519-670a86b35d63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Teil', part.name_en = 'Das Buch mit sieben Siegeln: 2. Teil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18866 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:b4e66ed7-a626-40ad-a108-2bd4bf74ee88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4e66ed7-a626-40ad-a108-2bd4bf74ee88', 3, NULL, 'Teil', 'Das Buch mit sieben Siegeln: 2. Teil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18866 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4e66ed7-a626-40ad-a108-2bd4bf74ee88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Epilog', part.name_en = 'Das Buch mit sieben Siegeln: Epilog',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18866 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:016aa028-2771-4acb-a48b-5ebb5bcfed8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:016aa028-2771-4acb-a48b-5ebb5bcfed8f', 4, NULL, 'Epilog', 'Das Buch mit sieben Siegeln: Epilog', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18866 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:016aa028-2771-4acb-a48b-5ebb5bcfed8f'
);


-- None Der Heiland ist erstanden

UPDATE pieces piece
SET piece.title = 'Der Heiland ist erstanden', piece.title_en = 'Der Heiland ist erstanden',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19939 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Drei kleine Phantasiestücke nach ungarischen Nationalmelodien für Violoncello und Klavierbegleitung

UPDATE pieces piece
SET piece.title = 'Drei kleine Phantasiestücke nach ungarischen Nationalmelodien für Violoncello und Klavierbegleitung', piece.title_en = 'Drei kleine Phantasiestücke nach ungarischen Nationalmelodien für Violoncello und Klavierbegleitung',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16228 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'G-Dur. Allegretto', part.name_en = 'Drei kleine Phantasiestücke nach ungarischen Nationalmelodien für Violoncello und Klavierbegleitung: Nr. 1 G-Dur. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16228 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:221530af-7cd6-4732-b9ca-043480139f21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:221530af-7cd6-4732-b9ca-043480139f21', 1, NULL, 'G-Dur. Allegretto', 'Drei kleine Phantasiestücke nach ungarischen Nationalmelodien für Violoncello und Klavierbegleitung: Nr. 1 G-Dur. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16228 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:221530af-7cd6-4732-b9ca-043480139f21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto con moto', part.name_en = 'Drei kleine Phantasiestücke nach ungarischen Nationalmelodien für Violoncello und Klavierbegleitung: Nr. 2. Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16228 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:29753355-5d49-42ce-9f6e-e063e5d9ca9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29753355-5d49-42ce-9f6e-e063e5d9ca9f', 2, NULL, 'Allegretto con moto', 'Drei kleine Phantasiestücke nach ungarischen Nationalmelodien für Violoncello und Klavierbegleitung: Nr. 2. Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16228 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29753355-5d49-42ce-9f6e-e063e5d9ca9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro vivace', part.name_en = 'Drei kleine Phantasiestücke nach ungarischen Nationalmelodien für Violoncello und Klavierbegleitung: Nr. 3. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16228 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:73df2e60-928d-4476-ae1d-cb9fce32f244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73df2e60-928d-4476-ae1d-cb9fce32f244', 3, NULL, 'Allegro vivace', 'Drei kleine Phantasiestücke nach ungarischen Nationalmelodien für Violoncello und Klavierbegleitung: Nr. 3. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16228 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73df2e60-928d-4476-ae1d-cb9fce32f244'
);


-- None 환상곡 B♭장조

UPDATE pieces piece
SET piece.title = '환상곡 B♭장조', piece.title_en = 'Fantasia for piano & orchestra in B-flat major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19495 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasie und Fuge D-Dur

UPDATE pieces piece
SET piece.title = 'Fantasie und Fuge D-Dur', piece.title_en = 'Fantasie und Fuge D-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17828 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Fredigundis>

UPDATE pieces piece
SET piece.title = '오페라 <Fredigundis>', piece.title_en = 'Fredigundis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16537 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fuge F-Dur

UPDATE pieces piece
SET piece.title = 'Fuge F-Dur', piece.title_en = 'Fuge F-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17049 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 협주곡 E♭장조

UPDATE pieces piece
SET piece.title = '협주곡 E♭장조', piece.title_en = 'Konzert für Klavier für die linke Hand und Orchester Es-Dur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18493 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato un poco maestoso', part.name_en = 'Konzert für Klavier für die linke Hand und Orchester Es-Dur: 1. Allegro moderato un poco maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18493 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:ccda16dd-f296-4b00-900d-5fd535ad6200' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccda16dd-f296-4b00-900d-5fd535ad6200', 1, NULL, 'Allegro moderato un poco maestoso', 'Konzert für Klavier für die linke Hand und Orchester Es-Dur: 1. Allegro moderato un poco maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18493 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccda16dd-f296-4b00-900d-5fd535ad6200'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Konzert für Klavier für die linke Hand und Orchester Es-Dur: 2. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18493 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:15d0aa3f-3c8e-47df-ad65-8494ea8ed14e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15d0aa3f-3c8e-47df-ad65-8494ea8ed14e', 2, NULL, 'Andante', 'Konzert für Klavier für die linke Hand und Orchester Es-Dur: 2. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18493 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15d0aa3f-3c8e-47df-ad65-8494ea8ed14e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vivace', part.name_en = 'Konzert für Klavier für die linke Hand und Orchester Es-Dur: 3. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18493 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:62e4942d-88a9-4dd0-b45b-0d4a8167ae79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62e4942d-88a9-4dd0-b45b-0d4a8167ae79', 3, NULL, 'Vivace', 'Konzert für Klavier für die linke Hand und Orchester Es-Dur: 3. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18493 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62e4942d-88a9-4dd0-b45b-0d4a8167ae79'
);


-- None Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester)

UPDATE pieces piece
SET piece.title = 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester)', piece.title_en = 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17486 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Langsam', part.name_en = 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 1. Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17486 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:caf1466c-f479-4129-828a-a4801fb0db43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caf1466c-f479-4129-828a-a4801fb0db43', 1, NULL, 'Langsam', 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 1. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17486 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caf1466c-f479-4129-828a-a4801fb0db43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Thema', part.name_en = 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 2. Thema',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17486 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:f0b0f349-fc45-4cfd-9524-74e202ca790f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0b0f349-fc45-4cfd-9524-74e202ca790f', 2, NULL, 'Thema', 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 2. Thema', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17486 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0b0f349-fc45-4cfd-9524-74e202ca790f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ruhig fließend', part.name_en = 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 3. Ruhig fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17486 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:9bb05fe6-8eb9-460e-bfb0-a5009b0bc48a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bb05fe6-8eb9-460e-bfb0-a5009b0bc48a', 3, NULL, 'Ruhig fließend', 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 3. Ruhig fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17486 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bb05fe6-8eb9-460e-bfb0-a5009b0bc48a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lebhaft, doch nicht zu schnell', part.name_en = 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 4. Lebhaft, doch nicht zu schnell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17486 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:a4b1f8ce-6f45-47ad-bc26-ab8fb4ee96b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4b1f8ce-6f45-47ad-bc26-ab8fb4ee96b9', 4, NULL, 'Lebhaft, doch nicht zu schnell', 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 4. Lebhaft, doch nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17486 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4b1f8ce-6f45-47ad-bc26-ab8fb4ee96b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Langsam - Sehr lebhaft', part.name_en = 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 5. Langsam - Sehr lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17486 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:f975bcea-e9d4-40f2-9de1-6074dbab7ec3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f975bcea-e9d4-40f2-9de1-6074dbab7ec3', 5, NULL, 'Langsam - Sehr lebhaft', 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 5. Langsam - Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17486 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f975bcea-e9d4-40f2-9de1-6074dbab7ec3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Sehr ruhig', part.name_en = 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 6. Sehr ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17486 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:2a5db773-d319-4202-95ab-091172d01f6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a5db773-d319-4202-95ab-091172d01f6b', 6, NULL, 'Sehr ruhig', 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 6. Sehr ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17486 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a5db773-d319-4202-95ab-091172d01f6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Mäßig bewegt - Sehr bewegt', part.name_en = 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 7. Mäßig bewegt - Sehr bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17486 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:9c5bdd44-3cb9-407b-a418-9ff6a114838b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c5bdd44-3cb9-407b-a418-9ff6a114838b', 7, NULL, 'Mäßig bewegt - Sehr bewegt', 'Konzertante Variationen über ein Thema von Beethoven (für Klavier für die linke Hand und Orchester): 7. Mäßig bewegt - Sehr bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17486 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c5bdd44-3cb9-407b-a418-9ff6a114838b'
);


-- Op. 2 오페라 <Notre Dame> Op. 2

UPDATE pieces piece
SET piece.title = '오페라 <Notre Dame> Op. 2', piece.title_en = 'Notre Dame, op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17920 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Notre Dame, op. 2: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17920 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:27be9874-0232-495a-8f0a-1fa481e876ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27be9874-0232-495a-8f0a-1fa481e876ea', 1, NULL, 'Act I', 'Notre Dame, op. 2: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17920 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27be9874-0232-495a-8f0a-1fa481e876ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:27be9874-0232-495a-8f0a-1fa481e876ea'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. Carnival Music', part.name_en = 'Notre Dame, op. 2: Act I. Carnival Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17920 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:2a7b86de-b10b-30a4-a178-d6abc2b09f92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a7b86de-b10b-30a4-a178-d6abc2b09f92', 1, NULL, 'Act I. Carnival Music', 'Notre Dame, op. 2: Act I. Carnival Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:27be9874-0232-495a-8f0a-1fa481e876ea'
WHERE p.id = 17920 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a7b86de-b10b-30a4-a178-d6abc2b09f92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:27be9874-0232-495a-8f0a-1fa481e876ea'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. Introduction', part.name_en = 'Notre Dame, op. 2: Act I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17920 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:55c0b87b-c2dd-3d37-b626-186d9174a1b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55c0b87b-c2dd-3d37-b626-186d9174a1b7', 2, NULL, 'Act I. Introduction', 'Notre Dame, op. 2: Act I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:27be9874-0232-495a-8f0a-1fa481e876ea'
WHERE p.id = 17920 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55c0b87b-c2dd-3d37-b626-186d9174a1b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:27be9874-0232-495a-8f0a-1fa481e876ea'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. Intermezzo', part.name_en = 'Notre Dame, op. 2: Act I. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17920 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:8b755e07-5d2c-36e5-b2cb-c817c71168c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b755e07-5d2c-36e5-b2cb-c817c71168c1', 3, NULL, 'Act I. Intermezzo', 'Notre Dame, op. 2: Act I. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:27be9874-0232-495a-8f0a-1fa481e876ea'
WHERE p.id = 17920 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b755e07-5d2c-36e5-b2cb-c817c71168c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Notre Dame, op. 2: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17920 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:778fbd60-f271-4124-876d-3422678b1ea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:778fbd60-f271-4124-876d-3422678b1ea8', 2, NULL, 'Act II', 'Notre Dame, op. 2: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17920 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:778fbd60-f271-4124-876d-3422678b1ea8'
);


-- None 피아노 협주곡 E♭장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 E♭장조', piece.title_en = 'Piano Concerto in E-flat Major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18704 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato un poco maestoso', part.name_en = 'Piano Concerto in E-flat Major: I. Allegro moderato un poco maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18704 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:caa31a9c-51c7-4f16-a5a5-9d4e2495b867' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caa31a9c-51c7-4f16-a5a5-9d4e2495b867', 1, 'I', 'Allegro moderato un poco maestoso', 'Piano Concerto in E-flat Major: I. Allegro moderato un poco maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18704 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caa31a9c-51c7-4f16-a5a5-9d4e2495b867'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Piano Concerto in E-flat Major: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18704 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:2b97a275-a2cd-4538-8d81-b88decf7627b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b97a275-a2cd-4538-8d81-b88decf7627b', 2, 'II', 'Andante', 'Piano Concerto in E-flat Major: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18704 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b97a275-a2cd-4538-8d81-b88decf7627b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Piano Concerto in E-flat Major: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18704 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:a16c8507-0769-4751-90c4-72189aace439' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a16c8507-0769-4751-90c4-72189aace439', 3, 'III', 'Vivace', 'Piano Concerto in E-flat Major: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18704 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a16c8507-0769-4751-90c4-72189aace439'
);


-- None Präludium und Fuge A-Dur

UPDATE pieces piece
SET piece.title = 'Präludium und Fuge A-Dur', piece.title_en = 'Präludium und Fuge A-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18602 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Präludium und Fuge C-Dur

UPDATE pieces piece
SET piece.title = 'Präludium und Fuge C-Dur', piece.title_en = 'Präludium und Fuge C-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17331 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Präludium und Fuge Es-Dur

UPDATE pieces piece
SET piece.title = 'Präludium und Fuge Es-Dur', piece.title_en = 'Präludium und Fuge Es-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17585 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 5중주 G장조

UPDATE pieces piece
SET piece.title = '5중주 G장조', piece.title_en = 'Quintet in G major for 2 Violins, Viola, Cello and Piano Left Hand',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16864 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lebhaft, doch nicht schnell', part.name_en = 'Quintet in G major for 2 Violins, Viola, Cello and Piano Left Hand: I. Lebhaft, doch nicht schnell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16864 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:9b920201-3bef-4081-8f66-e9aef40e2d29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b920201-3bef-4081-8f66-e9aef40e2d29', 1, 'I', 'Lebhaft, doch nicht schnell', 'Quintet in G major for 2 Violins, Viola, Cello and Piano Left Hand: I. Lebhaft, doch nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16864 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b920201-3bef-4081-8f66-e9aef40e2d29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Quintet in G major for 2 Violins, Viola, Cello and Piano Left Hand: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16864 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:10b39586-a26a-4735-89ed-cca5637cf48a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10b39586-a26a-4735-89ed-cca5637cf48a', 2, 'II', 'Adagio', 'Quintet in G major for 2 Violins, Viola, Cello and Piano Left Hand: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16864 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10b39586-a26a-4735-89ed-cca5637cf48a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sehr ruhig', part.name_en = 'Quintet in G major for 2 Violins, Viola, Cello and Piano Left Hand: III. Sehr ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16864 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:44fb8d65-07cb-4073-bfd5-3fe62cd713e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44fb8d65-07cb-4073-bfd5-3fe62cd713e2', 3, 'III', 'Sehr ruhig', 'Quintet in G major for 2 Violins, Viola, Cello and Piano Left Hand: III. Sehr ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16864 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44fb8d65-07cb-4073-bfd5-3fe62cd713e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sehr lebhaft', part.name_en = 'Quintet in G major for 2 Violins, Viola, Cello and Piano Left Hand: IV. Sehr lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16864 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:343389d8-6f3e-4cb6-b0a5-6437c27d1151' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:343389d8-6f3e-4cb6-b0a5-6437c27d1151', 4, 'IV', 'Sehr lebhaft', 'Quintet in G major for 2 Violins, Viola, Cello and Piano Left Hand: IV. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16864 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:343389d8-6f3e-4cb6-b0a5-6437c27d1151'
);


-- None 피아노 로망스

UPDATE pieces piece
SET piece.title = '피아노 로망스', piece.title_en = 'Romance for Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17573 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 1번 A장조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 A장조', piece.title_en = 'String Quartet no. 1 in A major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16245 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Anmutig bewegt', part.name_en = 'String Quartet no. 1 in A major: I. Anmutig bewegt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16245 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:93878966-e135-40b6-be71-a7dd676721da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93878966-e135-40b6-be71-a7dd676721da', 1, 'I', 'Anmutig bewegt', 'String Quartet no. 1 in A major: I. Anmutig bewegt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16245 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93878966-e135-40b6-be71-a7dd676721da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'String Quartet no. 1 in A major: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16245 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:9db34390-e3ec-40e3-a668-c86a54088e73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9db34390-e3ec-40e3-a668-c86a54088e73', 2, 'II', 'Adagio', 'String Quartet no. 1 in A major: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16245 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9db34390-e3ec-40e3-a668-c86a54088e73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Sehr lebhaft', part.name_en = 'String Quartet no. 1 in A major: III. Scherzo. Sehr lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16245 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:5ecc4915-e18d-4f87-9ce2-b1c69ce5da3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ecc4915-e18d-4f87-9ce2-b1c69ce5da3f', 3, 'III', 'Scherzo. Sehr lebhaft', 'String Quartet no. 1 in A major: III. Scherzo. Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16245 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ecc4915-e18d-4f87-9ce2-b1c69ce5da3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Ruhig fließend', part.name_en = 'String Quartet no. 1 in A major: IV. Ruhig fließend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16245 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:2e1d392a-d049-4ba1-8f87-79c8300d5297' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e1d392a-d049-4ba1-8f87-79c8300d5297', 4, 'IV', 'Ruhig fließend', 'String Quartet no. 1 in A major: IV. Ruhig fließend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16245 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e1d392a-d049-4ba1-8f87-79c8300d5297'
);


-- None 현악 4중주 2번 G장조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 G장조', piece.title_en = 'String Quartet no. 2 in G major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18368 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Molto tranquillo', part.name_en = 'String Quartet no. 2 in G major: I. Molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18368 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:cc41f50b-a69e-411e-b2e2-14183fb9a3fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc41f50b-a69e-411e-b2e2-14183fb9a3fc', 1, 'I', 'Molto tranquillo', 'String Quartet no. 2 in G major: I. Molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18368 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc41f50b-a69e-411e-b2e2-14183fb9a3fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'String Quartet no. 2 in G major: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18368 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:3c0de350-a7d3-4d6c-a113-256f6a67d73d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c0de350-a7d3-4d6c-a113-256f6a67d73d', 2, 'II', 'Adagio', 'String Quartet no. 2 in G major: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18368 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c0de350-a7d3-4d6c-a113-256f6a67d73d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Allegro vivace', part.name_en = 'String Quartet no. 2 in G major: III. Scherzo. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18368 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:fbea0971-1a16-4bef-a458-d7bded644de3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbea0971-1a16-4bef-a458-d7bded644de3', 3, 'III', 'Scherzo. Allegro vivace', 'String Quartet no. 2 in G major: III. Scherzo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18368 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbea0971-1a16-4bef-a458-d7bded644de3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet no. 2 in G major: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18368 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:9657c1f1-1990-4926-a3b0-652d3b7977a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9657c1f1-1990-4926-a3b0-652d3b7977a3', 4, 'IV', 'Allegro', 'String Quartet no. 2 in G major: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18368 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9657c1f1-1990-4926-a3b0-652d3b7977a3'
);


-- None 교향곡 1번 E장조

UPDATE pieces piece
SET piece.title = '교향곡 1번 E장조', piece.title_en = 'Symphonie Nr. 1 E-Dur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17440 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sehr langsam - Sehr lebhaft', part.name_en = 'Symphonie Nr. 1 E-Dur: I. Sehr langsam - Sehr lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17440 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:081931a9-6137-35b5-9e06-6149de6c1a4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:081931a9-6137-35b5-9e06-6149de6c1a4a', 1, 'I', 'Sehr langsam - Sehr lebhaft', 'Symphonie Nr. 1 E-Dur: I. Sehr langsam - Sehr lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17440 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:081931a9-6137-35b5-9e06-6149de6c1a4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Langsam', part.name_en = 'Symphonie Nr. 1 E-Dur: II. Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17440 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:b16f95d1-8949-3598-8e24-4a91cb08e142' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b16f95d1-8949-3598-8e24-4a91cb08e142', 2, 'II', 'Langsam', 'Symphonie Nr. 1 E-Dur: II. Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17440 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b16f95d1-8949-3598-8e24-4a91cb08e142'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Schnell und leicht', part.name_en = 'Symphonie Nr. 1 E-Dur: III. Schnell und leicht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17440 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:ad4fb6d2-4d2e-30e4-9050-decd1076e218' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad4fb6d2-4d2e-30e4-9050-decd1076e218', 3, 'III', 'Schnell und leicht', 'Symphonie Nr. 1 E-Dur: III. Schnell und leicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17440 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad4fb6d2-4d2e-30e4-9050-decd1076e218'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lebhaft, doch nicht zu schnell', part.name_en = 'Symphonie Nr. 1 E-Dur: IV. Lebhaft, doch nicht zu schnell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17440 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:c9619f47-d663-3a37-b63b-25904cc53acc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9619f47-d663-3a37-b63b-25904cc53acc', 4, 'IV', 'Lebhaft, doch nicht zu schnell', 'Symphonie Nr. 1 E-Dur: IV. Lebhaft, doch nicht zu schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17440 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9619f47-d663-3a37-b63b-25904cc53acc'
);


-- None 교향곡 2번 E♭장조

UPDATE pieces piece
SET piece.title = '교향곡 2번 E♭장조', piece.title_en = 'Symphonie Nr. 2 Es-Dur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16560 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lebhaft', part.name_en = 'Symphonie Nr. 2 Es-Dur: I. Lebhaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16560 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:c5c76299-33d0-378c-b3e3-aba8acb66b99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5c76299-33d0-378c-b3e3-aba8acb66b99', 1, 'I', 'Lebhaft', 'Symphonie Nr. 2 Es-Dur: I. Lebhaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16560 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5c76299-33d0-378c-b3e3-aba8acb66b99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto con variazioni: Einfach und zart', part.name_en = 'Symphonie Nr. 2 Es-Dur: II. Allegretto con variazioni: Einfach und zart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16560 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:fb6c1fa9-d778-37eb-be3d-dc251a8187da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb6c1fa9-d778-37eb-be3d-dc251a8187da', 2, 'II', 'Allegretto con variazioni: Einfach und zart', 'Symphonie Nr. 2 Es-Dur: II. Allegretto con variazioni: Einfach und zart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16560 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb6c1fa9-d778-37eb-be3d-dc251a8187da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale: Langsam', part.name_en = 'Symphonie Nr. 2 Es-Dur: III. Finale: Langsam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16560 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:b5760b44-ae0c-374b-a374-85d52623f3b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5760b44-ae0c-374b-a374-85d52623f3b8', 3, 'III', 'Finale: Langsam', 'Symphonie Nr. 2 Es-Dur: III. Finale: Langsam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16560 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5760b44-ae0c-374b-a374-85d52623f3b8'
);


-- None 교향곡 3번 A장조

UPDATE pieces piece
SET piece.title = '교향곡 3번 A장조', piece.title_en = 'Symphonie Nr. 3 A-Dur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18789 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto moderato', part.name_en = 'Symphonie Nr. 3 A-Dur: I. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18789 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:31a19bc1-eed1-3727-b020-e7fe2cf409e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31a19bc1-eed1-3727-b020-e7fe2cf409e7', 1, 'I', 'Allegro molto moderato', 'Symphonie Nr. 3 A-Dur: I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18789 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31a19bc1-eed1-3727-b020-e7fe2cf409e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Symphonie Nr. 3 A-Dur: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18789 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:f4f4c385-740d-3c6c-95f5-97b6e92d4b6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4f4c385-740d-3c6c-95f5-97b6e92d4b6c', 2, 'II', 'Adagio', 'Symphonie Nr. 3 A-Dur: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18789 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4f4c385-740d-3c6c-95f5-97b6e92d4b6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo: Allegro vivace', part.name_en = 'Symphonie Nr. 3 A-Dur: III. Scherzo: Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18789 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:3ba79888-4c6a-3fe5-a03d-e28e7c5250e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ba79888-4c6a-3fe5-a03d-e28e7c5250e7', 3, 'III', 'Scherzo: Allegro vivace', 'Symphonie Nr. 3 A-Dur: III. Scherzo: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18789 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ba79888-4c6a-3fe5-a03d-e28e7c5250e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento - Allegro vivace', part.name_en = 'Symphonie Nr. 3 A-Dur: IV. Lento - Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18789 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:d9104a34-1faa-3402-a472-3cb30b4f1475' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9104a34-1faa-3402-a472-3cb30b4f1475', 4, 'IV', 'Lento - Allegro vivace', 'Symphonie Nr. 3 A-Dur: IV. Lento - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18789 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9104a34-1faa-3402-a472-3cb30b4f1475'
);


-- None 교향곡 4번 C장조

UPDATE pieces piece
SET piece.title = '교향곡 4번 C장조', piece.title_en = 'Symphonie Nr. 4 C-Dur',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19283 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto moderato', part.name_en = 'Symphonie Nr. 4 C-Dur: I. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19283 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:340e8c83-26cf-3b25-8f11-32ed6fe623f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:340e8c83-26cf-3b25-8f11-32ed6fe623f4', 1, 'I', 'Allegro molto moderato', 'Symphonie Nr. 4 C-Dur: I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19283 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:340e8c83-26cf-3b25-8f11-32ed6fe623f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Symphonie Nr. 4 C-Dur: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19283 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:a746a0b5-edef-339a-b5cf-5cdb541cd7ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a746a0b5-edef-339a-b5cf-5cdb541cd7ef', 2, 'II', 'Adagio', 'Symphonie Nr. 4 C-Dur: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19283 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a746a0b5-edef-339a-b5cf-5cdb541cd7ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto vivace', part.name_en = 'Symphonie Nr. 4 C-Dur: III. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19283 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:a2c85f9d-89e8-385b-bbef-8147f37ee277' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2c85f9d-89e8-385b-bbef-8147f37ee277', 3, 'III', 'Molto vivace', 'Symphonie Nr. 4 C-Dur: III. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19283 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2c85f9d-89e8-385b-bbef-8147f37ee277'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Tempo primo un poco sostenuto', part.name_en = 'Symphonie Nr. 4 C-Dur: IV. Tempo primo un poco sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19283 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:e222586d-844d-3463-9624-d90617452cf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e222586d-844d-3463-9624-d90617452cf4', 4, 'IV', 'Tempo primo un poco sostenuto', 'Symphonie Nr. 4 C-Dur: IV. Tempo primo un poco sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19283 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e222586d-844d-3463-9624-d90617452cf4'
);


-- None 토카타 C장조

UPDATE pieces piece
SET piece.title = '토카타 C장조', piece.title_en = 'Toccata in C major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18842 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Toccata und Fuge As-Dur

UPDATE pieces piece
SET piece.title = 'Toccata und Fuge As-Dur', piece.title_en = 'Toccata und Fuge As-Dur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16714 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variationen und Fuge über ein eigenes Thema (Königsfanfaren aus "Fredigundis")

UPDATE pieces piece
SET piece.title = 'Variationen und Fuge über ein eigenes Thema (Königsfanfaren aus "Fredigundis")', piece.title_en = 'Variationen und Fuge über ein eigenes Thema (Königsfanfaren aus "Fredigundis")',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18238 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations and fugue on a theme from "Fredigundis"

UPDATE pieces piece
SET piece.title = 'Variations and fugue on a theme from "Fredigundis"', piece.title_en = 'Variations and fugue on a theme from "Fredigundis"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19315 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations on a Hussar Song

UPDATE pieces piece
SET piece.title = 'Variations on a Hussar Song', piece.title_en = 'Variations on a Hussar Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18899 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vier kleine Choralvorspiele

UPDATE pieces piece
SET piece.title = 'Vier kleine Choralvorspiele', piece.title_en = 'Vier kleine Choralvorspiele',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19056 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'O Ewigkeit, du Donnerwort', part.name_en = 'Vier kleine Choralvorspiele: I. O Ewigkeit, du Donnerwort',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19056 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:9e1349ca-da68-45cb-aa75-5360a0f1d2a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e1349ca-da68-45cb-aa75-5360a0f1d2a4', 1, 'I', 'O Ewigkeit, du Donnerwort', 'Vier kleine Choralvorspiele: I. O Ewigkeit, du Donnerwort', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19056 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e1349ca-da68-45cb-aa75-5360a0f1d2a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Was mein Gott will', part.name_en = 'Vier kleine Choralvorspiele: II. Was mein Gott will',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19056 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:ad291411-ac6c-4b28-9a9d-9c15162ca4b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad291411-ac6c-4b28-9a9d-9c15162ca4b1', 2, 'II', 'Was mein Gott will', 'Vier kleine Choralvorspiele: II. Was mein Gott will', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19056 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad291411-ac6c-4b28-9a9d-9c15162ca4b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'O wie selig seid ihr doch, ihr Frommen', part.name_en = 'Vier kleine Choralvorspiele: III. O wie selig seid ihr doch, ihr Frommen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19056 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:116f3e69-a018-42a3-a85d-b389de6c4d7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:116f3e69-a018-42a3-a85d-b389de6c4d7b', 3, 'III', 'O wie selig seid ihr doch, ihr Frommen', 'Vier kleine Choralvorspiele: III. O wie selig seid ihr doch, ihr Frommen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19056 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:116f3e69-a018-42a3-a85d-b389de6c4d7b'
);


-- None Vier kleine Präludien und Fugen

UPDATE pieces piece
SET piece.title = 'Vier kleine Präludien und Fugen', piece.title_en = 'Vier kleine Präludien und Fugen',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18250 AND piece.composer_id = 282
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'E♭장조', part.name_en = 'Vier kleine Präludien und Fugen: I. Es-Dur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18250 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:0360b301-8b18-4df5-b02c-ad3dfc14917b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0360b301-8b18-4df5-b02c-ad3dfc14917b', 1, 'I', 'E♭장조', 'Vier kleine Präludien und Fugen: I. Es-Dur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18250 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0360b301-8b18-4df5-b02c-ad3dfc14917b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'C단조', part.name_en = 'Vier kleine Präludien und Fugen: II. c-Moll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18250 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:88c626ab-989a-41a2-ad6c-f183d8a95bff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88c626ab-989a-41a2-ad6c-f183d8a95bff', 2, 'II', 'C단조', 'Vier kleine Präludien und Fugen: II. c-Moll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18250 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88c626ab-989a-41a2-ad6c-f183d8a95bff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'G장조', part.name_en = 'Vier kleine Präludien und Fugen: III. G-Dur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18250 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:20eda3cb-5766-45f5-b33c-34abf23070b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20eda3cb-5766-45f5-b33c-34abf23070b9', 3, 'III', 'G장조', 'Vier kleine Präludien und Fugen: III. G-Dur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18250 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20eda3cb-5766-45f5-b33c-34abf23070b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'D-Dur „Halleluja“', part.name_en = 'Vier kleine Präludien und Fugen: IV. D-Dur „Halleluja“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18250 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:f5946dd5-e8b7-4bae-ba91-f9f355c6b64e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5946dd5-e8b7-4bae-ba91-f9f355c6b64e', 4, 'IV', 'D-Dur „Halleluja“', 'Vier kleine Präludien und Fugen: IV. D-Dur „Halleluja“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18250 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5946dd5-e8b7-4bae-ba91-f9f355c6b64e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5946dd5-e8b7-4bae-ba91-f9f355c6b64e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Präludium', part.name_en = 'Vier kleine Präludien und Fugen: IV. D-Dur „Halleluja“: Präludium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18250 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:69a99306-7d86-4852-b348-8555792756d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69a99306-7d86-4852-b348-8555792756d6', 1, NULL, 'Präludium', 'Vier kleine Präludien und Fugen: IV. D-Dur „Halleluja“: Präludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5946dd5-e8b7-4bae-ba91-f9f355c6b64e'
WHERE p.id = 18250 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69a99306-7d86-4852-b348-8555792756d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5946dd5-e8b7-4bae-ba91-f9f355c6b64e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fuge', part.name_en = 'Vier kleine Präludien und Fugen: IV. D-Dur „Halleluja“: Fuge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18250 AND p.composer_id = 282 AND part.part_key = 'musicbrainz:ccc3d3d5-cbaf-4de0-a5ed-693ecf8f0658' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ccc3d3d5-cbaf-4de0-a5ed-693ecf8f0658', 2, NULL, 'Fuge', 'Vier kleine Präludien und Fugen: IV. D-Dur „Halleluja“: Fuge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5946dd5-e8b7-4bae-ba91-f9f355c6b64e'
WHERE p.id = 18250 AND p.composer_id = 282
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccc3d3d5-cbaf-4de0-a5ed-693ecf8f0658'
);


-- None 토카타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타', 'Toccata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 282
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09f00314-c92a-400d-b12e-4ba87180891a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09f00314-c92a-400d-b12e-4ba87180891a'
FROM pieces p
WHERE p.composer_id = 282 AND p.title = '토카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09f00314-c92a-400d-b12e-4ba87180891a'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 282 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    19618
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
