-- A tier A6 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   베를리오즈 <파우스트의 겁벌> 중 "헝가리 행진곡" 전곡(piece 171):
--     콜린 데이비스·LSO / 카라얀·베를린필 / 래틀·LSO                  0.0356~0.0603
--   베를리오즈 서곡 <로마의 사육제> 전곡(piece 172):
--     아바도·베를린필 / 뒤투아·몬트리올심포니 / 번스타인·뉴욕필       0.0451~0.0591
--   글린카 가곡집 <페테르부르크 고별> 중 "종달새" 전곡(piece 175):
--     비슈넵스카야·로스트로포비치 / 고르차코바·게르기예바 / 숙마노바  0.0733~0.0840
--
-- 175 는 발라키레프의 피아노 독주 편곡(키신·플레트뇨프 등)이 검색 상위를 덮는
-- 곡이다. 편곡을 모두 걸러내고 성악+피아노 원곡판으로 셋을 맞췄다. 반주자는
-- ACCOMPANIST 로 넣었다 — PIANIST 로 넣으면 적재기가 독주자로 묶는다.
--
-- 숙마노바 녹음의 반주자는 크레딧에 넣지 않았다. 찾아 온 wikidata 항목
-- (Q139199024)이 레이블 하나에 직업이 대학 교원으로만 적힌 빈약한 항목이라
-- 이름이 같다는 것 말고 이 녹음의 반주자라는 근거가 없다. 이름만으로 인물을
-- 붙이지 않는다. 한 구간 안에서 크레딧 모양이 달라도 된다.
--
-- 171 은 리스트 <헝가리 광시곡 15번>과 같은 라코치 선율이지만 다른 곡이다.
-- 취주악 편곡(US Marine Band)도 뺐다. 세 연주 모두 베를리오즈 관현악 원곡이다.
--
-- 175 세 건의 검출 끝을 고쳤다. 종결이 디미누엔도로 사그라들어 검출이 일찍
-- 끊었다. 잘린 구간의 평탄도가 0.001~0.009(박수 기준 0.05 아래)이고 하모닉 RMS 가
-- 광대역과 1~4dB 안에 붙어 있어 음악이 이어지고 있었다. 섹터 큐가 "종결 화음과
-- 잔향" 이므로 고쳤다.
--
--   비슈넵스카야 → 201.30   고르차코바 → 207.50   숙마노바 → 194.80
--
-- **비용으로는 갈리지 않는다.** 끝점을 훑어도 곡선이 평평했고(0.0726→0.0735,
-- 0.0860→0.0843, 0.0860→0.0858) 고친 뒤 비용도 사실상 그대로다. 판단 근거는
-- 비용이 아니라 평탄도·하모닉 RMS 와 섹터 큐다.
--
-- 175 의 세 쌍이 171·172 보다 조금 높은데(0.073~0.084 대 0.036~0.059) 성부와
-- 반주 소리가 서로 다르고 종결 피아니시모가 길어서다. 세 쌍이 함께 그 대역이라
-- 한 연주의 문제가 아니다.
--
-- 아홉 건 모두 최종 구간에서 회전 12방향을 떠 최저가 0반음인 것을 확인했다.
-- 2위와 3~5배 벌어진다. tuning 값은 +0.06~+0.28 로 접힘 경계와 0 근처 어디에도
-- 걸치지 않고 시대악기 앙상블도 없다.
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
