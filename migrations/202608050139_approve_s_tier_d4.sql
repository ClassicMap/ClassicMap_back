-- S tier 대기열 D4 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   차이콥스키 교향곡 5번 2악장 도입(piece 453): 페트렌코·베를린필 /
--     하이팅크·콘세르트허바우 / 게르기예프·빈필                         0.0588~0.0668
--   버르토크 관현악을 위한 협주곡 2악장 도입(piece 327): 카라얀·베를린필 /
--     번스타인·뉴욕필 / 두다멜·LA필                                     0.0604~0.0630
--   버르토크 현·타·첼 3악장 도입(piece 328): 하이팅크·콘세르트허바우 /
--     뒤투아·몬트리올 / 오자와·보스턴심포니                             0.0750~0.0990
--
-- 검출 9건 중 8건을 고쳤다. 지금까지 중 가장 나쁜 비율이고, 세 곡이 각각 다른 이유로
-- 틀렸다. 원본은 detected.orig.json 에 있다.
--
-- ## 차이콥스키 5번 2악장 — 저현 코랄 27~37초를 통째로 버렸다
--
--   페트렌코  28.03 → 1.05   하이팅크  37.55 → 1.00   게르기예프 11.22 → 10.48
--
-- 검출값이 둘 다 **호른 주제 진입 지점**이었다. 이 악장은 저현의 여린 코랄로 시작하고
-- 유명한 호른 선율은 그 뒤에 나온다. 250~1200Hz 대역이 1.0초부터 -43 → -26dB 로
-- 오르고 하모닉 RMS 가 광대역 RMS 와 1~2dB 차이로 붙어 있어 조성음임을 확인했다.
-- 하이팅크는 0.93초까지가 테이프 히스였다(rms-harm 7dB, 평탄도 0.011~0.020).
--
-- ## 버르토크 관현악 협주곡 2악장 — 작은북을 음악으로 보지 못했다
--
--   카라얀  14.23 → 2.26   번스타인 12.56 → 0.16   두다멜 1.32 → 0.16
--
-- 이 악장은 작은북의 홑 리듬으로 시작하고 바순 짝이 그 뒤에 들어온다. 카라얀·번스타인의
-- 검출값이 둘 다 **바순 진입 지점**이었다. 작은북 타는 조성 성분이 없어(하모닉 RMS 가
-- 광대역보다 16dB 아래) 검출기가 음악으로 보지 않는다. 박수 마스크 오탐은 아니었다
-- (평탄도가 어디서도 0.05 를 넘지 않았다).
--
-- ## 버르토크 현·타·첼 3악장 — 실로폰 아첼레란도가 임계를 넘는 지점을 잡았다
--
--   하이팅크 8.38 → 1.09   뒤투아 8.61 → 0.72   오자와 8.45 → 1.84
--
-- 검출값 셋이 8.4~8.6초로 거의 같아 맞는 값처럼 보였으나 **우연이었다.** 실로폰이
-- 홑음을 아첼레란도로 반복하는데 그 간격이 촘촘해지는 지점이 세 녹음에서 비슷했을
-- 뿐이다. 실로폰 대역(1.2~6kHz)이 튀는 자리를 찾아 고쳤다.
--
-- 고친 값이 같은 음악적 자리인지 교차 확인했다. 327 의 작은북 타점 간격(1.44/1.5/1.48초)과
-- 도입 길이(11.7/12.1/11.0초), 328 의 실로폰 첫→둘째 타 간격(3.53/4.09/3.43초)이
-- 세 연주에서 서로 맞아떨어졌다.
--
-- ## 328 의 정렬 비용이 높은 이유
--
-- 세 쌍이 0.0750~0.0990 으로 이 배치에서 가장 높다. 뒤투아와 오자와를 각각 잡고 떠 봤다.
--   * 구간 삼등분에서 **어느 연주를 잡아도 앞 1/3 이 가장 나쁘고 중간이 가장 좋다**
--     (뒤투아 기준 앞 0.131/0.109, 중간 0.096/0.065, 뒤 0.077/0.069)
--   * 끝점 훑기 115~137.5초가 0.0984~0.1052 로 평평하고 최저와 현재 값의 차이가 0.0024다.
--     여러 쌍이 함께 내려가는 모양도 아니다. 경계 오류가 아니다
--   * 12방향 회전에서 0반음 0.099 가 최저(나머지 0.126~0.206). 이조가 아니다
--   * 시작점을 뒤로 옮길수록 조금씩 좋아지지만(17.2초에서 0.0927) 섹터 큐가 "실로폰의
--     홑음 반복 첫 타(악장 시작)" 이므로 옮기지 않았다
--
-- **3악장 도입은 실로폰이 한 음(F#)만 반복하는 대목이라 chroma 에 화성 정보가 거의 없다.**
-- 세 쌍이 모두 그 구간에서만 오르고 중간·뒤는 0.063~0.077 로 다른 두 곡과 같은 대역이다.
-- 판본 차이가 아니라 이 대목의 성질이다. 임계(0.11) 아래이므로 그대로 뒀다.
--
-- ## 채널명 함정
--
-- "Berliner Philharmoniker" 채널에서 오자와·BPO, 페트렌코·BPO, 게르기예프·**빈필**이
-- 섞여 나왔다. 네 배치 연속이다. 전부 영상 설명의 배급 표기로 확정했다.
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
