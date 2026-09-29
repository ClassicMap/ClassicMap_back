-- A tier A29 비교 영상 3건을 발행 직전 상태로 올린다. **두 곡 가운데 하나만 발행한다.**
--
--   하차투리안 <가야네> 중 "칼춤" 전곡(piece 381):
--     오르만디·필라델피아 / 로즈데스트벤스키·레닌그라드필 /
--     체크나보리안·아르메니아필                                     0.0427~0.0449
--
-- **377 <부에노스 아이레스의 사계>는 막았다.** A28 피아졸라 셋과 같은 갈래다.
-- 위키데이터 항목이 있는 세 연주를 받아 쟀다.
--
--   크레머↔쿠아르테토 라티노아메리카노 0.1475 · 크레머↔존 윌리엄스 0.2173
--   존 윌리엄스↔쿠아르테토 0.2325
--
-- 셋이 서로 다른 편곡이다 — 크레머는 바이올린+크레메라타 발티카, 존 윌리엄스는
-- 기타(arr. B. Benitez), 쿠아르테토 라티노아메리카노는 관현악판이다. 길이도
-- 276~422초로 1.53배 갈린다. 01-selection.md 의 "피아졸라형" 세 조건에 다 걸린다.
--
-- **칼춤은 반대로 아주 깨끗하다.** 관현악 원곡이 표준 악보로 돌고 낱 곡 트랙이
-- 138~158초다. 위키데이터 항목이 있는 다섯 연주를 받아 열 쌍을 다 쟀다.
--
--   로즈데스트벤스키↔체크나보리안 0.0435 · 오르만디↔로즈데스트벤스키 0.0436
--   오르만디↔체크나보리안 0.0461 · 오르만디↔워즈워스 0.0504
--   오르만디↔피스툴라리 0.0515 · 워즈워스↔로즈데스트벤스키 0.0581
--   피스툴라리↔로즈데스트벤스키 0.0616 · 피스툴라리↔체크나보리안 0.0630
--   워즈워스↔체크나보리안 0.0681 · 워즈워스↔피스툴라리 0.0692
--
-- 열 쌍 전부 0.11 아래이고 회전도 전부 0반음이 최저다(차점 0.10~0.14). 조합 열 가지
-- 가운데 **오르만디·로즈데스트벤스키·체크나보리안이 0.0461 로 가장 낮아** 그것을 골랐다.
-- 아르메니아 작곡가의 곡에 아르메니아 필하모닉이 드는 것도 맞다.
--
-- **오르만디 판의 검출 끝이 111.71 이었다. 실제 음악은 156초까지 이어진다 — 44초를
-- 되살렸다.** 칼춤 중간에 여린 대목이 있어 덩어리가 거기서 끊기고 가장 긴 조각을
-- 고르는 규칙 때문에 뒤가 통째로 빠진 것이다. 02-detection.md 의 "종결부를 버리는 일"
-- 그대로다. 꼬리 음량을 직접 보고 고쳤다 — 150.7~153.6초가 −31~−36dB 에 평탄도
-- 0.001 대이고(종결 화음과 잔향), 157초부터 디지털 무음이다.
--
-- 되살리니 값이 내려갔다 — 대 로즈데스트벤스키 0.0594 → 0.0427, 대 체크나보리안
-- 0.0585(끝 111.71 일 때 대 피스툴라리) 기준으로도 함께 내려갔다.
--
-- 202608050213 에서 인물·단체 셋을 등록했다. **레닌그라드 필하모닉은 상트페테르부르크
-- 필하모닉(345)과 같은 악단이라 새로 등록하지 않았다.**
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
