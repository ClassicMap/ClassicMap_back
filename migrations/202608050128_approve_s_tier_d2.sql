-- S tier 대기열 D2 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   베토벤 교향곡 3번 "영웅" 2악장 장송행진곡 도입(piece 77): 카라얀·베를린필 /
--     하이팅크·콘세르트허바우 / 아바도·빈필                             0.0451~0.0502
--   브람스 교향곡 1번 1악장 서주(piece 153): 카라얀·베를린필 /
--     아바도·베를린필 / 샤이·콘세르트허바우                             0.0414~0.0500
--   브람스 교향곡 3번 3악장 Poco allegretto(piece 154): 아바도·베를린필 /
--     샤이·게반트하우스 / 하이팅크·보스턴심포니                         0.0395~0.0467
--
-- 아홉 쌍이 0.0395~0.0502 로 고르게 모였다. 곡 안의 최대-최소 차이가 0.005~0.009 로
-- 튀는 쌍이 없다. 지금까지 배치 중 가장 안정적이다.
--
-- 브람스 1번은 대기열에 4악장 주제로 적혀 있었으나 1악장 서주로 바꿨다. 4악장의 그
-- 선율은 악장 시작 후 4분 넘게 지나야 나와 head anchor 120초로는 닿지 않고, 구간을
-- 직접 지정하려면 기준 연주의 초를 사람이 들어 보고 찍어야 한다. 1악장의 팀파니
-- 오스티나토 서주도 이 곡의 얼굴이고 head anchor 로 안전하게 잡힌다.
--
-- 검출 시작 5건을 고쳤다. 원본은 s-d2-detected.orig.json 에 있다.
--
--   영웅 카라얀   11.38 → 1.33   악장 첫 10초를 통째로 버리고 있었다(아래 참고)
--   영웅 하이팅크  2.44 → 0.65   2.44 는 저역 진입 지점이고 1.7초 앞에 제1바이올린 주제가 있다
--   영웅 아바도    2.21 → 0.60   같다
--   브람스3 아바도 4.57 → 4.36 / 샤이 0.98 → 1.28 (샤이는 반대로 일렀다)
--
-- **영웅 2악장에서 새 검출 실패 유형이 나왔다.** 카라얀 건은 1.43~10.4초가 음악인데
-- 10.4~11.4초의 악구 사이 쉼에서 덩어리가 끊겨 검출기가 뒤 조각을 골랐다. 앞 조각이
-- MIN_MUSIC_SECONDS 에 못 미쳐 버려진 것이다. 여린 도입을 지나친 것이 아니라
-- **악구 사이 쉼이 도입을 잘라낸** 경우다.
--
-- 세 녹음을 250~1200Hz 대역 에너지와 하모닉 RMS 로 함께 봤다. 셋 다 "중역이 먼저
-- 오르고 1.4초쯤 뒤 40~250Hz 가 15~20dB 뛰는" 같은 모양이었고, 앞 구간은 하모닉 RMS 가
-- 광대역 RMS 와 1~4dB 차이로 붙어 있어 조성음이었다(테이프 프리에코라면 20dB 이상
-- 벌어진다). 서로 다른 마스터인 세 녹음이 같은 간격을 보인 것이 결정적이었다 —
-- 프리에코라면 지연이 제각각이다.
--
-- 고치기 전 값으로도 발췌·정렬을 다시 떠 비교했다. 영웅은 카라얀이 낀 두 쌍이 함께
-- 내려갔고(-0.0062, -0.0054) 나머지 한 쌍은 0.001 올랐다. 브람스 둘의 미세 조정은
-- ±0.001 안이라 사실상 변화가 없다. **판단 근거는 비용이 아니라 섹터 큐다.** 고치기
-- 전에는 세 연주 모두 악장 첫 10초가 빠진 채 서로만 맞물려 있어 비용으로는 드러나지
-- 않았고, 큐가 "제1바이올린의 C단조 행진 주제 첫 음(악장 시작)" 이라 그대로 두면
-- 큐를 어기는 것이었다.
--
-- 채널명과 실제 연주자가 다른 것이 세 건 있었다(영상 설명의 배급 표기로 확정).
--   fnnmEEeq5fc  채널 Herbert von Karajan      → 아바도·빈필
--   N4uG4SjvBgY  채널 Herbert von Karajan      → 뵘·빈필 (후보에서 뺌)
--   _7MgFeXbzyk  채널 Berliner Philharmoniker  → 번스타인·빈필 (후보에서 뺌)
--
-- 시대악기 연주(가디너·ORR, 아르농쿠르)는 조율이 달라 이조로 걸리므로 뺐다.
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
