-- 편곡 비교 배치 4(아디오스 노니노) 3건을 발행 직전 상태로 올린다.
--
-- **정렬 비용 임계를 적용하지 않는다**(sector_type ARRANGEMENTS). A28 에서 "편곡이
-- 판마다 다르고 길이가 125~616초로 갈린다" 는 까닭으로 **재지도 않고 막았던 곡**이다.
--
--   피아졸라 <아디오스 노니노> 전곡(piece 376), sector 263:
--     크라이엔호프 (반도네온 + 콘세르트헤바우 실내관현악 + 네덜란드 실내합창단, PIAS)
--                                                    1.18–278.50   277.3s
--     티엠포 (피아노 둘, 카린 레히너와, Warner)        0.98–516.50   515.5s
--     슈타인바허 (바이올린 + 피아노, 칼로 편곡, Naxos)  0.05–366.00   365.9s
--
-- 교차 정렬은 기록만 한다 — 0.1486 · 0.2457 · 0.2699.
--
-- **길이가 1.86배 갈리는 것이 이 구간의 들을 거리다.** 이 곡은 도입을 연주자가 풀어
-- 놓는 자리로 두고 판마다 그 길이와 성격이 다르다. 합창이 든 크라이엔호프 판이 가장
-- 짧고(277초) 피아노 둘 판이 카덴차를 가장 길게 늘린다(515초).
--
-- 임계를 대신하는 조건을 다 확인했다 — 같은 작품 MBID
-- 532643e5-b743-30b0-a623-1906b75d6524, 셋 다 전곡, 배급 표기가 편성을 밝힘,
-- **셋의 편성이 서로 다름**(반도네온+실내관현악+합창 / 피아노 둘 / 바이올린+피아노),
-- 머리와 꼬리가 구간 안에 다 듦.
--
-- **꼬리를 셋 다 늘렸다. 티엠포 판이 40.1초였다.**
--
--   크라이엔호프  269.10 → 278.50   (+9.4초)
--   티엠포        476.43 → 516.50   (**+40.1초**)
--   슈타인바허    363.07 → 366.00   (+2.9초)
--
-- 티엠포 판의 40.1초는 이 캠페인에서 A29 오르만디의 44.3초에 이어 두 번째로 큰
-- 종결부 누락이다. 카덴차가 길고 여린 곡이라 조성 곡선의 덩어리가 중간에서 끊겼다.
-- 뒤에서부터 훑어 −50dB 를 넘는 마지막 자리(515.92)를 근거로 삼았다.
--
-- **티엠포 판의 둘째 피아니스트(카린 레히너)를 적을 자리가 없다.** 배치 정의의 딸림
-- 크레딧 키가 conductor · choir · orchestra · accompanist 넷이고 피아노 듀오의 두 번째
-- 주자는 반주자가 아니다. 04-loading.md 의 방식대로 나중에 보탤 수 있다.
--
-- 202608050223 에서 인물·단체 다섯을 등록했다. 크라이엔호프의 category 를
-- `bandoneonist` 로 새로 썼다.
--
-- 경고: rights_mode 를 licensed_self_hosted 로 적지만 실제 이용 허락을 받은
-- 것이 아니다. 202608050017 의 경고와 같은 내용이다.

UPDATE performance_sources source
SET source.rights_mode = 'licensed_self_hosted',
    source.last_checked_at = CURRENT_TIMESTAMP(6)
WHERE source.rights_mode = 'unknown'
  AND EXISTS (
      SELECT 1 FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.performance_source_id = source.id
  );

UPDATE performance_sectors sector
SET sector.editorial_status = 'EDITOR_REVIEWED'
WHERE sector.editorial_status = 'FACTS_VERIFIED'
  AND EXISTS (
      SELECT 1 FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = sector.id
  );

UPDATE performance_candidates candidate
SET candidate.candidate_status = 'APPROVED'
WHERE candidate.candidate_status = 'REVIEW_REQUIRED'
  AND EXISTS (
      SELECT 1 FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = candidate.sector_id
        AND performance.performance_source_id = candidate.performance_source_id
        AND performance.start_ms = candidate.proposed_start_ms
        AND performance.end_ms = candidate.proposed_end_ms
  );
