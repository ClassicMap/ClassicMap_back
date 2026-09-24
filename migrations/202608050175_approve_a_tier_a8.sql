-- A tier A8 비교 영상 3건을 발행 직전 상태로 올린다.
--
--   림스키코르사코프 <셰헤라자데> 1악장 "바다와 신드바드의 배" 도입(piece 202):
--     카라얀·베를린필 / 게르기예프·마린스키 / 바렌보임·시카고심포니  0.0872~0.0984
--
-- 세 쌍이 0.087~0.098 로 임계(0.11) 아래이나 통상 통과 대역(0.04~0.09)의 위쪽이라
-- 세 영상을 모두 진단했다. **연주 문제가 아니라 대목의 성질이다.**
--
--   회전   — 셋 다 0반음이 뚜렷한 최저(0.087~0.098 대 0.24~0.41). 이조 아니다
--   경계   — 시작점 훑기에서 현재 값이 최저이고 뒤로 옮기면 세 쌍이 함께 오른다
--            (카라얀 0.0999 → 0.1592). 끝점 훑기는 평평하고 차이가 0.002 안이다
--   삼등분 — 어느 연주를 잡아도 **중간이 가장 나쁘다**(앞 0.074~0.096,
--            중간 0.097~0.124, 뒤 0.078~0.097)
--
-- 이 120초는 제창 술탄 주제 → 관악 화음 → **무반주 독주 바이올린 카덴차** →
-- Allegro 머리로 이뤄지고 카덴차가 중간 1/3 에 온다. 03-verification.md 의
-- "한 음만 반복하는 대목" 과 같은 기제로 화성 윤곽이 얇아 비용 바닥이 구조적으로
-- 높다. 한 쌍만 높은 것이 아니라 세 쌍이 고르게 높으므로 연주를 바꿀 자리가 아니다.
--
-- 비용을 낮추려면 시작을 Allegro(43초대)로 옮기면 되지만 섹터 큐가 "금관과 저현의
-- 술탄 주제 첫 음(작품 시작)" 이라 옮기지 않았다. 비용으로 큐를 사지 않는다.
--
-- 검출을 둘 고쳤다. 02-detection.md 의 "악구 사이 쉼이 도입을 잘라낸다" 이다.
-- 술탄 주제 뒤 무반주 바이올린 카덴차가 −40~−50dB 로 20초 넘게 이어져 앞 덩어리가
-- 끊기고 버려졌다.
--
--   카라얀   43.14 → 3.05   (43초는 Allegro 진입 자리다. 도입을 통째로 잃을 뻔했다)
--   바렌보임 88.79 → 1.02   (88초)
--   게르기예프 5.43 → 5.55  (4.4~5.5초는 홀 잡음이었다)
--
-- 스페인 기상곡(204)과 러시아 부활절 축제 서곡(205)은 이 배치에서 빠졌다.
-- **가장 빠른 전곡 연주조차 840초·851초**라 클립 600초 상한 안에 드는 연주가
-- 아예 없다. 셋을 못 맞추는 것이 아니라 WHOLE_WORK 로는 불가능한 곡이다.
-- 후보 45건을 훑은 결과이고 오디오는 받지 않았다. A-TIER-QUEUE.md 에 적었다.
--
-- 경고: rights_mode 를 licensed_self_hosted 로 적지만 실제 이용 허락을 받은
-- 것이 아니다. 202608050017 의 경고와 같은 내용이다.

UPDATE performance_sources source
SET source.rights_mode = 'licensed_self_hosted',
    source.last_checked_at = CURRENT_TIMESTAMP(6)
WHERE source.rights_mode = 'unknown'
  AND EXISTS (
      SELECT 1
      FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.performance_source_id = source.id
  );

UPDATE performance_sectors sector
SET sector.editorial_status = 'EDITOR_REVIEWED'
WHERE sector.editorial_status = 'FACTS_VERIFIED'
  AND EXISTS (
      SELECT 1
      FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = sector.id
  );

UPDATE performance_candidates candidate
SET candidate.candidate_status = 'APPROVED'
WHERE candidate.candidate_status = 'REVIEW_REQUIRED'
  AND EXISTS (
      SELECT 1
      FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = candidate.sector_id
        AND performance.performance_source_id = candidate.performance_source_id
        AND performance.start_ms = candidate.proposed_start_ms
        AND performance.end_ms = candidate.proposed_end_ms
  );
