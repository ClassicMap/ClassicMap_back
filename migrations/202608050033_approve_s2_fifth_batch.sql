-- 비교 영상 S2 다섯째 배치 9건을 발행 직전 상태로 올린다.
--
-- 대상은 2026-09-17 에 적재한 3곡이다.
--   마스네 <타이스> 명상곡       - 펄만 / 정경화 / 조슈아 벨 (바이올린)
--   쇼팽 녹턴 20번 C#단조 유작   - 조성진 / 브루스 리우 / 윤디 리
--   라벨 죽은 왕녀를 위한 파반느 - 조성진 / 바부제 / 티보데
--
-- 202608050030 과 같은 방식으로 뽑았다. 곡이 짧아 작품 전체가 곧 구간이므로
-- 음악이 실제로 시작하고 끝나는 지점만 오디오에서 찾았다.
--
-- 교차 정렬은 아홉 쌍 모두 0.057~0.079 로 통과했다. 걸러낸 것이 없다.
--
-- 비교 영상에 처음으로 피아노가 아닌 악기가 들어간다. 타이스 명상곡은
-- 바이올린 독주이므로 크레딧 역할을 VIOLINIST 로 넣었고, 적재기가 canonical
-- role 'soloist' 로 줄여 저장한다.
--
-- 세 곡 모두 모음곡의 낱곡이 아니라 독립된 작품이라, 202608050029 에서 막혔던
-- 국제 시드 piece_parts 충돌이 없었다. 붙이기 전에 양쪽을 확인했다.
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
