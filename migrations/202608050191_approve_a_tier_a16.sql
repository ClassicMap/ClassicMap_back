-- A tier A16 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   비제 교향곡 1번 C장조 1악장 도입(piece 196):
--     뒤투아·몬트리올 / 하이팅크·콘세르트허바우 / 번스타인·뉴욕필   0.0325~0.0458
--   클라라 슈만 피아노 3중주 G단조 Op. 17 1악장 도입(piece 176):
--     시르머 / 오키스·무터·페란데스 / 프레슬러·보자르 삼중주단      0.0667~0.0721
--   클라라 슈만 피아노 협주곡 A단조 Op. 7 1악장 도입(piece 177):
--     파럼·워즈워스·BBC 콘서트 / 카네메이슨·매시슨·RLPO /
--     셸리·태즈메이니아 심포니                                      0.0521~0.0535
--
-- **곡마다 세 쌍이 0.003 안에 모였다.** 유난히 높은 쌍이 없고 0.08 을 넘는 것도 없다.
-- 이 분포 자체가 로베르트 슈만과 섞일 위험을 걷어 냈다 — 176 과 177 은 로베르트의
-- 피아노 3중주·협주곡과 헷갈리기 쉽고 **177 은 조까지 같다**(로베르트도 A단조,
-- Op. 54). 다른 곡이 하나라도 섞였으면 이 자리에서 드러난다. 배급 표기에서
-- 작곡가가 Clara Schumann 인지, Op. 번호가 17·7 인지도 따로 확인했다.
--
-- **177 셸리는 건반에서 직접 지휘한다**(Hyperion 표기로 확인). conductor 크레딧을
-- 비우고 ORCHESTRA 만 붙였다.
--
-- **176 의 3중주 주자를 이쪽에서 보탰다.** 배치 정의의 videos[] 에 3중주 주자를
-- 적을 키가 없어 후보에는 피아니스트만 들어갔다. 202608050190 에서 등록하고
-- VIOLINIST·CELLIST·TRIO 로 넣었다. 반주가 아니라 대등한 3중주이므로 ACCOMPANIST
-- 가 아니다 — 적재기가 악기 역할을 독주자로 묶는 것이 이 곡에서는 맞는 동작이다.
--
-- 시르머 판만 크레딧이 둘(피아노·첼로)이고 나머지는 셋이다. 바이올린 주자
-- 이아손 케라미디스의 wikidata 항목이 라벨 하나에 직업 'musician' 뿐이라 넣지
-- 않았다. 사유는 202608050190 에 적었다.
--
-- **검출 시작을 아홉 건 다 독립 검증했다.** 광대역·하모닉 RMS·평탄도·250~1200Hz
-- 대역을 0.1초 간격으로 훑었다. 세 곡 모두 큐가 가리키는 첫 소리가 검출값 직후에
-- 있었다. 박수 오탐·attacca 덧붙음은 없다.
--
-- 176 은 검출 시작 앞에 여린 상승이 있어 **음계급을 좁게 추적했다**(16384점 FFT,
-- G·B♭·D 대 나머지 9계급 대조군). 세 건 모두 G·D 가 대조군에서 갈라지는 자리가
-- 검출값보다 0.20~0.23초 앞이었다(시르머 1.67 대 1.88, 오키스 0.65 대 0.86,
-- 프레슬러 1.83 대 2.07). **어긋남이 세 건에서 같은 크기라 음악적 간격이 보존되고**
-- 실측 중앙값(0.16초) 범위라 그대로 두었다. A12·A14 처럼 큐를 통째로 지나친 것과
-- 다르다.
--
-- **177 셸리의 발췌 길이 비율이 1.26배였다. 07-excerpt.md 의 두 방법으로 갈랐다.**
-- (1) 기준을 셋 다 바꿔 보니 어느 쪽에서 봐도 셸리가 같은 비율로 빠르다
--     (셸리/파럼 0.793·0.816, 셸리/카네메이슨 0.909·0.923). 압축이면 널뛴다.
-- (2) 발췌를 늘리니 악장 전체 비로 단조 수렴했다.
--       60s 0.771 → 120s 0.793 → 180s 0.809 → 300s 0.865 → 전체 0.858
--       (351.5 / 409.6)
-- **실제 템포 차이다.** 셸리가 도입을 빠르게 잡고 뒤에서 넓힌다. 임계를 넘은 쌍이
-- 없고 세 쌍이 0.0521~0.0535 로 모여 있어 기준은 그대로 두었다. A14 의 프랑크
-- 교향곡(1.43배)에서는 권장 폭을 넘겨 기준을 바꿨지만 여기는 95.1초로 폭 안이다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저이고 **차점이 최저의 4~5배로 벌어진다.**
-- 곡별 tuning 폭이 0.04~0.09 반음이고 ±0.5 경계에서 먼 값들이라 A=415 접힘 위험이
-- 없다. 시대악기 앙상블도 없다.
--
-- 보자르 삼중주단의 주자는 MusicBrainz 녹음 관계로 확인했다. 1972년 판이라 기유가
-- 아니라 코언이 바이올린이다(MB 길이 434,000ms 가 영상 434초와 일치).
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
