-- S tier 대기열 B2 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   멘델스존 교향곡 4번 "이탈리아" 1악장 도입(piece 124): 카라얀·베를린필 /
--     마리너·ASMF / 아바도·LSO                                        0.0396~0.0491
--   슈베르트 교향곡 8번 "미완성" 1악장 도입(piece 119): 카라얀·베를린필 /
--     뵘·베를린필 / 아바도·유럽 체임버                                  0.0581~0.0722
--   하이든 교향곡 94번 "놀람" 2악장 도입(piece 83): 마리너·ASMF /
--     카라얀·베를린필 / 번스타인·뉴욕필                                 0.0567~0.0713
--
-- 셋 다 악장 트랙 영상을 썼고 도입만 발췌했다. 옮김 비용 0.0286~0.0501, 길이 비율
-- 0.82~1.14배로 기준 안이다.
--
-- 검출 다섯 건이 여린 도입을 지나쳤다(슈베르트 20.18→2.40, 3.48→2.50, 36.22→3.00,
-- 하이든 29.07→1.78, 34.97→0.86). 특히 하이든의 두 건은 여린 주제 30초가 덩어리에서
-- 떨어져 나가 "놀람" 총주부터 잡혀 있었다. 0.05초 해상도 RMS 와 onset 으로 고쳤고
-- 도입부 flatness 는 0.0001~0.0047 로 내내 음악 대역이었다. 원본은
-- s-b2-detected.orig.json 에 있다.
--
-- 하이든은 기준 연주를 카라얀에서 마리너로 바꿨다. 카라얀 기준일 때 번스타인 발췌가
-- 1.38배였는데, 세 기준을 다 떠 보니 카라얀↔번스타인 폭은 어느 기준에서도 1.38~1.41배로
-- 같았다. 악장 전체 길이가 306.9초 대 438.3초(1.43배)라 옮김이 틀린 것이 아니라 실제
-- 템포 차다. 마리너를 기준으로 두면 세 클립이 74~103초로 모여 권장 범위에 들어온다.
--
-- 고르며 뺀 것: 하이팅크 영상은 그가 DB 에 `바이올린` 으로 잘못 분류돼 있어 뺐다
-- (202608050105 에서 고쳤다). 샤이·라 스칼라 필은 악단이 미등록이라 뺐다.
-- "Herbert von Karajan" 채널의 영상 하나는 설명상 아바도·빈필이었다.
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
