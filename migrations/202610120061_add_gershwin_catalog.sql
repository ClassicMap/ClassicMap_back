-- 거슈윈 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 116개(묶음 19, 다악장 0, 낱곡 97),
-- 새 작품 31개, part 105개, 그 아래 61개.
-- seed 184개 중 82개를 작품·part 에 잇고, 98개를 숨기고, 4개는 그대로 둔다.
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

-- None 영화음악 <A Damsel in Distress>

UPDATE pieces piece
SET piece.title = '영화음악 <A Damsel in Distress>', piece.title_en = 'A Damsel in Distress',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1632 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Things Are Looking Up', part.name_en = 'Things Are Looking Up',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1632 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:44285cbc-3f27-4fc3-9204-2b2674c3f6ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44285cbc-3f27-4fc3-9204-2b2674c3f6ec', 1, NULL, 'Things Are Looking Up', 'Things Are Looking Up', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1632 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44285cbc-3f27-4fc3-9204-2b2674c3f6ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sing of Spring', part.name_en = 'Sing of Spring',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1632 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:47921cc3-2d07-43ee-bafe-841cd5811a5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47921cc3-2d07-43ee-bafe-841cd5811a5f', 2, NULL, 'Sing of Spring', 'Sing of Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1632 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47921cc3-2d07-43ee-bafe-841cd5811a5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Stiff Upper Lip', part.name_en = 'Stiff Upper Lip',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1632 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:48a41828-ee01-4ac0-a8a9-bc1637179b3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48a41828-ee01-4ac0-a8a9-bc1637179b3e', 3, NULL, 'Stiff Upper Lip', 'Stiff Upper Lip', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1632 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48a41828-ee01-4ac0-a8a9-bc1637179b3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'I Can’t Be Bothered Now', part.name_en = 'I Can’t Be Bothered Now',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1632 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:4e7e9ee5-9e1f-3274-83c5-325c148f6f89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7e9ee5-9e1f-3274-83c5-325c148f6f89', 4, NULL, 'I Can’t Be Bothered Now', 'I Can’t Be Bothered Now', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1632 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7e9ee5-9e1f-3274-83c5-325c148f6f89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Jolly Tar and the Milkmaid', part.name_en = 'The Jolly Tar and the Milkmaid',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1632 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:874c549f-84c9-49f9-b597-9c3bbb7921d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:874c549f-84c9-49f9-b597-9c3bbb7921d7', 5, NULL, 'The Jolly Tar and the Milkmaid', 'The Jolly Tar and the Milkmaid', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1632 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:874c549f-84c9-49f9-b597-9c3bbb7921d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'An American in London', part.name_en = 'An American in London',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1632 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:b0fca8f1-e88a-4fed-9381-403216873fac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0fca8f1-e88a-4fed-9381-403216873fac', 6, NULL, 'An American in London', 'An American in London', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1632 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0fca8f1-e88a-4fed-9381-403216873fac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'A Foggy Day (in London Town)', part.name_en = 'A Foggy Day (in London Town)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1632 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:f2d4ab2e-9ea6-338f-8343-f0c557d4cb6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2d4ab2e-9ea6-338f-8343-f0c557d4cb6b', 7, NULL, 'A Foggy Day (in London Town)', 'A Foggy Day (in London Town)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1632 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2d4ab2e-9ea6-338f-8343-f0c557d4cb6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Nice Work If You Can Get It', part.name_en = 'Nice Work If You Can Get It',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1632 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:f357f974-037d-342a-b514-62c72a45c76a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f357f974-037d-342a-b514-62c72a45c76a', 8, NULL, 'Nice Work If You Can Get It', 'Nice Work If You Can Get It', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1632 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f357f974-037d-342a-b514-62c72a45c76a'
);


-- None 가곡 <A Woman Is a Sometime Thing>

UPDATE pieces piece
SET piece.title = '가곡 <A Woman Is a Sometime Thing>', piece.title_en = 'A Woman Is a Sometime Thing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 721 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Aren’t You Kind of Glad We Did?>

UPDATE pieces piece
SET piece.title = '가곡 <Aren’t You Kind of Glad We Did?>', piece.title_en = 'Aren’t You Kind of Glad We Did?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 743 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Bride and Groom>

UPDATE pieces piece
SET piece.title = '가곡 <Bride and Groom>', piece.title_en = 'Bride and Groom',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 753 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <By Strauss>

UPDATE pieces piece
SET piece.title = '가곡 <By Strauss>', piece.title_en = 'By Strauss',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 742 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Changing My Tune>

UPDATE pieces piece
SET piece.title = '가곡 <Changing My Tune>', piece.title_en = 'Changing My Tune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 722 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Dear Little Girl>

UPDATE pieces piece
SET piece.title = '가곡 <Dear Little Girl>', piece.title_en = 'Dear Little Girl',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 754 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Dixie Rose>

UPDATE pieces piece
SET piece.title = '가곡 <Dixie Rose>', piece.title_en = 'Dixie Rose',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1624 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Do What You Do>

UPDATE pieces piece
SET piece.title = '가곡 <Do What You Do>', piece.title_en = 'Do What You Do',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 755 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Don’t Ask>

UPDATE pieces piece
SET piece.title = '가곡 <Don’t Ask>', piece.title_en = 'Don’t Ask',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 747 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Drifting Along With the Tide>

UPDATE pieces piece
SET piece.title = '가곡 <Drifting Along With the Tide>', piece.title_en = 'Drifting Along With the Tide',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 810 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None East Is West

UPDATE pieces piece
SET piece.title = 'East Is West', piece.title_en = 'East Is West',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1139 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Under the Cinnamon Tree', part.name_en = 'Under the Cinnamon Tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1139 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:49a48c5f-b903-484c-96e3-2fd068be408c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a48c5f-b903-484c-96e3-2fd068be408c', 1, NULL, 'Under the Cinnamon Tree', 'Under the Cinnamon Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1139 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a48c5f-b903-484c-96e3-2fd068be408c'
);


-- None 가곡 <For You>

UPDATE pieces piece
SET piece.title = '가곡 <For You>', piece.title_en = 'For You',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2737 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fragment, for solo piano (Prelude No. 3 in G minor)

UPDATE pieces piece
SET piece.title = 'Fragment, for solo piano (Prelude No. 3 in G minor)', piece.title_en = 'Fragment, for solo piano (Prelude No. 3 in G minor)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 874 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None George White's Scandals of 1924

UPDATE pieces piece
SET piece.title = 'George White''s Scandals of 1924', piece.title_en = 'George White''s Scandals of 1924',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2382 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Hang on to Me>

UPDATE pieces piece
SET piece.title = '가곡 <Hang on to Me>', piece.title_en = 'Hang on to Me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 780 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Heaven on Earth>

UPDATE pieces piece
SET piece.title = '가곡 <Heaven on Earth>', piece.title_en = 'Heaven on Earth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 781 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Here Comes de Honey Man>

UPDATE pieces piece
SET piece.title = '가곡 <Here Comes de Honey Man>', piece.title_en = 'Here Comes de Honey Man',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2084 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Hi Ho!>

UPDATE pieces piece
SET piece.title = '가곡 <Hi Ho!>', piece.title_en = 'Hi Ho!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2098 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Home Blues

UPDATE pieces piece
SET piece.title = 'Home Blues', piece.title_en = 'Home Blues',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2026 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I Don't Think I'll Fall in Love Today>

UPDATE pieces piece
SET piece.title = '가곡 <I Don''t Think I''ll Fall in Love Today>', piece.title_en = 'I Don''t Think I''ll Fall in Love Today',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 768 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I Found a Four-Leaf Clover>

UPDATE pieces piece
SET piece.title = '가곡 <I Found a Four-Leaf Clover>', piece.title_en = 'I Found a Four-Leaf Clover',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2115 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I Won’t Say I Will But I Won’t Say I Won’t>

UPDATE pieces piece
SET piece.title = '가곡 <I Won’t Say I Will But I Won’t Say I Won’t>', piece.title_en = 'I Won’t Say I Will But I Won’t Say I Won’t',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 782 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I'm a Poached Egg>

UPDATE pieces piece
SET piece.title = '가곡 <I''m a Poached Egg>', piece.title_en = 'I''m a Poached Egg',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 748 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Idle Dreams>

UPDATE pieces piece
SET piece.title = '가곡 <Idle Dreams>', piece.title_en = 'Idle Dreams',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 813 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Impromptu in Two Keys

UPDATE pieces piece
SET piece.title = 'Impromptu in Two Keys', piece.title_en = 'Impromptu in Two Keys',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1209 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <In the Rain>

UPDATE pieces piece
SET piece.title = '가곡 <In the Rain>', piece.title_en = 'In the Rain',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2779 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Innocent Lonesome Blue Baby>

