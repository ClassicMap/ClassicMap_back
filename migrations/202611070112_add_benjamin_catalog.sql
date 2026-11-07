-- 아서 벤저민 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 39개(묶음 5, 다악장 7, 낱곡 27),
-- 새 작품 6개, part 43개, 그 아래 0개.
-- seed 41개 중 33개를 작품·part 에 잇고, 2개를 숨기고, 6개는 그대로 둔다.
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

-- None A Tune and Variations for Little People

UPDATE pieces piece
SET piece.title = 'A Tune and Variations for Little People', piece.title_en = 'A Tune and Variations for Little People',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17530 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Before Dawn>

UPDATE pieces piece
SET piece.title = '가곡 <Before Dawn>', piece.title_en = 'Before Dawn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16385 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto for Harmonica

UPDATE pieces piece
SET piece.title = 'Concerto for Harmonica', piece.title_en = 'Concerto for Harmonica',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19376 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오보에 협주곡 C단조

UPDATE pieces piece
SET piece.title = '오보에 협주곡 C단조', piece.title_en = 'Concerto for Oboe in C minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19954 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cotillon

UPDATE pieces piece
SET piece.title = 'Cotillon', piece.title_en = 'Cotillon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19224 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Diaphenia>

UPDATE pieces piece
SET piece.title = '가곡 <Diaphenia>', piece.title_en = 'Diaphenia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19788 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Elegiac Mazurka

UPDATE pieces piece
SET piece.title = 'Elegiac Mazurka', piece.title_en = 'Elegiac Mazurka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16668 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 환상곡

UPDATE pieces piece
SET piece.title = '환상곡', piece.title_en = 'Fantasies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19621 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Book I: Soldiers in the Distance', part.name_en = 'Fantasies: Book I: Soldiers in the Distance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19621 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:0c7a25ec-7587-425c-b827-8431e6f9b234' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c7a25ec-7587-425c-b827-8431e6f9b234', 1, NULL, 'Book I: Soldiers in the Distance', 'Fantasies: Book I: Soldiers in the Distance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19621 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c7a25ec-7587-425c-b827-8431e6f9b234'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Book I: A Song With a Sad Ending', part.name_en = 'Fantasies: Book I: A Song With a Sad Ending',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19621 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:43e8a3fc-952a-46b5-b503-1ce635662cde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43e8a3fc-952a-46b5-b503-1ce635662cde', 2, NULL, 'Book I: A Song With a Sad Ending', 'Fantasies: Book I: A Song With a Sad Ending', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19621 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43e8a3fc-952a-46b5-b503-1ce635662cde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Book II: Waltz', part.name_en = 'Fantasies: Book II: Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19621 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:5f1af198-940b-4939-b545-9e7a44877c99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f1af198-940b-4939-b545-9e7a44877c99', 3, NULL, 'Book II: Waltz', 'Fantasies: Book II: Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19621 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f1af198-940b-4939-b545-9e7a44877c99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Book II: A Gay Study', part.name_en = 'Fantasies: Book II: A Gay Study',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19621 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:802f6f9e-b324-41e2-adb8-c9bca44993e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:802f6f9e-b324-41e2-adb8-c9bca44993e3', 4, NULL, 'Book II: A Gay Study', 'Fantasies: Book II: A Gay Study', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19621 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:802f6f9e-b324-41e2-adb8-c9bca44993e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Book I: A Cloudlet - Like a Swan It Sailed', part.name_en = 'Fantasies: Book I: A Cloudlet - Like a Swan It Sailed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19621 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:9b703494-c108-4e5e-b09e-398abe08dd14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b703494-c108-4e5e-b09e-398abe08dd14', 5, NULL, 'Book I: A Cloudlet - Like a Swan It Sailed', 'Fantasies: Book I: A Cloudlet - Like a Swan It Sailed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19621 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b703494-c108-4e5e-b09e-398abe08dd14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Book II: Silent and Soft and Slow Descends the Snow', part.name_en = 'Fantasies: Book II: Silent and Soft and Slow Descends the Snow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19621 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:b84bdcea-9d7c-4c1a-85a3-365e513c44a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b84bdcea-9d7c-4c1a-85a3-365e513c44a6', 6, NULL, 'Book II: Silent and Soft and Slow Descends the Snow', 'Fantasies: Book II: Silent and Soft and Slow Descends the Snow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19621 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b84bdcea-9d7c-4c1a-85a3-365e513c44a6'
);


