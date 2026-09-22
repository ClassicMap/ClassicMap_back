-- 2라운드 발췌 배치(교향곡) 비교 영상 6건을 발행 직전 상태로 올린다.
--
-- 대상 (S tier 2라운드, 서브에이전트 배치)
--   베토벤 교향곡 9번 4악장 도입(piece 76): 아바도·베를린필 / 샤이·게반트하우스 / 정명훈·서울시향  0.0462~0.0527
--   모차르트 교향곡 40번 1악장 도입(piece 67): 카라얀·베를린필 / 무티·빈필 / 마리너·ASMF         0.0335~0.0646
--
-- 악장 트랙 영상을 골라 한 연주에서 발췌를 정하고 나머지는 부분열 DTW 로 옮겼다.
-- 옮김 비용 0.0348~0.0436.
--
-- 두 가지를 배웠다.
--   1. 제시부 반복: 모차르트 40번에서 무티의 발췌가 제시부 반복 쪽(123.99~217.06초)으로
--      옮겨졌고 화성이 같아 비용이 오히려 낮았다. 탐색 창을 발췌 길이의 1.7배로 좁혀
--      다시 옮기자 5.39~96.97초가 나왔고 비용은 거의 같았다.
--   2. 큐와 시작: 부분열 DTW 가 여섯 영상 모두 시작을 0.2~4.1초 늦게 잡았다. 섹터 큐가
--      "악장 시작" 이므로 시작을 검출값으로 고정했다. 비용 변화는 ±0.005 안이었다.
--
-- 같은 배치의 봄의 제전(piece 309)은 오자와의 옮김 비용이 0.0899(기준 0.06 초과),
-- 교차 정렬 최대 0.1097 로 다른 쌍(0.034~0.065)보다 눈에 띄게 높아 보류했다.
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
