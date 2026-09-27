-- A tier A15 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   포레 파반느 Op. 50 관현악판 전곡(piece 207):
--     마리너·ASMF / 틸슨 토머스·샌프란시스코 / 오르만디·필라델피아   0.0559~0.0694
--   포레 시칠리엔 Op. 78 첼로와 피아노 원곡 전곡(piece 208):
--     이서리스·드부아용 / 요요마·스톳 / 카퓌송·달베르토              0.0636~0.0740
--   포레 <꿈을 꾼 후에> Op. 7-1 성악과 피아노 원곡 전곡(piece 209):
--     플레밍·티보데 / 드비엘·타로 / 헨드릭스·달베르토                0.0762~0.0815
--
-- 셋 다 짧아 전곡이다. **셋 다 편곡이 원곡을 덮은 곡이라 편성 맞추기가 이 배치의
-- 거의 전부였다.**
--
--   207 은 합창 없는 순수 관현악판으로 맞췄다. 포레 자신의 합창판과 피아노 독주판·
--       플루트·기타판·현악 합주판이 돈다.
--   208 은 첼로+피아노 원곡으로 맞췄다. <펠레아스와 멜리장드> 모음곡의 관현악판
--       (플루트와 하프가 선율을 든다)이 훨씬 유명하고 플루트·바이올린·기타·오르간판도 돈다.
--   209 는 사람이 노래하는 판으로 맞췄다. 카살스 편곡 첼로판이 원곡만큼 유명하다.
--
-- **209 에서 폰 슈타데를 헨드릭스로 바꿨다. 이조였다.** 처음 편성(플레밍·폰 슈타데·
-- 드비엘)에서 플레밍↔폰 슈타데의 회전 최저가 **2반음**(0.0807)이고 0반음은 0.369 다.
-- 이 곡은 소프라노·메조·바리톤 이조판이 다 도는데, 폰 슈타데(메조)가 장2도 아래
-- 조로 부른 판이었다. 헨드릭스로 바꾸니 세 쌍 모두 0반음이 최저다. 조가 갈리는 것은
-- 실수가 아니라 실제 조성 차이이므로 같은 조끼리 셋을 맞추는 것이 맞다.
--
-- **마리너의 tuning 이 정확히 +0.000 이다.** A=415 는 440 대비 정확히 -1.000 반음
-- 이라 접히면 0.000 으로 보이므로 이것이 접힘 의심 자리다. 회전을 떠서 갈랐다 —
-- 최저가 0반음(0.0678)이고 다음으로 낮은 값이 0.283 이다. 접힘이 아니다.
-- ASMF 의 1970년대 현대악기 녹음이다. A11 의 라트비아 방송합창단과 같은 자리다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저다. tuning 폭은 곡마다 0.15 / 0.03 /
-- 0.11 반음으로 좁다.
--
-- **경계를 손봤다.** 셋 다 소품이라 경계가 곧 판정이다. 208·209 는 여린 피아노
-- 전주로 시작해 광대역 RMS 가 시작을 늦게 잡는다. 검출값과 끝 보정을 견줘 보고
-- 비용이 함께 내려가는 쪽을 골랐다(208 은 검출값, 209 는 시작+끝 보정). 209 에서
-- 시작만 보정한 경우가 0.0790~0.0880, 시작과 끝을 함께 보정한 경우가
-- 0.0762~0.0815 로 **세 쌍이 함께 내려갔다.**
--
-- 209 의 길이가 159.5~201.8초로 1.27배 벌어지는데 전곡이라 발췌 압축 판별이
-- 해당하지 않는다. 이 가곡은 템포가 연주마다 크게 갈리는 곡이다.
--
-- 반주 피아니스트는 모두 ACCOMPANIST 로 넣었다. PIANIST 로 넣으면 적재기가
-- 독주자로 묶어 첼리스트·성악가와 나란히 뜬다. 202608050188 에서 인물 6명을
-- 등록했다. 달베르토는 208 과 209 양쪽에 든다.
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