-- None 가곡 <Hey Nonny No!>

UPDATE pieces piece
SET piece.title = '가곡 <Hey Nonny No!>', piece.title_en = 'Hey Nonny No!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19371 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Jan, a Creole Melody>

UPDATE pieces piece
SET piece.title = '가곡 <Jan, a Creole Melody>', piece.title_en = 'Jan, a Creole Melody',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17100 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le tombeau de Ravel

UPDATE pieces piece
SET piece.title = 'Le tombeau de Ravel', piece.title_en = 'Le tombeau de Ravel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16494 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Linstead Market>

UPDATE pieces piece
SET piece.title = '가곡 <Linstead Market>', piece.title_en = 'Linstead Market',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18252 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Man and Woman>

UPDATE pieces piece
SET piece.title = '가곡 <Man and Woman>', piece.title_en = 'Man and Woman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16637 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None North American Square Dance

UPDATE pieces piece
SET piece.title = 'North American Square Dance', piece.title_en = 'North American Square Dance',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18158 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction and "Miller''s Reel"', part.name_en = 'North American Square Dance: I. Introduction and "Miller''s Reel"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18158 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:16510b9c-e9d0-489c-a11f-deb787a67903' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16510b9c-e9d0-489c-a11f-deb787a67903', 1, 'I', 'Introduction and "Miller''s Reel"', 'North American Square Dance: I. Introduction and "Miller''s Reel"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18158 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16510b9c-e9d0-489c-a11f-deb787a67903'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"The Old Plunk"', part.name_en = 'North American Square Dance: II. "The Old Plunk"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18158 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:6bcf07a3-6b94-4896-b91c-24494182fb6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bcf07a3-6b94-4896-b91c-24494182fb6b', 2, 'II', '"The Old Plunk"', 'North American Square Dance: II. "The Old Plunk"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18158 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bcf07a3-6b94-4896-b91c-24494182fb6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"The Bundle of Straw"', part.name_en = 'North American Square Dance: III. "The Bundle of Straw"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18158 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:231bf8bb-2e45-4f41-a0d6-875642e45c47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:231bf8bb-2e45-4f41-a0d6-875642e45c47', 3, 'III', '"The Bundle of Straw"', 'North American Square Dance: III. "The Bundle of Straw"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18158 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:231bf8bb-2e45-4f41-a0d6-875642e45c47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"He piped so sweet"', part.name_en = 'North American Square Dance: IV. "He piped so sweet"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18158 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:a8c52a9c-82c2-4033-89f7-03cd7d1e5ae5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8c52a9c-82c2-4033-89f7-03cd7d1e5ae5', 4, 'IV', '"He piped so sweet"', 'North American Square Dance: IV. "He piped so sweet"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18158 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8c52a9c-82c2-4033-89f7-03cd7d1e5ae5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"Fill the Bowl"', part.name_en = 'North American Square Dance: V. "Fill the Bowl"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18158 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:68a84b95-eca1-42aa-964c-455ed399023a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68a84b95-eca1-42aa-964c-455ed399023a', 5, 'V', '"Fill the Bowl"', 'North American Square Dance: V. "Fill the Bowl"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18158 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68a84b95-eca1-42aa-964c-455ed399023a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '"Pigeon on the Pier"', part.name_en = 'North American Square Dance: VI. "Pigeon on the Pier"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18158 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:d8bfd992-6e17-4901-8dbf-0eb7e5c44abd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8bfd992-6e17-4901-8dbf-0eb7e5c44abd', 6, 'VI', '"Pigeon on the Pier"', 'North American Square Dance: VI. "Pigeon on the Pier"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18158 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8bfd992-6e17-4901-8dbf-0eb7e5c44abd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Calder Pair', part.name_en = 'North American Square Dance: VII. Calder Pair',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18158 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:2924c444-67c4-4c9c-9cf3-d7312fac8b62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2924c444-67c4-4c9c-9cf3-d7312fac8b62', 7, 'VII', 'Calder Pair', 'North American Square Dance: VII. Calder Pair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18158 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2924c444-67c4-4c9c-9cf3-d7312fac8b62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '"Salamanca" and Coda', part.name_en = 'North American Square Dance: VIII. "Salamanca" and Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18158 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:e7a35710-c6bd-47f6-9162-6ed67fb3a36a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7a35710-c6bd-47f6-9162-6ed67fb3a36a', 8, 'VIII', '"Salamanca" and Coda', 'North American Square Dance: VIII. "Salamanca" and Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18158 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a35710-c6bd-47f6-9162-6ed67fb3a36a'
);