UPDATE pieces piece
SET piece.title = '가곡 <Innocent Lonesome Blue Baby>', piece.title_en = 'Innocent Lonesome Blue Baby',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 814 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I’d Rather Charleston!>

UPDATE pieces piece
SET piece.title = '가곡 <I’d Rather Charleston!>', piece.title_en = 'I’d Rather Charleston!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1208 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jazzbo Brown

UPDATE pieces piece
SET piece.title = 'Jazzbo Brown', piece.title_en = 'Jazzbo Brown',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 758 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Juanita>

UPDATE pieces piece
SET piece.title = '가곡 <Juanita>', piece.title_en = 'Juanita',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2135 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Katinkitschken>

UPDATE pieces piece
SET piece.title = '가곡 <Katinkitschken>', piece.title_en = 'Katinkitschken',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1285 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La La Lucille

UPDATE pieces piece
SET piece.title = 'La La Lucille', piece.title_en = 'La La Lucille',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2821 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tee-Oodle-Um-Bum-Bo', part.name_en = 'Tee-Oodle-Um-Bum-Bo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2821 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:90660555-43c3-40fe-8870-21099343f878' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90660555-43c3-40fe-8870-21099343f878', 1, NULL, 'Tee-Oodle-Um-Bum-Bo', 'Tee-Oodle-Um-Bum-Bo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2821 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90660555-43c3-40fe-8870-21099343f878'
);


-- None 뮤지컬 <Lady, Be Good>

UPDATE pieces piece
SET piece.title = '뮤지컬 <Lady, Be Good>', piece.title_en = 'Lady, Be Good',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1118 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fascinatin’ Rhythm', part.name_en = 'Fascinatin’ Rhythm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1118 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:a1a48391-a619-3690-add5-42340a79d7dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1a48391-a619-3690-add5-42340a79d7dc', 1, NULL, 'Fascinatin’ Rhythm', 'Fascinatin’ Rhythm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1118 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a48391-a619-3690-add5-42340a79d7dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'So Am I', part.name_en = 'So Am I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1118 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:cbe96fa4-aacb-3dbb-918a-215c7cc23908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbe96fa4-aacb-3dbb-918a-215c7cc23908', 2, NULL, 'So Am I', 'So Am I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1118 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbe96fa4-aacb-3dbb-918a-215c7cc23908'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Oh, Lady Be Good!', part.name_en = 'Oh, Lady Be Good!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1118 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:f8987074-fb0d-32e9-b68e-50931959f2bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8987074-fb0d-32e9-b68e-50931959f2bf', 3, NULL, 'Oh, Lady Be Good!', 'Oh, Lady Be Good!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1118 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8987074-fb0d-32e9-b68e-50931959f2bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '“The Half of It, Dearie” Blues', part.name_en = '“The Half of It, Dearie” Blues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1118 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:90e79c65-236e-316c-a573-36fb76f21f67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90e79c65-236e-316c-a573-36fb76f21f67', 4, NULL, '“The Half of It, Dearie” Blues', '“The Half of It, Dearie” Blues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1118 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90e79c65-236e-316c-a573-36fb76f21f67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Little Jazz Bird', part.name_en = 'Little Jazz Bird',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1118 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:148af1b8-ea6c-3ff8-ac0a-7b210c0da46f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:148af1b8-ea6c-3ff8-ac0a-7b210c0da46f', 5, NULL, 'Little Jazz Bird', 'Little Jazz Bird', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1118 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:148af1b8-ea6c-3ff8-ac0a-7b210c0da46f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'I''d Rather Charleston With You', part.name_en = 'I''d Rather Charleston With You',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1118 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:a3ee6d9b-4b5c-3675-aea8-ca9dc947521a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3ee6d9b-4b5c-3675-aea8-ca9dc947521a', 6, NULL, 'I''d Rather Charleston With You', 'I''d Rather Charleston With You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1118 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3ee6d9b-4b5c-3675-aea8-ca9dc947521a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Man I Love', part.name_en = 'The Man I Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1118 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:e10256bd-40c6-3ebf-847e-c3f561ae4a1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e10256bd-40c6-3ebf-847e-c3f561ae4a1e', 7, NULL, 'The Man I Love', 'The Man I Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1118 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e10256bd-40c6-3ebf-847e-c3f561ae4a1e'
);


-- None 가곡 <Land of the Gay Caballero>

UPDATE pieces piece
SET piece.title = '가곡 <Land of the Gay Caballero>', piece.title_en = 'Land of the Gay Caballero',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2878 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Limehouse Nights>

UPDATE pieces piece
SET piece.title = '가곡 <Limehouse Nights>', piece.title_en = 'Limehouse Nights',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2664 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Mans mīļotais>

UPDATE pieces piece
SET piece.title = '가곡 <Mans mīļotais>', piece.title_en = 'Mans mīļotais',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1089 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Meadow Serenade>

UPDATE pieces piece
SET piece.title = '가곡 <Meadow Serenade>', piece.title_en = 'Meadow Serenade',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 759 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Melody, for solo piano (Prelude No. 4 in F minor)

UPDATE pieces piece
SET piece.title = 'Melody, for solo piano (Prelude No. 4 in F minor)', piece.title_en = 'Melody, for solo piano (Prelude No. 4 in F minor)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2433 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Merry Andrew

UPDATE pieces piece
SET piece.title = 'Merry Andrew', piece.title_en = 'Merry Andrew',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2823 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mexican Dance

UPDATE pieces piece
SET piece.title = 'Mexican Dance', piece.title_en = 'Mexican Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2500 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Mīla atnāca>

UPDATE pieces piece
SET piece.title = '가곡 <Mīla atnāca>', piece.title_en = 'Mīla atnāca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1912 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Nashville Nightingale>

UPDATE pieces piece
SET piece.title = '가곡 <Nashville Nightingale>', piece.title_en = 'Nashville Nightingale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 764 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O Land of Mine, America

UPDATE pieces piece
SET piece.title = 'O Land of Mine, America', piece.title_en = 'O Land of Mine, America',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2070 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Oh Gee! Oh Joy!>

UPDATE pieces piece
SET piece.title = '가곡 <Oh Gee! Oh Joy!>', piece.title_en = 'Oh Gee! Oh Joy!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1282 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <On My Mind the Whole Night Long>

UPDATE pieces piece
SET piece.title = '가곡 <On My Mind the Whole Night Long>', piece.title_en = 'On My Mind the Whole Night Long',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 812 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Overture to "Funny Face"

UPDATE pieces piece
SET piece.title = 'Overture to "Funny Face"', piece.title_en = 'Overture to "Funny Face"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1943 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Overture to Lady Be Good

UPDATE pieces piece
SET piece.title = 'Overture to Lady Be Good', piece.title_en = 'Overture to Lady Be Good',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1721 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Overture: Gershwin in Hollywood

UPDATE pieces piece
SET piece.title = 'Overture: Gershwin in Hollywood', piece.title_en = 'Overture: Gershwin in Hollywood',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1025 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 뮤지컬 <Pardon My English>

UPDATE pieces piece
SET piece.title = '뮤지컬 <Pardon My English>', piece.title_en = 'Pardon My English',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2251 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'My Cousin in Milwaukee', part.name_en = 'My Cousin in Milwaukee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2251 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:0c668541-eb70-3e83-8216-47566ef074ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c668541-eb70-3e83-8216-47566ef074ab', 1, NULL, 'My Cousin in Milwaukee', 'My Cousin in Milwaukee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2251 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c668541-eb70-3e83-8216-47566ef074ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lorelei', part.name_en = 'Lorelei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2251 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:603e2204-c660-3b8a-97b8-952ea6e8601f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:603e2204-c660-3b8a-97b8-952ea6e8601f', 2, NULL, 'Lorelei', 'Lorelei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2251 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:603e2204-c660-3b8a-97b8-952ea6e8601f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Isn’t It a Pity?', part.name_en = 'Isn’t It a Pity?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2251 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:db50d8cf-02b0-3d0c-9aca-58c6eede610e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db50d8cf-02b0-3d0c-9aca-58c6eede610e', 3, NULL, 'Isn’t It a Pity?', 'Isn’t It a Pity?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2251 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db50d8cf-02b0-3d0c-9aca-58c6eede610e'
);


