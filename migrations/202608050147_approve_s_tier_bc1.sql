-- S tier 대기열 BC1 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   브람스 바이올린 협주곡 Op. 77 1악장 도입(piece 156): 한·마리너·ASMF /
--     카퓌송·하딩·빈필 / 무터·카라얀·베를린필                           0.0462~0.0571
--   쇤베르크 <정화된 밤> Op. 4 도입(piece 313): 바렌보임·시카고심포니 /
--     카라얀·베를린필 / 메타·LA필                                       0.0812~0.0896
--   번스타인 <웨스트 사이드 스토리> 중 "심포닉 댄스" Prologue 도입(piece 337):
--     틸슨 토머스·런던심포니 / 번스타인·뉴욕필 / 칼 데이비스·로열필      0.0551~0.0832
--
-- ## 심포닉 댄스에서 연주를 교체했다
--
-- 처음 고른 하딩·빈필(쇤브룬 야외 실황)이 배치 안 두 쌍에서 0.1009 / 0.1033 으로
-- 임계(0.11)에 바싹 붙었다. 진단은 이조도 경계도 아니었고(0반음이 최저, 끝점 훑기
-- 0.100~0.108 로 평평, 삼등분은 가운데가 최악) 2번 패턴이었다.
--
-- 예비 연주(칼 데이비스·로열필)를 받아 네 연주 교차표를 뜨니 **하딩↔데이비스가
-- 0.1124 로 임계를 넘었다.** 기준을 바꿔도 0.1146 으로 같았다. 하딩이 셋 모두와 멀다.
--
-- 202608050116(교향곡 7번 번스타인)과 다른 판단을 한 이유가 여기 있다. 그때는 예비
-- 둘을 더해 열 쌍이 **전부** 통과해 바깥 연주가 없었고 두 연주가 해석의 양 끝일
-- 뿐이었다. 여기서는 넷째 연주를 넣자 선을 넘었다. **교차표에서 임계를 넘는 쌍이
-- 하나라도 생기면 그 연주가 바깥이다.**
--
-- 교체 뒤 세 쌍이 0.0551 / 0.0783 / 0.0832 가 됐다. 칼 데이비스는 202608050142 에서
-- 등록했다.
--
-- ## 검출
--
-- 시작 여섯 건을 고쳤다. 원본은 s-bc1-detected.orig.json 에 있다.
--
--   정화된 밤 카라얀  40.17 → 1.10   Grave 의 pp 도입 39초를 통째로 버렸다. 0.6초까지
--                                     디지털 무음, 0.7~1.0 은 -96dB 테이프 히스, 1.10 에서
--                                     -82.8dB / 하모닉 -85.8dB(차 3dB)로 올라와 단조 상승
--   정화된 밤 메타    49.44 → 1.90   0.1~1.7초는 rms-하모닉 차 15~20dB, 평탄도 0.41~0.53
--                                     이라 테이프·홀 잡음이다. 1.90 에서 차 3.8dB 로 닫힌다
--   정화된 밤 바렌보임 4.32 → 2.95
--   브람스 한 1.16 → 0.42 / 카퓌송 1.46 → 0.85 / 무터 3.13 → 2.40
--
-- 정화된 밤 보정은 세 쌍이 함께 내려갔다(0.0987→0.0879, 0.1003→0.0811, 0.0977→0.0896).
--
-- **브람스 보정은 반대로 세 쌍이 0.005 올랐다.** 그래도 유지했다. (1) 0.42~0.45초의
-- 소리는 하모닉 RMS 가 광대역과 2dB 안에 붙어 프리에코가 아니라 조성음이다,
-- (2) 서로 다른 마스터 셋에서 검출이 모두 참 첫 음보다 0.61~0.74초 뒤에 잡혀 계통
-- 오차다, (3) 섹터 큐가 "악장 시작" 이라 첫 음을 뺄 수 없다. **비용을 0.005 낮추려고
-- 큐를 어기지 않는다**(202608050139 의 실로폰 도입과 같은 판단).
--
-- ## 그 밖에
--
-- 메타의 발췌 길이 비율이 1.28배지만 세 연주를 차례로 기준 삼아도 1.275/1.308/1.322 로
-- 같은 비가 나와 옮김 오류가 아니라 실제 템포 차다. 메타(Decca 1967)가 Grave 도입을
-- 유난히 넓게 잡는다.
--
-- Prologue 의 손가락 튕김은 검출에 문제가 되지 않았다. 첫 소리가 튕김이 아니라 관현악
-- 진입이고, 앞의 -50~-67dB 는 250Hz 아래로 몰린 홀 잡음이다(평탄도 0.002~0.02).
--
-- "Herbert von Karajan" 채널의 한 영상이 미트로풀로스·빈필이어서 뺐다.
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