-- None Overture to an Italian Comedy

UPDATE pieces piece
SET piece.title = 'Overture to an Italian Comedy', piece.title_en = 'Overture to an Italian Comedy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19673 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prelude to Holiday

UPDATE pieces piece
SET piece.title = 'Prelude to Holiday', piece.title_en = 'Prelude to Holiday',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17190 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quasi una Fantasia

UPDATE pieces piece
SET piece.title = 'Quasi una Fantasia', piece.title_en = 'Quasi una Fantasia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19489 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Romantic Fantasy for Violin, Viola, and Orchestra

UPDATE pieces piece
SET piece.title = 'Romantic Fantasy for Violin, Viola, and Orchestra', piece.title_en = 'Romantic Fantasy for Violin, Viola, and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17293 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Nocturne', part.name_en = 'Romantic Fantasy for Violin, Viola, and Orchestra: I. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17293 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:c2891aac-70dd-4e0e-b05c-a2de421bcb9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2891aac-70dd-4e0e-b05c-a2de421bcb9f', 1, 'I', 'Nocturne', 'Romantic Fantasy for Violin, Viola, and Orchestra: I. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17293 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2891aac-70dd-4e0e-b05c-a2de421bcb9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzino', part.name_en = 'Romantic Fantasy for Violin, Viola, and Orchestra: II. Scherzino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17293 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:614c079e-0cdc-4dfd-91d3-f4c063c281fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:614c079e-0cdc-4dfd-91d3-f4c063c281fe', 2, 'II', 'Scherzino', 'Romantic Fantasy for Violin, Viola, and Orchestra: II. Scherzino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17293 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:614c079e-0cdc-4dfd-91d3-f4c063c281fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sonata: Allegro, tempo giusto', part.name_en = 'Romantic Fantasy for Violin, Viola, and Orchestra: III. Sonata: Allegro, tempo giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17293 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:0865cb03-6256-4f31-8325-31a10daf6f7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0865cb03-6256-4f31-8325-31a10daf6f7d', 3, 'III', 'Sonata: Allegro, tempo giusto', 'Romantic Fantasy for Violin, Viola, and Orchestra: III. Sonata: Allegro, tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17293 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0865cb03-6256-4f31-8325-31a10daf6f7d'
);


-- None 가곡 <Shepherd's Holiday>

UPDATE pieces piece
SET piece.title = '가곡 <Shepherd''s Holiday>', piece.title_en = 'Shepherd''s Holiday',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18356 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Moon>

UPDATE pieces piece
SET piece.title = '가곡 <The Moon>', piece.title_en = 'The Moon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18720 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Mouse>

UPDATE pieces piece
SET piece.title = '가곡 <The Mouse>', piece.title_en = 'The Mouse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18207 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Piper>

UPDATE pieces piece
SET piece.title = '가곡 <The Piper>', piece.title_en = 'The Piper',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19142 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Song of the Banana Carriers>

UPDATE pieces piece
SET piece.title = '가곡 <The Song of the Banana Carriers>', piece.title_en = 'The Song of the Banana Carriers',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16159 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <The Storm Clouds Cantata from "The Man Who Knew Too Much">

UPDATE pieces piece
SET piece.title = '칸타타 <The Storm Clouds Cantata from "The Man Who Knew Too Much">', piece.title_en = 'The Storm Clouds Cantata from "The Man Who Knew Too Much"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15782 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Greek Poems

UPDATE pieces piece
SET piece.title = 'Three Greek Poems', piece.title_en = 'Three Greek Poems',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19251 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Flower Girl', part.name_en = 'Three Greek Poems: No. 1. The Flower Girl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19251 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:66ad3b22-3ac4-4b65-9b24-070570cac353' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66ad3b22-3ac4-4b65-9b24-070570cac353', 1, NULL, 'The Flower Girl', 'Three Greek Poems: No. 1. The Flower Girl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19251 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66ad3b22-3ac4-4b65-9b24-070570cac353'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'On Deck', part.name_en = 'Three Greek Poems: No. 2. On Deck',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19251 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:4385b54b-7df9-45fc-adfd-a61ecc62a63d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4385b54b-7df9-45fc-adfd-a61ecc62a63d', 2, NULL, 'On Deck', 'Three Greek Poems: No. 2. On Deck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19251 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4385b54b-7df9-45fc-adfd-a61ecc62a63d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A Wine Jug', part.name_en = 'Three Greek Poems: No. 3. A Wine Jug',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19251 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:c546e9cd-83d4-4b72-ac60-92dc28d45a05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c546e9cd-83d4-4b72-ac60-92dc28d45a05', 3, NULL, 'A Wine Jug', 'Three Greek Poems: No. 3. A Wine Jug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19251 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c546e9cd-83d4-4b72-ac60-92dc28d45a05'
);


