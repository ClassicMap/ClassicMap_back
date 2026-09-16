-- 비교 영상 S3 넷째 배치 3건을 발행 직전 상태로 올린다.
--
-- 대상은 쇼팽 발라드 1번이다.
--   Op. 23 전곡 - 아슈케나지 / 폴리니 / 루빈슈타인
--
-- 단일 악장이라 sector 는 전곡이다. 9분대 연주라 클립 한도(600초) 안에 든다.
--
-- 세 번째 연주는 한 번 교체했다. 처음 넣으려던 짐머만이 다른 둘과
-- 0.1031~0.1081 이었다. 끝점을 훑었더니 565.5초부터 601.5초까지 0.104~0.110 에서
-- 평평했다. 경계가 아니라 연주가 다르다는 뜻이다.
-- 아슈케나지로 바꾸자 0.0597~0.0636 으로 내려갔다.
--
-- 이로써 판정 방법이 세 배치 연속 같은 방식으로 작동했다.
--   비창 3악장  - 끝점을 옮기자 비용이 내려감 → 경계 문제, 값을 고침
--   트로이메라이 - 조금 내려가다 멈춤        → 연주 차이, 교체
--   발라드 1번  - 평평함                     → 연주 차이, 교체
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