-- None 오페라 <Porgy and Bess>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Porgy and Bess: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:544398d6-b056-39a1-a5a7-a1b5f7956317' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:544398d6-b056-39a1-a5a7-a1b5f7956317', 1, NULL, 'Overture', 'Porgy and Bess: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:544398d6-b056-39a1-a5a7-a1b5f7956317'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Porgy and Bess: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:5ed4ffb8-48f1-41ab-b819-37c796b2096a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ed4ffb8-48f1-41ab-b819-37c796b2096a', 2, NULL, 'Act I', 'Porgy and Bess: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ed4ffb8-48f1-41ab-b819-37c796b2096a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5ed4ffb8-48f1-41ab-b819-37c796b2096a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I', part.name_en = 'Porgy and Bess: Act I, Scene I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:25a8172c-c283-4241-9c76-b0bb1dc38090' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25a8172c-c283-4241-9c76-b0bb1dc38090', 1, NULL, 'Scene I', 'Porgy and Bess: Act I, Scene I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5ed4ffb8-48f1-41ab-b819-37c796b2096a'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25a8172c-c283-4241-9c76-b0bb1dc38090'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5ed4ffb8-48f1-41ab-b819-37c796b2096a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II', part.name_en = 'Porgy and Bess: Act I, Scene II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:e9dcc48e-800f-4064-b827-1df8527a68f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e9dcc48e-800f-4064-b827-1df8527a68f1', 2, NULL, 'Scene II', 'Porgy and Bess: Act I, Scene II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5ed4ffb8-48f1-41ab-b819-37c796b2096a'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9dcc48e-800f-4064-b827-1df8527a68f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Porgy and Bess: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267', 3, NULL, 'Act II', 'Porgy and Bess: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene III', part.name_en = 'Porgy and Bess: Act II, Scene III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:1ab28a3a-cf85-464f-93be-7ec2c99b4802' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ab28a3a-cf85-464f-93be-7ec2c99b4802', 1, NULL, 'Scene III', 'Porgy and Bess: Act II, Scene III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab28a3a-cf85-464f-93be-7ec2c99b4802'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene I', part.name_en = 'Porgy and Bess: Act II, Scene I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:1c40e317-4360-48fe-a6f9-cc3cdebdb554' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c40e317-4360-48fe-a6f9-cc3cdebdb554', 2, NULL, 'Scene I', 'Porgy and Bess: Act II, Scene I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c40e317-4360-48fe-a6f9-cc3cdebdb554'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene II', part.name_en = 'Porgy and Bess: Act II, Scene II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:276ddd51-44ff-4ae4-ac2c-d4ea11f3cb59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:276ddd51-44ff-4ae4-ac2c-d4ea11f3cb59', 3, NULL, 'Scene II', 'Porgy and Bess: Act II, Scene II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:276ddd51-44ff-4ae4-ac2c-d4ea11f3cb59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II. “Oh, Doctor Jesus”', part.name_en = 'Porgy and Bess: Act II. “Oh, Doctor Jesus”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:41dfdf2b-a8e7-319c-a641-e464780249ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41dfdf2b-a8e7-319c-a641-e464780249ce', 4, NULL, 'Act II. “Oh, Doctor Jesus”', 'Porgy and Bess: Act II. “Oh, Doctor Jesus”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41dfdf2b-a8e7-319c-a641-e464780249ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene IV', part.name_en = 'Porgy and Bess: Act II, Scene IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:7e2087fa-5b44-45c1-81ce-e4475d7dbe60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e2087fa-5b44-45c1-81ce-e4475d7dbe60', 5, NULL, 'Scene IV', 'Porgy and Bess: Act II, Scene IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efc76139-fe5f-4270-b7e6-8f3ae8471267'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e2087fa-5b44-45c1-81ce-e4475d7dbe60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Porgy and Bess: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1', 4, NULL, 'Act III', 'Porgy and Bess: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lonely Boy', part.name_en = 'Porgy and Bess: Act III: Lonely Boy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:6c9343e9-b7cd-4a8d-9a58-48ec5d8c3d4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c9343e9-b7cd-4a8d-9a58-48ec5d8c3d4d', 1, NULL, 'Lonely Boy', 'Porgy and Bess: Act III: Lonely Boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c9343e9-b7cd-4a8d-9a58-48ec5d8c3d4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II', part.name_en = 'Porgy and Bess: Act III, Scene II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:8182c032-a498-4f41-a87e-1ef49d2f9838' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8182c032-a498-4f41-a87e-1ef49d2f9838', 2, NULL, 'Scene II', 'Porgy and Bess: Act III, Scene II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8182c032-a498-4f41-a87e-1ef49d2f9838'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene III', part.name_en = 'Porgy and Bess: Act III, Scene III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:9e3c79fc-9518-4fd1-866d-2c649cf5f201' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e3c79fc-9518-4fd1-866d-2c649cf5f201', 3, NULL, 'Scene III', 'Porgy and Bess: Act III, Scene III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e3c79fc-9518-4fd1-866d-2c649cf5f201'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene I', part.name_en = 'Porgy and Bess: Act III, Scene I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 333 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:f26dd0ab-1890-4cca-812f-4361b431d1d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f26dd0ab-1890-4cca-812f-4361b431d1d3', 4, NULL, 'Scene I', 'Porgy and Bess: Act III, Scene I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bad4ab5-9760-4aaa-9e3d-633a8155f2c1'
WHERE p.id = 333 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f26dd0ab-1890-4cca-812f-4361b431d1d3'
);


-- None Porgy and Bess: The Song of Serena

UPDATE pieces piece
SET piece.title = 'Porgy and Bess: The Song of Serena', piece.title_en = 'Porgy and Bess: The Song of Serena',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2333 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prelude Melody no. 17

UPDATE pieces piece
SET piece.title = 'Prelude Melody no. 17', piece.title_en = 'Prelude Melody no. 17',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 983 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 3번

UPDATE pieces piece
SET piece.title = '전주곡 3번', piece.title_en = 'Prelude No. 3, Andante from Rhapsody In Blue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2919 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 뮤지컬 <Primrose>

UPDATE pieces piece
SET piece.title = '뮤지컬 <Primrose>', piece.title_en = 'Primrose',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2198 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Naughty Baby', part.name_en = 'Naughty Baby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2198 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:1d57a9d5-f942-4fd6-adb7-2d3f77055002' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d57a9d5-f942-4fd6-adb7-2d3f77055002', 1, NULL, 'Naughty Baby', 'Naughty Baby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2198 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d57a9d5-f942-4fd6-adb7-2d3f77055002'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Isn''t It Wonderful', part.name_en = 'Isn''t It Wonderful',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2198 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:86e9929b-9f2d-4b24-9317-3563bec1b9e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86e9929b-9f2d-4b24-9317-3563bec1b9e9', 2, NULL, 'Isn''t It Wonderful', 'Isn''t It Wonderful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2198 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86e9929b-9f2d-4b24-9317-3563bec1b9e9'
);


-- None Primrose: Ballet

UPDATE pieces piece
SET piece.title = 'Primrose: Ballet', piece.title_en = 'Primrose: Ballet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2001 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rhapsody In Gerswin

UPDATE pieces piece
SET piece.title = 'Rhapsody In Gerswin', piece.title_en = 'Rhapsody In Gerswin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2623 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Scandal Walk>

UPDATE pieces piece
SET piece.title = '가곡 <Scandal Walk>', piece.title_en = 'Scandal Walk',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 793 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Second Rhapsody for Piano and Orchestra

UPDATE pieces piece
SET piece.title = 'Second Rhapsody for Piano and Orchestra', piece.title_en = 'Second Rhapsody for Piano and Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 547 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <She's Just A Baby>

UPDATE pieces piece
SET piece.title = '가곡 <She''s Just A Baby>', piece.title_en = 'She''s Just A Baby',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2798 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sleepless Night, for solo piano (Prelude No. 8 in A flat major)

UPDATE pieces piece
SET piece.title = 'Sleepless Night, for solo piano (Prelude No. 8 in A flat major)', piece.title_en = 'Sleepless Night, for solo piano (Prelude No. 8 in A flat major)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2361 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Song of the Flame>

UPDATE pieces piece
SET piece.title = '가곡 <Song of the Flame>', piece.title_en = 'Song of the Flame',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1142 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <South Sea Isles>

UPDATE pieces piece
SET piece.title = '가곡 <South Sea Isles>', piece.title_en = 'South Sea Isles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2501 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sutton Place

UPDATE pieces piece
SET piece.title = 'Sutton Place', piece.title_en = 'Sutton Place',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 963 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 뮤지컬 <Sweet Little Devil>

UPDATE pieces piece
SET piece.title = '뮤지컬 <Sweet Little Devil>', piece.title_en = 'Sweet Little Devil',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 894 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Someone Believes in You', part.name_en = 'Someone Believes in You',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 894 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:81f4e77b-bbb9-4a10-8b6c-016edba3895e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81f4e77b-bbb9-4a10-8b6c-016edba3895e', 1, NULL, 'Someone Believes in You', 'Someone Believes in You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 894 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81f4e77b-bbb9-4a10-8b6c-016edba3895e'
);


-- None 가곡 <Swiss Miss>

UPDATE pieces piece
SET piece.title = '가곡 <Swiss Miss>', piece.title_en = 'Swiss Miss',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 760 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Babbit and the Bromide>

UPDATE pieces piece
SET piece.title = '가곡 <The Babbit and the Bromide>', piece.title_en = 'The Babbit and the Bromide',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 744 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Life of a Rose>

