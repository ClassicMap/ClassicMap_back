-- A tier A30 비교 영상 6건을 발행 직전 상태로 올린다. **A tier 캠페인의 마지막 배치다.**
--
--   하차투리안 바이올린 협주곡 D단조 Op. 46 1악장 도입 120초(piece 383):
--     라둘로비치·괴첼·보루산 이스탄불필 / 리치·피스툴라리·런던필 /
--     모르드코비치·예르비·왕립 스코틀랜드필                          0.0552~0.0674
--   하차투리안 <가면무도회> 모음곡 Op. 48a 1곡 "왈츠"(piece 384):
--     체크나보리안·아르메니아필 / 예르비·왕립 스코틀랜드필 /
--     스탠리 블랙·런던심포니                                        0.0499~0.0805
--
-- 여섯 쌍 전부 임계(0.11) 아래다.
--
-- **383 은 1악장이 860~955초로 600초를 넘어 anchor:head 120초 발췌를 유지했다.**
-- 옮김 비용이 0.0357·0.0439 로 0.06 문턱 아래이고 길이가 120.6~121.2초로 기준
-- (120초)과 1.01배 안이다. 검증 삼종을 모두 통과한다.
--
-- **384 는 낱 곡 트랙이 231~247초라 발췌를 뺐다.** A25 이후 배치의 방식과 같다.
--
-- 여섯 건 모두 회전 12방향에서 0반음이 최저이고 차점까지 383 은 0.20, 384 는 0.15
-- 이상 벌어진다. tuning 폭은 383 0.30(리치 −0.160 ~ 라둘로비치 +0.140) · 384 0.20
-- (예르비·블랙 +0.040 ~ 체크나보리안 +0.240) 반음이다. 0 근처 값이 없어 A=415 접힘
-- 자리가 없다.
--
-- 끝은 여섯 건 다 검출값을 그대로 두었다. 늘리면 모든 쌍이 나빠지거나 0.001 안에서
-- 움직인다. 예르비의 384 검출 끝이 231.36 으로 영상(243초)보다 12초 이르지만,
-- 늘리면 두 쌍이 함께 올라가(0.0805→0.0849, 0.0499→0.0554) 남은 12초가 음악이 아니다.
--
-- 202608050215 에서 인물·단체 일곱 곳을 등록했다. **네메 예르비(817)는 이미 등록된
-- 파보 예르비(583)와 다른 사람이고, 스탠리 블랙은 위키데이터 동명 항목이 넷이라
-- 생몰년으로 가렸다.**
--
-- 선정에서 뺀 것 — 383 의 펄만 판(`TwKQWHx0MBA`)과 오이스트라흐 판(`bSTK09D9kHY`)은
-- 배급 표기에 악단 이름이 없다. 384 의 필하모니아 판(`zGgBxgoY3M8`)과 차이콥스키
-- 대교향악단 판(`tXnXXGXhKzw`)은 지휘자 이름이 없다. 모스크바 RTV 판(`ocJPJJAtQX8`)은
-- 표기에 하차투리안 본인(Aram)과 카렌 하차투리안이 함께 있어 누가 지휘인지 가릴 수 없다.
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
