-- A tier A5 비교 영상 6건을 발행 직전 상태로 올린다.
--
--   로시니 <도둑 까치> 서곡 전곡(piece 169): 카라얀·베를린필 / 아바도·유럽 체임버 /
--     번스타인·뉴욕필                                                   0.0437~0.0661
--   베를리오즈 환상 교향곡 4악장 "단두대로의 행진" 도입(piece 170):
--     카라얀·베를린필 / 콜린 데이비스·빈필 / 오자와·보스턴심포니        0.0501~0.0639
--
-- 연주자와 악단 열 곳이 모두 이미 등록돼 있어 연주자 마이그레이션이 없다.
--
-- 윌리엄 텔 서곡(piece 168)은 이 배치에서 뺐다. 오직 클립 600초 상한 때문이다.
-- 전곡 후보 스무 건 남짓을 훑었는데 가장 짧은 연주가 658초(아바도·유럽 체임버)이고
-- 나머지는 664~890초다. 200초대로 보이는 것은 전부 피날레만 잘라 낸 트랙이다.
-- 연주자 중복도 DB 미등록도 판본 차이도 아니다. 섹터를 전곡 대신 피날레 발췌로
-- 다시 정하면 살릴 수 있다. A-TIER-QUEUE.md 의 "다시 볼 곡" 에 적었다.
--
-- 검출을 네 군데 고쳤다. 넷 다 02-detection.md 의 "조성이 없는 타악 도입" 이다.
-- 도둑 까치는 작은북 연타로, 환상 교향곡 4악장은 팀파니 여린 연타로 시작하는데
-- 검출기가 조성 성분이 붙는 관현악 진입부터 잡았다.
--
--   169 카라얀   16.14 → 5.44   (10.7초를 버릴 뻔했다)
--   169 아바도   20.48 → 2.17   (18.3초)
--   170 카라얀    5.13 → 1.82   ( 3.3초)
--   170 데이비스 21.78 → 2.12   (19.7초. 이대로면 120초 발췌가 다른 자리로 옮겨진다)
--
-- 고친 값에서 재면 169 의 첫 타에서 관현악 진입까지가 카라얀 10.9초·아바도 11.6초·
-- 번스타인 9.8초로 서로 맞는다. 판단 근거는 비용이 아니라 섹터 큐다.
--
-- 채널 이름으로 악단을 짐작하면 틀리는 예가 또 나왔다. 170 의 iia2J-6CHmY 는
-- 채널이 "Berliner Philharmoniker - Topic" 인데 배급 표기는 빈 필·콜린 데이비스다.
-- 크레딧은 빈 필로 넣었다. A4 의 카라얀 채널 건과 같은 함정이다.
--
-- 여섯 건 모두 최종 구간에서 회전 12방향을 떠 최저가 0반음인 것을 확인했다
-- (둘째로 낮은 회전과 0.07~0.12 벌어진다). tuning 폭은 곡마다 0.22 반음이고
-- 셋 다 현대 관현악이라 A=415 접힘 자리에 걸리는 것이 없다.
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
