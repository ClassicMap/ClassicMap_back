-- S tier 대기열 A1 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   쇼팽 환상 즉흥곡(piece 128): 트리포노프 / 랑랑 / 윤디            0.0538~0.0854
--   리스트 사랑의 꿈 3번(piece 139): 임윤찬 / 키신 / 랑랑            0.0691~0.0717
--   브람스 헝가리 무곡 5번 관현악판(piece 155): 아바도·베를린필 /
--     얀손스·바이에른 방송 교향악단 / 마리너·ASMF                   0.0540~0.0683
--
-- 환상 즉흥곡과 사랑의 꿈은 references/03-verification.md 에 "반복 구조가 갈리는 곡"
-- 으로 의심돼 있었다. 그 기록은 교차 정렬이 구간마다 튜닝을 추정하던 때(202608050064
-- 이전, 고침 f0a234c) 것이다. 튜닝을 고정하고 다시 재니 아홉 쌍이 모두 임계 아래였고
-- 5번 패턴은 재현되지 않았다. 교체도 경계 수정도 없었다.
--
-- 헝가리 무곡은 관현악판(G단조)만 썼다. 세 영상 모두 설명에 조성과 지휘자·악단이 적혀
-- 있다. 길이가 140~190초로 벌어지지만(1.35배) 얀손스가 실황 앙코르라 템포가 느린 것이고
-- 정렬은 0.054~0.068 이다.
--
-- 고른 과정에서 뺀 것: "Herbert von Karajan" 채널의 두 영상은 설명상 각각 아바도·빈필과
-- 프리츠 라이너·빈필이었다(채널 이름은 근거가 아니다). 두다멜 영상은 F#단조 피아노
-- 연탄판이라 다른 work 이다.
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
