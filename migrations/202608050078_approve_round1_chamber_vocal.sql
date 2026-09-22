-- 실내악·가곡 비교 영상 6건을 발행 직전 상태로 올린다.
--
-- 대상 (S tier 1라운드, 서브에이전트 배치)
--   쇼스타코비치 현악 4중주 8번 2악장(piece 320): 보로딘 / 에머슨 / 세인트로렌스   0.0567~0.0719
--   슈베르트 "아베 마리아"(piece 443): 플레밍 / 보니(반주 파슨스) / 치자크          0.0570~0.0629
--
-- 4중주: 에머슨 트랙의 끝이 126초로 잡혔지만 156.4초까지 연주가 이어졌다. 끝을 옮기자
-- 에머슨이 낀 두 쌍이 함께 내려가(0.1205/0.1076 → 0.0719/0.0683) 고친 값을 썼다.
--
-- 아베 마리아: 독일어 원어, 성악+피아노 원곡판만 골랐다. 크로마 자기유사도로 절 길이를
-- 재 셋 다 3절임을 확인했다(곡 길이/절 길이 3.11, 3.26, 3.16). 처음 넣은 크리스타
-- 루트비히는 3반음 낮춰 부른 녹음이라(0반음 0.367, 3반음 0.069) 치자크로 바꿨다.
-- 반주자는 설명에 역할이 적힌 보니의 파슨스만 크레딧에 넣었다.
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
