-- S tier 대기열 D3 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   브람스 교향곡 4번 1악장 도입(piece 452): 아바도·베를린필 / 카라얀·베를린필 /
--     프레빈·로열필                                                     0.0332~0.0456
--   슈만 교향곡 3번 "라인" 1악장 도입(piece 137): 샤이·콘세르트허바우 /
--     무티·빈필 / 바렌보임·시카고심포니                                  0.0356~0.0421
--   차이콥스키 교향곡 6번 "비창" 4악장 Adagio lamentoso 도입(piece 158):
--     카라얀·베를린필 / 하이팅크·콘세르트허바우 / 게르기예프·빈필        0.0413~0.0560
--
-- 아홉 쌍이 0.0332~0.0560 이고 곡 안에서 튀는 쌍이 없다(최대 편차 0.015).
--
-- 검출 시작 여섯 건을 고쳤다. 전부 여린 도입을 지나친 유형이다. 원본은
-- s-d3-detected.orig.json 에 있다.
--
--   브람스4 아바도  13.56 → 12.28  10.72초에 디지털 무음이 끝나고 10.75~12.27초는
--                                  피크가 183~300Hz 에 흩어진 홀 잡음(하모닉 RMS -84dB).
--                                  첫 음 B 의 부분음(495/990Hz)이 12.27초에 선다
--   브람스4 카라얀   2.83 → 2.15   검출값 2.83 은 첫 음 한가운데였다
--   브람스4 프레빈   2.65 → 1.99   1.98초까지 디지털 무음
--   비창 카라얀      0.93 → 0.51   0.14~0.25초의 C#5 미소 신호(-91~-60dB)는 프리에코
--                                  수준이라 제외했다
--   비창 하이팅크    0.88 → 0.83
--   비창 게르기예프  0.70 → 0.81   이쪽은 반대로 0.11초 이른 값이었다
--
-- 라인 세 건은 총주 타격이라 검출값을 그대로 뒀다. 악구 사이 쉼으로 도입이 잘린
-- 경우(202608050128 의 영웅)는 이 배치에 없었다. 여섯 건 모두 첫 음이 검출 시작보다
-- 앞에 연속으로 존재했고 사라진 덩어리가 없음을 확인했다.
--
-- 비창의 길이 비율이 1.22배로 권장 1.2배를 살짝 넘는다. 세 연주를 차례로 기준 삼아
-- 떠 보니 어느 기준에서도 카라얀 : 하이팅크 : 게르기예프 ≈ 1 : 1.22 : 1.14 로 같은 비가
-- 나왔고 정렬 비용도 0.041~0.056 에서 움직이지 않았다. 1812년 서곡처럼 한 기준에서만
-- 벌어지는 모양이 아니므로 옮김 오류가 아니라 도입부의 실제 템포 차로 본다. 카라얀은
-- 악장 전체 길이가 게르기예프와 같은 583초인데 도입만 1.14배 빠르다. 비율이 가장 작은
-- 카라얀 기준을 그대로 뒀다. 202608050116(세레나데 1.21배)과 같은 판단이다.
--
-- 라인의 1.20배는 악장 전체 길이 비율(626.0/524.8 = 1.19)과 일치해 따로 보지 않았다.
--
-- 채널명 함정이 또 걸렸다. 같은 "Berliner Philharmoniker" 채널에 쿠벨리크·번스타인·
-- 무티·게르기예프의 빈필 녹음이 섞여 있었고 "Herbert von Karajan" 채널에 케르테스·
-- 메타의 빈필 녹음이 있었다. 전부 영상 설명의 배급 표기로 확정했다. 세 배치 연속이다.
--
-- 비창 세 건은 첫 음이 셋 다 B4(495~506Hz)로 확인돼 4악장이 맞다(3악장은 여기서
-- 시작하지 않는다). 제목의 악장 번호를 믿지 않고 첫 음으로 확인했다.
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
