-- A tier A24 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   아이브스 <대답 없는 질문> 전곡(piece 370):
--     번스타인·뉴욕필 / 틸슨 토머스·시카고심포니 / 길렌·SWR          0.0889~0.0936
--   아이브스 교향곡 4번 1악장 Prelude(piece 371):
--     오자와·탱글우드합창단·보스턴 / 틸슨 토머스·SF합창단·SF심포니 /
--     리턴·댈러스합창단·댈러스심포니                                 0.0719~0.0741
--   아이브스 콩코드 소나타 1악장 "에머슨"(piece 372):
--     에마르 / 아멜랭 / 뎅크                                         0.0735~0.0876
--
-- **370 에서 슬래트킨을 길렌으로 바꿨다.** 처음 편성(번스타인·틸슨 토머스·슬래트킨)
-- 에서 슬래트킨이 낀 두 쌍만 임계를 넘었다.
--
--   번스타인 ↔ 틸슨 토머스   0.0905
--   번스타인 ↔ 슬래트킨      0.1465  (초과)
--   틸슨 토머스 ↔ 슬래트킨   0.1310  (초과)
--
--   회전 12방향 최저가 0반음(0.1465) — 이조 아님
--   시작점 훑기 0~16.8초에서 0.1452~0.1527 로 평평 — 경계 아님
--
-- **"한 연주만 바깥" 모양이다.** 길렌으로 바꾸니 0.0889 / 0.0905 / 0.0936 이 됐다.
--
-- **370 은 이 배치에서 비용 바닥이 가장 높다**(0.089~0.094). 곡 구조 때문이다 —
-- 현이 여린 지속 화음을 곡 내내 바닥에 깔고 무대 밖 트럼펫과 목관이 **서로 다른
-- 템포로 따로 논다.** 세 층이 동기화되지 않는 것이 이 곡의 뜻이므로 녹음마다 무대 밖
-- 배치와 마이킹이 달라 chroma 가 어긋난다. 셋이 **함께** 높고 한 연주의 두 쌍만
-- 오르는 모양이 아니다. A19 목신 · A20 볼레로 · A17 파가니니 2번과 같은 구조적 바닥이다.
--
-- **370 번스타인의 시작이 17.2초 늦었다**(17.39 → 0.23). 현의 여린 지속 화음이
-- 광대역 RMS 로 안 잡히는 자리다. 오늘 이 유형에서 잡은 것이 일곱 건이고 가장 큰
-- 것이 101초였다(A22 오 포르투나, 그때 비용이 0.0698 로 통과권이었다).
--
-- **370·371 의 끝을 다섯 건 늘렸다.** 번스타인 355.43 → 367.00, 틸슨 토머스
-- 427.22 → 431.50, 오자와 154.44 → 172.90, 틸슨 토머스 205.08 → 212.20, 리턴
-- 200.95 → 203.40. 370 은 트럼펫의 마지막 "질문" 이 현의 지속 화음 위에 여리게 남고
-- 그 뒤 현이 더 이어지는 구조라 큐가 그것까지 가리킨다. 오늘 종결부 보정이 스무 건째다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저다. 370 의 tuning 은 +0.03 / +0.13 / +0.18
-- 로 폭이 0.15 반음이고, 0 근처인 번스타인(+0.03)의 건너편 A≈415 는 뉴욕필 녹음에
-- 해당하지 않는다.
--
-- **371 은 1악장 Prelude 에 합창이 든다.** 합창단 셋을 처음부터 넣었다 — A12 의 천인
-- 교향곡에서 빠뜨려 나중에 보탠 일이 있었다. 차례는 CONDUCTOR → CHOIR → ORCHESTRA 다.
--
-- **372 콩코드 소나타는 45분 전곡 트랙에서 1악장 "에머슨" 120초를 발췌했다.**
-- 아이브스가 판을 여럿 남기고 연주자마다 즉흥을 섞는 곡인데 세 쌍이 0.0735~0.0876 으로
-- 모여 같은 대목임이 확인됐다.
--
-- 202608050203 에서 인물·단체 일곱 곳을 등록했다. 에마르의 QID(Q561097)는 앞 세션이
-- `TBD` 로 비워 둔 것을 채운 값이다.
--
-- **이 배치는 서브에이전트가 보고 전에 멈춘 뒤 로그에서 되짚어 발행했다.** 다만
-- A19 와 달리 `verify.log` · `rotate-370/371/372.log` · `verify-with-slatkin.log` ·
-- `diagnose-370-*.log` 가 모두 남아 있어 다시 재지 않았다. 로그를 남기라는 지시가
-- 값을 한 자리다.
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
