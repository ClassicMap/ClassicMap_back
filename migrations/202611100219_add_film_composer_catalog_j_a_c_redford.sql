-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 10/11).
-- 작품 4개(새 0개), seed 4개 중 잇기 4·숨김 0·그대로 0.
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

-- ===== J. A. C. Redford (composer_id 203) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 4개 중 음반 묶음 0개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 4개,
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 0개를 음반 묶음 안 곡으로 잇고, 4개는 낱개 작품으로 두고, 0개를 숨긴다.

-- None The Rescue

UPDATE pieces piece
SET piece.title = 'The Rescue', piece.title_en = 'The Rescue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16038 AND piece.composer_id = 203
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sykes

UPDATE pieces piece
SET piece.title = 'Sykes', piece.title_en = 'Sykes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17733 AND piece.composer_id = 203
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pursuit Through the Subway

UPDATE pieces piece
SET piece.title = 'Pursuit Through the Subway', piece.title_en = 'Pursuit Through the Subway',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18752 AND piece.composer_id = 203
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bedtime Story

UPDATE pieces piece
SET piece.title = 'Bedtime Story', piece.title_en = 'Bedtime Story',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19264 AND piece.composer_id = 203
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음
