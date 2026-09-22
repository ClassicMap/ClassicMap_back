-- S tier 대기열 B1 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   거슈윈 파리의 미국인 도입(piece 334): 번스타인·뉴욕필 / 메타·LA필 / 샤이·클리블랜드  0.0441~0.0571
--   리스트 교향시 전주곡 도입(piece 142): 카라얀·베를린필 / 마주어·게반트하우스 /
--     무티·필라델피아                                                          0.0527~0.0974
--   차이콥스키 1812년 서곡 코다(piece 163): 아바도·베를린필 / 얀손스·오슬로필 /
--     뒤투아·몬트리올                                                          0.0577~0.0660
--
-- 파리의 미국인과 전주곡은 도입 발췌, 1812 는 끝에서 120초를 잡은 코다 발췌다.
--
-- 전주곡에서 무티가 낀 두 쌍이 0.0876~0.0974 로 다른 쌍(0.0527)보다 높다. 이조가 아니고
-- (회전 0반음 0.097, 다음이 0.276) 끝점 훑기의 바닥이 122.2초로 지금 값(123.2초)과 같아
-- 경계 문제도 아니다. 시작을 4.8초로 옮기면 0.003 내려가지만 그만큼은 의미가 없다.
-- 연주 차이로 보고 셋을 그대로 둔다.
--
-- 서브에이전트가 후보까지 만든 뒤 보고 없이 멈춰, 호출한 쪽에서 오디오를 다시 받아
-- 교차 정렬과 진단을 직접 돌려 확인한 값이다.
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
