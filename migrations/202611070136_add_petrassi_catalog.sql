-- 고프레도 페트라시 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 23개(묶음 2, 다악장 6, 낱곡 15),
-- 새 작품 3개, part 48개, 그 아래 0개.
-- seed 21개 중 20개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.
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

-- None Canto per addormentare una bambina

UPDATE pieces piece
SET piece.title = 'Canto per addormentare una bambina', piece.title_en = 'Canto per addormentare una bambina',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23256 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 관현악 협주곡 1번

UPDATE pieces piece
SET piece.title = '관현악 협주곡 1번', piece.title_en = 'Concerto for Orchestra no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25455 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concerto for Orchestra no. 1: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25455 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:e9d7c5e8-284e-407c-9b3f-fa2fd4f3fb96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9d7c5e8-284e-407c-9b3f-fa2fd4f3fb96', 1, 'I', 'Allegro', 'Concerto for Orchestra no. 1: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25455 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9d7c5e8-284e-407c-9b3f-fa2fd4f3fb96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Concerto for Orchestra no. 1: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25455 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:9dc77952-b348-4b0f-a7a9-19b74b1a47d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dc77952-b348-4b0f-a7a9-19b74b1a47d2', 2, 'II', 'Adagio', 'Concerto for Orchestra no. 1: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25455 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dc77952-b348-4b0f-a7a9-19b74b1a47d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tempo di marcia', part.name_en = 'Concerto for Orchestra no. 1: III. Tempo di marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25455 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:57209356-5a49-49a9-94cc-872bbb40663e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57209356-5a49-49a9-94cc-872bbb40663e', 3, 'III', 'Tempo di marcia', 'Concerto for Orchestra no. 1: III. Tempo di marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25455 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57209356-5a49-49a9-94cc-872bbb40663e'
);


-- None 관현악 협주곡 2번

UPDATE pieces piece
SET piece.title = '관현악 협주곡 2번', piece.title_en = 'Concerto for Orchestra no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25808 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 관현악 협주곡 3번 "Récréation concertante"

UPDATE pieces piece
SET piece.title = '관현악 협주곡 3번 "Récréation concertante"', piece.title_en = 'Concerto for Orchestra no. 3 "Récréation concertante"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24985 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Cronaca familiare>

UPDATE pieces piece
SET piece.title = '영화음악 <Cronaca familiare>', piece.title_en = 'Cronaca familiare',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23307 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Elogio per un'ombra

UPDATE pieces piece
SET piece.title = 'Elogio per un''ombra', piece.title_en = 'Elogio per un''ombra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24484 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Flou

UPDATE pieces piece
SET piece.title = 'Flou', piece.title_en = 'Flou',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23769 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 플루트 협주곡

UPDATE pieces piece
SET piece.title = '플루트 협주곡', piece.title_en = 'Flute Concerto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23278 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <La follia di Orlando>

UPDATE pieces piece
SET piece.title = '발레 <La follia di Orlando>', piece.title_en = 'La follia di Orlando',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25740 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nonsense

