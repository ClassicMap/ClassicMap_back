-- Éric Tanguy 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 24개(묶음 2, 다악장 4, 낱곡 18),
-- 새 작품 2개, part 16개, 그 아래 0개.
-- seed 22개 중 22개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None 카프리치오

UPDATE pieces piece
SET piece.title = '카프리치오', piece.title_en = 'Capriccio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18329 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Descendues des étoiles

UPDATE pieces piece
SET piece.title = 'Descendues des étoiles', piece.title_en = 'Descendues des étoiles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19535 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deux Études

UPDATE pieces piece
SET piece.title = 'Deux Études', piece.title_en = 'Deux Études',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18431 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Deux Études: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18431 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:9a373848-c2c0-480a-99dd-1fab5f6b2a65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a373848-c2c0-480a-99dd-1fab5f6b2a65', 1, NULL, 'No. 1', 'Deux Études: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18431 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a373848-c2c0-480a-99dd-1fab5f6b2a65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Deux Études: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18431 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:f30efa82-4df1-4482-b7d2-1f41efb884fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f30efa82-4df1-4482-b7d2-1f41efb884fc', 2, NULL, 'No. 2', 'Deux Études: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18431 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f30efa82-4df1-4482-b7d2-1f41efb884fc'
);


-- None Further

UPDATE pieces piece
SET piece.title = 'Further', piece.title_en = 'Further',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16147 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In a Dream, pour violon et piano

UPDATE pieces piece
SET piece.title = 'In a Dream, pour violon et piano', piece.title_en = 'In a Dream, pour violon et piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19059 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lacrymosa, pour clarinette et piano

UPDATE pieces piece
SET piece.title = 'Lacrymosa, pour clarinette et piano', piece.title_en = 'Lacrymosa, pour clarinette et piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16025 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musique pour Ming

UPDATE pieces piece
SET piece.title = 'Musique pour Ming', piece.title_en = 'Musique pour Ming',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16436 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mélancolie

UPDATE pieces piece
SET piece.title = 'Mélancolie', piece.title_en = 'Mélancolie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19689 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nachtmusik, pour piano seul

UPDATE pieces piece
SET piece.title = 'Nachtmusik, pour piano seul', piece.title_en = 'Nachtmusik, pour piano seul',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19898 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prélude et Rondo

UPDATE pieces piece
SET piece.title = 'Prélude et Rondo', piece.title_en = 'Prélude et Rondo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18244 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prélude', part.name_en = 'Prélude et Rondo: Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18244 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:0f7a1530-f8c1-4169-b3c0-e0ed2d6474a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f7a1530-f8c1-4169-b3c0-e0ed2d6474a4', 1, NULL, 'Prélude', 'Prélude et Rondo: Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18244 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f7a1530-f8c1-4169-b3c0-e0ed2d6474a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rondo', part.name_en = 'Prélude et Rondo: Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18244 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:77a1e032-edf7-486d-a721-3af46502ebe2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77a1e032-edf7-486d-a721-3af46502ebe2', 2, NULL, 'Rondo', 'Prélude et Rondo: Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18244 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77a1e032-edf7-486d-a721-3af46502ebe2'
);


-- None Quatuor à cordes n° 2

UPDATE pieces piece
SET piece.title = 'Quatuor à cordes n° 2', piece.title_en = 'Quatuor à cordes n° 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16791 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Animé', part.name_en = 'Quatuor à cordes n° 2: I. Animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16791 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:adeb20d0-fa14-4d4a-93aa-98e8c9969b31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adeb20d0-fa14-4d4a-93aa-98e8c9969b31', 1, 'I', 'Animé', 'Quatuor à cordes n° 2: I. Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16791 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adeb20d0-fa14-4d4a-93aa-98e8c9969b31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Très lent', part.name_en = 'Quatuor à cordes n° 2: II. Très lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16791 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:a41b8615-2fcb-41e2-922f-45773cf6f303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a41b8615-2fcb-41e2-922f-45773cf6f303', 2, 'II', 'Très lent', 'Quatuor à cordes n° 2: II. Très lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16791 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a41b8615-2fcb-41e2-922f-45773cf6f303'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Très vif', part.name_en = 'Quatuor à cordes n° 2: III. Très vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16791 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:8cdb0c1f-70fa-4df3-acb4-1b2f65b5769d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cdb0c1f-70fa-4df3-acb4-1b2f65b5769d', 3, 'III', 'Très vif', 'Quatuor à cordes n° 2: III. Très vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16791 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cdb0c1f-70fa-4df3-acb4-1b2f65b5769d'
);


-- None Quintette pour piano et quatuor à cordes

UPDATE pieces piece
SET piece.title = 'Quintette pour piano et quatuor à cordes', piece.title_en = 'Quintette pour piano et quatuor à cordes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16143 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rhapsodie pour alto et piano

UPDATE pieces piece
SET piece.title = 'Rhapsodie pour alto et piano', piece.title_en = 'Rhapsodie pour alto et piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18813 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonata breve

