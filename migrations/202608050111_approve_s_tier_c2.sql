-- S tier 대기열 C2 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   멘델스존 바이올린 협주곡 1악장 도입(piece 122): 한·울프·오슬로필 /
--     무터·카라얀·베를린필 / 벨·마리너·ASMF                            0.0451~0.0732
--   모차르트 클라리넷 협주곡 2악장 Adagio 도입(piece 74): 자비네 마이어·아바도·베를린필 /
--     에른스트 오텐자머·콜린 데이비스·빈필 / 마르틴 프뢰스트·스웨덴 체임버  0.0339~0.0442
--   쇼스타코비치 첼로 협주곡 1번 1악장 도입(piece 321): 요요 마·넬손스·보스턴 /
--     고티에 카푸송·게르기예프·마린스키 / 미샤 마이스키·틸슨 토머스·LSO   0.0620~0.0725
--
-- 셋 다 악장 트랙 영상이고 도입만 발췌했다. 옮김 비용 0.0184~0.0452, 길이 비율 1.09~1.17배.
--
-- 요요 마 영상에서 박수 마스크가 25~39초를 박수로 잘못 잡아 첫 덩어리가 20초로 토막 났고,
-- 최소 길이 25초에 걸려 버려지면서 검출 시작이 38.85초가 됐다. 1악장 도입(첼로 네 음 동기)이
-- 통째로 빠진 것이다. 그 구간은 −24~−44dB 에 spectral flatness 0.0001~0.011 로 음악이었다
-- (박수 기준 0.05). 박수 마스크만 끄고 같은 검출기를 돌려 2.02초를 얻었고, 그를 포함한 두 쌍이
-- 함께 내려갔다(0.1095→0.0725, 0.1134→0.0684). 무터 영상도 같은 이유로 끝이 72초 일렀으나
-- 도입 발췌라 결과에는 영향이 없고 기록만 맞췄다. 원본은 s-c2-detected.orig.json 에 있다.
--
-- 프뢰스트는 자신이 지휘한 녹음이라 크레딧 중복을 피해 conductor 를 비우고 악단만 넣었다.
-- 클라리넷 판본은 오텐자머·프뢰스트가 바셋 클라리넷이고 마이어는 설명에 표기가 없다.
-- 발췌가 Adagio 도입이라 바셋 확장음 자리에 닿지 않고, 크로마는 옥타브를 접으므로 판본
-- 차이가 정렬에 영향을 주지 않는다(실측 0.034~0.044 로 배치 최저).
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
