-- 중복 때문에 막혀 있던 비교 영상 6건을 발행 직전 상태로 올린다.
--
--   드뷔시 달빛 (piece 220)               - 조성진 / 피레스 / 프레슬러
--   라흐마니노프 전주곡 C#단조 (piece 229) - 키신 / 루간스키 / 아슈케나지
--
-- 두 곡은 이미 검증을 마치고도 적재하지 못했다. 그 MBID 가 국제 시드 곡의
-- piece_parts 에 이미 있어 해소 대상이 2건이 됐기 때문이다(202608050028,
-- 202608050030 참고).
--
-- 적재기의 해소 규칙을 고쳐 풀었다. piece_identifiers 는 "이 곡이 그 작품이다"
-- 라는 직접 진술이고 piece_parts 는 포함 관계다. 둘이 같은 MBID 를 가리키면
-- 직접 진술을 따른다. 국제 시드가 모음곡을 악장 part 로 넣어 두었고 legacy 곡이
-- 그 낱곡을 독립된 곡으로 갖고 있을 때 늘 이렇게 겹치며, 연주를 붙일 대상은
-- 낱곡 쪽이다.
--
-- 정렬 검증은 적재 당시 이미 통과했다. 달빛 0.0675~0.0811, 전주곡 0.0496~0.0716.
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
