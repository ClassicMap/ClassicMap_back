-- 2라운드 첫 발췌 배치(협주곡) 비교 영상 9건을 발행 직전 상태로 올린다.
--
-- 대상 (S tier 2라운드, 서브에이전트 배치)
--   베토벤 피아노 협주곡 5번 "황제" 1악장 도입(piece 80): 폴리니 / 루푸 / 아슈케나지   0.0395~0.0509
--   차이콥스키 바이올린 협주곡 1악장 도입(piece 160): 무터 / 벨 / 얀센                0.0712~0.0789
--   모차르트 피아노 협주곡 20번 2악장 로만체(piece 72): 조성진 / 리시에츠키 / 부니아티슈빌리  0.0422~0.0467
--
-- 세 곡 다 20분을 넘어 전곡을 클립으로 만들 수 없다. 악장 트랙 영상을 골라 한 연주에서
-- 발췌를 정하고 나머지는 부분열 DTW 로 옮겼다(references/07-excerpt.md). 옮김 비용은
-- 0.0238~0.0554 로 모두 기준(0.06) 아래이고, 길이 비율도 1.2배 안이다.
--
-- 모차르트 20번 2악장은 세 연주가 507~553초로 모두 600초 안이라 발췌하지 않고 악장 전체를 썼다.
--
-- 차이콥스키: 얀센 영상의 검출 시작이 3.78초로 잡혀(여린 서주를 놓침) 발췌 탐색 창이
-- 앞을 보지 못했고 그 쌍만 0.0885 였다. 탐색 창 시작만 0 으로 넓혀 다시 옮기자 두 쌍이
-- 함께 내려갔다(0.0885→0.0789, 0.0769→0.0712). 발췌 구간을 손으로 옮긴 것이 아니다.
-- 도입 발췌라 세 곡 모두 카덴차에 닿지 않는다.
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
