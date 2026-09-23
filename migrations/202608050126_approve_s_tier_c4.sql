-- S tier 대기열 C4 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   슈베르트 피아노 5중주 "송어" 4악장 주제(piece 118): 쉬프 / 길렐스·아마데우스 4중주단 /
--     브론프만                                                          0.0744~0.0965
--   슈베르트 현악 4중주 "죽음과 소녀" 2악장 주제(piece 120): 에머슨 / 보로딘 / 타카치
--                                                                       0.0765~0.0874
--   하이든 현악 4중주 "황제" 2악장 주제(piece 86): 아마데우스 / 알반 베르크 / 에머슨
--                                                                       0.0485~0.0683
--
-- 셋 다 2·4악장이라 전곡 영상을 쓸 수 없고(head anchor 가 1악장을 잡는다) 해당 악장
-- 트랙만 담긴 영상으로 골랐다. 그 안에서 도입 120초를 발췌했다.
--
-- 검출 9건 중 8건을 고쳤다. 이 배치가 지금까지 중 가장 나빴다. 원본은
-- s-c4-detected.orig.json 에 있다.
--
--   송어  쉬프      3.00 → 0.86   A4 밴드(425~465Hz)가 0.86초부터 45dB 오른다.
--                                 3.00 은 저음이 들어오는 다음 마디였다
--         길렐스    1.39 → 1.19   0.66~0.95초의 -25dB 는 아날로그 테이프 프리에코다
--                                 (하모닉 RMS 는 -78dB 로 바닥)
--         브론프만  2.44 → 0.69
--   죽음  에머슨    1.90 → 1.58 / 보로딘 8.82 → 8.55 / 타카치 1.23 → 1.05
--   황제  아마데우스 4.09 → 4.30  반대로 히스 램프를 음악으로 읽어 이르게 잡았다
--         알반베르크 5.13 → 5.08
--
-- 송어는 주제의 여린 A4 피업비트를 셋 중 둘이 통째로 건너뛰어 2.14초·1.75초를 버리고
-- 있었다. 섹터 큐가 "주제의 첫 음" 이라 반드시 고쳐야 했다.
--
-- 옮김 비용이 0.06 을 넘은 둘(길렐스 0.0712, 보로딘 0.0678)은 끝 경계를 2.5초 간격으로
-- 훑어 확인했다. 네 곡선 모두 매끈하게 내려가 현재 값에서 최저였다(쉬프↔길렐스 122.5초,
-- 에머슨↔보로딘 145.5초). 옮긴 자리가 맞다고 본다.
--
-- 송어 세 쌍이 0.0744~0.0965 로 이 배치에서 가장 높지만 한 쌍만 튀는 것이 아니라
-- 세 쌍이 고르게 높다. 발췌 앞머리가 현악만의 얇은 텍스처라 화성 정보가 적은 탓으로
-- 본다. 한 연주의 문제가 아니므로 교체하지 않았다.
--
-- 송어의 두 번째 크레딧은 길렐스 건에만 붙였다. 영상 설명에 단체 이름이 적힌 것이
-- 그 하나뿐이고(아마데우스 4중주단), 쉬프와 브론프만은 개인 연주자 이름만 적혀 있다.
-- 하겐 4중주단 등으로 짐작하지 않았고 개인을 독주자로 흩어 적지도 않았다.
--
-- 시대악기 단체(Quatuor Mosaïques 등)는 조율이 달라 이조로 걸리므로 뺐다.
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
