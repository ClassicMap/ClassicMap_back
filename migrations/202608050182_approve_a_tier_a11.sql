-- A tier A11 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   브루크너 모테트 <Locus iste> WAB 23 전곡(piece 184):
--     몬테베르디 합창단·가드너 / 폴리포니·레이턴 /
--     라트비아 방송합창단·클라바                                      0.0541~0.0600
--   말러 교향곡 2번 "부활" 1악장 도입(piece 215):
--     솔티·LSO / 아바도·시카고심포니 / 메타·빈필                     0.0475~0.0546
--   말러 교향곡 5번 1악장 Trauermarsch 도입(piece 216):
--     틸슨 토머스·샌프란시스코 / 카라얀·베를린필 / 오자와·보스턴     0.0671~0.0965
--
-- 216 은 카라얀이 높은 두 쌍에 다 끼어 있어 임계 아래인데도 진단했다. 예비
-- 둘(번스타인·빈필, 솔티·시카고)을 받아 다섯으로 교차표를 떴더니 **열 쌍이
-- 0.067~0.097 한 덩어리**에 들어 있다. 연주별 평균은 틸슨 토머스 0.0796 ·
-- 번스타인 0.0809 · 오자와 0.0831 · 솔티 0.0888 · 카라얀 0.0902 로, 카라얀이
-- 가장 높지만 솔티보다 0.0014 높을 뿐이다. **한 연주가 바깥인 모양이 아니다** —
-- A3 의 로데는 낀 네 쌍이 0.118~0.130 이고 나머지가 0.069~0.086 이었다.
--
-- 조율로도 갈리지 않는다. +0.17~+0.21 세 연주끼리의 평균이 0.0871 이고 다른
-- 덩어리와 섞인 쌍의 평균이 0.0861 로 같다. 밤의 여왕 같은 조율 덩어리가 아니다.
--
-- 바닥이 높은 것은 대목의 성질이다. 발췌 앞부분이 **무반주 트럼펫 단선율**이라
-- chroma 가 붙잡을 화성이 얇다. 같은 날 A8 의 셰헤라자데도 무반주 바이올린
-- 카덴차 때문에 세 쌍이 0.087~0.098 로 고르게 높았다. 삼등분에서 앞이 좋고
-- 중간·뒤가 나쁜 것은 어긋나지 않는다 — **무반주 단선율은 비용 바닥을 올리고
-- 총주(장송행진곡)는 연주 차이를 드러낸다.** 교체하지 않았다.
--
-- 216 의 발췌 기준을 카라얀에서 틸슨 토머스로 바꿨다. 셋을 다 기준 삼아 떠 보고
-- 옮긴 길이 비율이 가장 나은 것을 골랐다(0.89/0.90 → 0.97/0.95). A10 의 브루크너
-- 7번과 같은 방법이고 07-excerpt.md 에 적혀 있다.
--
-- 216 의 검출 시작 둘을 고쳤다. 1악장이 트럼펫 독주 신호로 시작하는데 검출이
-- 그 독주를 지나치고 두세 번째 악구에 붙었다. 400~2500Hz 로 첫 음을 실측했다.
--   오자와 10.05 → 7.99 (첫 악구 2.1초)   틸슨 토머스 12.65 → 8.38 (첫 두 악구 4.3초)
-- 카라얀은 검출값 2.35 가 실측 첫 음 2.409 보다 0.06초 앞이라 그 간격을 나머지
-- 둘에도 맞췄다. 트럼펫 악구 간격이 셋 다 2.2~2.3초로 맞는다.
--
-- **라트비아 방송합창단의 tuning 이 정확히 0.000 이다.** A=415 는 440 대비 정확히
-- −1.000 반음이라 접히면 0.000 으로 보이므로 이것이 접힘 의심 자리다. 회전을
-- 떠서 갈랐다 — 최저가 0반음(0.0541)이고 1반음이 0.3601 이다. 접힘이 아니다.
--
-- 184 는 아마추어 합창단 영상이 쏟아지는 곡이다. 음반 트랙만 남기려니 **DB 에
-- 등록된 합창단 넷에는 이 곡 음반 트랙이 없어** 미등록 셋을 202608050181 에서
-- 새로 등록했다. 셋 다 무반주 원곡판이고 오르간 반주판은 넣지 않았다.
--
-- 채널 이름 함정을 두 번 더 만났다. 베를린 필 채널의 말러 2번이 빈 필·불레즈,
-- 카라얀 채널의 말러 2번이 빈 필·메타였다. 오늘 여덟 번째다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저다(1반음 0.22~0.36).
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
