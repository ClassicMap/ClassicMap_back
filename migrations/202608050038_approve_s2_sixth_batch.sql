-- 비교 영상 S2 여섯째 배치 9건을 발행 직전 상태로 올린다.
--
-- 대상은 2026-09-17 에 적재한 3곡이다.
--   J. 슈트라우스 2세 천둥과 번개 폴카 - 카라얀+빈필 / 무티+빈필 / 얀손스+베를린필
--   J. 슈트라우스 2세 박쥐 서곡        - 카라얀+베를린필 / 클라이버+빈필 / 오자와+빈필
--   라벨 물의 유희                     - 조성진 / 티보데 / 바부제
--
-- 관현악 곡이 처음 들어간다. 지휘자를 primary 로 두고 악단을 함께 적어
-- 연주 하나에 크레딧이 둘이다(CONDUCTOR + ORCHESTRA). 적재기는 이 둘을
-- canonical role 'conductor' 와 'orchestra' 로 줄여 저장한다.
--
-- 지휘자와 악단은 영상 설명의 Universal/Sony 배급 표기로 확인했다.
-- 제목만으로는 악단을 알 수 없는 영상이 많아 설명을 근거로 삼았다.
--
-- 교차 정렬은 아홉 쌍 모두 통과했다. 다만 박쥐 서곡의 오자와 쌍이
-- 0.0947~0.0962 로 다른 쌍(카라얀↔클라이버 0.0583)보다 높다. 처음 넣으려던
-- 주빈 메타는 0.0964~0.1046 으로 더 높아 교체했다. 구간을 셋으로 나눠 보니
-- 뒤 1/3 에서만 나빴고 끝점을 훑어도 평평해, 경계가 아니라 판본 차이로 본다.
-- 박쥐 서곡은 극장용과 음악회용 커트가 달라 이런 차이가 생긴다.
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