UPDATE pieces piece
SET piece.title = 'Sonata breve', piece.title_en = 'Sonata breve',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16919 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lyrique', part.name_en = 'Sonata breve: I. Lyrique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16919 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:b71245b3-5c9e-4c7e-9474-4c7cdd1b037a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b71245b3-5c9e-4c7e-9474-4c7cdd1b037a', 1, 'I', 'Lyrique', 'Sonata breve: I. Lyrique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16919 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b71245b3-5c9e-4c7e-9474-4c7cdd1b037a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Etrange', part.name_en = 'Sonata breve: II. Etrange',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16919 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:5704dc08-2f0e-422e-894c-5fa83b0f744b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5704dc08-2f0e-422e-894c-5fa83b0f744b', 2, 'II', 'Etrange', 'Sonata breve: II. Etrange', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16919 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5704dc08-2f0e-422e-894c-5fa83b0f744b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vertigineux', part.name_en = 'Sonata breve: III. Vertigineux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16919 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:8b5b6f56-08fa-4712-a612-acf53ea0ac25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b5b6f56-08fa-4712-a612-acf53ea0ac25', 3, 'III', 'Vertigineux', 'Sonata breve: III. Vertigineux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16919 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b5b6f56-08fa-4712-a612-acf53ea0ac25'
);


-- None Sonate pour violon & violoncelle

UPDATE pieces piece
SET piece.title = 'Sonate pour violon & violoncelle', piece.title_en = 'Sonate pour violon & violoncelle',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17231 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Animé', part.name_en = 'Sonate pour violon & violoncelle: I. Animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17231 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:5f86fc3c-91ec-4d94-8e46-6da87aa381b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f86fc3c-91ec-4d94-8e46-6da87aa381b5', 1, 'I', 'Animé', 'Sonate pour violon & violoncelle: I. Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17231 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f86fc3c-91ec-4d94-8e46-6da87aa381b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dolce', part.name_en = 'Sonate pour violon & violoncelle: II. Dolce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17231 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:cba13763-4553-4776-9427-608f14b91c00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cba13763-4553-4776-9427-608f14b91c00', 2, 'II', 'Dolce', 'Sonate pour violon & violoncelle: II. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17231 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cba13763-4553-4776-9427-608f14b91c00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vif', part.name_en = 'Sonate pour violon & violoncelle: III. Vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17231 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:d2bd8b5e-4920-4014-96c3-d7971a7a6085' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2bd8b5e-4920-4014-96c3-d7971a7a6085', 3, 'III', 'Vif', 'Sonate pour violon & violoncelle: III. Vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17231 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2bd8b5e-4920-4014-96c3-d7971a7a6085'
);


-- None Spirales, pour violoncelle et piano

UPDATE pieces piece
SET piece.title = 'Spirales, pour violoncelle et piano', piece.title_en = 'Spirales, pour violoncelle et piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16432 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Towards

UPDATE pieces piece
SET piece.title = 'Towards', piece.title_en = 'Towards',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17846 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trio pour piano, violon et violoncelle

UPDATE pieces piece
SET piece.title = 'Trio pour piano, violon et violoncelle', piece.title_en = 'Trio pour piano, violon et violoncelle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17395 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trois esquisses

UPDATE pieces piece
SET piece.title = 'Trois esquisses', piece.title_en = 'Trois esquisses',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19302 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Intense', part.name_en = 'Trois esquisses: I. Intense',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19302 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:39ff3eb6-768a-4bab-bb3c-9954e9dce91c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39ff3eb6-768a-4bab-bb3c-9954e9dce91c', 1, 'I', 'Intense', 'Trois esquisses: I. Intense', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19302 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39ff3eb6-768a-4bab-bb3c-9954e9dce91c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Très calme', part.name_en = 'Trois esquisses: II. Très calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19302 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:87e085d8-e1f5-4bf9-80b3-516f2614f60d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87e085d8-e1f5-4bf9-80b3-516f2614f60d', 2, 'II', 'Très calme', 'Trois esquisses: II. Très calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19302 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87e085d8-e1f5-4bf9-80b3-516f2614f60d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fulgurant', part.name_en = 'Trois esquisses: III. Fulgurant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19302 AND p.composer_id = 200 AND part.part_key = 'musicbrainz:87c3020a-0269-4e92-aed9-4372add7ded4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87c3020a-0269-4e92-aed9-4372add7ded4', 3, 'III', 'Fulgurant', 'Trois esquisses: III. Fulgurant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19302 AND p.composer_id = 200
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87c3020a-0269-4e92-aed9-4372add7ded4'
);


-- None Wadi

UPDATE pieces piece
SET piece.title = 'Wadi', piece.title_en = 'Wadi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18797 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Éclipse

UPDATE pieces piece
SET piece.title = 'Éclipse', piece.title_en = 'Éclipse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17618 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Élégie pour violon

UPDATE pieces piece
SET piece.title = 'Élégie pour violon', piece.title_en = 'Élégie pour violon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19293 AND piece.composer_id = 200
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 녹턴

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴', 'Nocturne', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 200
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6eeaea31-9383-44a4-98d8-f2656be0895c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6eeaea31-9383-44a4-98d8-f2656be0895c'
FROM pieces p
WHERE p.composer_id = 200 AND p.title = '녹턴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6eeaea31-9383-44a4-98d8-f2656be0895c'
);


-- None 토카타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타', 'Toccata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 200
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '652be1e1-1bf8-415b-bd4a-0580ad372a1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '652be1e1-1bf8-415b-bd4a-0580ad372a1f'
FROM pieces p
WHERE p.composer_id = 200 AND p.title = '토카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '652be1e1-1bf8-415b-bd4a-0580ad372a1f'
);


-- 숨길 seed 작품 없음
