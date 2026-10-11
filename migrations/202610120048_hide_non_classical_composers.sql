-- 국제 시드가 작곡가 표에 넣은 대중음악 작곡가 23명과 연주자·지휘자·가수 66명을 목록·검색에서 숨긴다(지우지 않음, 상세는 열림).
-- 분류는 seed_pipeline/curation/composer-classify-2026-10-12/(classify.json·report.md). Wikidata 직업·장르,
-- MusicBrainz 설명·태그, seed 작품 제목을 보고 정했다. 영화·TV·게임 작곡가와 작곡도 한 연주자는 숨기지 않는다.
-- 손으로 넣은 작곡가와 비교 구간이 붙은 작품이 있는 작곡가는 숨기지 않는다. 두 번 돌려도 같다.

-- 대중음악(록·팝·재즈·샹송 등) 작곡가 23명
UPDATE composers composer
SET composer.hidden_reason = 'non_classical'
WHERE composer.origin = 'seed' AND composer.hidden_reason IS NULL
  AND composer.id IN (
    151, 152, 156, 165, 180, 194, 265, 272, 285, 305, 306, 308, 309, 340, 378, 394, 396, 427, 432, 438,
    450, 453, 477
  )
  AND NOT EXISTS (
    SELECT 1 FROM pieces piece
    JOIN performance_sectors sector ON sector.piece_id = piece.id
    WHERE piece.composer_id = composer.id
  );

-- 작곡 작품이 없는 연주자·지휘자·가수 66명
UPDATE composers composer
SET composer.hidden_reason = 'performer'
WHERE composer.origin = 'seed' AND composer.hidden_reason IS NULL
  AND composer.id IN (
    118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 135, 137, 148, 157, 164,
    173, 184, 185, 209, 213, 215, 218, 219, 254, 258, 268, 273, 277, 294, 311, 317, 320, 333, 342, 357,
    361, 363, 364, 370, 376, 377, 379, 380, 382, 390, 403, 410, 412, 417, 426, 436, 437, 451, 452, 455,
    462, 466, 472, 476, 484, 496
  )
  AND NOT EXISTS (
    SELECT 1 FROM pieces piece
    JOIN performance_sectors sector ON sector.piece_id = piece.id
    WHERE piece.composer_id = composer.id
  );

