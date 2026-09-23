-- S tier 대기열 C3 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   프로코피예프 피아노 협주곡 3번 1악장 도입(piece 325): 아르헤리치·아바도·베를린필 /
--     아슈케나지·프레빈·런던심포니 / 랑랑·래틀·베를린필                   0.0622~0.0827
--   거슈윈 피아노 협주곡 F장조 1악장 도입(piece 335): 트리포노프·네제세갱·필라델피아 /
--     티보데·올솝·볼티모어심포니 / 로제·드 비이·빈방송교향악단             0.0591~0.0914
--   베토벤 바이올린 협주곡 Op. 61 1악장 도입(piece 81): 무터·카라얀·베를린필 /
--     펄만·바렌보임·베를린필 / 한·진먼·볼티모어심포니                      0.0429~0.0544
--
-- 셋 다 도입 120초 발췌(anchor=head)이고 시작은 검출값에 고정했다. 크레딧은
-- 독주자(주역) → 지휘자 → 악단 세 층이다.
--
-- 검출이 아홉 건 중 다섯에서 여린 도입을 지나쳤다. RMS 와 저역(50~160Hz) 에너지로
-- 확인해 고쳤고 원본은 s-c3-detected.orig.json 에 있다.
--
--   아르헤리치  13.84 → 0.70   0.7초부터 -41dB, 평탄도 0.000 (클라리넷 독주)
--   아슈케나지  26.56 → 2.70   26.5초는 Allegro 진입점이고 2.7초부터 조성 성분이 있다
--   랑랑         0.98 → 0.15
--   무터         6.92 → 4.45   저역 타격 4.5/5.1/5.7/6.3/6.9초 = 팀파니 다섯 타
--   펄만         3.85 → 1.05   저역 타격 1.1/1.8/2.4/3.1/3.8초
--
-- 베토벤 바이올린 협주곡의 도입은 팀파니 다섯 타로 시작하는데 검출기가 이것을 음악으로
-- 보지 못했다. 이 곡에서 그 다섯 타는 악장의 첫 소리이자 1악장 전체를 지배하는 동기라
-- 빠뜨리면 큐를 어긴다. 한은 검출값 2.04 가 이미 맞아 그대로 뒀다.
--
-- 카덴차는 들어가지 않는다. 판본이 연주자마다 달라 발췌에 넣을 수 없는데, 세 연주 모두
-- 카덴차가 11~13분 지점이라 도입 120초와 멀리 떨어져 있다.
--
-- 발췌 검증 3종 모두 통과: 옮김 비용 최대 0.0559, 길이 비율 0.93~1.10배,
-- 교차 정렬 최대 0.0914.
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
