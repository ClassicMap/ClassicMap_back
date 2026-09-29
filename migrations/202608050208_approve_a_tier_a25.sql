-- A tier A25 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   아이브스 <뉴잉글랜드의 세 장소> 1곡 "세인트고든스 기념상"(piece 373):
--     틸슨 토머스·보스턴 / 마주어·뉴욕필 / 슬래트킨·세인트루이스     0.0733~0.0791
--   베르크 바이올린 협주곡 1악장 Andante 도입(piece 365):
--     무터·러바인·시카고 / 펄만·오자와·보스턴 / 카퓌송·하딩·빈필     0.1029~0.1105
--   베르크 <서정 모음곡> 1악장 Allegretto gioviale(piece 366):
--     에머슨 / 알반 베르크 / 라살 4중주단                            0.0871~0.1044
--
-- **검출기가 무터의 시작을 38.06초로 잡았다. 35.6초를 놓친 것이다.**
-- 365 는 anchor head 120초 발췌라 그냥 두면 완전히 다른 대목을 담았을 것이다.
--
-- 원인이 새 갈래다. **머리가 디지털 무음(-100dB)인데 도입이 너무 여려 광대역
-- -45dB 규칙이 52초까지 밀린다.** 02-detection.md 의 세 규칙 가운데 기본(조성 바닥
-- +8dB)과 디지털 무음용(광대역 -45dB)이 둘 다 듣지 않는다. 협대역 250~1200Hz >
-- -20dB 을 세 연주에 같이 적용해 6.28 / 4.86 / 3.26 을 얻었다. 검출기는 펄만·카퓌송
-- 에서는 이 값과 거의 같게 잡았고 무터에서만 무너졌다.
--
-- **366 은 셋 다 검출이 맞다.** 디지털 무음 뒤 4중주 총주 타건이라 모든 문턱이
-- 0.4초 안에 함께 넘는다. 알반 베르크 4중주단의 10.17초는 진짜 시작이다.
--
-- **373 의 종결부를 둘 늘렸다** — 마주어 484.88 → 486.50, 슬래트킨 518.46 → 522.50.
-- 꼬리 음량을 직접 보고 고쳤다. 셋 다 "근무음 → 큰 종결 화음 → 감쇠" 모양인데
-- 검출기가 그 화음 뒤 잔향을, 슬래트킨에서는 화음 3초까지 버렸다. 늘리니 **세 쌍이
-- 함께 내려갔다**(최대 0.0808 → 0.0791). 틸슨 토머스는 트랙 파일 자체가 종결 화음
-- 도중(515.99초, -46dB)에 끊겨 있어 늘릴 것이 없다. 음원의 한계다.
--
-- 처음에는 그 큰 대목을 **2악장 <퍼트넘 캠프>의 머리로 의심했다.** 틸슨 토머스와
-- 슬래트킨 트랙에만 있고 마주어 트랙에는 없어 보였기 때문이다. 아니었다 — 마주어도
-- 자기 끝에서 같은 모양을 보이고, 잘라내 보니 비용이 오히려 올라갔다(0.0808 → 0.0829).
-- **1악장의 종결 화음이다.** 의심의 결론이 늘 "잘라라" 는 아니다.
--
-- **365 의 비용 바닥이 0.11 이다. 펄만↔카퓌송 0.1105 는 임계를 0.0005 넘는다.**
-- 곡 구조 때문이고 경계나 창 문제가 아니다. 근거 일곱이다.
--
--   (1) 되풀이 시험 0.313~0.387, 자기 밀기가 단조 급증(+2초 0.011 → +40초 0.32)
--       → **비용이 자리를 가린다.** A20 볼레로형이 아니다
--   (2) 시작점 훑기가 ±4초에서 0.105~0.128 로 평평하고 뚜렷한 최저가 없다 → 경계 아님
--   (3) 발췌 길이를 45초부터 300초까지 아홉 가지로 바꿔도 최대가 0.11~0.13 에 머문다
--   (4) 펄만·카퓌송 창 길이 격자 25칸의 최저가 **곧 부분열 DTW 가 고른 값**(0.1105)
--       이다. 창은 이미 최적이다
--   (5) 회전 12방향 최저가 0반음(0.1105), 차점 7반음 0.3487 → 이조 아님
--   (6) **최악 쌍이 펄만↔카퓌송으로 고정이고 둘 다 무터와는 0.1029 다.** A13 카라얀과
--       같은 "둘이 서로에게만 멀다" 모양이고 A24 슬래트킨 같은 "한 연주만 바깥" 이
--       아니다. 바꿀 대상이 없다
--   (7) 곡이 12음 기법이라 조성 중심이 없어 chroma 가 열두 음계급에 고르게 퍼지고,
--       도입은 하프·클라리넷·독주 바이올린뿐이라 짜임이 얇다. **화성이 평평한 것과
--       얇은 것이 겹친 자리다**
--
-- 화성이 평평해 바닥이 높은 갈래를 A25 에서 처음 실측했다. 같은 12음 기법인 366 은
-- 현악 4중주라 짜임이 두꺼워 0.0871~0.1044 로 임계 아래에 든다. **같은 기법이라도
-- 짜임이 두꺼우면 바닥이 내려간다.**
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저다. 차점까지 373 은 0.15, 365 는 0.20,
-- 366 은 0.14 이상 벌어진다. tuning 폭은 373 0.02 · 365 0.15 · 366 0.11 반음이다.
-- 0 근처인 펄만(+0.01)과 라살(-0.04)은 둘 다 1970~80년대 현대 악기 녹음이라 A=415
-- 접힘이 해당하지 않는다.
--
-- **366 의 끝은 셋 다 검출값을 그대로 두었다.** 끝을 늘리면 모든 쌍이 단조로 나빠진다
-- (에머슨 0.0871 → 0.0903, 라살 0.1044 → 0.1070). 남은 몇 초는 음악이 아니다.
--
-- 202608050207 에서 단체 둘을 등록했다(세인트루이스 교향악단 · 라살 4중주단).
-- 나머지 열다섯 곳은 이미 등록돼 있었다.
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