UPDATE pieces piece
SET piece.title = 'Nonsense', piece.title_en = 'Nonsense',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24587 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'C''era una signorina il cui naso', part.name_en = 'Nonsense: I. C''era una signorina il cui naso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24587 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:bc19f2fa-7ec8-499b-a2e9-7d9c8e788e65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc19f2fa-7ec8-499b-a2e9-7d9c8e788e65', 1, 'I', 'C''era una signorina il cui naso', 'Nonsense: I. C''era una signorina il cui naso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24587 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc19f2fa-7ec8-499b-a2e9-7d9c8e788e65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'C''era un vecchio musicale', part.name_en = 'Nonsense: II. C''era un vecchio musicale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24587 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:9cdd7cad-fe44-4849-b910-e86c843ef57d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cdd7cad-fe44-4849-b910-e86c843ef57d', 2, 'II', 'C''era un vecchio musicale', 'Nonsense: II. C''era un vecchio musicale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24587 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cdd7cad-fe44-4849-b910-e86c843ef57d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'C''era un vecchio di Rovigo', part.name_en = 'Nonsense: III. C''era un vecchio di Rovigo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24587 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:8ff6329f-a715-4c5a-ae82-55c922a9c00f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ff6329f-a715-4c5a-ae82-55c922a9c00f', 3, 'III', 'C''era un vecchio di Rovigo', 'Nonsense: III. C''era un vecchio di Rovigo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24587 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ff6329f-a715-4c5a-ae82-55c922a9c00f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'C''era una signorina di Pozzillo', part.name_en = 'Nonsense: IV. C''era una signorina di Pozzillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24587 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:ad6bb620-2a70-4351-90a5-0aa681cf0307' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad6bb620-2a70-4351-90a5-0aa681cf0307', 4, 'IV', 'C''era una signorina di Pozzillo', 'Nonsense: IV. C''era una signorina di Pozzillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24587 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad6bb620-2a70-4351-90a5-0aa681cf0307'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'C''era una vecchia di Polla', part.name_en = 'Nonsense: V. C''era una vecchia di Polla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24587 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:412e22c2-58fa-4a2a-a576-1a8c46330c42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:412e22c2-58fa-4a2a-a576-1a8c46330c42', 5, 'V', 'C''era una vecchia di Polla', 'Nonsense: V. C''era una vecchia di Polla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24587 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:412e22c2-58fa-4a2a-a576-1a8c46330c42'
);


-- None Nunc

UPDATE pieces piece
SET piece.title = 'Nunc', piece.title_en = 'Nunc',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24456 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 파르티타

UPDATE pieces piece
SET piece.title = '파르티타', piece.title_en = 'Partita',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25215 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quarto Concerto per orchestra d’archi

UPDATE pieces piece
SET piece.title = 'Quarto Concerto per orchestra d’archi', piece.title_en = 'Quarto Concerto per orchestra d’archi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25432 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Placidamente', part.name_en = 'Quarto Concerto per orchestra d’archi: Placidamente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25432 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:161e325a-c094-4a5d-8e0b-de235162fa81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:161e325a-c094-4a5d-8e0b-de235162fa81', 1, NULL, 'Placidamente', 'Quarto Concerto per orchestra d’archi: Placidamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25432 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:161e325a-c094-4a5d-8e0b-de235162fa81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro inquieto', part.name_en = 'Quarto Concerto per orchestra d’archi: Allegro inquieto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25432 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:4faa66b9-83bb-4e20-a973-46a85ed6ec8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4faa66b9-83bb-4e20-a973-46a85ed6ec8e', 2, NULL, 'Allegro inquieto', 'Quarto Concerto per orchestra d’archi: Allegro inquieto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25432 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4faa66b9-83bb-4e20-a973-46a85ed6ec8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Molto sostenuto', part.name_en = 'Quarto Concerto per orchestra d’archi: Molto sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25432 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:83790f92-d4ef-423d-bc0f-580961f9a7a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83790f92-d4ef-423d-bc0f-580961f9a7a4', 3, NULL, 'Molto sostenuto', 'Quarto Concerto per orchestra d’archi: Molto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25432 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83790f92-d4ef-423d-bc0f-580961f9a7a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro molto', part.name_en = 'Quarto Concerto per orchestra d’archi: Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25432 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:c392e93a-b21d-4c2c-a1f0-a09e4d63a0b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c392e93a-b21d-4c2c-a1f0-a09e4d63a0b7', 4, NULL, 'Allegro molto', 'Quarto Concerto per orchestra d’archi: Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25432 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c392e93a-b21d-4c2c-a1f0-a09e4d63a0b7'
);


-- None Quinto Concerto per orchestra

