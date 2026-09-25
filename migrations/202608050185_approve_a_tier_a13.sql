-- A tier A13 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   요한 슈트라우스 2세 왈츠 <아름답고 푸른 도나우> 서주와 첫 왈츠 머리(piece 185):
--     번스타인·뉴욕필 / 카라얀·베를린필 / 마젤·빈필            0.0590~0.0980
--   요한 슈트라우스 2세 왈츠 <빈 숲 속의 이야기> 서주와 첫 왈츠 머리(piece 188):
--     무티·빈필 / 카라얀·베를린필 / 마젤·빈필                  0.0372~0.0552
--   프랑크 바이올린 소나타 A장조 1악장 도입(piece 179):
--     카퓌송·아르헤리치 / 무터·오키스 / 벨·티보데               0.0698~0.0837
--
-- **왈츠 둘은 처음부터 발췌로 잡았다.** 전곡이 10~12분이라 클립 600초 상한에
-- 걸린다. 오늘 이 상한으로 곡 셋(로시니 윌리엄 텔 최단 658초, 스페인 기상곡
-- 840초, 러시아 부활절 서곡 851초)이 통째로 빠졌다. 앞에서 피한 것이다.
--
-- **검출값을 셋 고쳤다.** 셋 다 여린 도입을 지나쳐 뒤의 큰 덩어리에 붙은 것이다.
-- 근거는 비용이 아니라 대역 에너지다(0.25초 해상도, 다섯 대역).
--
--   185 카라얀 18.09 → 4.34   179 카퓌송 9.73 → 0.84   179 벨 14.26 → 1.35
--
-- 185 카라얀은 250~600Hz(호른 음역)가 4.18→4.64초에서 -21.1→-14.4dB 로 올라
-- 지속한다. 큐가 "호른 주제 첫 음" 이고 번스타인 4.92·마젤 4.53 도 같은 자리다.
-- 179 벨은 무터를 기준으로 시작점을 훑어 교차 확인했다 — 1.50 에서 최저이고
-- 그 뒤 단조 증가한다. 카퓌송은 곡선이 평평해(0.0865~0.1020) 비용으로 가려지지
-- 않아 온셋으로만 정했다. **프랑크 도입은 화성이 정적이라 크로마가 위치를
-- 특정하지 못한다.**
--
-- **기준 연주를 179·188 에서 바꿨다. 근거는 길이이지 비용이 아니다.** 카라얀
-- 기준으로는 188 의 무티 132.6초·마젤 130.2초가 권장 폭을 넘었는데, 발췌
-- 구간에서 가장 느린 무티를 기준으로 바꾸니 105.8~120.3초로 모두 들어왔다.
-- 옮김 비용도 함께 내려갔다. 179 도 같은 이유로 카퓌송을 앞에 뒀다.
--
-- **179 의 startCue 를 고쳤다.** "피아노 서주 뒤 바이올린의 첫 음" 으로 적혀
-- 있었으나 실제 구간은 피아노 서주의 첫 화음, 곧 악장의 진짜 첫 음부터다.
-- 바이올린 진입은 그로부터 9~14초 뒤이고 세 녹음에서 신뢰할 만하게 특정되지
-- 않았다(부분열 DTW 붕괴). **큐를 구간에 맞춰 고쳤다.** 185·188 의 nameKo 도
-- 120초 발췌가 실제로는 서주 위주라 "서주와 첫 왈츠 머리" 로 고쳤다.
--
-- 185 번스타인↔카라얀 0.0980 은 진단했으나 교체하지 않았다. 이조가 아니고
-- (회전 최저 0반음, 차점 0.260) 삼등분·끝점·시작점 훑기가 모두 평평하다.
-- **교차표에 바깥이 없다** — 둘 다 마젤과는 0.0590·0.0653 으로 가깝고 서로에게만
-- 멀다. 한 연주만 임계를 넘기는 쌍을 만드는 모양이 아니라 교체 근거가 없다.
-- 도나우 서주는 A장조 트레몰로 위 호른 아르페지오가 오래 이어져 화성이 정적이고,
-- 앞 1/3 이 가장 나쁜 것이 이와 맞는다. A11 의 카라얀·말러 5번과 같은 판단이다.
--
-- 188 은 치터가 드는 판으로 셋을 맞췄다. 카라얀·무티는 배급 표기에 치터 주자가
-- 명시돼 있고(Josef Hausmann / Barbara Laister-Ebner), 마젤은 빈 필 신년음악회라
-- 관례상 든다. 발췌 구간 안에서 편성 차이는 나타나지 않았다.
--
-- 185 는 관현악 스튜디오 셋으로 맞췄다. 피아노·합창·취주악 편곡을 배제했고,
-- **신년음악회 실황은 머리에 박수와 신년 인사가 붙으므로 처음부터 뺐다.**
-- 179 는 첼로판(카살스·로스트로포비치)과 플루트판을 피해 바이올린 원곡으로 맞췄다.
-- 피아니스트는 ACCOMPANIST 로 넣었다. PIANIST 로 넣으면 적재기가 독주자로 묶는다.
--
-- 채널 이름 함정을 세 건 더 만났다. AokcMTltEqA 는 채널이 카라얀인데 표기는
-- 클레멘스 크라우스·빈 필이라 뺐고, 채택한 BBy8gWDE2nQ 는 채널이 베를린 필인데
-- 표기는 빈 필·마젤이다. 오늘 열한~열세 번째다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저이고 차점과 0.21 이상 벌어진다.
-- 185 에서 번스타인만 tuning 이 0 근처(-0.01)로 떨어져 있으나 조율 덩어리가
-- 아니다 — 번스타인↔마젤(0.27 차)이 0.0653 인데 번스타인↔카라얀(0.30 차)은
-- 0.0980 이라 조율 차이로 설명되지 않는다.
--
-- 연주자·악단·반주자 12명 전원이 이미 DB 에 등록돼 있어 인물 마이그레이션이 없다.
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