UPDATE pieces piece
SET piece.title = '가곡 <The Life of a Rose>', piece.title_en = 'The Life of a Rose',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2845 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Woman's Touch>

UPDATE pieces piece
SET piece.title = '가곡 <The Woman''s Touch>', piece.title_en = 'The Woman''s Touch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 746 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Yankee Doodle Blues

UPDATE pieces piece
SET piece.title = 'The Yankee Doodle Blues', piece.title_en = 'The Yankee Doodle Blues',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1279 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <There Is No Music>

UPDATE pieces piece
SET piece.title = '가곡 <There Is No Music>', piece.title_en = 'There Is No Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 766 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three-Quarter Blues

UPDATE pieces piece
SET piece.title = 'Three-Quarter Blues', piece.title_en = 'Three-Quarter Blues',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1206 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tip-Toes

UPDATE pieces piece
SET piece.title = 'Tip-Toes', piece.title_en = 'Tip-Toes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2064 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Looking for a Boy', part.name_en = 'Looking for a Boy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2064 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:3f09a561-ba49-43e6-82e2-a0d0cc46c91f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f09a561-ba49-43e6-82e2-a0d0cc46c91f', 1, NULL, 'Looking for a Boy', 'Looking for a Boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2064 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f09a561-ba49-43e6-82e2-a0d0cc46c91f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sweet and Low Down', part.name_en = 'Sweet and Low Down',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2064 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:90b4f7fd-86a5-35b9-bf5d-b529b9480534' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90b4f7fd-86a5-35b9-bf5d-b529b9480534', 2, NULL, 'Sweet and Low Down', 'Sweet and Low Down', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2064 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90b4f7fd-86a5-35b9-bf5d-b529b9480534'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'It''s a Great Little World', part.name_en = 'It''s a Great Little World',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2064 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:9348ef11-d9b9-4865-8ce8-3e90df93cd69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9348ef11-d9b9-4865-8ce8-3e90df93cd69', 3, NULL, 'It''s a Great Little World', 'It''s a Great Little World', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2064 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9348ef11-d9b9-4865-8ce8-3e90df93cd69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'That Certain Feeling', part.name_en = 'That Certain Feeling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2064 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:be0b78c7-ee8c-3177-b6bf-b9599076bedf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be0b78c7-ee8c-3177-b6bf-b9599076bedf', 4, NULL, 'That Certain Feeling', 'That Certain Feeling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2064 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be0b78c7-ee8c-3177-b6bf-b9599076bedf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Tip-Toes: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2064 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:c64401ca-c34c-466e-b229-ebaca52a3dca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c64401ca-c34c-466e-b229-ebaca52a3dca', 5, NULL, 'Overture', 'Tip-Toes: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2064 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c64401ca-c34c-466e-b229-ebaca52a3dca'
);


-- None 뮤지컬 <Treasure Girl>

UPDATE pieces piece
SET piece.title = '뮤지컬 <Treasure Girl>', piece.title_en = 'Treasure Girl',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1067 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'What Causes That?', part.name_en = 'What Causes That?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1067 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:126abfd5-2e0d-470a-b79b-a4694961dcb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:126abfd5-2e0d-470a-b79b-a4694961dcb7', 1, NULL, 'What Causes That?', 'What Causes That?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1067 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:126abfd5-2e0d-470a-b79b-a4694961dcb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I’ve Got a Crush on You', part.name_en = 'I’ve Got a Crush on You',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1067 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:909c68e7-2991-374b-a6d2-fbadec2ce79f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:909c68e7-2991-374b-a6d2-fbadec2ce79f', 2, NULL, 'I’ve Got a Crush on You', 'I’ve Got a Crush on You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1067 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:909c68e7-2991-374b-a6d2-fbadec2ce79f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Oh, So Nice', part.name_en = 'Oh, So Nice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1067 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:ae39f09d-73a8-4fbf-bbac-7513d65caf97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae39f09d-73a8-4fbf-bbac-7513d65caf97', 3, NULL, 'Oh, So Nice', 'Oh, So Nice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1067 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae39f09d-73a8-4fbf-bbac-7513d65caf97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'K-ra-zy for You', part.name_en = 'K-ra-zy for You',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1067 AND p.composer_id = 86 AND part.part_key = 'musicbrainz:e443a417-bc14-468b-b871-538d0c305825' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e443a417-bc14-468b-b871-538d0c305825', 4, NULL, 'K-ra-zy for You', 'K-ra-zy for You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1067 AND p.composer_id = 86
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e443a417-bc14-468b-b871-538d0c305825'
);


-- None Two Waltzes in C

UPDATE pieces piece
SET piece.title = 'Two Waltzes in C', piece.title_en = 'Two Waltzes in C',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2249 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Walzes in C

UPDATE pieces piece
SET piece.title = 'Two Walzes in C', piece.title_en = 'Two Walzes in C',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2179 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Wait a Bit, Susie>

UPDATE pieces piece
SET piece.title = '가곡 <Wait a Bit, Susie>', piece.title_en = 'Wait a Bit, Susie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2487 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Waiting for the Sun to Come Out>

UPDATE pieces piece
SET piece.title = '가곡 <Waiting for the Sun to Come Out>', piece.title_en = 'Waiting for the Sun to Come Out',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1595 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <When Do We Dance?>

UPDATE pieces piece
SET piece.title = '가곡 <When Do We Dance?>', piece.title_en = 'When Do We Dance?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2513 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <When Our Ship Comes Sailing In>

UPDATE pieces piece
SET piece.title = '가곡 <When Our Ship Comes Sailing In>', piece.title_en = 'When Our Ship Comes Sailing In',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 816 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <When You Want ’Em, You Can’t Get ’Em, When You’ve Got ’Em, You Don’t Want ’Em>

UPDATE pieces piece
SET piece.title = '가곡 <When You Want ’Em, You Can’t Get ’Em, When You’ve Got ’Em, You Don’t Want ’Em>', piece.title_en = 'When You Want ’Em, You Can’t Get ’Em, When You’ve Got ’Em, You Don’t Want ’Em',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1982 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <You’ve Got What Gets Me>

UPDATE pieces piece
SET piece.title = '가곡 <You’ve Got What Gets Me>', piece.title_en = 'You’ve Got What Gets Me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 749 AND piece.composer_id = 86
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Back Bay Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Back Bay Polka>', 'Back Bay Polka', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Back Bay Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc950399-2f0d-40c0-8d40-ae47f94eb7e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc950399-2f0d-40c0-8d40-ae47f94eb7e7'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Back Bay Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc950399-2f0d-40c0-8d40-ae47f94eb7e7'
);


-- None 가곡 <Blah, Blah, Blah>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Blah, Blah, Blah>', 'Blah, Blah, Blah', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Blah, Blah, Blah>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f2a726b-c04a-4858-89a5-4f2e856f6712'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f2a726b-c04a-4858-89a5-4f2e856f6712'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Blah, Blah, Blah>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f2a726b-c04a-4858-89a5-4f2e856f6712'
);


-- None 가곡 <Blue, Blue, Blue>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Blue, Blue, Blue>', 'Blue, Blue, Blue', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Blue, Blue, Blue>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bffa560-5e10-449e-87a0-4e05c74ce0f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5bffa560-5e10-449e-87a0-4e05c74ce0f0'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Blue, Blue, Blue>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bffa560-5e10-449e-87a0-4e05c74ce0f0'
);


-- None Cuban Overture

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cuban Overture', 'Cuban Overture', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cuban Overture'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9ef69ab-818e-3803-a416-853b4d9583b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9ef69ab-818e-3803-a416-853b4d9583b9'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = 'Cuban Overture' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9ef69ab-818e-3803-a416-853b4d9583b9'
);


-- None 가곡 <Delishious>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Delishious>', 'Delishious', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Delishious>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac96c3f5-9ae9-41b5-a4ee-d0d0d3639233'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac96c3f5-9ae9-41b5-a4ee-d0d0d3639233'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Delishious>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac96c3f5-9ae9-41b5-a4ee-d0d0d3639233'
);


-- None 가곡 <Do It Again>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Do It Again>', 'Do It Again', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Do It Again>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e817cf2-eddc-390f-a8ae-e0fcde101ff9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7e817cf2-eddc-390f-a8ae-e0fcde101ff9'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Do It Again>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e817cf2-eddc-390f-a8ae-e0fcde101ff9'
);


-- None Dream Sequence

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Dream Sequence', 'Dream Sequence', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Dream Sequence'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe1d4f3e-acc2-4288-a623-6d294ecf6fce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe1d4f3e-acc2-4288-a623-6d294ecf6fce'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = 'Dream Sequence' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe1d4f3e-acc2-4288-a623-6d294ecf6fce'
);


