-- A tier A21 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   라벨 <다프니스와 클로에> 모음곡 2번 1곡 "동트기"(piece 234):
--     뒤투아·몬트리올 / 무티·필라델피아 / 아바도·LSO                0.0410~0.0501
--   라벨 <치건> 도입 무반주 카덴차, 바이올린+관현악판(piece 457):
--     정경화·뒤투아·RPO / 펄먼·메타·뉴욕필 / 아카르도·아바도·LSO     0.0629~0.0670
--   사티 그노시엔 1번 전곡, 피아노 원곡(piece 379):
--     치콜리니 / 로제 / 티보데                                       0.0472~0.0956
--
-- **234 는 발레 전곡판 트랙과 모음곡 2번 트랙이 섞였는데 문제가 없다.** 뒤투아·아바도는
-- 전곡판 Part 3 트랙이고 무티만 모음곡 2번 트랙이다. 그런데 **라벨의 모음곡 2번이
-- 발레 Part 3 그 자체**이고 그 1곡이 "Lever du jour" 이므로 셋 다 같은 악장의 낱
-- 트랙이다. 모음곡 1번(야상곡·간주곡·전사의 춤)은 하나도 섞이지 않았고 교차 정렬
-- 0.0410~0.0501 이 이것을 뒷받침한다.
--
-- **뒤투아 트랙은 머리에 다른 대목 24초가 붙어 있다**(전곡판 트랙 경계 때문).
-- 검출기가 24.22 를 잡아 잘라 냈고, 처음에는 "여린 도입을 24초 버렸다" 로 의심했으나
-- 아니었다. 근거 셋이다.
--
--   (1) 시작점 훑기가 24~26초에서 뚜렷한 최저(대 무티 0.0548, 대 아바도 0.0400)이고
--       0초 쪽은 0.1207 / 0.0865 로 크게 오른다. **두 쌍이 함께 움직인다**
--   (2) **뒤투아[0–20] ↔ 뒤투아[25–45] = 0.3056** — 머리 24초는 그 뒤와 다른 음악이다
--   (3) 무티·아바도의 머리를 각각 뒤투아 창에서 찾으면 25.08 / 27.77 로 떨어진다
--
-- (2)가 03-verification.md 의 **자기 자신과의 정렬**을 세 번째로 쓴 것이다. A18 에서는
-- 트랙의 진위를 가리는 데, A20 에서는 비용이 쓸 만한지 재는 데 썼고, 여기서는
-- **검출기가 잘라 낸 머리가 정말 다른 음악인지 확인하는 데** 썼다. 상대 연주가 필요 없다.
--
-- 오늘 검출이 도입을 놓친 건이 열이 넘었으므로 "앞을 잘랐으면 의심한다" 가 맞는
-- 출발점이었다. 다만 **의심의 결론이 늘 "되살려라" 는 아니다.**
--
-- **457 은 셋 다 바이올린+관현악판이다.** 아카르도 표기가 "Concert Rhapsody, M. 76a"
-- 인데 76a 가 관현악 반주판 번호다. 피아노 반주 원곡판(M. 76)은 섞이지 않았다.
--
-- 457 은 무반주 바이올린 카덴차로 시작해 비용 바닥이 구조적으로 높을 자리였는데
-- 0.0629~0.0670 으로 낮게 나왔다. A19 의 목신 · A20 의 볼레로 · A17 의 파가니니
-- 2번과 달리 카덴차가 화성을 짚는 겹음이 많아 chroma 가 붙잡을 것이 있는 것으로 보인다.
--
-- **379 는 마디선도 박자표도 없는 악보라 길이가 1.53배 벌어진다**(치콜리니 178s 대
-- 티보데 270s). 전곡이라 발췌 압축 판별이 해당하지 않는다. 근거를 길이가 아니라
-- 회전(셋 다 0반음 최저)과 교차 정렬에 두었다. 치콜리니↔로제 0.0956 이 이 배치에서
-- 가장 높은데 템포가 가장 크게 갈리는 쌍이고 임계 아래다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저다. 차점까지 234·457 은 0.20 이상,
-- 379 는 0.07 이상 벌어진다. tuning 폭은 234 0.12 · 457 0.07 · 379 0.07 반음으로 좁다.
-- 0 근처인 로제(+0.00)·티보데(+0.01)는 1980년대 데카 현대 피아노 녹음이라 A=415
-- 접힘이 해당하지 않는다.
--
-- 인물·단체 열다섯 곳이 모두 이미 등록돼 있어 인물 마이그레이션이 없다. A13 · A18 ·
-- A19 · A20 에 이어 다섯 번째다.
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
