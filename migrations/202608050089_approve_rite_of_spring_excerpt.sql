-- 스트라빈스키 <봄의 제전> 제1부 서주(piece 309) 비교 영상 3건을 발행 직전 상태로 올린다.
--
-- 대상: 네제 세갱·필라델피아 / 메타·LA필 / 게르기예프·마린스키   0.0687~0.0787
--
-- 202608050087 때는 오자와·보스턴이 들어 있었고 옮김 비용 0.0899(기준 0.06 초과),
-- 네제 세갱과 0.1097 로 보류했다. 예비 둘(아바도·LSO, 게르기예프·마린스키)을 더해
-- 다섯 연주 10쌍을 떴다.
--
--            NS      오자와   메타    아바도   게르기예프   행 평균
--   NS        –     0.1097  0.0687  0.1036   0.0784      0.0901
--   오자와  0.1097     –    0.0820  0.0924   0.1131      0.0993
--   메타    0.0687  0.0820     –    0.0889   0.0787      0.0796
--   아바도  0.1036  0.0924  0.0889     –     0.0804      0.0913
--   게르    0.0784  0.1131  0.0787  0.0804      –        0.0877
--
-- 임계를 넘는 쌍은 오자와↔게르기예프 하나뿐이고 오자와가 행 평균 최고다. 오자와를
-- 빼고 게르기예프를 넣어 세 쌍 최대 0.0787 로 맞췄다.
--
-- 다만 다섯 연주가 모두 0.069~0.113 에 걸쳐 있다. 이 서주는 여린 목관 독주가 이어져
-- 화성 윤곽이 얇고, 같은 배치의 다른 두 곡(0.034~0.065)보다 정렬이 어렵다.
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