-- None 가곡 <For You, for Me, for Evermore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <For You, for Me, for Evermore>', 'For You, for Me, for Evermore', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <For You, for Me, for Evermore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54f61cd0-c520-4b09-a9c5-08b13b966b79'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54f61cd0-c520-4b09-a9c5-08b13b966b79'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <For You, for Me, for Evermore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54f61cd0-c520-4b09-a9c5-08b13b966b79'
);


-- None 뮤지컬 <Funny Face>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '뮤지컬 <Funny Face>', 'Funny Face', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '뮤지컬 <Funny Face>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b31d5c-f100-4e44-803a-3c26ceace165'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8b31d5c-f100-4e44-803a-3c26ceace165'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Funny Face>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b31d5c-f100-4e44-803a-3c26ceace165'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03eca442-d95e-3ff1-8835-545343c2bff0', 1, NULL, 'Funny Face', 'Funny Face', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Funny Face>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03eca442-d95e-3ff1-8835-545343c2bff0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:361a6a8a-f01a-3778-81f0-498a851b71b5', 2, NULL, 'He Loves and She Loves', 'He Loves and She Loves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Funny Face>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:361a6a8a-f01a-3778-81f0-498a851b71b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e381912-32cd-3373-820b-5c5c245998ae', 3, NULL, 'My One and Only', 'My One and Only', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Funny Face>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e381912-32cd-3373-820b-5c5c245998ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cb8c093-919d-39f5-80e4-62f049770d3d', 4, NULL, 'Let’s Kiss and Make Up', 'Let’s Kiss and Make Up', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Funny Face>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cb8c093-919d-39f5-80e4-62f049770d3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4e08849-bab5-302b-aed6-b07b1665754e', 5, NULL, 'High Hat', 'High Hat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Funny Face>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e08849-bab5-302b-aed6-b07b1665754e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f583f1d2-a199-3c7b-b8bd-6a61b1d3e0cb', 6, NULL, '’S Wonderful', '’S Wonderful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Funny Face>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f583f1d2-a199-3c7b-b8bd-6a61b1d3e0cb'
);


-- None 뮤지컬 <Girl Crazy>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '뮤지컬 <Girl Crazy>', 'Girl Crazy', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '뮤지컬 <Girl Crazy>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce5721a0-fdb9-4405-9519-24a037758d22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce5721a0-fdb9-4405-9519-24a037758d22'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce5721a0-fdb9-4405-9519-24a037758d22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13869248-f36a-3fe0-a8bd-7c0d2793d8d9', 1, NULL, 'Embraceable You', 'Embraceable You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13869248-f36a-3fe0-a8bd-7c0d2793d8d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:418d11f7-0c0c-4388-9350-d7859b96c663', 2, NULL, 'Walking in the Garden', 'Walking in the Garden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:418d11f7-0c0c-4388-9350-d7859b96c663'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4652978e-963c-4724-bf8e-b1f67724f7a5', 3, NULL, 'End Title (extended version)', 'Girl Crazy: End Title (extended version)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4652978e-963c-4724-bf8e-b1f67724f7a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c8981d2-71c2-495f-aa59-8601524b3092', 4, NULL, 'Ginger Dear', 'Ginger Dear', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c8981d2-71c2-495f-aa59-8601524b3092'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f38b20a-02b1-4ede-ab5b-ee835a7e977c', 5, NULL, 'Treat Me Rough', 'Treat Me Rough', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f38b20a-02b1-4ede-ab5b-ee835a7e977c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a8da382-e35b-4b6a-a022-2d93c9f1b2b9', 6, NULL, 'Bronco Busters', 'Bronco Busters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a8da382-e35b-4b6a-a022-2d93c9f1b2b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d534478-9b42-4369-b5fe-7d5500fa40c8', 7, NULL, 'Sam and Delilah', 'Sam and Delilah', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d534478-9b42-4369-b5fe-7d5500fa40c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85054a48-605f-38e8-b55a-61d108eb2210', 8, NULL, 'Overture to “Girl Crazy”', 'Overture to “Girl Crazy”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85054a48-605f-38e8-b55a-61d108eb2210'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:924ff92b-c3ca-4af3-8deb-c9960e9f28e5', 9, NULL, 'Boy! What Love Has Done to Me!', 'Boy! What Love Has Done to Me!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:924ff92b-c3ca-4af3-8deb-c9960e9f28e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1a48391-a619-3690-add5-42340a79d7dc', 10, NULL, 'Fascinatin’ Rhythm', 'Fascinatin’ Rhythm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a48391-a619-3690-add5-42340a79d7dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3f21543-f085-33b5-b76b-5e59b9118896', 11, NULL, 'Bidin’ My Time', 'Bidin’ My Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3f21543-f085-33b5-b76b-5e59b9118896'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b58a65f4-e500-3fe7-8dc6-ff485af84cf6', 12, NULL, 'Could You Use Me?', 'Could You Use Me?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b58a65f4-e500-3fe7-8dc6-ff485af84cf6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0898f8d-77ff-314e-9888-1bfdc73dc2d8', 13, NULL, 'I Got Rhythm', 'I Got Rhythm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0898f8d-77ff-314e-9888-1bfdc73dc2d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4034755-002f-38b5-b8ba-9e59e79b1b3e', 14, NULL, 'Barbary Coast', 'Barbary Coast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4034755-002f-38b5-b8ba-9e59e79b1b3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f53d7dd0-fdbd-3901-adf8-9b1ab3121e9e', 15, NULL, 'But Not for Me', 'But Not for Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Girl Crazy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f53d7dd0-fdbd-3901-adf8-9b1ab3121e9e'
);


-- None 가곡 <I Was So Young, You Were So Beautiful>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <I Was So Young, You Were So Beautiful>', 'I Was So Young, You Were So Beautiful', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <I Was So Young, You Were So Beautiful>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86dd0899-be3a-4a1b-a516-9bd13c0fddf1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86dd0899-be3a-4a1b-a516-9bd13c0fddf1'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <I Was So Young, You Were So Beautiful>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86dd0899-be3a-4a1b-a516-9bd13c0fddf1'
);


-- None 가곡 <I’ll Build a Stairway to Paradise>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <I’ll Build a Stairway to Paradise>', 'I’ll Build a Stairway to Paradise', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <I’ll Build a Stairway to Paradise>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb04c83d-d4fe-3935-bbf7-f9becba6614c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fb04c83d-d4fe-3935-bbf7-f9becba6614c'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <I’ll Build a Stairway to Paradise>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb04c83d-d4fe-3935-bbf7-f9becba6614c'
);


