-- 레거시 비교 영상 3곡을 이 파이프라인으로 다시 수집한 33건을 발행 직전 상태로 올린다.
--
-- 대상 (섹터 10개, 기존 레거시 섹터는 그대로 두고 새 sector_key 로 붙였다)
--   라흐마니노프 피아노 협주곡 3번(piece 226): 1악장 카덴차 / 2악장 / 3악장 클라이맥스 / 3악장 도입부
--     임윤찬 · 랑랑 · 유자 왕
--   라흐마니노프 피아노 협주곡 2번(piece 225): 1악장 / 2악장 / 3악장
--     안나 페도로바 · 조성진 · 유자 왕
--   쇼팽 발라드 1번(piece 129): 서주·제1주제 / 제2주제 / 코다
--     짐머만 · 조성진 · 호로비츠 · 키신
--
-- 클립 자산 없이 수동으로 넣었던 레거시 연주는 새 비교 API 공개 기준(서로 다른 primary 3명 이상,
-- 클립 ready)에 들지 못했다. 같은 영상과 사람이 잡은 발췌 경계를 출발점으로 삼고, 첫 음 onset 과
-- 악구 사이 숨에 맞추는 미세 조정만 했다. 조정 폭은 섹터마다 1초 안팎이다.
--
-- 교차 정렬
--   대부분 0.049~0.098 이다.
--   라흐 3번 1악장 카덴차는 랑랑이 낀 쌍이 0.107~0.123 이다. 연주자마다 오시아판과 원판을 골라
--   친 구간이고, 그 차이를 비교하라는 것이 레거시 섹터의 설명이라 그대로 둔다.
--   발라드의 루빈스타인(1963 실황)은 세 섹터 모두에서 다른 연주와 0.11~0.17 로 멀어 뺐다.
--   섹터마다 네 명이 남는다.
--
-- 크레딧: 독주자 → 지휘자 → 악단. 지휘자·악단은 영상 설명에 적힌 것만 넣었고(202608050065),
-- 설명에 없는 랑랑(3번)·조성진(2번) 영상은 독주자만 둔다.
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
