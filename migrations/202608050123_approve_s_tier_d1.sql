-- S tier 대기열 D1 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   베토벤 피아노 소나타 23번 "열정" 3악장 도입(piece 440): 랑랑 / 폴리니 / 아슈케나지
--                                                                      0.0402~0.0476
--   모차르트 피아노 소나타 11번 "터키 행진곡" 3악장(piece 73): 윤디 리 / 시프 / 페라이아
--                                                                      0.0377~0.0814
--   베토벤 바이올린 소나타 5번 "봄" 1악장 도입(piece 439): 펄만·아슈케나지 /
--     무터·오키스 / 강주미·김선욱                                       0.0429~0.0537
--
-- 터키 행진곡은 발췌가 아니라 악장 전체다. 세 영상 모두 3악장 낱 트랙(197~205초)이라
-- 검출 길이가 이미 그 대목의 길이였다. 07-excerpt.md 의 "검출 길이가 이미 그 대목의
-- 길이면 발췌하지 않는다" 를 따랐다(카니발에서 이것을 어겨 202608050101 로 되돌린 적이
-- 있다). 섹터 이름도 "도입" 을 빼고 끝 큐를 "악장 마지막 화음" 으로 고쳤다.
-- 440·439 는 악장이 7~10분이라 도입 120초를 발췌했다.
--
-- 바이올린 소나타의 피아노는 반주가 아니라 대등한 짝이므로 두 번째 크레딧의 역할을
-- ACCOMPANIST 가 아니라 PIANIST 로 넣었다. 램버트 오키스는 202608050121 에서 추가했다.
--
-- 검출을 두 군데 고쳤다. 원본은 detected.orig.json 에 있다.
--   페라이아  1.09 → 0.14   0.14초부터 -37~-44dB 에 평탄도 0.00001~0.0002 로 완전한
--                           조성음이고 무음 바닥은 0.116초까지다. 첫 마디 회전음형이
--                           통째로 빠져 있었다
--   강주미    0.72 → 1.38   반대로 이르게 잡았다. 0.23~1.30초는 -65~-70dB 홀 잡음이고
--                           1.35→1.39초에서 -52.5dB 로 뛴다
-- 두 수정 모두 관련된 두 쌍이 함께 내려갔다(경계 오류의 근거).
--
-- 터키 행진곡의 시프가 다른 쌍보다 두 배 높아(0.0777/0.0814) 진단했다. 이조가 아니고
-- (0반음 0.078 이 뚜렷한 최저, 나머지 0.169~0.404) 경계 문제도 아니다(삼등분이 고르게
-- 높고 시작·끝 훑기가 평평하다). 예비 연주 한 개(우치다 미쓰코)를 받아 교차표를 뜨니
-- 시프가 나머지 셋 모두와 0.078~0.082 로 일관되게 멀어졌고 나머지 셋은 0.038~0.056 에
-- 모였다. 1981년 데카 녹음의 장식음·아티큘레이션 읽기가 다른 것으로 보인다.
-- 우치다로 바꾸면 세 쌍이 0.0377~0.0563 으로 모이지만, 시프의 값은 임계(0.11)는 물론
-- 통상 통과 대역(0.04~0.09) 안이고 해석 차이를 보여 주는 것이 이 기능의 목적이라
-- 교체하지 않았다.
--
-- 강주미 연주는 제시부 반복을 하지 않아 악장 길이가 다른 둘의 0.66~0.70배지만
-- 발췌가 도입 120초라 영향이 없다.
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
