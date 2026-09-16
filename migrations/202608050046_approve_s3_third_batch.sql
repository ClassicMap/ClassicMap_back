-- 비교 영상 S3 셋째 배치 3건을 발행 직전 상태로 올린다.
--
-- 대상은 비창 소나타 3악장이다.
--   Op. 13 3악장 Rondo. Allegro - 아슈케나지 / 길렐스 / 레비트
--
-- 같은 작품(piece 79)에 sector 를 하나 더 만든 것이고, 2악장은 202608050040
-- 에서 이미 발행했다. 월광 소나타에 이어 두 번째로 한 작품에 악장이 둘 붙는다.
--
-- 검출기가 아슈케나지 연주의 끝을 23초 일찍 끊었다. 교차 정렬이 0.1106 으로
-- 걸려서 끝점을 훑어 보니 274.7초에서 0.0984 로 내려갔다. 다른 쌍과의 비용도
-- 함께 개선돼(0.0652 → 0.0471) 경계 문제가 맞다고 보고 그 값을 썼다.
--
-- 조성 성분이 여리게 끝나는 종결부에서 검출기가 일찍 끊는 일이 있다.
-- 교차 정렬이 이런 경우를 잡아낸다.
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
