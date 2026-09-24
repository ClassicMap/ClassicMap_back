-- A tier A1·A2 비교 영상 15건을 발행 직전 상태로 올린다.
--
--   C.P.E. 바흐 솔페지에토 전곡(piece 103): 아멜린 / 바렌보임 / 카차리스   0.0386~0.0555
--   C.P.E. 바흐 플루트 협주곡 D단조 1악장 도입(piece 105): 파위·피노크·포츠담 /
--     골웨이·페르버·뷔르템베르크 / 갈루아·맬런·토론토                      0.0479~0.0616
--   C.P.E. 바흐 마니피카트 1곡 도입(piece 106): 라데만·베를린 고음악·RIAS /
--     윌런스·쾰른 아카데미 / 슈나이더·라 스타조네·드레스덴                 0.0426~0.0518
--   J.C. 바흐 신포니아 B♭장조 Op. 18-2 1악장 도입(piece 107): 진먼·네덜란드 체임버 /
--     뮌힝거·슈투트가르트 체임버 / 판 베이눔·콘세르트허바우                0.0407~0.0455
--   J.C. 바흐 신포니아 콘체르탄테 C장조 1악장 도입(piece 108): 마이어·콜레기움 아우레움 /
--     홀스테드·하노버 밴드 / 스탠디지·아카데미 오브 에인션트 뮤직          0.0523~0.0823
--
-- A tier 대기열의 첫 두 배치다. 앞단에서 88곡의 작품 MBID 를 미리 확정했고
-- (202608050163·202608050164) 작곡가 식별자 오류도 미리 고쳤다(202608050162).
--
-- 108 은 조율 폭이 0.47 반음이나 그대로 둔다. 세 연주가 모두 시대악기 악단인데
-- 콜레기움 아우레움만 +0.05 이고 하노버 밴드·AAM 은 −0.42/−0.38 이다. 시대악기를
-- 현대 피치로 연주하는 악단이 있어 편성만 보고는 거를 수 없다. 예비 연주를 하나 더
-- 받아 네 연주로 교차표를 떴더니 조율 간격과 비용이 함께 움직였다.
--
--   간격 0.09 → 0.0373   간격 0.04 → 0.0523   간격 0.43 → 0.0529
--   간격 0.47 → 0.0823   간격 0.52 → 0.0729   간격 0.56 → 0.0925
--
-- 네 녹음이 두 덩어리로 갈려 어느 쪽에도 셋이 없고 W C43 의 공식 채널 녹음은 이
-- 넷이 전부다. 최대 0.0823 은 통상 통과 대역(0.04~0.09) 안이며, 비용을 낮추려고
-- 현대악기를 섞지 않는다.
--
-- 마니피카트는 합창곡이라 합창단 크레딧을 붙였다. 윌런스 녹음은 영상 채널이
-- 악단이라 합창단을 가릴 수 없어 지휘자·악단만 적었다. S tier F1 의 히브리
-- 노예들도 셋 중 둘만 합창단이 붙었다.
--
-- C.P.E. 바흐 첼로 협주곡 A단조(piece 104)는 이 배치에서 빠졌다. 세 쌍이 모두
-- 임계를 넘었다(0.2497 / 0.2624 / 0.3556). 조율은 원인이 아니다 — 간격 0.12 반음인
-- 쌍이 0.2497 이고 0.52 반음인 쌍이 0.2624 로 비용이 간격을 따라가지 않는다.
-- 발췌 옮김이 1.38배·1.52배로 늘어난 것이 원인으로 보인다. A-TIER-QUEUE.md 의
-- "다시 볼 곡" 에 적었다.
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