UPDATE pieces piece
SET piece.title = 'Quinto Concerto per orchestra', piece.title_en = 'Quinto Concerto per orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25787 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Molto moderato – Presto', part.name_en = 'Quinto Concerto per orchestra: I. Molto moderato – Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25787 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:ccd780d4-038a-4681-ad05-17010da95edd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccd780d4-038a-4681-ad05-17010da95edd', 1, 'I', 'Molto moderato – Presto', 'Quinto Concerto per orchestra: I. Molto moderato – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25787 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccd780d4-038a-4681-ad05-17010da95edd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino tranquillo – Mosso, con vivacità – Lento e grave', part.name_en = 'Quinto Concerto per orchestra: II. Andantino tranquillo – Mosso, con vivacità – Lento e grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25787 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:03f325e4-cb01-4913-a505-1c15006bd391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03f325e4-cb01-4913-a505-1c15006bd391', 2, 'II', 'Andantino tranquillo – Mosso, con vivacità – Lento e grave', 'Quinto Concerto per orchestra: II. Andantino tranquillo – Mosso, con vivacità – Lento e grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25787 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03f325e4-cb01-4913-a505-1c15006bd391'
);


-- None Salmo IX°

UPDATE pieces piece
SET piece.title = 'Salmo IX°', piece.title_en = 'Salmo IX°',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25027 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prima parte. "Et factus est Dominus refugium pauperi"', part.name_en = 'Salmo IX°: Prima parte. "Et factus est Dominus refugium pauperi"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:0ebe6299-50f3-4d42-a438-294c5131adbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ebe6299-50f3-4d42-a438-294c5131adbe', 1, NULL, 'Prima parte. "Et factus est Dominus refugium pauperi"', 'Salmo IX°: Prima parte. "Et factus est Dominus refugium pauperi"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ebe6299-50f3-4d42-a438-294c5131adbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Seconda parte. "Exurge, Domine"', part.name_en = 'Salmo IX°: Seconda parte. "Exurge, Domine"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:14bf6a6e-5d9d-4fdc-a8b8-2a37479bc275' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14bf6a6e-5d9d-4fdc-a8b8-2a37479bc275', 2, NULL, 'Seconda parte. "Exurge, Domine"', 'Salmo IX°: Seconda parte. "Exurge, Domine"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14bf6a6e-5d9d-4fdc-a8b8-2a37479bc275'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Seconda parte. "Psallite Domino qui habitat in Sion"', part.name_en = 'Salmo IX°: Seconda parte. "Psallite Domino qui habitat in Sion"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:170bb645-2a6e-46b6-a8eb-9f294fe3e78a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:170bb645-2a6e-46b6-a8eb-9f294fe3e78a', 3, NULL, 'Seconda parte. "Psallite Domino qui habitat in Sion"', 'Salmo IX°: Seconda parte. "Psallite Domino qui habitat in Sion"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:170bb645-2a6e-46b6-a8eb-9f294fe3e78a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Prima parte. "Inimici defecerunt frameae in fine"', part.name_en = 'Salmo IX°: Prima parte. "Inimici defecerunt frameae in fine"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:24328d76-b126-47fa-8a43-e8083d66ab04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24328d76-b126-47fa-8a43-e8083d66ab04', 4, NULL, 'Prima parte. "Inimici defecerunt frameae in fine"', 'Salmo IX°: Prima parte. "Inimici defecerunt frameae in fine"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24328d76-b126-47fa-8a43-e8083d66ab04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Prima parte. "Et Dominus in aeternum permanet"', part.name_en = 'Salmo IX°: Prima parte. "Et Dominus in aeternum permanet"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:33825457-5c05-42f4-b054-3b842c80eeb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33825457-5c05-42f4-b054-3b842c80eeb5', 5, NULL, 'Prima parte. "Et Dominus in aeternum permanet"', 'Salmo IX°: Prima parte. "Et Dominus in aeternum permanet"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33825457-5c05-42f4-b054-3b842c80eeb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Prima parte. "Et sperent in te"', part.name_en = 'Salmo IX°: Prima parte. "Et sperent in te"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:3982c4f1-1451-47d9-b355-c5a7dea3bb3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3982c4f1-1451-47d9-b355-c5a7dea3bb3d', 6, NULL, 'Prima parte. "Et sperent in te"', 'Salmo IX°: Prima parte. "Et sperent in te"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3982c4f1-1451-47d9-b355-c5a7dea3bb3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Prima parte. "Increpasti gentes"', part.name_en = 'Salmo IX°: Prima parte. "Increpasti gentes"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:40e81c6d-996e-417b-b8ad-e7f42688f633' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40e81c6d-996e-417b-b8ad-e7f42688f633', 7, NULL, 'Prima parte. "Increpasti gentes"', 'Salmo IX°: Prima parte. "Increpasti gentes"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40e81c6d-996e-417b-b8ad-e7f42688f633'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Seconda parte. "Vide humilitatem mean de inimici mei"', part.name_en = 'Salmo IX°: Seconda parte. "Vide humilitatem mean de inimici mei"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:42929aad-5f01-40d5-b718-c7a02f032434' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42929aad-5f01-40d5-b718-c7a02f032434', 8, NULL, 'Seconda parte. "Vide humilitatem mean de inimici mei"', 'Salmo IX°: Seconda parte. "Vide humilitatem mean de inimici mei"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42929aad-5f01-40d5-b718-c7a02f032434'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Seconda parte. "Constitue, Domine, legislatorem super eos"', part.name_en = 'Salmo IX°: Seconda parte. "Constitue, Domine, legislatorem super eos"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:4f0fc30c-37ac-478d-a5a5-9f5a25249d0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f0fc30c-37ac-478d-a5a5-9f5a25249d0d', 9, NULL, 'Seconda parte. "Constitue, Domine, legislatorem super eos"', 'Salmo IX°: Seconda parte. "Constitue, Domine, legislatorem super eos"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f0fc30c-37ac-478d-a5a5-9f5a25249d0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Seconda parte. "Exultabo in salutari tuo"', part.name_en = 'Salmo IX°: Seconda parte. "Exultabo in salutari tuo"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:8af8554f-c415-4453-9721-cbf505227183' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8af8554f-c415-4453-9721-cbf505227183', 10, NULL, 'Seconda parte. "Exultabo in salutari tuo"', 'Salmo IX°: Seconda parte. "Exultabo in salutari tuo"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8af8554f-c415-4453-9721-cbf505227183'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Prima parte. "Confitebor ribi Domine"', part.name_en = 'Salmo IX°: Prima parte. "Confitebor ribi Domine"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:a286a7b5-85f3-45fb-9041-20e4bf3bce12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a286a7b5-85f3-45fb-9041-20e4bf3bce12', 11, NULL, 'Prima parte. "Confitebor ribi Domine"', 'Salmo IX°: Prima parte. "Confitebor ribi Domine"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a286a7b5-85f3-45fb-9041-20e4bf3bce12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Prima parte. "Et civitates eorum dextruxisti"', part.name_en = 'Salmo IX°: Prima parte. "Et civitates eorum dextruxisti"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:a7159274-deab-4cc7-ae31-730033134f91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7159274-deab-4cc7-ae31-730033134f91', 12, NULL, 'Prima parte. "Et civitates eorum dextruxisti"', 'Salmo IX°: Prima parte. "Et civitates eorum dextruxisti"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7159274-deab-4cc7-ae31-730033134f91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Seconda parte. "Cognoscetur Dominus judicia faciens"', part.name_en = 'Salmo IX°: Seconda parte. "Cognoscetur Dominus judicia faciens"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:cbbbd684-a115-43fa-b3e7-00f1169185da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbbbd684-a115-43fa-b3e7-00f1169185da', 13, NULL, 'Seconda parte. "Cognoscetur Dominus judicia faciens"', 'Salmo IX°: Seconda parte. "Cognoscetur Dominus judicia faciens"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbbbd684-a115-43fa-b3e7-00f1169185da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Seconda parte. "Quoniam non in finem oblivio"', part.name_en = 'Salmo IX°: Seconda parte. "Quoniam non in finem oblivio"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:dd8b4214-3054-47d3-99a0-60fcf9604494' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd8b4214-3054-47d3-99a0-60fcf9604494', 14, NULL, 'Seconda parte. "Quoniam non in finem oblivio"', 'Salmo IX°: Seconda parte. "Quoniam non in finem oblivio"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd8b4214-3054-47d3-99a0-60fcf9604494'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Prima parte. "Quoniam fecisti judicium meum"', part.name_en = 'Salmo IX°: Prima parte. "Quoniam fecisti judicium meum"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25027 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:eefc6329-c9f1-4e96-9888-a58c1fa06d08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eefc6329-c9f1-4e96-9888-a58c1fa06d08', 15, NULL, 'Prima parte. "Quoniam fecisti judicium meum"', 'Salmo IX°: Prima parte. "Quoniam fecisti judicium meum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25027 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eefc6329-c9f1-4e96-9888-a58c1fa06d08'
);


