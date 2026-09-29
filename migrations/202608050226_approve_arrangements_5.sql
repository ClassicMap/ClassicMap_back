-- 편곡 비교 배치 5(보칼리제) 3건을 발행 직전 상태로 올린다.
--
-- **정렬 비용 임계를 적용하지 않는다**(sector_type ARRANGEMENTS). A18 에서 보류된
-- 뒤 편곡 비교로도 한동안 못 살렸던 곡이다.
--
--   라흐마니노프 <14개의 로망스> Op. 34 중 14번 "보칼리제"(piece 228), sector 264:
--     테 카나와 (목소리 + 피아노, 로저 비뇰스)          7.15–304.20   297.1s
--     로스트로포비치 (첼로 + 피아노, 데듀힌)            1.70–390.80   389.1s
--     쾰른 신 필하모닉 (관현악판)                      2.79–422.50   419.7s
--
-- 교차 정렬은 기록만 한다 — 0.1393 · 0.3479 · 0.3701.
--
-- **이 배치는 판마다 role 을 달리 쓴 첫 자리다.** primary 가 각각 vocalist · soloist ·
-- orchestra 다. 원곡이 가사 없이 모음으로만 부르는 가곡이라 선율을 무엇이 노래해도
-- 되고, 그래서 편곡이 원곡보다 널리 돈다(라흐마니노프 본인도 관현악판을 남겼다).
--
-- 막고 있던 것은 DB 가 아니라 `build_candidates.py` 한 줄이었다 — `piece["role"]` 을
-- 세 영상에 똑같이 붙이고 있었다. 적재기는 크레딧마다 `role_code` 를 읽고
-- (`canonical_credit_role`) `performance_credits.role_code` 도 크레딧마다 따로 있다.
-- `video.role` 을 먼저 읽게 고쳐서 목소리와 악기를 한 구간에 둘 수 있게 됐다.
-- 딸림 크레딧 검사도 곡의 role 이 아니라 판별 role 을 보게 함께 고쳤다.
--
-- 임계를 대신하는 조건을 다 확인했다 — 같은 작품 MBID
-- 24b1c94b-2779-3964-bc2e-3c5d4137f3f9, 셋 다 전곡, 배급 표기가 편성을 밝힘,
-- **셋의 편성이 서로 다름**(목소리+피아노 / 첼로+피아노 / 관현악), 머리와 꼬리가
-- 구간 안에 다 듦.
--
-- **꼬리를 셋 다 늘렸다** — 테 카나와 298.19 → 304.20, 로스트로포비치 384.06 → 390.80,
-- 쾰른 416.91 → 422.50. 뒤에서부터 훑어 −50dB 를 넘는 마지막 자리 뒤로 잡았다.
--
-- 테 카나와 판의 머리는 앞 6초가 디지털 무음이고 문턱 다섯이 5.99~7.91초에 모인다.
-- 검출값 7.15 를 그대로 두었다.
--
-- **A18 에서 뺀 배틀 판은 쓰지 않는다.** 음원 자체가 앞 79초만 같은 음악이고 그 뒤
-- 150초가 다른 녹음이다(같은 트랙 안에서 앞블록↔다음블록이 0.2818). 편곡 문제가 아니라
-- 음원 결함이므로 편곡 비교로도 살릴 수 없다.
--
-- 202608050225 에서 인물·단체 셋을 등록했다. **쾰른 신 필하모닉(Q22959500)은 이미
-- 등록된 쾰른 실내관현악단(729, Q111795682)과 다른 악단이다.**
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