-- None 뮤지컬 <Let 'em Eat Cake>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '뮤지컬 <Let ''em Eat Cake>', 'Let ''em Eat Cake', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '뮤지컬 <Let ''em Eat Cake>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '461e71da-20f2-4de7-9291-84dc209fab42'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '461e71da-20f2-4de7-9291-84dc209fab42'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '461e71da-20f2-4de7-9291-84dc209fab42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6203b8d5-5231-3b0e-8611-8bc2b5406e91', 1, NULL, 'Overture', 'Let ''em Eat Cake: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6203b8d5-5231-3b0e-8611-8bc2b5406e91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5', 2, NULL, 'Act I', 'Let ''em Eat Cake: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4ce20aa-9ddf-44da-b42b-9987df67e996', 1, NULL, 'Tweedledee for President', 'Tweedledee for President', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4ce20aa-9ddf-44da-b42b-9987df67e996'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59cf0acb-6c05-4dca-b1c4-ce982d4f9f4b', 2, NULL, 'Union Square', 'Union Square', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59cf0acb-6c05-4dca-b1c4-ce982d4f9f4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4df96266-fa61-41b4-89e2-c957012a3200', 3, NULL, 'Shirts by Millions', 'Shirts by Millions', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4df96266-fa61-41b4-89e2-c957012a3200'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:849d11d9-7c93-48b8-8254-a02ae56ca374', 4, NULL, 'Comes the Revolution', 'Comes the Revolution', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:849d11d9-7c93-48b8-8254-a02ae56ca374'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82707ae2-3074-4357-ae57-ba1cfc296049', 5, NULL, 'Climb Up the Social Ladder', 'Climb Up the Social Ladder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82707ae2-3074-4357-ae57-ba1cfc296049'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:93958911-12b6-4c37-87d9-dcba263919f8', 6, NULL, 'Cloistered from the Noisy City', 'Cloistered from the Noisy City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93958911-12b6-4c37-87d9-dcba263919f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c2297791-5999-4cfc-b1f7-b2bbab45339f', 7, NULL, 'On and On and On', 'On and On and On', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2297791-5999-4cfc-b1f7-b2bbab45339f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1f22d476-552e-46d2-9718-ee7105e1d452', 8, NULL, 'I''ve Brushed My Teeth', 'I''ve Brushed My Teeth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f22d476-552e-46d2-9718-ee7105e1d452'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e195168a-05e2-4f9f-bbb9-05f4b9313264', 9, NULL, 'The General''s Gone to a Party', 'The General''s Gone to a Party', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e195168a-05e2-4f9f-bbb9-05f4b9313264'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8efeabc7-df7a-42f7-8ec4-d81e998d91ec', 10, NULL, 'All the Mothers of the Nation', 'All the Mothers of the Nation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8efeabc7-df7a-42f7-8ec4-d81e998d91ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7274a850-7838-4666-9e93-24fe8824d4d6', 11, NULL, 'Let ''Em Eat Cake', 'Let ''Em Eat Cake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:782e4847-9949-4760-ac96-a4a6715214b5'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7274a850-7838-4666-9e93-24fe8824d4d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09', 3, NULL, 'Act II', 'Let ''em Eat Cake: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1945e9a-fc56-47dd-ab3f-87e1cab96620', 1, NULL, 'Blue, Blue, Blue', 'Blue, Blue, Blue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1945e9a-fc56-47dd-ab3f-87e1cab96620'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:77b0a303-4491-49ff-8bc4-c53a0e419f6e', 2, NULL, 'Who''s the Greatest?', 'Who''s the Greatest?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77b0a303-4491-49ff-8bc4-c53a0e419f6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12471c79-660e-46dd-961e-330274d6cd72', 3, NULL, 'The League of Nations', 'The League of Nations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12471c79-660e-46dd-961e-330274d6cd72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e30daa29-153b-4c10-a472-9628af702689', 4, NULL, 'Up and at ''em', 'Up and at ''em', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e30daa29-153b-4c10-a472-9628af702689'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7a615dc-19bb-346f-a888-7f57c39692b0', 5, NULL, 'Mine', 'Mine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7a615dc-19bb-346f-a888-7f57c39692b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09f8788a-bfac-4cbb-89d1-abe02a7e3748', 6, NULL, 'That''s What He Did', 'That''s What He Did', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09f8788a-bfac-4cbb-89d1-abe02a7e3748'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b870087c-742a-4e28-b1d7-99c01288fe82', 7, NULL, 'I Know a Foul Ball', 'I Know a Foul Ball', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b870087c-742a-4e28-b1d7-99c01288fe82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c1df540-c64a-45a0-b06f-70b968b2f964', 8, NULL, 'Throttle Throttlebottom', 'Throttle Throttlebottom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c1df540-c64a-45a0-b06f-70b968b2f964'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31b39ef0-4ed1-4cba-b618-3818e9a5f79f', 9, NULL, 'It Isn''t What You Did', 'It Isn''t What You Did', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31b39ef0-4ed1-4cba-b618-3818e9a5f79f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e50f1137-f4c9-4617-a10d-b8ba76cdd1e6', 10, NULL, 'Mine (Reprise)', 'Mine (Reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e50f1137-f4c9-4617-a10d-b8ba76cdd1e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5dea373-dfe5-4e63-8e7d-2dac46e7a537', 11, NULL, 'First Lady and First Gent', 'First Lady and First Gent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5dea373-dfe5-4e63-8e7d-2dac46e7a537'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e13362d-874f-4cdd-8a01-86d5c8075391', 12, NULL, 'Hang Throttlebottom in the Morning', 'Hang Throttlebottom in the Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e13362d-874f-4cdd-8a01-86d5c8075391'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c85f49c5-5128-46d6-97bc-3287e3cebca1', 13, NULL, 'Fashion Show', 'Fashion Show', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c85f49c5-5128-46d6-97bc-3287e3cebca1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6237c27a-57aa-4f66-afff-d05faff15893', 14, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4941be4c-4f08-4863-b7e0-564ab953dd09'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Let ''em Eat Cake>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6237c27a-57aa-4f66-afff-d05faff15893'
);


-- None 가곡 <Liza (All the Clouds’ll Roll Away)>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Liza (All the Clouds’ll Roll Away)>', 'Liza (All the Clouds’ll Roll Away)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Liza (All the Clouds’ll Roll Away)>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7be42dcb-bbbb-3e7a-aa8c-d9412283a7e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7be42dcb-bbbb-3e7a-aa8c-d9412283a7e1'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Liza (All the Clouds’ll Roll Away)>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7be42dcb-bbbb-3e7a-aa8c-d9412283a7e1'
);


-- None 자장가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '자장가', 'Lullaby', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '자장가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '779a0bc1-7710-4056-a27d-b7cfc45d69ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '779a0bc1-7710-4056-a27d-b7cfc45d69ba'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '자장가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '779a0bc1-7710-4056-a27d-b7cfc45d69ba'
);


-- None 뮤지컬 <My One and Only>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '뮤지컬 <My One and Only>', 'My One and Only', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '뮤지컬 <My One and Only>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ed91d74-00b1-4b4a-a633-9ca47bdab508'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ed91d74-00b1-4b4a-a633-9ca47bdab508'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ed91d74-00b1-4b4a-a633-9ca47bdab508'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b49cbb-a0d0-41e5-8617-f0ed79d13364', 1, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b49cbb-a0d0-41e5-8617-f0ed79d13364'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7e9ee5-9e1f-3274-83c5-325c148f6f89', 2, NULL, 'I Can’t Be Bothered Now', 'I Can’t Be Bothered Now', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7e9ee5-9e1f-3274-83c5-325c148f6f89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f2a726b-c04a-4858-89a5-4f2e856f6712', 3, NULL, 'Blah, Blah, Blah', 'Blah, Blah, Blah', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f2a726b-c04a-4858-89a5-4f2e856f6712'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e7f4207-361b-42c4-a240-a58cf5bc70ec', 4, NULL, 'Boy Wanted', 'Boy Wanted', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e7f4207-361b-42c4-a240-a58cf5bc70ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddf678a6-a75f-3235-bf12-702c61180860', 5, NULL, 'Soon', 'Soon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddf678a6-a75f-3235-bf12-702c61180860'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90b4f7fd-86a5-35b9-bf5d-b529b9480534', 6, NULL, 'Sweet and Low Down', 'Sweet and Low Down', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90b4f7fd-86a5-35b9-bf5d-b529b9480534'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:361a6a8a-f01a-3778-81f0-498a851b71b5', 7, NULL, 'He Loves and She Loves', 'He Loves and She Loves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:361a6a8a-f01a-3778-81f0-498a851b71b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f583f1d2-a199-3c7b-b8bd-6a61b1d3e0cb', 8, NULL, '’S Wonderful', '’S Wonderful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f583f1d2-a199-3c7b-b8bd-6a61b1d3e0cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e681e229-56be-3c54-9c8d-884ddce93cd6', 9, NULL, 'Strike Up the Band', 'Strike Up the Band', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e681e229-56be-3c54-9c8d-884ddce93cd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b427c2e-0b63-4fb7-84eb-442f422a2328', 10, NULL, 'Entr''acte', 'Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b427c2e-0b63-4fb7-84eb-442f422a2328'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5132b02-ba0f-4763-9784-a9c4b94e32c4', 11, NULL, 'In the Swim', 'In the Swim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5132b02-ba0f-4763-9784-a9c4b94e32c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f357f974-037d-342a-b514-62c72a45c76a', 12, NULL, 'Nice Work If You Can Get It', 'Nice Work If You Can Get It', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f357f974-037d-342a-b514-62c72a45c76a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e381912-32cd-3373-820b-5c5c245998ae', 13, NULL, 'My One and Only', 'My One and Only', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e381912-32cd-3373-820b-5c5c245998ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03eca442-d95e-3ff1-8835-545343c2bff0', 14, NULL, 'Funny Face', 'Funny Face', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03eca442-d95e-3ff1-8835-545343c2bff0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dec2fc3-a4c8-3002-aeec-f7670c5cb0a8', 15, NULL, 'Kickin’ the Clouds Away', 'Kickin’ the Clouds Away', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dec2fc3-a4c8-3002-aeec-f7670c5cb0a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bf20a2a-53fd-3ae0-9a2d-749128be0ad2', 16, NULL, 'How Long Has This Been Going On?', 'How Long Has This Been Going On?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <My One and Only>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bf20a2a-53fd-3ae0-9a2d-749128be0ad2'
);


-- None 영화음악 <New York Rhapsody>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <New York Rhapsody>', 'New York Rhapsody', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <New York Rhapsody>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4ace5c9-c0b0-46a5-82ce-7b1311056b98'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd4ace5c9-c0b0-46a5-82ce-7b1311056b98'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <New York Rhapsody>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4ace5c9-c0b0-46a5-82ce-7b1311056b98'
);


-- None 가곡 <Nobody but You>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Nobody but You>', 'Nobody but You', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Nobody but You>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c4edafb-b034-3249-8cd3-fca774ffeb30'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c4edafb-b034-3249-8cd3-fca774ffeb30'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Nobody but You>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c4edafb-b034-3249-8cd3-fca774ffeb30'
);


