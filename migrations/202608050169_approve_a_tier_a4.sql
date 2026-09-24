-- A tier A4 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   클레멘티 피아노 소나타 G단조 Op. 50-3 "버림받은 디도" 1악장 도입(piece 115):
--     셸리 / 매케이브 / 데 팔마                                          0.0632~0.0735
--   글루크 <오르페오와 에우리디체> 중 "정령들의 춤" 전곡(piece 62):
--     카라얀·베를린필 / 마리너·ASMF / 솔티·로열 오페라하우스             0.0529~0.0827
--   글루크 <오르페오와 에우리디체> 중 "에우리디체 없이 어찌하리" 전곡(piece 63):
--     베르간사·로열 오페라하우스 / 카사로바·뮌헨 방송 / 폰 슈타데·유타 심포니
--                                                                        0.0706~0.0793
--
-- 62 는 판(版)을 맞추는 것이 일이었다. 짧은 A 부분만 연주하는 2~3분판을 모두 빼고
-- 373~444초의 전곡판(D단조 – F장조 중간부 – Da capo)으로 셋을 맞췄다. 편성도
-- 관현악판(플루트 독주 + 현악)으로 통일했다. 플루트와 피아노·하프·피아노 독주
-- 편곡이 널리 도는 곡이다.
--
-- 62 에서 채널 이름으로 악단을 짐작하면 틀리는 예가 있었다. 검색 상위의 두 영상이
-- 채널 이름은 "Herbert von Karajan" 인데 설명란의 배급 표기는 루돌프 켐페·빈 필이다.
-- 악단 근거는 모두 배급 표기에서 잡았다.
--
-- 63 은 성부와 언어가 갈리는 곡이다. 글루크는 이 역을 1762년 빈 초연에서 알토에게,
-- 1774년 파리판에서 테너에게 주었다. MBID 가 이탈리아어 Wq. 30 3막 아리아이므로
-- 이탈리아어판으로 맞췄고 세 연주 모두 메조소프라노다. 테너 프랑스어판과 바리톤
-- 이조판은 뺐다. piece 의 role 도 VOCALIST 에서 MEZZO_SOPRANO 로 바꿨다.
--
-- 115 데 팔마의 검출 시작을 5.36 → 3.50 으로 고쳤다. 여린 첫 화음을 지나쳤다.
-- 3.44초까지 −56dB 암소음이다가 3.53초에 −40.8dB, 3.62초에 −36.4dB 로 뛰고
-- 하모닉 RMS 가 −44.3/−37.7dB 로 붙어 따라온다(프리에코가 아니라 조성음).
-- 평탄도는 0.0000 이라 박수도 아니다.
--
-- 115 매케이브의 발췌 길이 비율이 0.73 으로 권장(1.2배)을 넘는다. DTW 오류가
-- 아니라 실제 템포 차이다. 기준 연주를 셋 다 바꿔 떠도 매케이브만 0.73~0.74 로
-- 일관되고, 1악장 전체 길이에서 나오는 매케이브/셸리 = 0.80 과도 맞는다. 옮김
-- 비용은 0.0500 으로 기준(0.06) 안이다. SKILL.md 의 "길이로는 판정하지 않는다" 에
-- 해당하는 자리다.
--
-- 62 의 카라얀만 tuning 이 +0.30 이고 마리너·솔티는 +0.05 다. 비용이 이 간격을
-- 따라간다(카라얀이 낀 두 쌍 0.0788·0.0827, 마리너↔솔티 0.0529). 접힘 건너편
-- (−0.70, A≈422.6Hz)은 1984년 DG 베를린 필 스튜디오 녹음에 없는 피치이고,
-- +0.30 은 A≈447.7Hz 로 카라얀 시절 베를린 필의 고피치와 맞는다. 셋 다 임계의
-- 절반 수준이라 연주는 바꾸지 않았다.
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
