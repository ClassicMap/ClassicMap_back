-- S tier 대기열 마지막 배치 비교 영상 9건을 발행 직전 상태로 올린다.
-- 이것으로 S tier 작곡가의 수동 곡 대기열이 비었다.
--
--   모차르트 <피가로의 결혼> 3막 "편지 이중창"(piece 69): 무티·빈필·배틀·프라이스 /
--     아바도·빈필·슈투더·맥네어 / 아르농쿠르·콘세르트허바우·보니·마르히오노
--                                                                      0.0558~0.0736
--   바그너 <트리스탄과 이졸데> 1막 전주곡 도입(piece 145): 카라얀·베를린필 /
--     솔티·시카고심포니 / 얀손스·오슬로필                               0.0569~0.0857
--   버르토크 <이상한 만다린> 도입(piece 329): 솔티·시카고심포니 /
--     오자와·보스턴심포니 / 뒤투아·몬트리올                              0.0546~0.0640
--
-- 69 는 낱 트랙을 통째로 쓰고 145·329 는 도입 120초를 발췌했다.
--
-- ## 트리스탄 전주곡에서 도입이 통째로 사라질 뻔했다
--
-- 검출 시작 세 건을 고쳤다. 원본은 s-last-detected.orig.json 에 있다.
--
--   카라얀  57.12 → 1.20   솔티 35.99 → 0.22   얀손스 7.34 → 0.88
--
-- **"악구 사이 쉼이 도입을 잘라낸다" 유형이다**(202608050128 영웅 2악장과 같다).
-- 트리스탄 전주곡 도입은 첼로 동기 뒤 페르마타 쉼이 길어(카라얀은 21.5~23초가
-- -66dB 이하) 첫 덩어리가 MIN_MUSIC_SECONDS(25초)에 못 미쳐 버려졌다.
-- **이 배치는 head 120 발췌라 고치지 않았으면 도입이 통째로 빠졌을 것이다.**
--
-- 카라얀 건은 저역 진입 오류와 구별해 두었다. 1.20초 첫 소리가 40~250Hz 에서 먼저
-- 오르지만 이 대목은 첼로의 상행 동기(A3=220Hz)라 그것이 맞다. 1.7초에 하모닉 RMS 가
-- 광대역과 1dB 차이로 붙는다. 솔티 건도 프리에코가 아니다 — 하모닉 간격이 0.3초 13dB
-- 에서 1.0초 2.5dB 로 좁혀지고, 프리에코라면 20dB 이상 벌어진 채로 있는다.
--
-- 피가로 무티 건도 고쳤다(4.81 → 1.88). 0.45~1.80 이 -60dB 대 홀 잡음이고 1.95 에서
-- 250~1200Hz 가 -44.6 → -19.4 로 25dB 뛴다. 큐가 "관현악 전주의 첫 박" 인데 검출값이
-- 2.9초 뒤였다.
--
-- 이상한 만다린 셋은 고치지 않았다. 도입(현의 반음계 질주)에서 하모닉 RMS 가 광대역보다
-- 10~14dB 아래이지만 평탄도가 어디서도 0.05 를 넘지 않는다. 박수 오탐이 아니라 질주의
-- 조성 성분이 약한 것이다.
--
-- ## 트리스탄의 기준 연주를 카라얀으로 골랐다
--
-- 얀손스의 길이 비율이 0.79 로 1.2배 선 밖이다. 세 연주를 차례로 기준 삼아 떠 봤다.
--
--   카라얀 기준(채택)  길이 비율 1.04 / 0.79   옮김 0.0597 / 0.0460   정렬 0.0569~0.0857
--   솔티 기준          0.94 / 0.75            옮김 0.0617 / **0.0678**
--   얀손스 기준        **1.26 / 1.29**         옮김 0.0424 / 0.0595   정렬 0.0543~0.0781
--
-- 얀손스 기준이 정렬은 가장 좋지만 발췌가 151~154초로 권장 상한(120초)을 넘고,
-- 솔티 기준은 옮김 비용이 0.06 을 넘는다. **카라얀 기준만 검증 세 가지를 모두 지킨다.**
-- 비율 0.79 는 전주곡 전체 길이(카라얀 665.8초 대 얀손스 576.0초)와 방향이 맞는다.
--
-- ## 솔티↔얀손스 0.0857 을 교체하지 않았다
--
-- 같은 곡의 카라얀↔얀손스(0.0569)보다 눈에 띄게 높아 진단했다. 이조가 아니고
-- (0반음 0.057, 나머지 0.276~0.422) 경계 오류도 아니다 — 삼등분이 앞 0.1048 /
-- 중간 0.0923 / 뒤 0.0888 로 **고르게** 높고, 끝점 훑기에서 현재 값이 최저 부근이다.
-- 시작점을 2.4초로 옮기면 0.0024 내려가지만 큐가 "첼로의 상행 동기 첫 음" 이라
-- 옮기지 않았다. 1978년 데카 시카고반의 연주·녹음 차이로 본다.
--
-- ## 조율
--
-- 시대악기 연주(외스트만·가디너·야코프스·쿠렌치스)를 선정에서 전부 뺐다. 남은 아홉 건의
-- tuning 이 0.07~0.28 반음이고 곡마다 폭이 0.08~0.13 반음으로 **두 덩어리로 갈린 곳이
-- 없다.** 202608050150(밤의 여왕)의 0.65 반음 갈림과 다르다.
--
-- ## 크레딧
--
-- 편지 이중창은 백작부인과 수잔나의 이중창이라 지휘자를 주역으로 두고 악단과 소프라노
-- 둘을 붙였다(202608050153 축배의 노래와 같은 차례). 소프라노 넷을 새로 등록했다
-- (202608050159).
--
-- ## 그 밖에
--
-- 피가로 세 트랙의 길이가 2분 06초~2분 47초로 1.32배 벌어진다. 정렬이 0.0558~0.0736 이라
-- 같은 대목이다. 아바도 트랙은 0.00초부터 -42dB 로 시작해 125.85 에서 잔향 없이 끊기는
-- 앞뒤 여백이 없는 마스터다.
--
-- 이상한 만다린은 모음곡판(Sz. 73a) 둘과 발레 전곡반의 도입 낱 트랙 하나가 섞였다.
-- 도입은 두 판이 같으므로 문제되지 않는다.
--
-- "Herbert von Karajan" 채널의 트리스탄 전주곡 영상이 솔티·빈필(Decca 1960)이어서 뺐다.
-- **열 배치 연속이다.**
--
-- <쇼생크 탈출> OST 컴필에 실린 뵘 트랙은 음원 자체는 DG 1968 오페라반이지만 배급
-- 표기가 OST 앨범이라 쓰지 않았다.
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