-- None Novelette in Fourths

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Novelette in Fourths', 'Novelette in Fourths', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Novelette in Fourths'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7eca38d1-4dd3-37e8-a9be-ce325294e347'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7eca38d1-4dd3-37e8-a9be-ce325294e347'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = 'Novelette in Fourths' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7eca38d1-4dd3-37e8-a9be-ce325294e347'
);


-- None 뮤지컬 <Of Thee I Sing>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '뮤지컬 <Of Thee I Sing>', 'Of Thee I Sing', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '뮤지컬 <Of Thee I Sing>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '426e498c-d7a3-47ec-ab79-a66877f6ea98'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '426e498c-d7a3-47ec-ab79-a66877f6ea98'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '426e498c-d7a3-47ec-ab79-a66877f6ea98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40516756-e016-4238-bb09-eb6ca89fe748', 1, NULL, 'Overture', 'Of Thee I Sing: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40516756-e016-4238-bb09-eb6ca89fe748'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865', 2, NULL, 'Act II', 'Of Thee I Sing: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1de60aae-bebf-4ba2-ae35-ba8da69dc941', 1, NULL, 'Hello, Good Morning', 'Hello, Good Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1de60aae-bebf-4ba2-ae35-ba8da69dc941'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d7e246b-857c-4832-b09e-f6aa1e0a801d', 2, NULL, 'Garçon, S''il Vous Plaît', 'Garçon, S''il Vous Plaît', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d7e246b-857c-4832-b09e-f6aa1e0a801d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8874f1a7-0643-4897-96f7-7521977a5972', 3, NULL, 'The Illegitimate Daughter', 'The Illegitimate Daughter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8874f1a7-0643-4897-96f7-7521977a5972'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a20588d0-d147-4070-a087-7dcf66121203', 4, NULL, 'We''ll Impeach Him', 'We''ll Impeach Him', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a20588d0-d147-4070-a087-7dcf66121203'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1aace34f-e31f-4b28-9274-ffa08e6b033d', 5, NULL, 'Who Cares? (Reprise)', 'Who Cares? (Reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aace34f-e31f-4b28-9274-ffa08e6b033d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49419737-699e-48b7-83ee-06c42cb468d4', 6, NULL, 'The (Senatorial) Roll Call', 'The (Senatorial) Roll Call', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49419737-699e-48b7-83ee-06c42cb468d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7853d42-6a93-4051-bd07-fb1e6a9252ba', 7, NULL, 'Jilted', 'Jilted', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7853d42-6a93-4051-bd07-fb1e6a9252ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aaa175b6-6fa6-4664-bfb2-8ee1105f438c', 8, NULL, 'Who Could Ask for Anything More?', 'Who Could Ask for Anything More?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa175b6-6fa6-4664-bfb2-8ee1105f438c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e6d8d61-775d-4857-b15d-eb4b3d949d62', 9, NULL, 'Posterity', 'Posterity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e6d8d61-775d-4857-b15d-eb4b3d949d62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71b83e3d-ece4-4402-9347-11c3a3eaa2e9', 10, NULL, 'Trumpeter, Blow Your Horn', 'Trumpeter, Blow Your Horn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71b83e3d-ece4-4402-9347-11c3a3eaa2e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:611d7931-fb1a-4dc5-8b9a-1f39bdff2e3b', 11, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:611d7931-fb1a-4dc5-8b9a-1f39bdff2e3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d89a0ad0-9b56-37fd-8a76-724a99998493', 12, NULL, 'Who Cares?', 'Who Cares?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49a54d6c-a2fc-49eb-820b-f586bf686865'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d89a0ad0-9b56-37fd-8a76-724a99998493'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5df0c5ee-1ca0-4500-b4b6-cf06d549c2ec', 3, NULL, 'Love Is Sweeping the Country', 'Love Is Sweeping the Country', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5df0c5ee-1ca0-4500-b4b6-cf06d549c2ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b', 4, NULL, 'Act I', 'Of Thee I Sing: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a12b59e2-6d00-48fa-9cd2-7ca06c9c95fe', 1, NULL, 'Who is the Lucky Girl to Be?', 'Who is the Lucky Girl to Be?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a12b59e2-6d00-48fa-9cd2-7ca06c9c95fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:66d3b053-2911-498a-ad52-d9a0839aa108', 2, NULL, 'The Dimple on My Knee', 'The Dimple on My Knee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66d3b053-2911-498a-ad52-d9a0839aa108'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8509518b-cfd0-43fc-946d-8fc0d518a786', 3, NULL, 'Because, Because', 'Because, Because', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8509518b-cfd0-43fc-946d-8fc0d518a786'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67258f64-7eda-4deb-9d8c-db5d5193dd14', 4, NULL, 'As the Chairman of the Committee', 'As the Chairman of the Committee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67258f64-7eda-4deb-9d8c-db5d5193dd14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca2f1d51-b767-4cec-a60b-a4082aab9642', 5, NULL, 'How Beautiful', 'How Beautiful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca2f1d51-b767-4cec-a60b-a4082aab9642'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d03fe5a1-314e-4750-ace0-67fc0e2db9b1', 6, NULL, 'Never Was There a Girl So Fair', 'Never Was There a Girl So Fair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d03fe5a1-314e-4750-ace0-67fc0e2db9b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8775475-557f-4617-8c85-5446b859f5e7', 7, NULL, 'Some Girls Can Bake a Pie', 'Some Girls Can Bake a Pie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8775475-557f-4617-8c85-5446b859f5e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22fd6211-ee18-4781-b195-fafb0da24765', 8, NULL, 'Love is Sweeping the Country', 'Love is Sweeping the Country', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22fd6211-ee18-4781-b195-fafb0da24765'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e94b0b0a-f366-48ac-8327-60e0c4b61526', 9, NULL, 'Here''s a Kiss for Cinderella', 'Here''s a Kiss for Cinderella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e94b0b0a-f366-48ac-8327-60e0c4b61526'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bcdedaec-a12e-4adb-9d1c-0a0ee88cd493', 10, NULL, 'I Was the Most Beautiful Blossom', 'I Was the Most Beautiful Blossom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcdedaec-a12e-4adb-9d1c-0a0ee88cd493'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f4c48fe-b4d1-4dae-911d-f33796419598', 11, NULL, 'Some Girls Can Bake a Pie (Reprise)', 'Some Girls Can Bake a Pie (Reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f4c48fe-b4d1-4dae-911d-f33796419598'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5cacd167-4a3d-4e9f-a5e5-ad8b04b304cf', 12, NULL, 'Wintergreen for President', 'Wintergreen for President', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cacd167-4a3d-4e9f-a5e5-ad8b04b304cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa5f0ddb-a7dc-4c49-ba63-5edc87f63d7a', 13, NULL, 'Of Thee I Sing', 'Of Thee I Sing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:886e7751-f171-4bd9-a100-3ef300fc919b'
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Of Thee I Sing>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa5f0ddb-a7dc-4c49-ba63-5edc87f63d7a'
);


-- None 뮤지컬 <Oh, Kay!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '뮤지컬 <Oh, Kay!>', 'Oh, Kay!', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '뮤지컬 <Oh, Kay!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '671d2d49-9b65-4fca-a487-be1664af188a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '671d2d49-9b65-4fca-a487-be1664af188a'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Oh, Kay!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '671d2d49-9b65-4fca-a487-be1664af188a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dfc4ebb-df57-3e21-bc30-d7ab5471ccbb', 1, NULL, 'Do, Do, Do', 'Do, Do, Do', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Oh, Kay!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dfc4ebb-df57-3e21-bc30-d7ab5471ccbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29725e55-cc34-35fe-8cbb-786dbd94c248', 2, NULL, 'Maybe', 'Maybe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Oh, Kay!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29725e55-cc34-35fe-8cbb-786dbd94c248'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ea7fd4e-648d-3698-917c-10eb0b328ba1', 3, NULL, 'Someone to Watch Over Me', 'Someone to Watch Over Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Oh, Kay!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ea7fd4e-648d-3698-917c-10eb0b328ba1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d437c7f-86be-3aa5-913e-80c4b0e84d40', 4, NULL, 'Fidgety Feet', 'Fidgety Feet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Oh, Kay!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d437c7f-86be-3aa5-913e-80c4b0e84d40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:839b03b4-5203-3d6b-810e-1db17d6aa37e', 5, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Oh, Kay!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:839b03b4-5203-3d6b-810e-1db17d6aa37e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3997993-eb1f-343f-8f06-d92a7ca93b9c', 6, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Oh, Kay!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3997993-eb1f-343f-8f06-d92a7ca93b9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0585f1d-7dfd-3793-8ea2-57c47d4f1a77', 7, NULL, 'Oh, Kay!', 'Oh, Kay!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Oh, Kay!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0585f1d-7dfd-3793-8ea2-57c47d4f1a77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f11efe95-0e42-38f7-8cf5-aa1df80d9ba8', 8, NULL, 'Clap Yo’ Hands', 'Clap Yo’ Hands', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Oh, Kay!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f11efe95-0e42-38f7-8cf5-aa1df80d9ba8'
);


