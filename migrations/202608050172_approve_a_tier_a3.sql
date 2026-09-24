-- A tier A3 비교 영상 6건을 발행 직전 상태로 올린다.
--
--   J.C. 바흐(카자드쉬 위작) 비올라 협주곡 C단조 1악장 도입(piece 109):
--     크리스트·뮐러브륄·쾰른 실내 / 라둘로비치 / 말리·프라하 실내     0.0714~0.0790
--   요한 슈타미츠 클라리넷 협주곡 B♭장조 1악장 도입(piece 110):
--     마이어·브라운·ASMF / 브루너·슈타틀마이어·뮌헨 체임버 /
--     오텐잠머·포츠담 실내악 아카데미                                 0.0559~0.0706
--
-- 109 에서 연주 하나를 교체했다. 처음 고른 하르트무트 로데가 교차표에서 혼자
-- 바깥이었다. 예비 둘을 더 받아 다섯으로 뜬 교차표에서 **로데가 낀 네 쌍이 전부
-- 임계를 넘었고**(0.1177 / 0.1219 / 0.1226 / 0.1295) 나머지 여섯 쌍은
-- 0.0687~0.0859 였다. S tier BC1 에서 하딩을 뺀 것과 같은 모양이다.
--
-- 원인은 넷을 배제했으나 끝내 못 밝혔다.
--   창 길이 아님 — 발췌를 120 → 55 → 34초로 줄여도 로데 쌍이 내려가지 않았고,
--                 옮긴 자리가 악장 길이 대비 0.515~0.531 로 비례가 맞아
--                 리토르넬로 overshoot 도 아니다
--   이조 아님   — 12방향 회전 최저가 0반음(0.1177), 다음이 7반음 0.238
--   경계 아님   — 구간 삼등분이 고르게 나쁘고 양끝 훑기가 평평하다
--   조율 아님   — 로데 0.14 로 다섯 중 한가운데인데 비용만 혼자 바깥이다
-- 무엇 때문인지는 모르나 바깥인 것은 분명하다. 교체 뒤 세 쌍이 0.0714~0.0790 으로
-- 나머지와 같은 대역에 들어왔다.
--
-- 109 의 MusicBrainz 작품은 작곡가가 앙리 귀스타브 카자드쉬이고
-- "previous attribution: Johann Christian Bach" 로 적혀 있다. 곡 제목의 "위작" 과
-- 맞는다. 음반과 영상은 대개 J.C. 바흐 이름으로 내므로 그대로 골랐다.
--
-- 트럼펫 협주곡 D장조(piece 112)는 이 배치에서 빠졌다. 이 곡 녹음은 넷뿐인데
-- (하르덴베르거·ASMF / Krisztián Kováts / Sander Kintaert / Chase Hawkins)
-- 하르덴베르거 말고는 **wikidata 항목이 아예 없다.** 적재기는 크레딧을 wikidata 로
-- 해소하므로 연주자 셋을 채울 수 없다. 영상을 받기 전에 확인해 운영 클리퍼를 아꼈다.
-- A-TIER-QUEUE.md 의 "다시 볼 곡" 에 적었다.
--
-- 조율 폭은 109 가 0.20 반음, 110 이 0.11 반음이다. 여섯 다 현대악기라 A=415
-- 접힘 자리에 걸리는 것이 없다.
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
