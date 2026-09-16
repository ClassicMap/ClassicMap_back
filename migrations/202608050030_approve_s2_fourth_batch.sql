-- 비교 영상 S2 넷째 배치 6건을 발행 직전 상태로 올린다.
--
-- 대상은 2026-09-17 에 적재한 피아노 소품 2곡이다.
--   바가텔 WoO 59 "엘리제를 위하여" - 랑랑 / 리시차 / 알리스 사라 오트
--   악흥의 순간 D. 780 제3번      - 조성진 / 다비드 프레 / 호로비츠
--
-- 202608050025 와 같은 방식으로 뽑았다. 곡이 짧아 작품 전체가 곧 구간이므로
-- 음악이 실제로 시작하고 끝나는 지점만 오디오에서 찾았다.
--
-- 교차 정렬은 여섯 쌍 모두 0.057~0.091 로 통과했다. 이번 배치는 걸러낸 것이 없다.
-- 길이 편차도 작다(엘리제 1.04배, 악흥의 순간 1.18배).
--
-- 함께 검증한 라흐마니노프 전주곡 C#단조 3건은 적재하지 않았다.
-- 정렬은 0.050~0.072 로 통과했지만 작품을 legacy piece 229 에 연결할 수 없다.
-- 202608050029 에 적은 대로 그 MBID 가 이미 국제 시드 곡의 piece_parts 에 있다.
-- 중복이 풀리면 그대로 쓸 수 있도록 구간과 검증 결과를 큐레이션 디렉터리에 남겼다.
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
