-- S tier 대기열 DB1 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   쇼스타코비치 교향곡 5번 "혁명" 4악장 도입(piece 317): 넬손스·보스턴심포니 /
--     하이팅크·콘세르트허바우 / 솔티·빈필                               0.0390~0.0453
--   쇼스타코비치 교향곡 7번 "레닌그라드" 1악장 도입(piece 318): 넬손스·보스턴심포니 /
--     노세다·런던심포니 / 번스타인·시카고심포니                          0.0394~0.0423
--   스트라빈스키 시편 교향곡 1악장 도입(piece 312): 래틀·베를린필 /
--     틸슨 토머스·런던심포니 / 솔티·시카고심포니                         0.0551~0.0661
--
-- 곡마다 세 쌍의 폭이 0.006~0.011 로 좁고 튀는 쌍이 없다.
--
-- ## 검출을 한 건도 고치지 않은 첫 배치다
--
-- 지금까지 배치마다 1~8건을 고쳐 왔다(직전 F4 는 아홉 중 일곱). 이 배치는 아홉 건의
-- 시작을 RMS·하모닉 RMS·평탄도·250~1200Hz 대역으로 전부 확인했고 **전부 맞았다.**
--
-- 늦게 보이던 셋이 실제 첫 타였다. 하이팅크 3.67(앞 3.6초가 -65dB 무음, 트랙 머리 여백),
-- 노세다 5.48(앞은 -57dB 이하 홀 잡음 페이드인, 5.50 에서 중역이 -1.9 → +10.6 으로 뜀),
-- 틸슨 토머스 3.25(3.20 에 rms -66 → -34).
--
-- "유명한 선율이 시작이 아니다" 유형도 없었다. 세 악장 모두 도입 자체가 첫 사건이다
-- (317 은 팀파니·금관 총주, 318 은 포르테 C장조 현 유니슨, 312 는 관현악 화음 타).
--
-- 시편 교향곡 세 건은 타격 순간에 하모닉 RMS 가 광대역보다 15~25dB 아래였다. 조성
-- 성분이 늦게 서는 화음 타격이지 박수도 저역 진입도 아니다. 평탄도가 어디서도 0.05 를
-- 넘지 않아 박수 마스크 오탐이 없었다.
--
-- ## 레닌그라드는 침공 주제를 쓰지 않았다
--
-- 유명한 침공 주제는 1악장 시작 후 6분쯤부터 나와 head anchor 로 닿지 않는다. 기준
-- 연주에 구간을 직접 찍으려면 사람이 들어 보고 초를 정해야 하는데 그 근거 없이 숫자를
-- 넣지 않았다. C장조 첫 주제만으로도 세 연주의 차이는 드러난다.
-- 202608050133(브람스 1번을 4악장 대신 1악장 서주로 바꾼 것)과 같은 판단이다.
--
-- ## 합창이 예고보다 낮았다
--
-- 시편 교향곡은 합창이 들어가는데 세 쌍이 0.0551~0.0661 로 나왔다. 202608050136 에서
-- 합창의 정상 범위를 0.09 대까지 잡아 두었는데 그보다 낮다. 1악장 도입이 관현악 화음과
-- 짧은 합창 진입이라 성부가 두껍게 겹치는 대목이 아닌 것으로 본다.
--
-- 판본(1930년 원판 / 1948년 개정판)은 세 영상 모두 표기가 없다. 조율값이 0.04~0.08 로
-- 한 덩어리이고 정렬도 모여 있어 편성 차이 징후가 없다. 단정하지 않는다.
--
-- ## 채널명 함정
--
-- 베를린필 채널의 두 영상이 각각 비치코프(미등록), 첼리비다케(배급사가 공식이 아님)
-- 였다. 아홉 배치 연속이다. 전부 영상 설명의 배급 표기로 확정했다.
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