-- None Salmo IX°: Seconda parte. "Convertantur peccatores in infernum". Accelerando molto -

UPDATE pieces piece
SET piece.title = 'Salmo IX°: Seconda parte. "Convertantur peccatores in infernum". Accelerando molto -', piece.title_en = 'Salmo IX°: Seconda parte. "Convertantur peccatores in infernum". Accelerando molto -',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24553 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sesto concerto per orchestra "Invenzione concertata"

UPDATE pieces piece
SET piece.title = 'Sesto concerto per orchestra "Invenzione concertata"', piece.title_en = 'Sesto concerto per orchestra "Invenzione concertata"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25786 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mosso (Inquieto)', part.name_en = 'Sesto concerto per orchestra "Invenzione concertata": I. Mosso (Inquieto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25786 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:0898cba5-04df-4c95-bde2-5e10e14e3144' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0898cba5-04df-4c95-bde2-5e10e14e3144', 1, 'I', 'Mosso (Inquieto)', 'Sesto concerto per orchestra "Invenzione concertata": I. Mosso (Inquieto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25786 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0898cba5-04df-4c95-bde2-5e10e14e3144'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio sostenuto', part.name_en = 'Sesto concerto per orchestra "Invenzione concertata": II. Adagio sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25786 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:ca81120e-7262-4e9a-886e-98ad91fab0e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca81120e-7262-4e9a-886e-98ad91fab0e1', 2, 'II', 'Adagio sostenuto', 'Sesto concerto per orchestra "Invenzione concertata": II. Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25786 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca81120e-7262-4e9a-886e-98ad91fab0e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tempo (Liberamente)', part.name_en = 'Sesto concerto per orchestra "Invenzione concertata": III. Tempo (Liberamente)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25786 AND p.composer_id = 468 AND part.part_key = 'musicbrainz:b094ea95-dd70-47a3-9d64-6ad3c0034527' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b094ea95-dd70-47a3-9d64-6ad3c0034527', 3, 'III', 'Tempo (Liberamente)', 'Sesto concerto per orchestra "Invenzione concertata": III. Tempo (Liberamente)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25786 AND p.composer_id = 468
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b094ea95-dd70-47a3-9d64-6ad3c0034527'
);


