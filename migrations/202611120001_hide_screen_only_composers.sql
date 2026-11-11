-- 클래식 작품이 없는 영화·TV·게임·재즈·앰비언트 작곡가 7명을 목록·검색에서 숨긴다(지우지 않음, 상세는 열림).
-- 2026-11-12 사용자 결정 「클래식에 중점」. 10/12(202610120048)에는 영화·TV·게임 작곡가를 숨기지 않았는데 이번에 바꾼다.
--   154 Mina Kubota(애니메이션), 203 J. A. C. Redford(영화·TV), 220 David Chesky(재즈·크로스오버 음반),
--   255 Martin O'Donnell(게임 「헤일로」), 399 Harold Budd(앰비언트), 419 Terry Plumeri(재즈 베이시스트의 영화음악),
--   421 Bear McCreary(TV·게임).
-- 클래식 작품도 있는 니노 로타·버나드 허먼·요한 요한손·사에구사 시게아키는 그대로 둔다.
-- 숨김 값은 10/12 와 같은 'non_classical'. seed 작곡가만, 비교 구간이 붙은 작품이 있으면 숨기지 않는다. 두 번 돌려도 같다.
-- 숨기기 전 운영 확인: 7명의 작품을 즐겨찾기·듣기 기록·영화 큐로 가리키는 행 0, 작곡가 즐겨찾기 0.
UPDATE composers composer
SET composer.hidden_reason = 'non_classical'
WHERE composer.origin = 'seed' AND composer.hidden_reason IS NULL
  AND composer.id IN (154, 203, 220, 255, 399, 419, 421)
  AND NOT EXISTS (
    SELECT 1 FROM pieces piece
    JOIN performance_sectors sector ON sector.piece_id = piece.id
    WHERE piece.composer_id = composer.id
  );
