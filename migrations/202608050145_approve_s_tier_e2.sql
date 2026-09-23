-- S tier 대기열 E2(발레·부수음악 낱곡) 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   스트라빈스키 <불새> "마왕 카슈체이의 흉악한 춤"(piece 310): 뒤투아·몬트리올 /
--     번스타인·뉴욕필 / 두다멜·LA필                                     0.0602~0.0695
--   스트라빈스키 <페트루슈카> 1장 "러시아의 춤"(piece 311): 하이팅크·베를린필 /
--     오자와·보스턴심포니 / 틸슨 토머스·필하모니아                      0.0609~0.0628
--   멘델스존 <한여름 밤의 꿈> "결혼 행진곡"(piece 123): 뒤투아·몬트리올 /
--     오자와·보스턴심포니 / 프레빈·빈필                                 0.0260~0.0364
--
-- 낱 트랙을 통째로 쓰는 배치다. excerpt 를 두지 않았고 run_excerpt.py 를 돌리지 않았다.
-- 결혼 행진곡 세 쌍이 0.0260~0.0364 로 지금까지 전체에서 가장 낮다.
--
-- 판본은 섞였지만 해당 대목의 음악이 같아 함께 썼다. 불새는 뒤투아가 발레 전곡(1910),
-- 나머지 둘이 1919년 모음곡이다. 페트루슈카는 하이팅크가 1911년 원판, 오자와가 1947년
-- 개정판이고 틸슨 토머스는 표기가 없다. 길이 편차가 1.05~1.08배로 편집 차이가 없다.
-- 피아노 독주 편곡(<페트루슈카>에서의 세 악장)은 전부 제외했다.
--
-- ## 영상 둘을 검출 뒤에 되돌렸다
--
-- 고르고 나서 실측으로 걸러낸 것이다. 선정 단계에서는 보이지 않는 결함이었다.
--
--   가디너·런던심포니 (결혼 행진곡)  음악이 215.5초에서 끝나고 그 뒤 55초가 박수·발언이다
--                                    (평탄도 0.14~0.47, 광대역-하모닉 13~22dB). 다른 둘은
--                                    303·310초이고 구조 지표(여린 중간 대목의 시작 위치를
--                                    전체 길이로 나눈 값)가 0.50인데 이 영상만 0.60 이라
--                                    마지막 한 블록 약 45초가 빠졌다
--   래틀·런던심포니 (카슈체이의 춤)   도입 2.5초가 페이드인이다. 피크가 0.00초 -30.4dB 에서
--                                    2.50초 -9.6dB 로 매끈하게 오른다. 섹터 큐가 "총주의
--                                    첫 충격 화음" 인데 그 화음이 감쇠된 채로만 들어온다
--                                    (번스타인 0.4초 -17.0dB, 두다멜 0.7초 -9.7dB 와 대조).
--                                    경계를 1.04 → 0.08 로 옮겨 재도 비용이 0.0862→0.0873,
--                                    0.0777→0.0776 으로 움직이지 않아 경계 문제도 아니었다
--
-- 둘 다 뒤투아로 교체했다.
--
-- ## 검출
--
-- 네 군데를 고쳤다. 원본은 s-e2-detected.orig.json 에 있다. **이 배치는 끝이 문제였다.**
--
--   불새 뒤투아   끝 275.90 → 251.50   춤의 마지막 총주 화음이 249.75~250.25초(피크 -1.9dB)
--                                      이고 251~276초가 -42~-52dB 의 조용한 조성음이다.
--                                      전곡반이라 자장가가 attacca 로 붙은 것이다
--   불새 두다멜   끝 260.06 → 237.50   같은 유형. 1919년 모음곡에서도 트랙 끝에 자장가
--                                      머리가 붙어 있었다
--   불새 번스타인 끝 233.36 → 234.25   위 둘에 맞춰 화음 + 잔향 1.5초로 통일했다
--   페트루슈카 하이팅크 끝 166.12 → 158.20  춤은 157.5초까지고 158~159초가 무음,
--                                      160~166초에 별개의 음악이 영상 끝에서 잘린 채
--                                      붙어 있다
--   결혼 행진곡 오자와 시작 3.67 → 0.03   트럼펫 팡파르의 첫 음이 0.05초다. 검출값은
--                                      두 번째 악구에 붙어 팡파르 두 음을 버렸다
--
-- **attacca 로 이어지는 다음 곡은 검출이 끊지 못한다.** 음악이 계속되므로 덩어리가
-- 이어지고, 조용해질 뿐 무음이 되지 않는다. 낱곡 배치에서 전곡반 트랙을 쓸 때는
-- 끝을 반드시 본다. 고친 뒤 여러 쌍이 함께 내려갔다(번스타인↔두다멜 0.0751→0.0623,
-- 하이팅크↔오자와 0.0654→0.0613, 하이팅크↔틸슨토머스 0.0643→0.0628).
--
-- ## 채널명 함정
--
-- "Herbert von Karajan" 채널의 두 영상이 각각 프레빈·빈필, 몬퇴·빈필이었다.
-- 여섯 배치 연속이다. 전부 영상 설명의 배급 표기로 확정했다.
--
-- 결혼 행진곡은 오르간·피아노·취주악 편곡과 로열티 음원이 검색 상위에 섞여 있어
-- 관현악 원곡만 골랐다. 런던심포니 채널에 올라간 것 중에도 표기가 다른 연주자인
-- 로열티 음원이 있었다.
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
