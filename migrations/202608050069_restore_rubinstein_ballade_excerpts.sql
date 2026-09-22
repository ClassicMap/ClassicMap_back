-- 쇼팽 발라드 1번(piece 129) 발췌 섹터 두 곳에 루빈스타인(1963 실황)을 되살린다.
--
-- 202608050068 에서는 루빈스타인이 다른 연주와 0.11~0.14 로 걸려 세 섹터 모두에서 뺐다.
-- 원인은 연주가 아니라 교차 정렬이었다. chroma_cens 가 구간마다 튜닝을 추정해, 조율이
-- 반음 경계 근처인 이 녹음은 경계가 0.1초만 달라도 비용이 0.068~0.115 를 오갔다.
-- 튜닝을 영상 단위로 고정하고 다섯 연주를 다시 쟀다.
--
--   서주·제1주제: 전체 0.063~0.097, 루빈스타인 쌍 0.063~0.095  → 되살림
--   코다:         전체 0.064~0.103, 루빈스타인 쌍 0.069~0.078  → 되살림
--   제2주제:      루빈스타인↔호로비츠 한 쌍만 0.115. 이 섹터에서 멀리 있는 쪽은 호로비츠
--                 (다른 연주와도 0.10 대)이지만 이미 발행돼 있어 두고, 루빈스타인을 넣지 않는다
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