-- None Rialto Ripples

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Rialto Ripples', 'Rialto Ripples', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Rialto Ripples'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c425a33a-a880-35ca-9d12-e211f3005866'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c425a33a-a880-35ca-9d12-e211f3005866'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = 'Rialto Ripples' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c425a33a-a880-35ca-9d12-e211f3005866'
);


-- None 가곡 <SUMMERTIME>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <SUMMERTIME>', 'SUMMERTIME', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <SUMMERTIME>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78a4cb44-cf5e-4d78-ad2e-35eaa05676b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '78a4cb44-cf5e-4d78-ad2e-35eaa05676b3'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <SUMMERTIME>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78a4cb44-cf5e-4d78-ad2e-35eaa05676b3'
);


-- None 영화음악 <Shall We Dance>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <Shall We Dance>', 'Shall We Dance', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <Shall We Dance>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a336a759-b4fc-47e3-bc4b-c9d7a3c916f3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a336a759-b4fc-47e3-bc4b-c9d7a3c916f3'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <Shall We Dance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a336a759-b4fc-47e3-bc4b-c9d7a3c916f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:084d087b-76ae-3e5f-92f8-e4ae07f8497d', 1, NULL, 'Shall We Dance', 'Shall We Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <Shall We Dance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:084d087b-76ae-3e5f-92f8-e4ae07f8497d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d1b0e75-c179-4540-80f1-d9946c63f36e', 2, NULL, 'Dance of the Waves', 'Dance of the Waves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <Shall We Dance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d1b0e75-c179-4540-80f1-d9946c63f36e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3161bb9f-a682-46d8-8363-4fbfe1f20199', 3, NULL, 'Watch Your Step!', 'Watch Your Step!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <Shall We Dance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3161bb9f-a682-46d8-8363-4fbfe1f20199'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e986179-b7ad-30ee-887a-acd6716a374e', 4, NULL, 'Promenade', 'Promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <Shall We Dance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e986179-b7ad-30ee-887a-acd6716a374e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9876926a-8d49-3cbc-96a9-5f1f947439f5', 5, NULL, 'They All Laughed', 'They All Laughed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <Shall We Dance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9876926a-8d49-3cbc-96a9-5f1f947439f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2f9419b-b3a4-382a-8d1b-db86822c3256', 6, NULL, 'They Can’t Take That Away From Me', 'They Can’t Take That Away From Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <Shall We Dance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2f9419b-b3a4-382a-8d1b-db86822c3256'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7d0b674-2292-4ee8-8337-5b7cea471a17', 7, NULL, '(I’ve Got) Beginner’s Luck', '(I’ve Got) Beginner’s Luck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <Shall We Dance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7d0b674-2292-4ee8-8337-5b7cea471a17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de3d1583-47cd-39f0-980e-2c43aa8619b2', 8, NULL, 'Slap That Bass', 'Slap That Bass', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '영화음악 <Shall We Dance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de3d1583-47cd-39f0-980e-2c43aa8619b2'
);


-- None 가곡 <Somebody From Somewhere>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Somebody From Somewhere>', 'Somebody From Somewhere', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Somebody From Somewhere>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33113522-998b-466d-84b8-c4436d974414'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '33113522-998b-466d-84b8-c4436d974414'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Somebody From Somewhere>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33113522-998b-466d-84b8-c4436d974414'
);


-- None 가곡 <Somebody Loves Me>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Somebody Loves Me>', 'Somebody Loves Me', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Somebody Loves Me>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2744a6b7-66af-3baf-9860-3e55aca1ba26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2744a6b7-66af-3baf-9860-3e55aca1ba26'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Somebody Loves Me>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2744a6b7-66af-3baf-9860-3e55aca1ba26'
);


-- None 뮤지컬 <Strike up the Band>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '뮤지컬 <Strike up the Band>', 'Strike up the Band', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '뮤지컬 <Strike up the Band>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc035bab-c006-44ab-ba11-c5f3b2ba4f19'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc035bab-c006-44ab-ba11-c5f3b2ba4f19'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Strike up the Band>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc035bab-c006-44ab-ba11-c5f3b2ba4f19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33a8d66d-5d19-3634-9bd7-d68b396c5572', 1, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Strike up the Band>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33a8d66d-5d19-3634-9bd7-d68b396c5572'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdd9356b-f3bc-4748-935b-cebd2e39c849', 2, NULL, 'I Mean to Say', 'I Mean to Say', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Strike up the Band>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdd9356b-f3bc-4748-935b-cebd2e39c849'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddf678a6-a75f-3235-bf12-702c61180860', 3, NULL, 'Soon', 'Soon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Strike up the Band>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddf678a6-a75f-3235-bf12-702c61180860'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5504902-902d-4118-8ce8-e50a3db1bfb2', 4, NULL, 'Yankee Doodle Rhythm', 'Yankee Doodle Rhythm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Strike up the Band>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5504902-902d-4118-8ce8-e50a3db1bfb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e681e229-56be-3c54-9c8d-884ddce93cd6', 5, NULL, 'Strike Up the Band', 'Strike Up the Band', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Strike up the Band>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e681e229-56be-3c54-9c8d-884ddce93cd6'
);


-- None 가곡 <Swanee>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Swanee>', 'Swanee', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Swanee>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b3565a1-5677-3a22-8ebc-81b61682cf61'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b3565a1-5677-3a22-8ebc-81b61682cf61'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '가곡 <Swanee>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b3565a1-5677-3a22-8ebc-81b61682cf61'
);


-- None 탱고

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '탱고', 'Tango', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '탱고'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fffd6c67-3d43-30d9-ae75-f3bc0233cb32'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fffd6c67-3d43-30d9-ae75-f3bc0233cb32'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '탱고' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fffd6c67-3d43-30d9-ae75-f3bc0233cb32'
);


-- None 뮤지컬 <Tell Me More!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '뮤지컬 <Tell Me More!>', 'Tell Me More!', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '뮤지컬 <Tell Me More!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '066174ad-e492-4a63-b64e-5c75ed0d9b0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '066174ad-e492-4a63-b64e-5c75ed0d9b0f'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Tell Me More!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '066174ad-e492-4a63-b64e-5c75ed0d9b0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04924e5b-ad59-4a71-a923-4f2f4792c1be', 1, NULL, 'Tell Me More!', 'Tell Me More!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Tell Me More!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04924e5b-ad59-4a71-a923-4f2f4792c1be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15b5cb94-0403-4f29-94d3-99a5aefa9ea3', 2, NULL, 'My Fair Lady', 'My Fair Lady', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Tell Me More!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15b5cb94-0403-4f29-94d3-99a5aefa9ea3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:371722f0-14c3-4100-87d3-b5ccfebb5889', 3, NULL, 'Why Do I Love You', 'Why Do I Love You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Tell Me More!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:371722f0-14c3-4100-87d3-b5ccfebb5889'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dec2fc3-a4c8-3002-aeec-f7670c5cb0a8', 4, NULL, 'Kickin’ the Clouds Away', 'Kickin’ the Clouds Away', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '뮤지컬 <Tell Me More!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dec2fc3-a4c8-3002-aeec-f7670c5cb0a8'
);


-- None 3개의 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 전주곡', 'Three Preludes', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 86
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '013d4aad-70a5-4822-985d-ff41c6656417'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '013d4aad-70a5-4822-985d-ff41c6656417'
FROM pieces p
WHERE p.composer_id = 86 AND p.title = '3개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '013d4aad-70a5-4822-985d-ff41c6656417'
);


-- 카탈로그에 대응이 없는 seed 작품 98개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 86 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    524, 561, 579, 587, 590, 652, 655, 763, 784, 833, 942, 969, 988, 998, 1003, 1044, 1053, 1083, 1131, 1149,
    1168, 1170, 1213, 1215, 1218, 1336, 1383, 1401, 1469, 1472, 1498, 1510, 1530, 1534, 1535, 1548, 1625, 1682, 1686, 1693,
    1705, 1716, 1740, 1741, 1758, 1759, 1773, 1791, 1798, 1852, 1867, 1873, 1875, 1895, 1997, 2018, 2033, 2063, 2073, 2106,
    2119, 2127, 2166, 2170, 2200, 2209, 2234, 2261, 2277, 2291, 2316, 2539, 2540, 2617, 2632, 2641, 2660, 2667, 2698, 2702,
    2707, 2727, 2744, 2745, 2749, 2768, 2791, 2820, 2843, 2886, 2905, 2915, 2931, 2949, 2952, 2968, 3015, 7625
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
