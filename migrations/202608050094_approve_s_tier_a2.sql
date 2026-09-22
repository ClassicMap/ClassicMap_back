-- S tier 대기열 A2 비교 영상 6건을 발행 직전 상태로 올린다.
--
--   쇼스타코비치 왈츠 2번(piece 319): 샤이·콘세르트허바우 / 넬손스·빈필 /
--     리턴·싱가포르 교향악단                                        0.0347~0.0394
--   모차르트 K.265 변주곡(piece 436): 정명훈 / 치콜리니 / 하스킬     0.0622~0.0686
--
-- 왈츠 2번은 원곡 관현악판(Suite for Variety Orchestra 일곱째 곡)만 썼다. 이 곡은
-- 재즈 밴드·아코디언·영화 사운드트랙 편곡이 많다. 제목의 "Jazz Suite No. 2" 는
-- 관행적 오기이고 세 영상 모두 설명에 악단과 지휘자가 적혀 있다.
--
-- K.265 는 세 연주가 464~565초로 모두 600초 안이라 전곡을 그대로 썼다.
-- 정명훈은 DB 에 지휘자로 등록돼 있지만 이 음원은 ECM "Piano" 앨범의 피아노 독주라
-- 크레딧을 PIANIST 로 넣었다. 해소는 wikidata 로 하므로 분류와 어긋나도 적재는 된다.
--
-- 검출이 네 건에서 종결부를 버렸다. 곡 안의 여린 대목에서 끊긴 것으로, 박수가 아니라
-- 음악이 이어지고 있었다(리턴 39초, 넬손스 22초, 정명훈 시작 5초와 종결 화음,
-- 치콜리니 종결 화음). RMS 로 실제 끝을 확인해 고쳤고 여러 쌍이 함께 내려갔다.
-- 고치기 전 값은 s-a2-detected.orig.json 에 있다.
--
-- 같은 배치의 브람스 자장가(piece 451)는 성악 원곡판 3종을 모으지 못해 막혔다.
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
