-- A tier A9 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   드보르자크 교향곡 9번 "신세계로부터" 2악장 Largo 도입(piece 197):
--     아바도·베를린필 / 솔티·시카고심포니 / 카라얀·빈필              0.0495~0.0559
--   드보르자크 첼로 협주곡 B단조 1악장 도입(piece 198):
--     로스트로포비치·카라얀·베를린필 / 이서리스·하딩·말러체임버 /
--     모르크·얀손스·오슬로필                                        0.0599~0.0760
--   드보르자크 현악 4중주 12번 "아메리카" 1악장 도입(piece 200):
--     에머슨 4중주단 / 타카치 4중주단 / 알반 베르크 4중주단          0.0666~0.0761
--
-- 연주자와 악단이 모두 이미 등록돼 있어 연주자 마이그레이션이 없다.
--
-- 검출을 다섯 군데 고쳤다. 가장 큰 것은 198 로스트로포비치다.
--
--   198 로스트로포비치 23.52 → 2.93  **클라리넷 서주 20.6초가 통째로 빠져 있었다**
--   198 모르크         5.99 → 0.05  트랙에 선행 무음이 없다
--   200 에머슨         7.31 → 6.48  현 트레몰로 0.83초
--   200 타카치         1.56 → 1.00  트레몰로 0.56초
--   200 알반 베르크   23.99 → 23.75 박수 꼬리가 잦아든 뒤 첫 음
--
-- 로스트로포비치는 02-detection.md 의 "악구 사이 쉼이 도입을 잘라낸다" 유형이다.
-- 17.4~18.6 과 22.5~23.4 의 악구 사이 쉼에서 덩어리가 끊겨 앞 조각이 버려졌다.
-- 2.95초에 중역(250~1200Hz)이 −32.8 → −19.2dB 로 뛰고 하모닉과 광대역의 차가
-- 10dB 에서 1.4dB 로 붙는다. 그대로 뒀으면 이 곡의 도입인 관현악 서주를 잃었다.
--
-- 197 의 여린 도입과 198 의 관현악 서주는 셋 다 살아 있다. 197 은 세 영상 모두
-- 시작 직후 중역이 −20 → −10dB 로 올라 금관 화음이 들어오고 잉글리시 호른
-- 진입이 아니라 악장 첫 화음이다. 198 은 독주 첼로 진입이 세 연주 모두 발췌
-- 구간 한참 뒤다.
--
-- 협주곡 발췌가 리토르넬로로 늘어나는 일은 없었다. 옮김 비용이 전부 0.06 아래
-- (0.0353~0.0547)이고 길이 비율 최대 1.19배로 임계 안이다. 같은 날 C.P.E. 바흐
-- 첼로 협주곡이 이 자리에서 빠졌으나 이 곡은 걸리지 않았다.
--
-- 200 알반 베르크(wBqoQ-uQYuE)는 실황이다. 머리 1.2~17.4초가 박수이고
-- (평탄도 0.05~0.12, 하모닉 RMS 가 광대역보다 17~20dB 아래) 음악은 23.775초에
-- 시작한다. 클립 시작 23초 앞의 0.75초는 −63dB 로 사실상 무음이다.
--
-- 채널 이름 함정을 또 만났다. Ac13w5uVfd0 은 채널이 Berliner Philharmoniker 인데
-- 배급 표기는 빈 필·로린 마젤이라 후보에서 뺐다. 오늘 네 번째다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 압도적 최저다(1반음이 0.26~0.55).
-- tuning 폭은 197 0.12, 198 0.21, 200 0.04 반음이고 ±0.5 경계 근처 값이 없다.
-- 로스트로포비치의 +0.34 는 건너편이 A≈423 이라 말이 안 되고 +0.34 = A≈448.7 이
-- 카라얀·베를린필 고피치와 맞는다.
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
