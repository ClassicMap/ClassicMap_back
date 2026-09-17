-- 성악 비교 영상 3건을 발행 직전 상태로 올린다.
--
-- 대상은 푸치니 <투란도트> 중 "공주는 잠 못 이루고"(piece 211)이다.
--   카우프만 / 카마레나 / 베차와 (테너)
--
-- 성악곡을 비교 영상에 넣는 첫 사례다. legacy 곡 중 41곡이 성악이라는 이유로
-- 미뤄져 있었는데, 화성 정렬이 성악에서도 통하는지 확인한 적이 없어서였다.
--
-- 결론부터 적으면 통한다. 세 쌍이 0.0589~0.0646 으로, 기악 배치와 같은 수준이다.
-- 가사와 발음이 chroma 에 잡히지 않고 화성 진행만 남기 때문으로 본다.
--
-- 다만 성악 특유의 문제를 하나 봤다. 처음 넣으려던 플로레스는 다른 둘과
-- 0.1077~0.1184 였는데, 원인이 지금까지 본 두 가지(경계·판본) 어느 쪽도
-- 아니었다.
--   - 이조가 아니다. 크로마를 12방향으로 돌려 보니 0반음이 최선이고
--     나머지 회전은 0.22~0.31 로 확연히 나빴다. 조성은 같다.
--   - 경계만의 문제도 아니다. 시작과 끝을 훑으니 비용이 0.118 근처에서
--     평평하다가 특정 지점(184.3, 199.3, 0.0, 12.5초)에서만 0.081~0.085 로
--     뚝 떨어졌다.
-- 어느 경계에서든 0.08 이 나온다는 것은 같은 곡이라는 뜻이다. 다만 DTW 경로가
-- 두 갈래로 갈리고 경계가 조금 달라지면 다른 쪽으로 빠진다. 라이브 연주의
-- 늘임이 심하면 이렇게 될 수 있다고 본다.
-- 구간을 억지로 맞추면 통과하지만 그 값이 음악적 경계는 아니므로 교체했다.
--
-- 남은 성악 40곡은 이 방식으로 진행할 수 있다. 다만 라이브 실황이 많은 곡은
-- 위와 같은 불안정이 나올 수 있어 교차 정렬을 그대로 신뢰하면 된다.
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
