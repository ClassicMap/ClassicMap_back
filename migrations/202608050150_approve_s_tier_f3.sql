-- S tier 대기열 F3 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   번스타인 <캔디드> 서곡 전곡(piece 338): 번스타인·뉴욕필 / 네제세갱·런던심포니 /
--     두다멜·빈필                                                       0.0469~0.0590
--   바그너 <탄호이저> 서곡 도입(piece 147): 아바도·베를린필 /
--     얀손스·바이에른방송 / 넬손스·게반트하우스                          0.0405~0.0507
--   모차르트 <마술피리> "밤의 여왕 아리아"(piece 70): 조수미·솔티·빈필 /
--     미클로샤·아바도·말러체임버 / 그루베로바·아르농쿠르·취리히오페라    0.0503~0.0566
--
-- 탄호이저는 셋 다 드레스덴판이다(860/870/911초). 파리판("서곡과 베누스베르크 음악")은
-- 1280~1300초 대라 길이로 갈렸다. 147 만 발췌하고 338·70 은 낱 트랙을 통째로 썼다.
--
-- ## 밤의 여왕 아리아에서 연주 둘을 바꿨다 — 조율 피치 때문이다
--
-- 처음 고른 셋은 담라우 / 드비엘헤 / 조수미였고 담라우↔조수미가 0.1158 로 임계를
-- 넘었다. 조수미를 진단하니 이조도(0반음 0.116, 나머지 0.191~0.275) 경계도 아니었다
-- (시작·끝 훑기가 모두 평평, 삼등분도 고르게 나쁨). 2번 패턴이다.
--
-- 예비 연주 둘을 받아 다섯 연주 교차표를 뜨니 **두 덩어리로 갈렸다.**
--
--   {조수미, 미클로샤, 그루베로바}  0.0503~0.0566
--   {담라우, 드비엘헤}              0.0676
--   두 덩어리 사이                  0.0948~0.1158
--
-- **덩어리가 align.tuning() 값과 정확히 겹친다.**
--
--   담라우 (Le Cercle de l'Harmonie)  -0.38 반음
--   드비엘헤 (Ensemble Pygmalion)     -0.38
--   조수미 (빈필)                     +0.27
--   미클로샤 (말러 체임버)            +0.17
--   그루베로바 (취리히 오페라)        +0.16
--
-- 앞의 둘은 시대악기 편성(A≈430)이고 나머지 셋은 현대 피치다. **반음 이조가 아닌데도**
-- (회전 최저가 셋 다 0반음) 반음보다 작은 피치 차이가 chroma 에 남는다. 지금까지
-- 시대악기 연주를 "이조로 걸린다" 는 이유로 미리 빼 왔는데, 실제 기제는 이조가 아니라
-- 이것이었다.
--
-- 규칙 문구("교차표에서 임계를 넘는 쌍이 생기면 그 연주가 바깥") 만 보면 담라우 하나만
-- 빼면 되지만 드비엘헤도 함께 뺐다. 드비엘헤만 남기면 0.0511 / 0.0988 / 0.1025 로 두
-- 쌍이 선에 붙은 채 분포가 두 덩어리로 갈린다. "통과" 가 아니라 "간신히 안 걸린" 것이다.
-- 원래 규칙은 편성·조율이 다른 연주를 섞지 않는 것이고 그쪽이 더 근본이다.
-- 그 대가로 등록 소프라노가 조수미 하나만 남고 미등록 넷을 새로 넣었다(202608050148).
--
-- ## 검출
--
-- 시작 여섯 건을 고쳤다. 전부 여린 도입을 지나친 유형이다. 광대역 RMS 와 하모닉 RMS 가
-- 붙는 지점 + 250~1200Hz 대역이 뛰는 지점으로 첫 음을 되짚었다.
--
--   두다멜 338   0.12 → 0.42   0.05~0.42 는 rms -92 → -54 인데 하모닉이 -67 에 머물러
--                              13dB 벌어진다(장내 암소음 페이드업)
--   아바도 147   3.69 → 2.82 / 얀손스 2.28 → 1.02 / 넬손스 1.18 → 1.14
--   70 세 건     1.44~2.30 → 0.12~0.88
--
-- **"지옥의 복수" 는 여린 관현악 두 마디 뒤에 총주 포르테가 온다.** 검출기가 그 포르테에
-- 붙었다. 다섯 녹음 모두 같은 모양이었고 여린 첫 음에서 포르테까지의 간격이
-- 1.59~1.80초로 일치해 여린 부분이 음악임을 확인했다. 비용은 ±0.001 밖에 움직이지
-- 않았지만 섹터 큐가 "관현악 전주의 첫 박" 이라 첫 음으로 되돌렸다(202608050128 과
-- 같은 판단 — 판단 근거는 비용이 아니라 큐다).
--
-- 끝은 아홉 건 모두 그대로 뒀다. 두다멜만 275.6초부터 박수인데(평탄도 0.05~0.11)
-- 검출 끝 275.30 이 그 직전에서 끊겼다.
--
-- ## 그 밖에
--
-- "Herbert von Karajan" 채널의 한 영상이 솔티·빈필이어서 뺐다. 일곱 배치 연속이다.
-- 338 은 취주악 편곡·뮤지컬 실황·브라스 편곡을 뺐다.
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
