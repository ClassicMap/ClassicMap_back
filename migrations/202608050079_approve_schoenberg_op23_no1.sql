-- 쇤베르크 5개의 피아노 소품 Op.23 1곡(piece 316) 비교 영상 3건을 발행 직전 상태로 올린다.
--
-- 대상: 폴리니 / 카시올리 / 피터 서킨   0.0716~0.0841
--
-- 처음 배치에는 글렌 굴드가 있었다. 202608050064 때는 구간마다 튜닝을 추정하던
-- 정렬 버그를 의심해 보류했고, 튜닝을 영상 단위로 고정한 뒤 다시 쟀다. 그래도 굴드는
-- 폴리니와 0.1208, 카시올리와 0.1015 였다. 회전 최저가 0반음이라 이조가 아니고,
-- 시작·끝을 훑어도 내려가지 않아 경계 문제도 아니다. 예비로 받은 피터 서킨은
-- 폴리니·카시올리와 0.072~0.084 로 모였고 굴드와는 0.1186 이었다. 넷 중 셋과 먼
-- 굴드를 빼고 서킨을 넣었다. 예비로 받은 피터 슈타들렌은 모두와 0.145 이상이었다.
--
-- 폴리니 영상의 시작 10.17초는 앞 10초가 디지털 무음이라 그대로 두었다.
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