-- None Three Impressions

UPDATE pieces piece
SET piece.title = 'Three Impressions', piece.title_en = 'Three Impressions',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19344 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hedgerow', part.name_en = 'Three Impressions: No. 1. Hedgerow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19344 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:72f06205-c000-4a53-94a9-e13201bb31ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72f06205-c000-4a53-94a9-e13201bb31ad', 1, NULL, 'Hedgerow', 'Three Impressions: No. 1. Hedgerow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19344 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72f06205-c000-4a53-94a9-e13201bb31ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Calm Sea and Mist', part.name_en = 'Three Impressions: No. 2. Calm Sea and Mist',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19344 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:ab1a9f68-2ea1-49a6-af99-e84da5502dea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab1a9f68-2ea1-49a6-af99-e84da5502dea', 2, NULL, 'Calm Sea and Mist', 'Three Impressions: No. 2. Calm Sea and Mist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19344 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab1a9f68-2ea1-49a6-af99-e84da5502dea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Wasp', part.name_en = 'Three Impressions: No. 3. The Wasp',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19344 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:d8dfd42d-a0fb-4295-87ab-738f9ddbb901' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8dfd42d-a0fb-4295-87ab-738f9ddbb901', 3, NULL, 'The Wasp', 'Three Impressions: No. 3. The Wasp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19344 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8dfd42d-a0fb-4295-87ab-738f9ddbb901'
);


-- None 3개의 바이올린과 피아노를 위한 소품

UPDATE pieces piece
SET piece.title = '3개의 바이올린과 피아노를 위한 소품', piece.title_en = 'Three Pieces for Violin and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18385 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Arabesque (The Muted Pavane)', part.name_en = 'Three Pieces for Violin and Piano: Arabesque (The Muted Pavane)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18385 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:3073d78b-b7c8-4f02-b346-db9aea7f64f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3073d78b-b7c8-4f02-b346-db9aea7f64f2', 1, NULL, 'Arabesque (The Muted Pavane)', 'Three Pieces for Violin and Piano: Arabesque (The Muted Pavane)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18385 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3073d78b-b7c8-4f02-b346-db9aea7f64f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Carnavalesque: Tempo di valse', part.name_en = 'Three Pieces for Violin and Piano: Carnavalesque: Tempo di valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18385 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:f4f015b0-7879-47ef-93b2-02a33fcabf01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4f015b0-7879-47ef-93b2-02a33fcabf01', 2, NULL, 'Carnavalesque: Tempo di valse', 'Three Pieces for Violin and Piano: Carnavalesque: Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18385 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4f015b0-7879-47ef-93b2-02a33fcabf01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Humoresque: Non troppo allegro', part.name_en = 'Three Pieces for Violin and Piano: Humoresque: Non troppo allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18385 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:db58cd32-5833-4a88-843f-4cc2a6160239' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db58cd32-5833-4a88-843f-4cc2a6160239', 3, NULL, 'Humoresque: Non troppo allegro', 'Three Pieces for Violin and Piano: Humoresque: Non troppo allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18385 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db58cd32-5833-4a88-843f-4cc2a6160239'
);


-- None 가곡 <To Phyllis, Milking Her Flock>

UPDATE pieces piece
SET piece.title = '가곡 <To Phyllis, Milking Her Flock>', piece.title_en = 'To Phyllis, Milking Her Flock',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19474 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Jamaican Pieces

