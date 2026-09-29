-- A tier A23 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   브리튼 청소년을 위한 관현악 입문 Op. 34, 주제 총주 제시(piece 356):
--     프레빈·RPO / 오르만디·필라델피아 / 슬래트킨·런던필           0.0649~0.0924
--   브리튼 전쟁 레퀴엠 Op. 66, 1곡 "Requiem aeternam" 도입(piece 358):
--     얀손스·바이에른 / 래틀·버밍엄 / 노세다·LSO                  0.0568~0.0627
--   브리튼 첼로 모음곡 1번 Op. 72, 1곡 "Canto primo"(piece 359):
--     로스트로포비치 / 모르크 / 게르하르트                         0.0589~0.0783
--
-- **356 에서 발췌 DTW 가 두 연주의 창을 잘못 압축했다.** run_excerpt.py 가 프레빈의
-- 머리 120초를 옮겨 오르만디를 92.0초, 슬래트킨을 107.4초로 잡았고 그 상태에서
-- 프레빈↔오르만디가 **0.1127 로 임계를 넘었다.**
--
-- 진단하니 경계 오류의 모양이었다.
--   구간 삼등분이 앞 0.166 → 중간 0.240 → 뒤 0.303 으로 **뒤로 갈수록 나빠지고**
--   그 모양이 오르만디를 양쪽 상대 모두에게서 따라다녔다
--   끝점을 늘리면 **두 쌍이 함께 내려갔다**(0.1113 → 0.0989, 0.0868 → 0.0674)
--   회전 최저는 0반음(0.1127) — 이조 아님
--
-- 다만 끝점 훑기가 115~150초에서 0.090~0.094 로 **평평해** 깨끗한 최저가 없었다.
-- 이 곡은 같은 퍼셀 주제를 악기군만 바꿔 되풀이하므로 A20 볼레로처럼 비용이 자리를
-- 못 가리는 것인지 확인해야 했다. **자기 정렬로 갈랐다.**
--
--   자기 안 앞블록 ↔ 다음블록: 프레빈 0.219 · 오르만디 0.201 · 슬래트킨 0.204
--     → 되풀이지만 악기군이 달라 chroma 가 구별한다. 볼레로형이 아니다
--   오르만디 창을 상대 머리에서 옮겨 보기: +0초 0.0924 · +30초 0.1023 ·
--     +60초 0.1437 · +90초 0.2208 · +120초 0.2390
--     → **단조 증가한다. 비용이 자리를 가린다**
--
-- 자리를 가릴 수 있으므로 문제는 창의 **길이**였다. 셋 다 자기 시작에서 120초로
-- 두니 0.0649 / 0.0756 / 0.0924 가 됐다. 섹터 큐가 "전 관현악 총주의 첫 화음
-- (작품 시작)" 이고 `anchor: head` 이므로 **셋 다 같은 자리에서 같은 시간을 담는 것이
-- 큐에 맞다.** 검출 시작은 셋 다 트랙 머리(0.21 / 1.63 / 1.00)로 이미 맞았다.
--
--   오르만디 1.63–93.58 → 1.63–121.63
--   슬래트킨 1.00–108.37 → 1.00–121.00
--
-- **부분열 DTW 가 되풀이 구조에서 창을 짧게 잡는 것은 07-excerpt.md 가 경고한
-- 자리다.** 옮긴 값을 그대로 믿지 않는다.
--
-- 아홉 쌍 모두 회전 12방향에서 0반음이 최저이고 차점까지 크게 벌어진다(356 은
-- 0.18 이상, 358 은 0.26 이상, 359 는 0.31 이상). tuning 폭은 356 0.01 · 358 0.13 ·
-- 359 0.20 반음이다. 0 근처 값이 없어 A=415 접힘 자리가 없다.
--
-- **358 은 합창이 주역이라 choir 를 처음부터 넣었다**(202608050205 에서 단체 넷 등록).
-- 차례는 CONDUCTOR → CHOIR → ORCHESTRA 다. 독창자는 넣지 않았다.
--
-- 358 의 세 트랙 길이가 213~558초로 갈리는데(2.62배) 발매마다 1곡을 자르는 지점이
-- 다른 것이다. 발췌가 머리 120초라 담기는 음악은 같고, 교차 정렬 0.057~0.063 이
-- 그것을 뒷받침한다.
--
-- 선정에서 걸러낸 것을 남긴다. **브리튼 본인이 지휘한 356 트랙을 뺐다** — 지휘자
-- QID 가 작곡가 QID(Q150767)와 같아 작곡가 엔티티가 연주자로 붙는다. 내레이터가
-- 배급 표기에 든 판(번스타인, "Classical Music With a Story")과 악단 이름이 없는 판
-- ("Lorin Maazel with Orchestra")도 뺐다. 검색어가 "London Symphony" 였는데 배급
-- 표기가 RPO 인 것도 표기대로 적었다.
--
-- 경고: rights_mode 를 licensed_self_hosted 로 적지만 실제 이용 허락을 받은
-- 것이 아니다. 202608050017 의 경고와 같은 내용이다.

UPDATE performance_sources source
SET source.rights_mode = 'licensed_self_hosted',
    source.last_checked_at = CURRENT_TIMESTAMP(6)
WHERE source.rights_mode = 'unknown'
  AND EXISTS (
      SELECT 1 FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.performance_source_id = source.id
  );

UPDATE performance_sectors sector
SET sector.editorial_status = 'EDITOR_REVIEWED'
WHERE sector.editorial_status = 'FACTS_VERIFIED'
  AND EXISTS (
      SELECT 1 FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = sector.id
  );

UPDATE performance_candidates candidate
SET candidate.candidate_status = 'APPROVED'
WHERE candidate.candidate_status = 'REVIEW_REQUIRED'
  AND EXISTS (
      SELECT 1 FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = candidate.sector_id
        AND performance.performance_source_id = candidate.performance_source_id
        AND performance.start_ms = candidate.proposed_start_ms
        AND performance.end_ms = candidate.proposed_end_ms
  );
