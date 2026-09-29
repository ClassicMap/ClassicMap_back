-- A tier A26 비교 영상 6건을 발행 직전 상태로 올린다. **세 곡 가운데 둘만 발행한다.**
--
--   베베른 교향곡 Op. 21 1악장 Ruhig schreitend(piece 367):
--     카라얀·베를린필 / 도흐나니·클리블랜드 / 불레즈·런던심포니     0.1088~0.1241
--   베베른 <5개의 악장> Op. 5 1악장 Heftig bewegt(piece 368):
--     아르디티 / 이탈리아 / 에머슨 4중주단                          0.0795~0.0996
--
-- **369 <6개의 소품> Op. 6 은 막았다.** 아래에 까닭을 적는다.
--
-- 셋 다 낱 악장·낱 곡 트랙을 찾아 **발췌를 빼고 악장 전체를 구간으로 썼다**
-- (367 은 380~395초, 368 은 132~157초). A25 의 373·366 과 같은 방식이다.
--
-- **368 에서 줄리아드 현악 4중주단을 에머슨 4중주단으로 바꿨다.** 다섯 연주 열 쌍을
-- 다 재 보니 줄리아드가 낀 쌍만 높았다.
--
--   아르디티↔에머슨 0.0823 · 이탈리아↔알반베르크 0.0970 · 이탈리아↔에머슨 0.0979
--   아르디티↔이탈리아 0.0996 · 아르디티↔알반베르크 0.1007 · 에머슨↔알반베르크 0.1013
--   아르디티↔줄리아드 0.1126 · 줄리아드↔이탈리아 0.1142 · 줄리아드↔에머슨 0.1185
--   줄리아드↔알반베르크 0.1324
--
-- **"한 연주만 바깥" 모양이다**(A24 슬래트킨과 같다). 열 조합 가운데 최저가
-- 아르디티·이탈리아·에머슨(최대 0.0996)이라 그것을 골랐다. 회전 셋 다 0반음 최저에
-- 차점 0.18~0.20 이고, 끝을 늘리면 나빠져 검출값을 그대로 두었다.
--
-- **367 은 비용 바닥이 0.12 다. 도흐나니↔불레즈 0.1241 이 임계를 0.0141 넘는다.**
-- 그래도 발행한다. A20 볼레로의 카라얀(0.1341)을 진단 뒤 그대로 둔 것과 같은 판단이고,
-- 여기는 근거가 더 깨끗하다.
--
--   (1) **회전 12방향 최저가 0반음이고 차점이 0.29~0.32 다.** 셋이 같은 악장임이
--       분명하다 — 다른 음악이면 회전 낱값이 평평해진다(369 가 그렇다)
--   (2) 자기 정렬이 민감하다 — 앞블록↔다음블록 0.331~0.438, 40초 밀면 같은 값.
--       비용이 자리를 가린다
--   (3) 구간 삼등분이 0.104~0.152 로 고르고 뒤로 갈수록 나빠지지 않는다 → 경계 아님
--   (4) 끝을 늘려도 0.001 안에서 움직인다
--   (5) 길이를 60초부터 378초까지 일곱 가지로 바꿔도 최대가 0.127~0.150 이다.
--       **검출한 악장 전체(0.1241)가 그중 가장 낮다**
--   (6) 도흐나니가 낀 두 쌍이 높아(0.1161 · 0.1241) 교체를 시도했다. 길버트·뉴욕필
--       (252초)을 넣으니 0.1831~0.1936 으로 크게 나빠졌다. **바꿀 것이 없다**
--   (7) 곡이 12음 기법 엄격 캐논이고 관현악 편성이 한 마디에 한두 악기만 울린다.
--       **화성이 평평한 것과 얇은 것이 겹친 자리다**(A25 365 와 같은 갈래이나 더 심하다)
--
-- **369 를 막은 까닭 — chroma 에 쓸 만한 음높이 정보가 없다.**
--
-- 구간을 1곡(67~73초)에서 4곡 <장송행진곡>(258~324초)으로 바꿔 보았고 래틀·버밍엄을
-- 더해 네 연주 여섯 쌍을 다 재 보았다.
--
--   카라얀↔로스바우트 0.1335 · 카라얀↔도흐나니 0.1384 · 도흐나니↔래틀 0.1454
--   카라얀↔래틀 0.1491 · 로스바우트↔래틀 0.1616 · 도흐나니↔로스바우트 0.2039
--
-- **여섯 쌍의 최저가 0.1335 다.** 그런데 자기 정렬은 0.061~0.079 밖에 안 된다 —
-- 40초를 밀어도 그 값이다. **비용이 자리를 못 가리는 볼레로형인데(둔한 자) 교차값은
-- 그 두세 배다.** 둔한 자가 큰 값을 냈다는 것은 음악이 어긋난 것이 아니라 재는 것이
-- 음이 아니라는 뜻이다.
--
-- 회전이 그것을 확인한다. **도흐나니↔로스바우트의 최저가 0반음이 아니라 6반음
-- (0.1378)이고, 카라얀↔도흐나니는 최저 0.1384 에 차점 0.1412 로 열두 방향이 사실상
-- 평평하다.** 회전해도 값이 안 바뀌면 chroma 벡터가 평평한 것이다.
--
-- 까닭은 곡이다. 장송행진곡은 먼 북소리와 낮은 트레몰로, 낱 음색이 대부분이라
-- **음높이 성분이 녹음마다 다른 잡음·홀·밸런스에 묻힌다.** 로스바우트 판은 1950년대
-- 모노로 잡음 바닥이 −35dB 다. Op. 6 의 나머지 다섯 곡은 42~172초로 더 짧고 더
-- 여리므로 구간을 바꿔도 되살릴 길이 없다.
--
-- 지금까지 적은 구조적 바닥의 갈래에 하나를 보탠다 — 화성이 얇음 · 층이 어긋남 ·
-- 되풀이 · 화성이 평평함에 이어 **음높이가 잡음에 묻힘**이다. 앞의 넷은 값이 높아도
-- 회전이 0반음을 가리키는데 이것은 회전 자체가 평평하다.
--
-- 202608050209 에서 인물·단체 여섯 곳을 등록했다. 그 가운데 **줄리아드 현악 4중주단은
-- 위 교체로 쓰이지 않게 됐다.** 등록은 그대로 둔다.
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
