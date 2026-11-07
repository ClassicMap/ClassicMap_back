-- 이시이 마키 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 19개(묶음 0, 다악장 0, 낱곡 19),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 22개 중 19개를 작품·part 에 잇고, 3개를 숨기고, 0개는 그대로 둔다.
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

-- Op. 5 Aphorismen

UPDATE pieces piece
SET piece.title = 'Aphorismen', piece.title_en = 'Aphorismen, op. 5',
    piece.type = 'song', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18620 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 27 Black Intention I

UPDATE pieces piece
SET piece.title = 'Black Intention I', piece.title_en = 'Black Intention I, op. 27',
    piece.type = 'song', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15823 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cho-Etsu

UPDATE pieces piece
SET piece.title = 'Cho-Etsu', piece.title_en = 'Cho-Etsu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17172 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 79 Concertante

UPDATE pieces piece
SET piece.title = 'Concertante', piece.title_en = 'Concertante, op. 79',
    piece.type = 'song', piece.opus_number = 'Op. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15785 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38 Drifting Island

UPDATE pieces piece
SET piece.title = 'Drifting Island', piece.title_en = 'Drifting Island, op. 38',
    piece.type = 'song', piece.opus_number = 'Op. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19385 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 94 East - Green - Spring

UPDATE pieces piece
SET piece.title = 'East - Green - Spring', piece.title_en = 'East - Green - Spring, op. 94',
    piece.type = 'song', piece.opus_number = 'Op. 94',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15839 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 9 Hamon

UPDATE pieces piece
SET piece.title = 'Hamon', piece.title_en = 'Hamon, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15850 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 55 Hiten-Seidō II

UPDATE pieces piece
SET piece.title = 'Hiten-Seidō II', piece.title_en = 'Hiten-Seidō II, op. 55',
    piece.type = 'song', piece.opus_number = 'Op. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18098 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 Kyō-Sō

UPDATE pieces piece
SET piece.title = 'Kyō-Sō', piece.title_en = 'Kyō-Sō, op. 14',
    piece.type = 'song', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15833 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 13 Kyō-Ō

UPDATE pieces piece
SET piece.title = 'Kyō-Ō', piece.title_en = 'Kyō-Ō, op. 13',
    piece.type = 'song', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15773 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 33b Lost Sounds II

UPDATE pieces piece
SET piece.title = 'Lost Sounds II', piece.title_en = 'Lost Sounds II, op. 33b',
    piece.type = 'song', piece.opus_number = 'Op. 33b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16787 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Monochrome

UPDATE pieces piece
SET piece.title = 'Monochrome', piece.title_en = 'Monochrome',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16222 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 28 Monochrome Op. 28

UPDATE pieces piece
SET piece.title = 'Monochrome Op. 28', piece.title_en = 'Monochrome, op. 28',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '28',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19444 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 37 Search in Grey

UPDATE pieces piece
SET piece.title = 'Search in Grey', piece.title_en = 'Search in Grey, op. 37',
    piece.type = 'song', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16880 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19a Shikyō

UPDATE pieces piece
SET piece.title = 'Shikyō', piece.title_en = 'Shikyō, op. 19a',
    piece.type = 'song', piece.opus_number = 'Op. 19a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15730 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 23 Synkretismen

UPDATE pieces piece
SET piece.title = 'Synkretismen', piece.title_en = 'Synkretismen, op. 23',
    piece.type = 'song', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18089 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 19 Sō-Gū II

UPDATE pieces piece
SET piece.title = 'Sō-Gū II', piece.title_en = 'Sō-Gū II, op. 19',
    piece.type = 'song', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16077 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 73 Tango-Prism

UPDATE pieces piece
SET piece.title = 'Tango-Prism', piece.title_en = 'Tango-Prism, op. 73',
    piece.type = 'song', piece.opus_number = 'Op. 73',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17353 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 66 Thirteen Drums

UPDATE pieces piece
SET piece.title = 'Thirteen Drums', piece.title_en = 'Thirteen Drums, op. 66',
    piece.type = 'song', piece.opus_number = 'Op. 66',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15751 AND piece.composer_id = 278
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 278 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15814, 19268, 19957
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
