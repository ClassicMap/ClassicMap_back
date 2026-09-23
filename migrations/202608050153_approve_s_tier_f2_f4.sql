-- S tier 대기열 F2·F4 비교 영상 18건을 발행 직전 상태로 올린다.
--
-- F2 (베르디 오페라 낱곡)
--   <리골레토> 3막 "여자의 마음"(piece 149): 카우프만·모란디 / 베차와·마린·뮌헨방송 /
--     플로레스·리치·밀라노베르디                                        0.0612~0.0733
--   <라 트라비아타> 1막 "축배의 노래"(piece 148): 클라이버·바이에른국립·코트루바슈·도밍고 /
--     무티·라스칼라·파브리치니·알라냐 / 솔티·ROH·게오르기우·로파르도    0.0520~0.0533
--   <아이다> 2막 "개선 행진곡"(piece 150): 카라얀·빈필 / 무티·필하모니아 /
--     파파노·산타체칠리아                                               0.0331~0.0591
--
-- F4 (레퀴엠 낱곡)
--   모차르트 레퀴엠 "라크리모사"(piece 71): 콜린 데이비스·LSO / 카라얀·빈필 /
--     무티·베를린필                                                     0.0456~0.0569
--   베르디 레퀴엠 "진노의 날"(piece 152): 카라얀·베를린필 / 바렌보임·시카고 /
--     번스타인·LSO                                                      0.0417~0.0427
--   브람스 독일 레퀴엠 4곡(piece 157): 아바도·베를린필 / 래틀·베를린필 /
--     카라얀·베를린필                                                   0.0313~0.0549
--
-- 여섯 곡 모두 낱 트랙을 통째로 썼다. 발췌하지 않았다.
--
-- ## 조율 확인 — 시대악기가 섞이지 않았다
--
-- 202608050150 에서 밝힌 대로 반음보다 작은 조율 차이가 chroma 에 남는다. 레퀴엠은
-- 시대악기 연주가 흔한 갈래라 tuning 값을 실측해 확인했다.
--
--   모차르트  +0.09 / +0.24 / +0.23   (폭 0.15반음)
--   베르디    +0.15 / +0.05 / -0.07   (폭 0.22반음)
--   브람스    +0.27 / +0.13 / +0.31   (폭 0.18반음)
--
-- F3 에서 갈렸던 두 덩어리 간격이 0.65반음이었는데 여기 최대 폭은 그 3분의 1이다.
-- -0.38 대 값이 하나도 없다. 가디너·헤레베헤·사발·아르농쿠르는 선정에서 미리 뺐다.
--
-- ## 검출
--
-- F2 는 한 건, F4 는 일곱 건을 고쳤다. 원본은 각 배치의 detected.orig.json 에 있다.
--
-- **F4 라크리모사 셋 다 여린 현 도입을 지나쳤다.** 검출값이 전부 합창이 들어오며
-- 크레셴도하는 자리에 붙었다(데이비스 12.72, 카라얀 0.79, 무티 20.25). 250~1200Hz 가
-- 잡음 바닥에서 10dB 넘게 뛰는 지점을 첫 음으로 되짚었다.
--
-- 무티는 따로 확인했다. 트랙 앞 0.5~5.5초에 라크리모사가 아닌 소리가 있어(페이드인처럼
-- 올라와 3.5초에 -10.7dB 로 부풀고 5.5~7.25초에 -41dB 로 가라앉는다) 부분열 DTW 로
-- 다른 두 연주를 옮겨 봤다. 세 번 다 무티의 8.4~8.7 을 가리켰고 옮김 비용이
-- 0.0235~0.0342 였다. 옮김값보다 이른 7.45 를 쓴 것은 기준 연주 쪽 첫 음이 트랙 머리에
-- 바싹 붙어 잘려 있어서다. 검출값 20.25 를 뒀으면 도입 12.8초가 빠졌을 것이다.
--
-- **F4 베르디 카라얀·바렌보임은 종결부를 53~55초 버렸다.** "진노의 날" 총주가 끝난 뒤
-- 이어지는 여린 "Quantus tremor" 대목에서 덩어리가 끊겼다. 그 뒤로도 하모닉 RMS 가
-- 광대역 RMS 를 1~10dB 차이로 따라붙었고, 평탄도가 0.3~0.7 로 튀는 점은 큰북 타격이지
-- 박수가 아니다(큰 소리 조건에 걸리지 않는다). 고치니 길이 편차가 1.59배에서 1.11배로
-- 줄고 세 쌍이 0.0417~0.0427 로 0.001 안에 모였다.
--
-- **F4 브람스 셋은 마지막 화음의 감쇠를 4~6초씩 잘랐다.**
--
-- **F2 솔티의 축배의 노래는 전주의 첫 두 음을 버렸다.** 첫 온셋이 0.302초인데 검출이
-- 세 번째 온셋(0.998)에 붙었다. 고친 뒤 솔티가 낀 두 쌍이 함께 내려갔지만 변화는
-- 0.0001 뿐이다. 판단 근거는 비용이 아니라 큐다("관현악 전주의 첫 박"). 정수 초로
-- 줄면 발행 구간이 1초에서 0초로 바뀌므로 실제로 영향이 있다.
--
-- ## 큐와 어긋난 것
--
-- **개선 행진곡의 길이를 잘못 적었다.** 큐에 4~6분으로 두었으나 "Marcia trionfale"
-- 낱 트랙은 실제로 1분 26초~1분 45초다. 4~6분짜리는 전부 뒤에 발레(Ballabile)가
-- 붙었거나 앞에 "Gloria all'Egitto" 합창이 붙은 트랙이었다. 큐가 "트럼펫 팡파르 첫 음 →
-- 행진곡 마지막 화음" 이므로 행진곡만 담긴 트랙으로 갔다. 발행 구간 86~104초는 권장
-- 30~120초 안이다.
--
-- **진노의 날의 endCue 는 실물과 어긋난다.** 베르디 레퀴엠 2a 는 총주의 분노가 끝난 뒤
-- 여린 "Quantus tremor" 로 이어지다 **종결 화음 없이** 2b 투바 미룸으로 넘어간다.
-- 세 음반 트랙 모두 이 여린 대목 끝에서 끊기거나 페이드아웃한다. 구간을 큐에 맞추면
-- 트랙을 잘라야 하므로 구간을 두고 endCue 만 고쳤다(202608050143 기사들의 춤과 같은 판단).
--
-- ## 판본
--
-- 라크리모사 셋은 모두 쥐스마이어판이다. 카라얀 건은 영상 설명에 "Workarranger:
-- Franz Xaver Süssmayr" 가 박혀 있다. 길이가 173~206초로 1.19배 벌어지지만 판본
-- 차이가 아니다 — 가장 긴 무티가 낀 두 쌍이 오히려 비용이 낮고(0.0456/0.0470), 전곡
-- 옮김도 길이 비율 1.089 로 고르게 늘어나 특정 지점에서 튀지 않는다. 템포 차이다.
-- 아바도 1999(Ed. Beyer/Levin)는 라크리모사가 쥐스마이어 "Amen" 종지 대신 Amen 푸가로
-- 이어져 트랙 뒷부분이 다르므로 선정에서 뺐다. 이것이 진짜 판본 차이다.
--
-- ## 크레딧
--
-- 축배의 노래 세 건에 성악가를 붙였다(소프라노·테너). 이중창 + 합창이라 지휘자를
-- 주역으로 두지만 노래하는 사람이 연주의 정체성에 들어간다. 그 때문에 등록이 여섯 늘었다
-- (202608050151). 합창단은 위키데이터 항목이 없어 붙이지 못했다 — 바이에른 국립오페라
-- 합창단·ROH 합창단·빈 징페어라인·런던심포니 합창단 등이 여기 해당한다.
--
-- 리골레토 카우프만 건은 악단을 붙이지 못했다. 설명의 "Orchestra dell'Opera di Parma"
-- 가 위키데이터에 없다.
--
-- ## 그 밖에
--
-- 리골레토 세 테너는 셋 다 원조(B장조)다. 12방향 회전에서 0반음이 최저였다
-- (0.061/0.070 대 나머지 0.218~0.359). 아리아는 성악가에 맞춰 조를 옮기는 일이 있어
-- 따로 확인했다.
--
-- "Herbert von Karajan" 채널의 영상 하나가 카를 뵘·빈필이어서 뺐다. 여덟 배치 연속이다.
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

-- 진노의 날의 endCue 를 실물에 맞춘다. 202608050143 과 같은 판단이다.
UPDATE performance_sectors
SET end_cue = '여린 "Quantus tremor" 대목의 끝(종결 화음 없이 투바 미룸으로 넘어간다)'
WHERE sector_key = 'dies-irae' AND piece_id = 152;
