-- 비교 영상 2차 시드 18건을 발행 직전 상태로 올린다.
--
-- 대상은 2026-09-16 에 적재한 3곡이다.
--   차이콥스키 피아노 협주곡 1번 - 1악장 도입부 / 3악장 코다
--   베토벤 교향곡 5번           - 1악장 운명 동기 / 4악장 개선 주제
--   리스트 라 캄파넬라          - 도입 종소리 음형 / 종결 클라이맥스
-- 곡마다 연주 3종이라 6 sector × 3 = 18건이다.
--
-- 적재기(load_comparison_candidates)는 설계상 발행 직전까지만 만들기 때문에
-- 검수 결과가 DB 로 옮겨지지 않아 sector 는 FACTS_VERIFIED, 후보는 REVIEW_REQUIRED 로 남는다.
-- 202608050017·202608050018 이 파일럿 15건에 한 것과 같은 전이를 이번 배치에 적용한다.
--
-- 구간 판정 근거는 각 후보의 clip.verificationNote 에 들어 있다.
--   기준 연주는 사람이 스펙트로그램으로 음악 시작·끝을 직접 확인했고,
--   나머지 연주는 크로마 DTW 로 같은 구간을 옮긴 뒤 음 시작에 맞췄다.
--   전파 결과는 클립을 실제로 재생해 시작·끝 음이 맞물리는지 확인했다.
--
-- 경고: rights_mode 를 licensed_self_hosted 로 적지만 실제 이용 허락을 받은 것이 아니다.
-- 내부 기술 검증 단계라서 그렇게 두는 것이고, 외부 공개나 홍보 전에는
-- 권리자 확인을 반드시 다시 거쳐야 한다. 202608050017 의 경고와 같은 내용이다.
--
-- 조건은 모두 "clip_jobs 가 걸려 있을 것"이라 파일럿 15건은 이미 전이를 마쳐 다시 걸리지 않는다.

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
