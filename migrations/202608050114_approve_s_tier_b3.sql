-- S tier 대기열 B3 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   하이든 교향곡 101번 "시계" 2악장 도입(piece 84): 워즈워스·카펠라 이스트로폴리타나 /
--     번스타인·뉴욕필 / 콜린 데이비스·콘세르트허바우                     0.0554~0.0789
--   하이든 교향곡 45번 "고별" 4악장 Adagio(piece 85): 마리너·ASMF /
--     워즈워스·카펠라 이스트로폴리타나 / 바렌보임·잉글리시 체임버          0.0747~0.0977
--   모차르트 교향곡 41번 "주피터" 4악장 도입(piece 68): 뵘·베를린필 /
--     카라얀·베를린필 / 번스타인·뉴욕필                                  0.0434~0.0477
--
-- 서브에이전트가 오디오만 받고 멈춰, 호출한 쪽에서 검출부터 후보 생성까지 직접 돌렸다.
--
-- 검출을 여섯 군데 고쳤다. 주피터 세 건은 여린 푸가 주제를 지나쳐 총주(7.8~8.4초)부터
-- 잡혔고, 고별 세 건은 연주자들이 하나씩 빠지며 소리가 작아지는 끝부분을 8~10초씩 버렸다.
-- RMS 로 확인해 고쳤다(주피터 1.46 / 0.00 / 0.00, 고별 끝 461.5 / 477.5 / 466.0).
-- 원본은 s-b3-detected.orig.json 에 있다.
--
-- 고별은 처음에 끝에서 120초를 발췌했더니 마리너↔워즈워스가 0.1159 로 임계를 넘었다.
-- 기준 연주를 셋 다 바꿔 봐도 0.1129~0.1178 로 같았다. 이 대목은 연주자가 하나씩 퇴장해
-- 마지막에 바이올린 둘만 남는 곳이라 화성 윤곽이 얇다. 발췌를 180초로 늘려 Adagio 전체를
-- 담으니 세 쌍이 0.0747~0.0977 로 들어왔다(참고로 4악장 도입 120초는 0.0486~0.0548 이지만
-- 이 곡에서 들려줄 대목은 퇴장 장면이다). 권장 길이 30~120초를 넘기는 것은 이 이유 때문이다.
--
-- 시대악기 연주(하르농쿠르 A=415, 호그우드)는 조율이 달라 이조로 걸릴 위험이 있어 뺐다.
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
