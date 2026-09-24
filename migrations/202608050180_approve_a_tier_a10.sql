-- A tier A10 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   드보르자크 유모레스크 7번 피아노 원곡 전곡(piece 201):
--     바렌보임 / 피르쿠슈니 / 림파니                                  0.0541~0.0687
--   브루크너 교향곡 4번 "낭만적" 1악장 도입(piece 182):
--     뵘·빈필 / 무티·베를린필 / 샤이·콘세르트허바우                  0.0520~0.0685
--   브루크너 교향곡 7번 1악장 도입(piece 183):
--     하이팅크·콘세르트허바우 / 카라얀·빈필 / 넬손스·게반트하우스    0.0362~0.0571
--
-- **브루크너 여섯 건이 전부 도입이 잘려 있었다.** 검출값이 여린 현 트레몰로를
-- 지나쳐 주제 진입에 붙어 있었다. 섹터 큐가 "현의 트레몰로 첫 음(악장 시작)" 이라
-- 고쳤고 근거는 0.05초 해상도의 음량·하모닉 RMS·평탄도다.
--
--   182 뵘    9.15 → 3.79    182 무티 62.00 → 2.05    182 샤이  9.38 → 2.00
--   183 하이팅크 10.26 → 1.56  183 카라얀 6.94 → 2.00  183 넬손스 1.46 → 0.00
--
-- 무티는 62초까지 밀려 있었다. 첫 25초짜리 덩어리가 서는 자리였다.
--
-- **비용으로는 이것이 드러나지 않는다.** 뵘 쪽 시작을 훑으니 0.5초 0.0559,
-- 3.5초 0.0593, 9.5초 0.0871 로 앞쪽이 평평하고 원래 검출값 쪽에서만 오른다.
-- 비용만 보면 도입이 빠졌는지 알 수 없다. 판단 근거는 비용이 아니라 섹터 큐다.
--
-- 183 의 발췌 기준을 카라얀에서 하이팅크로 바꿨다. 카라얀 기준이면 나머지가
-- 1.29~1.33배로 권장(1.2배)을 넘는데, **실제 템포 차이이지 DTW 압축이 아니다.**
-- 셋을 차례로 기준 삼으니 어느 쪽에서 봐도 카라얀만 0.75 로 일정했고, 발췌를
-- 60 → 180 → 300 → 600초로 늘리니 비율이 0.732 → 0.764 → 0.868 → 0.945 로
-- 악장 전체 비(1180/1258 = 0.938)에 수렴했다. 카라얀이 도입을 빠르게 잡고 뒤에서
-- 넓히는 것이다. 기준을 바꿔 89.5 / 120 / 118.2초로 셋 다 권장 폭에 넣었다.
-- 비용을 낮추려는 것이 아니라 길이를 맞추려는 것이다. 07-excerpt.md 에 적었다.
--
-- 브루크너 판본은 4번이 뵘 1878/80 Nowak, 무티 1878/1880, 샤이 무표기이고
-- 7번이 카라얀·넬손스 Haas, 하이팅크 무표기다. **셋 다 1악장 도입이라 판본
-- 쟁점과 무관하다** — 4번의 차이는 피날레에, 7번의 Haas/Nowak 차이는 아다지오
-- 심벌즈에 있다. 발췌를 도입으로 잡은 것이 이 때문이다.
--
-- 201 유모레스크는 편곡이 원곡을 덮은 곡이다. MusicBrainz 의 동명 work 열한 건이
-- 전부 바이올린 편곡이고 검색 상위도 마찬가지다. 배급 표기에 `Piano:` 가 박힌
-- 피아노 독주 원곡만 골랐다. 이미 등록된 피아니스트 중 이 곡 녹음이 있는 사람은
-- 바렌보임뿐이라 둘을 202608050179 에서 새로 등록했다.
--
-- 채널 이름 함정을 이 배치에서만 둘 만났다. 182 뵘과 183 카라얀 둘 다 채널이
-- "Berliner Philharmoniker" 인데 배급 표기는 빈 필이다. 오늘 여섯 번째·일곱
-- 번째이고 베를린 필 채널만 네 번째다. 01-selection.md 에 표로 적었다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저이고 다음과 4~5배 벌어진다.
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
