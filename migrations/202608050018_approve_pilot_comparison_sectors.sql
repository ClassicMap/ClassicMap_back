-- 파일럿 비교 영상 15건의 편집 검수 결과를 DB 에 반영한다.
--
-- 이 15건은 2026-08-05 큐레이션에서 이미 검수를 마친 것이다.
-- seed_pipeline/curation/pilot-2026-08-05/candidates.jsonl 의 각 행에
-- candidateStatus=APPROVED, confidence=MEDIUM_HIGH, reviewedAt 과 근거가 적혀 있고
-- review-report.md 에 선정 기준과 확인 결과가 정리돼 있다.
--
-- 적재기(load_comparison_candidates)는 설계상 발행 직전 상태까지만 만들기 때문에
-- 그 승인이 DB 로 옮겨지지 않아 sector 는 FACTS_VERIFIED, 후보는 REVIEW_REQUIRED 로 남아 있다.
-- 클립 자산까지 준비된 지금 그 승인을 반영한다.
--
-- 대상은 clip_jobs 가 걸린 파일럿 15건뿐이다. 다른 sector 나 후보는 건드리지 않는다.

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