UPDATE pieces piece
SET piece.title = 'Two Jamaican Pieces', piece.title_en = 'Two Jamaican Pieces',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17702 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jamaican Song', part.name_en = 'Jamaican Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17702 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:777c5f1a-d722-44ee-87c9-ca3d3cd309f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:777c5f1a-d722-44ee-87c9-ca3d3cd309f0', 1, NULL, 'Jamaican Song', 'Jamaican Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17702 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:777c5f1a-d722-44ee-87c9-ca3d3cd309f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Jamaican Rumba', part.name_en = 'Jamaican Rumba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17702 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:eae2eb81-d26f-4ca6-80c9-960dcc5e97d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eae2eb81-d26f-4ca6-80c9-960dcc5e97d3', 2, NULL, 'Jamaican Rumba', 'Jamaican Rumba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17702 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eae2eb81-d26f-4ca6-80c9-960dcc5e97d3'
);


-- None Two Jamaican Street Songs

UPDATE pieces piece
SET piece.title = 'Two Jamaican Street Songs', piece.title_en = 'Two Jamaican Street Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18229 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mattie Rag', part.name_en = 'Two Jamaican Street Songs: I. Mattie Rag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18229 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:784390ee-e03b-4b40-988a-bdddde4eb67e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:784390ee-e03b-4b40-988a-bdddde4eb67e', 1, 'I', 'Mattie Rag', 'Two Jamaican Street Songs: I. Mattie Rag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18229 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:784390ee-e03b-4b40-988a-bdddde4eb67e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Cookie', part.name_en = 'Two Jamaican Street Songs: II. Cookie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18229 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:1ecf52be-0358-4aff-b854-08658b311dd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ecf52be-0358-4aff-b854-08658b311dd2', 2, 'II', 'Cookie', 'Two Jamaican Street Songs: II. Cookie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18229 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ecf52be-0358-4aff-b854-08658b311dd2'
);


-- None 비올라 소나타

UPDATE pieces piece
SET piece.title = '비올라 소나타', piece.title_en = 'Viola Sonata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16154 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Elegy. Adagio e mesto', part.name_en = 'Viola Sonata: I. Elegy. Adagio e mesto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16154 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:41e95253-e8a9-4f0a-8f7e-67e3cbd1fc69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41e95253-e8a9-4f0a-8f7e-67e3cbd1fc69', 1, 'I', 'Elegy. Adagio e mesto', 'Viola Sonata: I. Elegy. Adagio e mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16154 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41e95253-e8a9-4f0a-8f7e-67e3cbd1fc69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Waltz. Quasi improvisatore –', part.name_en = 'Viola Sonata: II. Waltz. Quasi improvisatore –',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16154 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:90a1f73e-e930-4414-b0e1-5b31a0533b3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90a1f73e-e930-4414-b0e1-5b31a0533b3d', 2, 'II', 'Waltz. Quasi improvisatore –', 'Viola Sonata: II. Waltz. Quasi improvisatore –', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16154 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90a1f73e-e930-4414-b0e1-5b31a0533b3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Toccata. Allegro ma non troppo', part.name_en = 'Viola Sonata: III. Toccata. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16154 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:214957f5-b3de-40c7-8fed-86653640abfa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:214957f5-b3de-40c7-8fed-86653640abfa', 3, 'III', 'Toccata. Allegro ma non troppo', 'Viola Sonata: III. Toccata. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16154 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:214957f5-b3de-40c7-8fed-86653640abfa'
);


-- None 바이올린 소나티네

UPDATE pieces piece
SET piece.title = '바이올린 소나티네', piece.title_en = 'Violin Sonatina',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16396 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tranquilly Flowing', part.name_en = 'Violin Sonatina: I. Tranquilly Flowing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16396 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:1bbb4f17-476f-40b0-9da1-842c51aee79d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bbb4f17-476f-40b0-9da1-842c51aee79d', 1, 'I', 'Tranquilly Flowing', 'Violin Sonatina: I. Tranquilly Flowing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16396 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bbb4f17-476f-40b0-9da1-842c51aee79d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo di stile antico', part.name_en = 'Violin Sonatina: II. Scherzo di stile antico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16396 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:c5e69b39-e052-4277-8f06-2866885d9d12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5e69b39-e052-4277-8f06-2866885d9d12', 2, 'II', 'Scherzo di stile antico', 'Violin Sonatina: II. Scherzo di stile antico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16396 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e69b39-e052-4277-8f06-2866885d9d12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo. Con moto ma non allegro', part.name_en = 'Violin Sonatina: III. Rondo. Con moto ma non allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16396 AND p.composer_id = 323 AND part.part_key = 'musicbrainz:f391fa0a-80b2-47bf-b700-b443648906d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f391fa0a-80b2-47bf-b700-b443648906d3', 3, 'III', 'Rondo. Con moto ma non allegro', 'Violin Sonatina: III. Rondo. Con moto ma non allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16396 AND p.composer_id = 323
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f391fa0a-80b2-47bf-b700-b443648906d3'
);


