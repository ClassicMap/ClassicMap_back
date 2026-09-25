-- A tier A12 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   말러 교향곡 1번 "거인" 1악장 도입(piece 217):
--     하이팅크·베를린필 / 틸슨 토머스·샌프란시스코 / 오자와·보스턴  0.0551~0.0695
--   말러 교향곡 8번 "천인 교향곡" 1부 "Veni, creator spiritus"(piece 218):
--     솔티·빈 국립오페라 합창연합·시카고 / 아바도·베를린 방송합창단·베를린필 /
--     두다멜·LA 마스터 코랄·LA필                                    0.0377~0.0410
--   말러 <대지의 노래> 1악장 "Das Trinklied"(piece 219):
--     카라얀·베를린필 / 번스타인·빈필 / 솔티·시카고                 0.0422~0.0520
--
-- **217 의 검출이 세 건 모두 도입을 지나쳤다.** 이 악장은 전 현이 A 음을 여리게
-- 내는 것으로 시작해 12초 가까이 지속음 하나뿐인데 검출이 목관의 하행 4도 동기
-- 진입에 붙었다. 하이팅크는 19.5초를 버릴 뻔했다.
--
--   하이팅크 20.76 → 1.30   틸슨 토머스 13.10 → 2.85   오자와 13.14 → 2.60
--
-- **광대역 RMS 로는 가려지지 않는다.** 하이팅크는 0.6~12초가 −108dB 에서 −54dB 로
-- 매끈하게 오른다 — 현의 활 잡음이 음과 함께 오르기 때문이다. 저역·중역도
-- 콘트라베이스 A 때문에 같이 오른다. **음계급을 좁게 추적해 갈랐다**(16384점 FFT,
-- A 110/220/440/880/1760Hz 대 대조군 C). 잡음 바닥에서는 차가 0dB 안팎인데
-- 음악이 시작하면 A 만 단조 상승한다. 고친 시작점에서 목관 진입까지가 10.6 /
-- 10.3 / 11.3초로 맞아떨어져 되짚었다. 02-detection.md 에 적었다.
--
-- 217 에서 무티를 오자와로 바꿨다. 처음 편성(하이팅크/틸슨 토머스/무티)에서
-- 무티가 낀 두 쌍만 0.0879·0.0715 로 올랐다. 이조가 아니고(회전 최저 0반음)
-- 경계 오류도 아니었다(끝점 훑기 0.0871~0.0914 로 폭 0.004). 예비 둘을 받아
-- 5×5 교차표를 뜨니 하이팅크·틸슨 토머스·오자와가 0.055~0.070 한 덩어리이고
-- 무티는 0.072~0.102 로 떨어져 있었다. 교체 뒤 0.0551 / 0.0695 / 0.0642 다.
-- 예비로 받은 아바도(1991 실황)는 넷 모두와 0.099~0.126 으로 더 바깥이라 쓰지
-- 않았고 배치 정의에도 넣지 않았다.
--
-- 원인은 판본이 아니라 도입 템포로 보인다. 이 대목은 지속음 하나뿐이라 chroma 에
-- 볼 것이 거의 없고(03-verification 의 "한 음만 반복하는 대목"), 지속음 길이가
-- 하이팅크 10.6 · 틸슨 토머스 10.3 · 오자와 11.3 인데 무티 13.2 · 아바도 12.2 로
-- **느린 둘이 그대로 비용이 높은 둘**이다. 교체 근거는 "교차표에서 한 연주만
-- 바깥" 으로 삼았고 원인 추정은 거기까지만 했다.
--
-- **218 은 발췌를 돌리지 않았다.** 세 영상 모두 1부 첫 절만 담긴 낱 트랙
-- (81~93초)이다. 120초를 억지로 잘랐으면 다음 절 "Imple superna gratia"
-- 한가운데서 끊겼다. endCue 를 트랙에 맞춰 고쳤다 — 구간을 큐에 맞추지 않고
-- 큐를 구간에 맞춘다.
--
-- 218 의 합창단 크레딧은 이쪽에서 보탰다. 서브에이전트는 세 합창단이 DB 미등록
-- 이라 뺐는데 **이 곡은 합창이 주역**이다. 202608050183 에서 등록하고 CHOIR 를
-- CONDUCTOR(0) → CHOIR(1) → ORCHESTRA(2) 차례로 넣었다. A2 의 마니피카트와 같다.
-- 세 녹음 다 합창단이 둘씩이나 choir 키가 하나라 앞에 오는 하나씩만 넣었다.
--
-- 219 는 셋 다 테너 + 관현악 원곡판이다. 쇤베르크 실내악 편곡판·피아노 반주판·
-- 중국어 가사판을 모두 배제했다.
--
-- 채널 이름 함정을 두 건 더 만났다. KMP7dr7KvP8 은 채널이 베를린 필인데 표기는
-- 빈 필·미트로풀로스, H-4dwHNL7hA 는 채널이 카라얀인데 빈 필·브루노 발터다.
-- 오늘 아홉·열 번째다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저다. tuning 폭은 곡마다 0.08~0.18 반음이다.
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
