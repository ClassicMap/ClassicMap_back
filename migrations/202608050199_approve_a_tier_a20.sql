-- A tier A20 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   드뷔시 <꿈> 전곡(piece 456):
--     오트 / 티보데 / 브루스 리우                                  0.0478~0.0625
--   라벨 <볼레로> 도입(piece 230):
--     카라얀·베를린필 / 아바도·LSO / 솔티·시카고심포니              0.0870~0.0969
--   라벨 피아노 협주곡 G장조 M. 83 1악장 도입(piece 233):
--     조성진·넬손스·보스턴 / 아르헤리치·아바도·베를린필 /
--     로제·뒤투아·몬트리올                                         0.0631~0.0682
--
-- **볼레로에서는 정렬 비용이 자리를 가려 주지 못한다.** 같은 선율이 18번 되풀이되는
-- 곡이라 한 바퀴 밀린 블록도 비용이 낮게 나온다. 같은 녹음 안에서 재 보았다.
--
--   연주     마디      A1↔A2(한 바퀴 뒤)   발췌↔한 바퀴 밀린 블록
--   카라얀   2.758s    0.0596              0.1341
--   아바도   2.509s    0.0915              0.0849
--   솔티     2.580s    0.0925              0.0830
--
-- **아바도·솔티는 한 바퀴 밀린 블록이 자기 되풀이보다 오히려 더 잘 붙는다**
-- (0.0849 대 0.0915, 0.0830 대 0.0925). 그리고 그 값들이 실제 교차 정렬
-- (0.0870~0.0969)과 같은 대역이다. **비용만 보면 한 바퀴 밀린 정렬과 맞는 정렬을
-- 구별할 수 없다.**
--
-- 그래서 이 곡을 지키는 것은 비용이 아니라 **`anchor: head` 로 머리에 고정한 것**
-- 뿐이다. 배치를 정의할 때부터 그렇게 잡았고 바꾸지 않았다. 세 연주 모두 작은북
-- 오스티나토의 첫 타가 구간 안에 있는지 파형으로 따로 확인했다
-- (`logs/boundary-230-snare.log`).
--
-- 03-verification.md 의 "자기 자신과의 정렬" 을 이렇게도 쓸 수 있다 — 트랙의 진위를
-- 가리는 데가 아니라 **그 곡에서 비용이 쓸 만한지**를 재는 데다.
--
-- 볼레로의 비용 0.0870~0.0969 가 다른 곡보다 높은 것도 같은 이유다. 도입이 작은북
-- 하나라 조성 성분이 거의 없다. 세 쌍이 **함께** 높고 한 연주의 두 쌍만 오르는 모양이
-- 아니다. A19 의 목신(무반주 플루트) · A17 의 파가니니 2번(종소리) · A8 의
-- 셰헤라자데와 같은 구조적 바닥이다.
--
-- **233 은 채찍 소리가 구간 안에 있는지 따로 확인했다**(`logs/boundary-233-whip.log`).
-- 큐가 "채찍 소리 한 번과 피콜로의 첫 주제(악장 시작)" 인데 검출이 채찍을 지나쳐
-- 피콜로에 붙기 쉬운 자리다.
--
-- 233 은 세 건 모두 배급 표기에 `Piano Concerto in G Major, M. 83: I. Allegramente`
-- 가 박혀 있다. **왼손을 위한 협주곡(D장조 M. 82)과 섞이지 않았다.**
-- 456 은 세 건 모두 피아노 독주다. 관현악 편곡판은 배제했다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저이고 차점까지 0.13~0.24 여유가 있다.
--
-- **카라얀 +0.310 과 아르헤리치 +0.270 은 둘 다 베를린 필이다.** 03-verification.md
-- 에 적은 카라얀 시절 BPO 고피치(A≈448)와 맞고 건너편(A≈422)은 말이 안 되므로 접힘
-- 의심 자리가 아니다. 반음 이하 조율 차이로 덩어리가 지는지도 따로 봤다 — 230 은
-- 카라얀이 홀로 떨어져 있는데 카라얀↔아바도가 세 쌍 중 가장 낮고, 233 은 아르헤리치의
-- 두 쌍과 나머지 한 쌍의 차이가 0.005 다. **갈리지 않는다.**
--
-- 인물·단체 열다섯 곳이 모두 이미 등록돼 있어 인물 마이그레이션이 없다. A13 · A19 ·
-- A18 에 이어 네 번째다.
--
-- **남겨 둘 것 — 미등록을 피해 연주를 고른 자리가 둘 있다.** 233 에서 지메르만
-- (Cleveland·불레즈)과 바부제(Tortelier)를 먼저 골랐다가 지휘자가 DB 미등록이라
-- 로제로 바꿨다. 오디오는 받지 않았다. **등록 여부가 선정을 흔든 것이므로**, 불레즈
-- (Q154216)와 Tortelier 를 등록하면 더 나은 후보로 다시 짤 수 있다.
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
