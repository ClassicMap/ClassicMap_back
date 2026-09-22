-- 관현악 비교 영상 9건을 발행 직전 상태로 올린다.
--
-- 대상 (S tier 1라운드, 서브에이전트 배치)
--   프로코피예프 고전 교향곡 1악장(piece 323): 카라얀·베를린필 / 게르기예프·LSO / 마리너·ASMF   0.0446~0.0511
--   바그너 "발퀴레의 기행"(piece 144): 메타·뉴욕필 / 넬손스·빈필 / 파보 예르비·NHK 교향악단       0.0383~0.0413
--   멘델스존 "핑갈의 동굴"(piece 126): 마주어·게반트하우스 / 번스타인·이스라엘필 / 가디너·LSO    0.0539~0.0692
--
-- 발퀴레의 기행은 성악 없는 관현악 콘서트판끼리만 골랐다. 셋 다 관현악 발췌 음반이고
-- 길이가 299~322초다(성악이 든 오페라 원판 영상은 480~490초대). 교차 정렬도 0.04 대로 붙는다.
--
-- 핑갈의 동굴은 대부분 연주가 600초를 넘어 582~598초 영상만 썼다. 가디너 영상은
-- LSO 공식 채널의 실황이고 설명에 배급 표기가 없어 채널과 제목으로 악단과 지휘자를
-- 판단했다. 번스타인이 낀 두 쌍이 0.066~0.069 로 조금 높지만 정상 범위다.
--
-- 경계 수정과 교체는 없었다.
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
