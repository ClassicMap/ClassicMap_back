-- A tier A7 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   무소르크스키 <전람회의 그림> 피아노 원곡, 첫 프롬나드(piece 189):
--     부니아티슈빌리 / 츠지이 노부유키 / 키신                          0.0434~0.0506
--   <전람회의 그림> 라벨 편곡 관현악판, 첫 프롬나드(piece 190):
--     아바도·LSO / 콜린 데이비스·콘세르트허바우 / 무티·필라델피아     0.0278~0.0309
--   <민둥산의 하룻밤> 림스키코르사코프 편곡 전곡(piece 191):
--     마젤·베를린필 / 프레트르·로열필하모닉 / 라이너·피츠버그         0.0515~0.0585
--
-- 189 와 190 은 같은 음악의 다른 편성이고 서로 다른 work 이다. 189 는 피아노
-- 원곡만, 190 은 라벨 편곡만 넣었다. 190 세 건 모두 배급 표기에 "Orch. Ravel" 이
-- 있고 다른 편곡자 표기는 없다. <전람회의 그림>은 편곡이 열아홉 가지 등록돼 있다.
--
-- **189·190 은 발췌하지 않았다.** 셋 다 "Promenade I" 낱 트랙을 찾았기 때문이다.
-- 07-excerpt.md 의 "낱 트랙을 찾았으면 돌리지 않는다" 에 해당한다. 그래도 양쪽을
-- 재서 비교했고 head 90초 발췌는 여섯 쌍이 전부 나빠졌다.
--
--   츠지이↔키신      0.0434 → 0.0693
--   아바도↔무티      0.0278 → 0.0397
--
-- 기준 연주에서만 90초를 끊고 짧은 트랙(키신 75.3초·무티 89.8초)은 전체가 남아
-- **프롬나드의 끝이 있는 연주와 없는 연주가 섞이기** 때문이다.
--
-- 그래서 섹터의 endCue "발췌 끝" 이 실제와 어긋났다. **구간을 큐에 맞추지 않고
-- 큐를 구간에 맞춘다.** nameKo 를 "첫 <프롬나드> 전곡", endCue 를 "프롬나드 1 의
-- 마지막 화음과 잔향" 으로 고치고 배치 정의의 excerpt 필드를 뺐다.
--
-- 191 은 클립 600초 상한에 아슬아슬하게 들어왔다(targetMaxMs 591,000). 이 곡은
-- 통상 10~12분이라 **이미 등록된 지휘자의 연주는 하나도 600초 안에 들지 않았다**
-- (솔티 621초, 오자와 651초, 번스타인 659초, 카라얀 688초, 오르만디 701초 등).
-- 그래서 1948·1959·1963년 녹음 셋이 됐고 지휘자 셋을 202608050176 에서 새로
-- 등록했다. 여유가 9초뿐이라 나중에 하나를 바꾸면 다시 상한에 걸린다.
--
-- 191 의 판본 근거 — 세 배급 표기에는 편곡자가 적혀 있지 않다. 다만 셋 다
-- "original version"·"1867" 표기가 없고, **1867 원곡 악보는 1968년에야 출판돼
-- 1948·1959·1963 녹음은 원리적으로 림스키판일 수밖에 없다.** 교차 정렬
-- 0.0515~0.0585 도 이를 받친다 — 원곡은 화성이 달라 이 값이 나오지 않는다.
--
-- 검출을 둘 고쳤다.
--   191 마젤  끝 530.37 → 587.40. **조용한 새벽 코다 57초를 통째로 버리고 있었다.**
--            530~587초 구간이 RMS −44~−59dB 인데 하모닉 RMS 가 광대역과 1~4dB 안에
--            붙어 있고 평탄도가 0.0003~0.004 로 내내 낮았다. 박수가 아니다
--   189 부니아티슈빌리 시작 4.44 → 3.50. 프롬나드를 아주 여리게 시작해(첫 음
--            −54dB, 다른 둘은 −33dB 대) 검출이 첫 음을 지나쳤다
--
-- 아홉 건 모두 회전 12방향에서 최저가 0반음이고 다음으로 낮은 회전이 0.18 이상이다.
-- tuning 은 +0.04~+0.11 로 폭이 0.03 반음 이내이며 시대악기 앙상블이 없다.
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
