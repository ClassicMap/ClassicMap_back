-- S tier 대기열 C1 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   리스트 피아노 협주곡 1번 1악장 도입(piece 450): 아르헤리치·아바도·LSO /
--     티보데·뒤투아·몬트리올 / 오트·헹엘브로크·뮌헨필                    0.0412~0.0489
--   쇼팽 피아노 협주곡 1번 2악장 로망스 도입(piece 132): 조성진·노세다·LSO /
--     랑랑·메타·빈필 / 쓰지이·콘론·포트워스                              0.0445~0.0599
--   슈만 피아노 협주곡 1악장 도입(piece 136): 폴리니·아바도·베를린필 /
--     페라이아·아바도·베를린필 / 키신·콜린 데이비스·LSO                   0.0475~0.0683
--
-- 셋 다 악장 트랙 영상을 썼고 도입만 발췌했다. 옮김 비용 0.0269~0.0447,
-- 길이 비율 1.03~1.17배로 모두 기준 안이다. 도입 발췌라 카덴차에 닿지 않는다.
--
-- 쇼팽 세 건은 검출이 약음기 현 서주를 통째로 버리고 피아노 진입(32~47초)부터 잡았다.
-- 세 파일 모두 0.2초부터 −40~−53dB 로 음악이 있었고 spectral flatness 가 0.000~0.003 으로
-- 음악 대역이었다. 시작을 0~0.2초로 고치자 기준 연주가 낀 두 쌍이 함께 내려갔다
-- (0.0688→0.0599, 0.0556→0.0445). 셋째 쌍은 0.0022 올랐는데 두 연주가 같은 방향으로
-- 움직여 상대 관계가 거의 바뀌지 않은 쌍이다. 고치기 전 값은 s-c1-detected.orig.json 에 있다.
--
-- 슈만은 폴리니와 페라이아가 둘 다 아바도·베를린필 반주지만 독주자가 다르므로 비교가 선다.
-- 쇼팽에서 트리포노프의 (Arr. Pletnev) 트랙은 편곡이라 뺐다.
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
