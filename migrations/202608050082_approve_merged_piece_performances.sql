-- 곡을 합친 뒤 보류했던 비교 영상 6건을 발행 직전 상태로 올린다.
--
-- 대상 (S tier 1라운드, 서브에이전트 배치)
--   프로코피예프 피아노 소나타 7번 3악장 Precipitato(piece 326): 폴리니 / 굴드 / 리시차
--   쇼스타코비치 피아노 협주곡 2번 2악장 Andante(piece 458): 멜니코프 / 레온스카야 / 유자 왕   0.0558~0.0949
--
-- 두 곡 모두 MBID 가 국제 시드 중복 곡에 붙어 있어 적재하지 못하고 있었다.
-- 202608050081 에서 식별자와 악장을 수동 곡으로 옮겨 풀었다.
--
-- 쇼스타코비치: 검출이 여린 현 도입을 건너뛰어 시작이 18~40초 늦게 잡혔고 왕↔멜니코프가
-- 0.1102 였다. 첫 음(0.86 / 0.71 / 0.72초)으로 당기자 세 쌍이 함께 내려갔다(1번 경계 오류).
-- 고친 뒤에도 왕↔멜니코프가 0.0949 로 다른 쌍(0.0558, 0.0705)보다 높다. 이조가 아니고
-- 경계를 훑어도 평평하다. 예비 연주 둘(번스타인, 막심 쇼스타코비치)을 더해 뜬 10쌍
-- 교차표에서 왕이 전반적으로 약간 바깥이고 템포가 양 끝인 두 연주(364초와 457초)가
-- 만날 때 가장 벌어졌다. 임계 아래라 셋을 그대로 둔다.
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
