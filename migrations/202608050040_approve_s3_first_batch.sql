-- 비교 영상 S3 첫 배치 6건을 발행 직전 상태로 올린다.
--
-- 대상은 2026-09-17 에 적재한 베토벤 피아노 소나타 2곡이다.
--   월광 소나타 Op. 27-2 1악장 - 레비트 / 폴리니 / 키신
--   비창 소나타 Op. 13 2악장   - 윤디 리 / 아슈케나지 / 레비트
--
-- S3(8~20분) 의 첫 배치다. 클립이 최대 600초이므로 작품 전체를 한 구간으로 둘 수
-- 없어 악장 단위로 잘랐다. sectorType 은 MOVEMENT 이고 작품은 전체 work 으로
-- 연결했다. 202608050039 에 이유를 적었다.
--
-- 악장만 따로 올린 영상을 골라서 구간 검출은 S2 와 같은 방식을 그대로 썼다.
-- 전악장 영상에서 악장 경계를 찾는 일은 하지 않았다.
--
-- 교차 정렬은 여섯 쌍 모두 0.0375~0.0547 로, 지금까지 배치 중 가장 낮다.
-- 같은 악장만 담긴 영상끼리 비교해서 군더더기가 없기 때문으로 본다.
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
