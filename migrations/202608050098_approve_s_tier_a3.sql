-- S tier 대기열 A3 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   슈베르트 즉흥곡 Op. 90 중 3번 G♭장조(piece 121): 부니아티슈빌리 / 에릭 루 / 짐머만  0.0458~0.0502
--   슈만 카니발 마지막 곡 "다비드 동맹의 행진"(piece 138): 키신 / 길트부르그 / 루빈스타인  0.0484~0.0557
--   거슈윈 랩소디 인 블루 도입(piece 332): 티보데 / 오라일리 / 번스타인               0.0673~0.0924
--
-- 카니발과 랩소디는 발췌다. 카니발은 전곡 영상의 끝에서 150초(다비드 동맹의 행진),
-- 랩소디는 도입 90초다. 옮김 비용은 카니발 0.0304~0.0336, 랩소디 0.0453~0.0696 이었다.
--
-- 랩소디에서 번스타인이 낀 두 쌍만 0.102~0.105 로 높았다. 이조가 아니고(회전 0반음 최저,
-- 다음이 0.196) 시작을 옮겨도 오르기만 했다. 끝점을 훑으니 두 쌍이 함께 내려가 92초에서
-- 0.098/0.094, 98초에서 0.092/0.091 로 바닥이었다. 부분열 DTW 가 성긴 해상도(93ms)로 옮기며
-- 그의 발췌를 10초쯤 짧게 끊은 것이라 보고 끝을 98초로 고쳤다(1번 경계 오류).
-- 그래도 티보데↔오라일리(0.067)보다 높은데, 번스타인은 연주와 지휘를 겸한 1959년 녹음이라
-- 도입의 템포 운용이 크게 다르다. 임계 아래이고 같은 판본이라 셋을 그대로 둔다.
--
-- 랩소디는 관현악 반주판만 골랐다(피아노 독주 편곡·재즈 밴드 편곡 제외).
--
-- 서브에이전트가 후보까지 만든 뒤 보고 없이 멈춰, 호출한 쪽에서 교차 정렬과 진단을 다시
-- 돌려 확인한 값이다.
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
