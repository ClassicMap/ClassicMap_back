-- 모차르트 비교 영상 6건을 발행 직전 상태로 올린다.
--
-- 대상
--   아이네 클라이네 나흐트무지크 1악장(piece 66): 조보트카 / 마리너 / 래틀
--   피아노 소나타 16번 K.545 1악장(piece 435): 피레스 / 손열음 / 랑랑
--
-- 두 배치는 서브에이전트에 맡긴 첫 배치다. 영상 선정부터 후보 생성까지 서브에이전트가
-- 했고, 작품 해소·적재·발행은 호출한 쪽이 했다.
--
-- 아이네 클라이네: 처음 넣은 카라얀·베를린필이 다른 연주 넷 중 셋과 0.110~0.136 으로
-- 어긋나고 경계를 훑어도 평평해 뺐다. 최종 세 연주는 0.0668~0.0696 이다.
-- 래틀·조보트카는 검출기가 첫 4마디를 잘라 시작을 0.05초로 바로잡았다.
--
-- K.545: 처음 넣은 쉬프가 0반음 0.2464, 1반음 0.1157 로 조율 피치가 다른 녹음이라
-- 피레스로 바꿨다. 세 연주는 0.0538~0.0871 이다.
-- 검출기 가장자리 버그를 고친 뒤 다시 재 보니 랑랑의 시작이 4.16초가 아니라 0.05초였다
-- (랑랑이 낀 두 쌍이 0.002~0.003 내려감). 이미 적재한 뒤라 자연키가 바뀌는 재적재를
-- 하지 않고 4초 경계로 발행한다. 발행된 다른 17건을 1~4초 차이라 고치지 않은 것과 같은 기준이다.
-- 재검출 결과는 curation 의 *.recheck.* 에 남겼다.
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
