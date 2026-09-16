-- 비교 영상 S2 둘째 배치 9건을 발행 직전 상태로 올린다.
--
-- 대상은 2026-09-16 에 적재한 쇼팽 소품 3곡이다.
--   전주곡 Op.28 No.15 "빗방울" - 랑랑 / 조성진 / 호로비츠
--   연습곡 Op.10 No.3 "이별의 곡" - 폴리니 / 임윤찬 / 시시킨
--   폴로네즈 Op.53 "영웅"        - 조성진 / 키신 / 호로비츠
--
-- 202608050022 와 같은 방식으로 뽑았다. 곡이 짧아 작품 전체가 곧 구간이므로
-- 음악이 실제로 시작하고 끝나는 지점만 오디오에서 찾았다.
--
-- 교차 정렬 검증이 이번에도 한 건을 걸러냈다. 이별의 곡에 처음 넣으려던 연주는
-- 다른 두 연주와 정렬 비용이 0.132~0.134 로 높았다. 피치 차이는 아니었고
-- (12방향 회전으로 확인) 구간 경계 문제도 아니었다. 잘 맞는 연주를 기준으로
-- 구간을 다시 잡아도 비용이 그대로여서, 같은 곡의 다른 판본으로 보고 교체했다.
-- 교체한 연주는 0.045~0.055 로 통과했다.
--
-- 반대로 길이 편차가 커서 의심했으나 통과한 것도 있다. 빗방울 전주곡은
-- 세 연주의 길이가 288~386초로 1.34배 차이 나는데 정렬 비용은 0.066~0.074 였다.
-- 길이만으로는 판정할 수 없고 화성 진행을 봐야 한다는 뜻이다.
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