-- None Souffle

UPDATE pieces piece
SET piece.title = 'Souffle', piece.title_en = 'Souffle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24242 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Suoni notturni

UPDATE pieces piece
SET piece.title = 'Suoni notturni', piece.title_en = 'Suoni notturni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24857 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Violasola

UPDATE pieces piece
SET piece.title = 'Violasola', piece.title_en = 'Violasola',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25459 AND piece.composer_id = 468
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 마니피카트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마니피카트', 'Magnificat', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 468
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마니피카트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd21243f7-6b67-4d38-a5b2-45572968ee5a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd21243f7-6b67-4d38-a5b2-45572968ee5a'
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd21243f7-6b67-4d38-a5b2-45572968ee5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee8a1fd-c9c3-4311-8724-292cd7fbfc61', 1, NULL, '"Suscepit Israel puerum suum"', 'Magnificat: "Suscepit Israel puerum suum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee8a1fd-c9c3-4311-8724-292cd7fbfc61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f2312fe-53e3-4ffb-a7a9-e5caec885e7b', 2, NULL, '"Magnificat: anima mea Dominum"', 'Magnificat: "Magnificat: anima mea Dominum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f2312fe-53e3-4ffb-a7a9-e5caec885e7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16b72560-e796-4f38-bbf0-5a36fef92de2', 3, NULL, '"Et misericordia ejus"', 'Magnificat: "Et misericordia ejus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16b72560-e796-4f38-bbf0-5a36fef92de2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:260c4f32-7418-4804-b0ba-730f1cce5828', 4, NULL, '"Quia fecit mihi magna"', 'Magnificat: "Quia fecit mihi magna"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:260c4f32-7418-4804-b0ba-730f1cce5828'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3794687d-f069-47fb-8418-942ab53cc257', 5, NULL, '"Et sanctum nomen ejus"', 'Magnificat: "Et sanctum nomen ejus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3794687d-f069-47fb-8418-942ab53cc257'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63d4ebd2-be30-4877-a039-353634d90f3c', 6, NULL, '"Et exultavit spiritus meus"', 'Magnificat: "Et exultavit spiritus meus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63d4ebd2-be30-4877-a039-353634d90f3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b0cde88-17d5-46e5-8289-3d22039e98b0', 7, NULL, '"Deposuit potentes de sede"', 'Magnificat: "Deposuit potentes de sede"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b0cde88-17d5-46e5-8289-3d22039e98b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a288af1b-97fc-4e9d-8d68-7e43b1888bf6', 8, NULL, '"In Deo salutari meo"', 'Magnificat: "In Deo salutari meo"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a288af1b-97fc-4e9d-8d68-7e43b1888bf6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a415cdd7-c4c3-4bdf-8d25-16dbdfa5a340', 9, NULL, '"Esurientes inplevit bonis"', 'Magnificat: "Esurientes inplevit bonis"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a415cdd7-c4c3-4bdf-8d25-16dbdfa5a340'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5f6c7d8-6dcb-4223-a5da-8609f7567acd', 10, NULL, '"Quia respexit humilitatem ancillae suae"', 'Magnificat: "Quia respexit humilitatem ancillae suae"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5f6c7d8-6dcb-4223-a5da-8609f7567acd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be789589-57b5-477c-850e-ef9721ddee90', 11, NULL, '"Fecit potentiam in brachio suo"', 'Magnificat: "Fecit potentiam in brachio suo"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be789589-57b5-477c-850e-ef9721ddee90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caa3ef51-f2f0-4da8-9282-900cf5cdc093', 12, NULL, '"Sicut locutus est ad patres nostros"', 'Magnificat: "Sicut locutus est ad patres nostros"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caa3ef51-f2f0-4da8-9282-900cf5cdc093'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f14afd53-2bd3-4a63-b0f4-5f9de0483c54', 13, NULL, '"Gloria Patri, et Filio"', 'Magnificat: "Gloria Patri, et Filio"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f14afd53-2bd3-4a63-b0f4-5f9de0483c54'
);


