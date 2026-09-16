-- 비교 영상 S2 셋째 배치 6건을 발행 직전 상태로 올린다.
--
-- 대상은 2026-09-17 에 적재한 두 곡이다.
--   드뷔시 두 개의 아라베스크 L.66 제1번 - 피레스 / 치콜리니 / 프레슬러
--   사티 짐노페디 제1번                   - 로제 / 부니아티슈빌리 / 셰프스
--
-- 202608050022·202608050025 와 같은 방식이다.
--
-- 함께 뽑았던 드뷔시 달빛 3건은 적재하지 못해 보류했다. 적재기는 작품을
-- piece_identifiers 와 piece_parts 양쪽에서 찾아 합이 정확히 1건이어야 하는데,
-- 달빛의 MusicBrainz work 가 국제 시드로 들어온 Suite bergamasque(piece 8876)의
-- 악장 part 로 이미 등록돼 있다. 레거시 곡 220 '달빛'에 같은 식별자를 붙이면
-- 2건이 되어 해소되지 않는다. 레거시 곡과 국제 시드 곡이 같은 작품을 가리키는
-- 중복 문제이므로 비교 영상 시드에서 처리하지 않고 따로 다룬다.
-- 202608050027 이 넣은 piece 220 의 식별자는 그 정리 때 쓰이므로 남겨 둔다.
--
-- 교차 정렬 검증은 이번에도 한 건을 걸러냈다. 달빛에 처음 넣으려던 연주가
-- 다른 두 연주와 0.142~0.148 로 어긋나 교체했고, 교체한 연주는 0.068~0.081 로
-- 통과했다. 다만 위 사유로 달빛 자체가 보류돼 이번 배치에는 들어가지 않는다.
--
-- 길이 편차가 커도 통과한 사례가 또 나왔다. 아라베스크 1번은 세 연주가
-- 237~320초로 1.35배 차이 나는데 정렬 비용은 0.049~0.066 이었다.
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
