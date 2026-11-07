-- Claudio Ambrosini 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 32개(묶음 0, 다악장 0, 낱곡 32),
-- 새 작품 4개, part 0개, 그 아래 0개.
-- seed 36개 중 28개를 작품·part 에 잇고, 0개를 숨기고, 8개는 그대로 둔다.
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

-- None "Oh, mia Euridice…" a fragment

UPDATE pieces piece
SET piece.title = '"Oh, mia Euridice…" a fragment', piece.title_en = '"Oh, mia Euridice…" a fragment',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19581 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A guisa di un arcier presto soriano

UPDATE pieces piece
SET piece.title = 'A guisa di un arcier presto soriano', piece.title_en = 'A guisa di un arcier presto soriano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16134 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Arie e danze

UPDATE pieces piece
SET piece.title = 'Arie e danze', piece.title_en = 'Arie e danze',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16803 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Arpeggiata

UPDATE pieces piece
SET piece.title = 'Arpeggiata', piece.title_en = 'Arpeggiata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17550 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canzone

UPDATE pieces piece
SET piece.title = 'Canzone', piece.title_en = 'Canzone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17152 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canzone a perdere

UPDATE pieces piece
SET piece.title = 'Canzone a perdere', piece.title_en = 'Canzone a perdere',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18985 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canzone d’ombre

UPDATE pieces piece
SET piece.title = 'Canzone d’ombre', piece.title_en = 'Canzone d’ombre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18682 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canzone in eco

UPDATE pieces piece
SET piece.title = 'Canzone in eco', piece.title_en = 'Canzone in eco',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16531 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canzone molle

UPDATE pieces piece
SET piece.title = 'Canzone molle', piece.title_en = 'Canzone molle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18398 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Capriccio, detto l'ermafrodita

UPDATE pieces piece
SET piece.title = 'Capriccio, detto l''ermafrodita', piece.title_en = 'Capriccio, detto l''ermafrodita',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18703 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ciaccona in labirinto (called Ciaccona del giglio)

UPDATE pieces piece
SET piece.title = 'Ciaccona in labirinto (called Ciaccona del giglio)', piece.title_en = 'Ciaccona in labirinto (called Ciaccona del giglio)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19409 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None De vulgari eloquentia

UPDATE pieces piece
SET piece.title = 'De vulgari eloquentia', piece.title_en = 'De vulgari eloquentia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17315 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Icaros

UPDATE pieces piece
SET piece.title = 'Icaros', piece.title_en = 'Icaros',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19374 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I’mbrazilian

UPDATE pieces piece
SET piece.title = 'I’mbrazilian', piece.title_en = 'I’mbrazilian',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19710 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Notturno (Tombeau per Jimi H.)

UPDATE pieces piece
SET piece.title = 'Notturno (Tombeau per Jimi H.)', piece.title_en = 'Notturno (Tombeau per Jimi H.)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16835 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Notturno con sogno

UPDATE pieces piece
SET piece.title = 'Notturno con sogno', piece.title_en = 'Notturno con sogno',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19131 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nulla nox sine linea – Notturno I

UPDATE pieces piece
SET piece.title = 'Nulla nox sine linea – Notturno I', piece.title_en = 'Nulla nox sine linea – Notturno I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18541 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nulla nox sine linea – Notturno II

UPDATE pieces piece
SET piece.title = 'Nulla nox sine linea – Notturno II', piece.title_en = 'Nulla nox sine linea – Notturno II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19330 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Priapo assiderato

UPDATE pieces piece
SET piece.title = 'Priapo assiderato', piece.title_en = 'Priapo assiderato',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18184 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prélude a l’après-midi d’un fauve

UPDATE pieces piece
SET piece.title = 'Prélude a l’après-midi d’un fauve', piece.title_en = 'Prélude a l’après-midi d’un fauve',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17418 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rap

UPDATE pieces piece
SET piece.title = 'Rap', piece.title_en = 'Rap',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19188 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rondò di forza

UPDATE pieces piece
SET piece.title = 'Rondò di forza', piece.title_en = 'Rondò di forza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16374 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sarabanda

UPDATE pieces piece
SET piece.title = 'Sarabanda', piece.title_en = 'Sarabanda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17995 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Song of Innocence, Song of Experience

UPDATE pieces piece
SET piece.title = 'Song of Innocence, Song of Experience', piece.title_en = 'Song of Innocence, Song of Experience',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16170 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tantalo sorridente

UPDATE pieces piece
SET piece.title = 'Tantalo sorridente', piece.title_en = 'Tantalo sorridente',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18662 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tastata

UPDATE pieces piece
SET piece.title = 'Tastata', piece.title_en = 'Tastata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19700 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tastata riflessa

UPDATE pieces piece
SET piece.title = 'Tastata riflessa', piece.title_en = 'Tastata riflessa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16487 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tutti parlano

UPDATE pieces piece
SET piece.title = 'Tutti parlano', piece.title_en = 'Tutti parlano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18973 AND piece.composer_id = 226
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aria

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Aria', 'Aria', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 226
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Aria'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc554a2b-f6b1-4a61-b005-071f92d2eacb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc554a2b-f6b1-4a61-b005-071f92d2eacb'
FROM pieces p
WHERE p.composer_id = 226 AND p.title = 'Aria' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc554a2b-f6b1-4a61-b005-071f92d2eacb'
);


-- None 샤콘

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '샤콘', 'Ciaccona', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 226
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '샤콘'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d4180a5-37dd-4b87-bc1e-51ef26824d02'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2d4180a5-37dd-4b87-bc1e-51ef26824d02'
FROM pieces p
WHERE p.composer_id = 226 AND p.title = '샤콘' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d4180a5-37dd-4b87-bc1e-51ef26824d02'
);


-- None Ricercare

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ricercare', 'Ricercare', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 226
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ricercare'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4898bea-f7f0-4abc-9cf5-f9b3fb447b1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4898bea-f7f0-4abc-9cf5-f9b3fb447b1f'
FROM pieces p
WHERE p.composer_id = 226 AND p.title = 'Ricercare' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4898bea-f7f0-4abc-9cf5-f9b3fb447b1f'
);


-- None 토카타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타', 'Toccata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 226
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dca6043f-e527-4cd3-b841-d6e03fd6d6ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dca6043f-e527-4cd3-b841-d6e03fd6d6ad'
FROM pieces p
WHERE p.composer_id = 226 AND p.title = '토카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dca6043f-e527-4cd3-b841-d6e03fd6d6ad'
);


-- 숨길 seed 작품 없음
