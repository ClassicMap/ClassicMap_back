-- 비교 영상 S2 첫 배치 9건을 발행 직전 상태로 올린다.
--
-- 대상은 2026-09-16 에 적재한 짧은 피아노 소품 3곡이다.
--   쇼팽 연습곡 Op.10 No.12 "혁명"  - 키신 / 조성진 / 폴리니
--   쇼팽 녹턴 Op.9 No.2              - 랑랑 / 조성진 / 루빈스타인
--   쇼팽 왈츠 Op.64 No.1 "강아지"    - 랑랑 / 루빈스타인 / 키신
--
-- S1 과 달리 사람이 구간을 고르지 않았다. 곡이 짧아 작품 전체가 곧 구간이므로,
-- 음악이 실제로 시작하고 끝나는 지점만 오디오에서 찾으면 된다.
-- 조성 성분이 이어지는 구간을 곡으로 보고 박수와 무음을 걷어냈다.
-- 이 방식은 S1 에서 사람이 확인한 9개 지점을 정답으로 재어
-- 시작 오차 중앙값 0.16초, 9건 중 8건이 1초 이내인 것을 확인한 뒤 적용했다.
--
-- 판정이 맞는지는 같은 곡의 세 연주를 서로 정렬해 확인했다.
-- 같은 곡의 같은 구간이라면 연주가 달라도 화성 진행이 맞물린다.
-- 이 배치는 모든 쌍이 정렬 비용 0.045~0.080 으로 통과했다.
--
-- 같은 방식으로 뽑았다가 걸러낸 것도 있다. 쇼팽 즉흥환상곡과 리스트 사랑의 꿈은
-- 정렬 비용이 0.11~0.13 으로 높아 이번 배치에서 뺐다. 검출이 틀린 것이 아니라
-- 연주마다 반복과 카덴차 처리가 달라 같은 악보 구간이 되지 않는 경우다.
-- 전곡을 구간으로 쓰는 방식의 한계이므로 따로 다뤄야 한다.
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
