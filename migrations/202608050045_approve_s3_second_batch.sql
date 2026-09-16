-- 비교 영상 S3 둘째 배치를 발행 직전 상태로 올린다.
--
-- 대상은 2026-09-17 에 적재한 월광 소나타 3악장 3건이다.
--   Op. 27-2 3악장 Presto agitato - 리시차 / 폴리니 / 키신
--
-- 202608050040 과 같은 방식이다. 같은 작품(piece 78)에 sector 를 하나 더 만든
-- 것이고, 1악장은 202608050040 에서 이미 발행했다.
--
-- 함께 적재한 슈만 <어린이의 정경> 중 트로이메라이 3건은 발행하지 않는다.
-- 그 모음곡의 MusicBrainz work 이 이미 국제 시드 곡(piece 464 "Kinderszenen,
-- op. 15")에 붙어 있어서 legacy 곡(piece 135 "피아노 모음곡 <어린이의 정경>")
-- 에는 붙일 수 없었다. piece_identifiers 의 (namespace, external_id) 가
-- 유일하기 때문이다. 그래서 세 연주가 legacy 곡이 아니라 국제 시드 곡으로
-- 해소됐다.
--
-- 202608050041 이 푼 것과는 다른 종류의 중복이다. 그때는 piece_identifiers 와
-- piece_parts 가 같은 작품을 가리키는 경우였고 해소 규칙으로 풀렸다.
-- 이번에는 piece_identifiers 두 행이 경쟁하는데 제약상 공존할 수 없다.
-- 어느 곡을 정본으로 둘지는 화면에 무엇이 보여야 하는가의 문제이므로
-- 비교 영상 시드에서 정하지 않는다. 적재된 3건은 클립을 만들지 않아
-- 발행되지 않은 상태로 남는다.
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