-- None 피아노 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡', 'Piano Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 468
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ae5024e-ed20-4e5a-aff3-fe8a6d96922b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ae5024e-ed20-4e5a-aff3-fe8a6d96922b'
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ae5024e-ed20-4e5a-aff3-fe8a6d96922b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83fb42cc-5b4c-4fde-9563-9f6c7efd1717', 1, 'I', 'Non molto mosso, ma energico', 'Piano Concerto: I. Non molto mosso, ma energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83fb42cc-5b4c-4fde-9563-9f6c7efd1717'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a661d6f-5771-4a0e-9608-93f63f43d4c0', 2, 'II', 'Arietta con variazioni: Molto adagio e tranquillo', 'Piano Concerto: II. Arietta con variazioni: Molto adagio e tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a661d6f-5771-4a0e-9608-93f63f43d4c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e08c5f5-becc-4a60-8dab-cb791d01bf90', 3, 'III', 'Rondo: Andantino mosso - Allegro agitato', 'Piano Concerto: III. Rondo: Andantino mosso - Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e08c5f5-becc-4a60-8dab-cb791d01bf90'
);


-- None 토카타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타', 'Toccata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 468
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a898d0f8-25bc-4e16-8d76-ca1b04974328'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a898d0f8-25bc-4e16-8d76-ca1b04974328'
FROM pieces p
WHERE p.composer_id = 468 AND p.title = '토카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a898d0f8-25bc-4e16-8d76-ca1b04974328'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 468 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25439
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
