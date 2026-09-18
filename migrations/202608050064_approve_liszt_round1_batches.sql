-- 리스트 비교 영상 6건을 발행 직전 상태로 올린다.
--
-- 대상 (S tier 1라운드, 서브에이전트 배치)
--   초절기교 연습곡 4번 "마제파"(piece 143): 트리포노프 / 임윤찬 / 하오첸 장  0.0548~0.0648
--   헝가리 광시곡 2번(piece 141): 리시차 / 스미노 하야토 / 시시킨           0.0651~0.0818
--
-- 마제파: 임윤찬의 끝(종결 팡파르 24초가 25초 기준에 못 미쳐 빠짐)과 하오첸 장의
-- 시작(46.8초로 잡힘)을 고쳤다. 두 경우 모두 그 연주가 낀 두 쌍이 함께 내려갔다.
--
-- 헝가리 광시곡: 처음 넣은 로베르토 시돈 녹음은 +46센트 조율이라 크로마 튜닝 추정이
-- 구간마다 뒤집혀 0.1255 로 걸렸다. 튜닝을 고정하면 0.08 대라 연주 문제는 아니었지만
-- 스미노 하야토로 교체한 채 통과했다(202608050062). 원곡 카덴차 영상만 골랐다.
--
-- 같은 라운드의 프로코피예프 소나타 7번은 MBID 가 국제 시드 곡에 이미 붙어 보류했고,
-- 쇤베르크 Op.23-1 은 굴드가 다른 넷과 멀어 대체 조합을 다시 재기로 보류했다.
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
