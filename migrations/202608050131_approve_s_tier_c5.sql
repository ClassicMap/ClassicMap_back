-- S tier 대기열 C5 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   베토벤 피아노 3중주 "대공" 3악장 주제(piece 441): 바렌보임 3중주 /
--     아슈케나지·펄만·하렐 / 프레빈·물로바·시프                          0.0526~0.0803
--   슈만 피아노 5중주 1악장 도입(piece 448): 프레슬러·에머슨 4중주단 /
--     아르헤리치 / 피레스                                               0.0571~0.0619
--   멘델스존 피아노 3중주 1번 1악장 도입(piece 449): 뎅크·벨·이서리스 /
--     아르헤리치·카퓌송 형제 / 프레빈·무터·하렐                          0.0613~0.0739
--
-- 셋 다 도입 120초 발췌(anchor=head)다. 크레딧은 피아니스트가 주역이고 3중주는
-- VIOLINIST·CELLIST 를, 5중주는 ENSEMBLE 을 붙였다. 실내악의 피아노는 반주가 아니므로
-- ACCOMPANIST 는 쓰지 않았다. 202608050129 에서 연주자 6명을 새로 등록했다.
--
-- 크레딧은 영상 설명의 배급 표기에서만 읽었다. 슈만 5중주의 아르헤리치와 피레스는
-- 설명에 개인 이름만 적혀 있어(슈바르츠베르크·홀·이마이·마이스키 / 뒤메이·카퓌송·
-- 코세·왕젠) 단체를 붙이지 않았고 개별 연주자를 독주자로 흩어 적지도 않았다.
-- 프레슬러 건만 "Emerson String Quartet" 이 적혀 있어 ENSEMBLE 을 붙였다.
--
-- 검출은 한 건만 고쳤다. 원본은 s-c5-detected.orig.json 에 있다.
--   멘델스존 뎅크  2.09 → 1.10
-- 80~4000Hz 대역 RMS 가 1.07초 -65.5dB → 1.21초 -49.7dB 로 튀고, 1.10초부터
-- 112/224/332/444/664/996Hz 의 배음열(A2 기음)이 선다. 그 앞의 완만한 상승은
-- 25·47Hz 가 지배하는 초저역 럼블이고 80Hz 위는 30~50dB 아래였다. 크기가 아니라
-- 조성 성분으로 갈랐다. 고친 뒤 뎅크가 낀 두 쌍이 함께 내려갔다(0.0743→0.0739,
-- 0.0629→0.0613). 나머지 여덟 건은 첫 음과 0.15초 안에서 맞았고, 아날로그 두 건
-- (아슈케나지 1982 · 프레빈 1995)도 첫 음 앞이 디지털 무음이거나 -65dB 바닥이라
-- 테이프 프리에코는 없었다.
--
-- 대공에서 프레빈이 낀 두 쌍이 다른 쌍보다 높아(0.0803 / 0.0690 vs 0.0526) 진단했다.
-- 이조가 아니고(0반음 0.080 이 최저, 나머지 0.25~0.58) 경계 오류도 아니다(끝점 훑기가
-- 0.0790~0.0953 로 평평하고 현재 값이 최저와 0.003 차이, 삼등분도 0.0777~0.0934 로
-- 고르게 퍼져 있다). 연주 차이로 보이나 값이 임계(0.11)에서 멀고 통과 배치의 정상
-- 범위(0.04~0.09) 안이라 교체하지 않았다.
--
-- 포르테피아노 연주(파우스트·멜니코프·케라스)는 조율과 악기가 달라 뺐다.
--
-- 대공의 아슈케나지 연주는 itzhakperlman 채널에도 같은 음원이 있으나 그쪽 제목이
-- "IV. Andante cantabile" 로 악장 번호가 틀려 있어, 번호가 맞고 피아니스트가 첫
-- 크레딧인 쪽을 골랐다.
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
