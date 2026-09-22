-- 협주곡 악장 비교 영상 6건을 발행 직전 상태로 올린다.
--
-- 대상 (S tier 1라운드, 서브에이전트 배치)
--   하이든 트럼펫 협주곡 3악장(piece 88): 허세스 / 앙드레 / 마샐리스          0.0450~0.0513
--   모차르트 호른 협주곡 4번 론도(piece 434): 회그너 / 골트샤이더 / 터크웰     0.0518~0.0679
--
-- 하이든: 검출기가 여린 현 도입을 건너뛰고 총주 진입(10~14초)에서 시작을 잡았다. 셋이
-- 같은 방향으로 틀려 교차 정렬로는 드러나지 않았고, 수정 전에도 모두 임계 아래였다.
-- 시작을 첫 음(0.00 / 0.28 / 2.16초)으로 당기자 세 쌍이 함께 내려가 고친 값을 썼다.
--
-- 모차르트: 턱웰·다이엇·담의 반주가 모두 ASMF/마리너라 다양성을 위해 골트샤이더(뮌헨
-- 체임버 오케스트라, 지휘자 표기 없음)를 골랐다. 골트샤이더가 낀 두 쌍이 0.015 쯤 높지만
-- 정상 범위다. 회그너 설명에는 역할 표기가 없어 이름과 Wikidata 유형으로 지휘자와
-- 악단을 나눴다.
--
-- 같은 라운드의 쇼스타코비치 피아노 협주곡 2번 안단테는 정렬은 통과(0.0558~0.0949)했지만
-- MBID 가 국제 시드 곡(piece 12515)에 붙어 있어 보류했다. 후보는 curation 에 있다.
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
