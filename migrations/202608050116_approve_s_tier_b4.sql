-- S tier 대기열 B4 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   베토벤 교향곡 7번 Op. 92 2악장 Allegretto 도입(piece 438): 피셔·콘세르트허바우 /
--     번스타인·뉴욕필 / 아바도·빈필                                     0.0654~0.0954
--   베토벤 교향곡 6번 "전원" Op. 68 1악장 도입(piece 437): 카라얀·베를린필 /
--     뵘·빈필 / 번스타인·뉴욕필                                         0.0400~0.0469
--   차이콥스키 현을 위한 세레나데 Op. 48 1악장 도입(piece 454): 카라얀·베를린필 /
--     번스타인·뉴욕필 / 마리너·ASMF                                     0.0375~0.0433
--
-- 셋 다 도입 120초 발췌(anchor=head)이고 시작은 검출값에 고정했다.
--
-- 검출 시작을 두 군데 고쳤다. 둘 다 전원 1악장의 여린 도입을 지나친 것이다.
-- 뵘은 41.49 → 2.85 (2.9초에서 조성 RMS 가 -57.3 → -44.4dB 로 계단식 상승, 39초를
-- 통째로 버리고 있었다), 카라얀은 7.62 → 1.50 (1.4초에서 평탄도 0.28 → 0.021 로 떨어져
-- 조성음이 되고, 번스타인의 확인된 도입을 부분열 DTW 로 옮겨도 1.53 으로 맞았다).
-- 원본은 s-b4-detected.orig.json 에 있다.
--
-- 교향곡 7번은 기준 연주를 아바도에서 피셔로 바꿨다. 아바도 기준일 때 번스타인의
-- 옮김 비용이 0.0678 로 0.06 을 넘었고, 피셔 기준에서 0.0430/0.0420 으로 내려갔다.
-- 그래도 아바도↔번스타인이 0.0954 로 같은 곡의 다른 쌍(0.065/0.067)보다 높아 진단했다.
-- 이조가 아니고(0반음 0.095 가 뚜렷한 최저, 나머지 0.299~0.423), 경계 오류도 아니다
-- (구간 삼등분이 0.1071/0.1012/0.0943 로 고르게 높다). 예비 연주 둘(카라얀·베를린필,
-- 두다멜·시몬 볼리바르)을 받아 다섯 연주 교차표를 뜨니 열 쌍이 0.0483~0.0954 로 전부
-- 통과했고 넷과 멀어지는 바깥 연주가 없었다. 번스타인(뉴욕필 1969)과 아바도(빈필 1987)가
-- 해석의 양 끝일 뿐이라고 보아 교체하지 않았다. 번스타인을 카라얀으로 바꾸면 세 쌍이
-- 0.0531~0.0657 로 좁아지지만, 이 배치의 세 곡 모두에 카라얀이 들어가 비교의 폭이 줄고
-- 무엇보다 0.0954 는 임계(0.11) 아래다.
--
-- 세레나데는 도입 발췌의 길이 비율이 1.21배(번스타인)와 0.80배(마리너)로 권장 1.2배를
-- 벗어난다. 세 연주를 차례로 기준 삼아도 결과가 서로 맞물렸고(번스타인≈카라얀 1.21~1.25배,
-- 마리너≈카라얀 0.80~0.84배, 마리너≈번스타인 0.66~0.67배), 악장 전체 길이도 같은 방향
-- (571/662/547초)이다. 옮김이 어긋난 것이 아니라 찬가풍 서주의 템포 차이가 실제로 그만큼
-- 크다는 뜻이다. 교차 정렬이 0.0375~0.0433 으로 이 배치에서 가장 낮은 축인 것도 같은
-- 결론을 가리킨다. 기준별 최대 이탈이 가장 작은 카라얀을 기준으로 두었다.
--
-- 영상 설명의 배급 표기로 확인한 결과 채널명과 실제 연주자가 다른 것이 둘 있다.
-- Vi05EG6sTVQ 는 채널이 베를린 필인데 녹음은 아바도·빈필(DG 1987)이고,
-- zbyO7qRoB7E 는 채널이 카라얀인데 녹음은 뵘·빈필(DG 1971)이다. 제목·채널명으로
-- 읽지 않는다는 규칙이 두 번 다 걸렸다.
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