-- None 가곡 <Wind's Work>

UPDATE pieces piece
SET piece.title = '가곡 <Wind''s Work>', piece.title_en = 'Wind''s Work',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18807 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 피아노 콘체르티노

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 콘체르티노', 'Concertino for Piano and Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 323
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 콘체르티노'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1328ed7-7513-4dab-a91f-a6c70aecc818'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f1328ed7-7513-4dab-a91f-a6c70aecc818'
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '피아노 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1328ed7-7513-4dab-a91f-a6c70aecc818'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:370c81dc-7c15-476d-b87a-9e72ae399dc9', 1, 'I', 'Allegro non troppo e ritmico', 'Concertino for Piano and Orchestra: I. Allegro non troppo e ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '피아노 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:370c81dc-7c15-476d-b87a-9e72ae399dc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f198fda-7ed2-4523-9837-841cfb3a5a93', 2, 'II', 'Andante poco lento', 'Concertino for Piano and Orchestra: II. Andante poco lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '피아노 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f198fda-7ed2-4523-9837-841cfb3a5a93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:922b12ef-6c83-43b5-8baf-3ed98fad546c', 3, 'III', 'Scherzo. Presto scherzando', 'Concertino for Piano and Orchestra: III. Scherzo. Presto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '피아노 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:922b12ef-6c83-43b5-8baf-3ed98fad546c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffc0d900-67be-4d0b-9353-b4b6803ca4c0', 4, 'IV', 'Come primo ma meno allegro', 'Concertino for Piano and Orchestra: IV. Come primo ma meno allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '피아노 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffc0d900-67be-4d0b-9353-b4b6803ca4c0'
);


-- None Fanfare for a Festive Occasion

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Fanfare for a Festive Occasion', 'Fanfare for a Festive Occasion', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 323
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Fanfare for a Festive Occasion'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39f0723c-bb3d-4013-a3a2-f5fe0fee05bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '39f0723c-bb3d-4013-a3a2-f5fe0fee05bc'
FROM pieces p
WHERE p.composer_id = 323 AND p.title = 'Fanfare for a Festive Occasion' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39f0723c-bb3d-4013-a3a2-f5fe0fee05bc'
);


-- None From San Domingo

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'From San Domingo', 'From San Domingo', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 323
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'From San Domingo'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '192dc33f-d668-443b-afdf-4a3411f79abc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '192dc33f-d668-443b-afdf-4a3411f79abc'
FROM pieces p
WHERE p.composer_id = 323 AND p.title = 'From San Domingo' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '192dc33f-d668-443b-afdf-4a3411f79abc'
);


-- None Jamaican Song

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Jamaican Song', 'Jamaican Song', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 323
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Jamaican Song'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b38b76c5-4d27-4a46-ad12-6ac3b992d923'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b38b76c5-4d27-4a46-ad12-6ac3b992d923'
FROM pieces p
WHERE p.composer_id = 323 AND p.title = 'Jamaican Song' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b38b76c5-4d27-4a46-ad12-6ac3b992d923'
);


-- None 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony no. 1', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 323
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae634906-6b99-43f9-8d46-522f4a227cbe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae634906-6b99-43f9-8d46-522f4a227cbe'
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae634906-6b99-43f9-8d46-522f4a227cbe'
);


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 323
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c994b410-81d7-4043-afa2-034e168b7686'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c994b410-81d7-4043-afa2-034e168b7686'
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c994b410-81d7-4043-afa2-034e168b7686'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fbdb250-3927-4087-9c34-bccb8a81dfcf', 1, 'I', 'Rhapsody', 'Violin Concerto: I. Rhapsody', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fbdb250-3927-4087-9c34-bccb8a81dfcf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dd0ebba-9964-4de0-bb13-c114f8220404', 2, 'II', 'Intermezzo', 'Violin Concerto: II. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dd0ebba-9964-4de0-bb13-c114f8220404'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:921e4d32-e80e-4463-a5c4-0f5270ebb6f9', 3, 'III', 'Rondo', 'Violin Concerto: III. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:921e4d32-e80e-4463-a5c4-0f5270ebb6f9'
);


-- 카탈로그에 대응이 없는 seed 작품 2개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 323 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16600, 20002
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
