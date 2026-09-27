-- A tier A17 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   클라라 슈만 3개의 로망스 Op. 22 중 1번 D♭장조 전곡(piece 178):
--     강클라라주미·손열음 / 얀선·파파노 / 바티아슈빌리·오트        0.0584~0.0647
--   파가니니 바이올린 협주곡 2번 3악장 "라 캄파넬라" 도입(piece 165):
--     아카르도·뒤투아·런던필하모닉 / 아슈케나시·에서·빈 교향악단 /
--     바라티·오우에·NDR                                           0.0653~0.0876
--   파가니니 바이올린 협주곡 1번 D장조 1악장 도입(piece 166):
--     펄먼·포스터·RPO / 미도리·슬래트킨·LSO / 벨·ASMF              0.0610~0.0964
--
-- **166 의 scordatura 의심을 회전으로 해소했다.** 파가니니가 독주 파트를 E♭장조로
-- 적고 관현악을 반음 내려 조율하게 했는데 현대 녹음은 대개 D장조로 옮겨 친다.
-- 표기만 믿지 않고 셋 다 회전 12방향을 떴다 — 0반음이 최저이고 1반음이 0.30~0.32
-- 다. 표기와 실제 음이 일치한다. tuning 폭도 0.09 반음뿐이다.
--
-- **166 에서 힐러리 한을 조슈아 벨로 바꿨다.** 처음 편성에서 펄먼↔한 0.1125 로
-- 임계를 넘고 미도리↔한 0.0821 이었다(펄먼↔미도리 0.0610). 한이 낀 두 쌍만 올랐다.
--   회전: 0반음 0.1125 최저, 차점 2반음 0.2114 — 이조 아님
--   끝점 훑기 120.7~143.2: 0.1125~0.1257 로 평평, 최저가 현재값 — 경계 아님
--   시작점 훑기 0.0~18.8: 0.1119~0.1251 로 평평
--   삼등분(대 펄먼/미도리): 앞 0.1173/0.0855, 중간 0.1418/0.1082, 뒤 0.0876/0.0529
-- **중간이 가장 나쁘다.** 경계 문제면 앞뒤가 나쁘다. 03-verification.md 의 2번
-- 패턴이고, 한이 낀 두 쌍만 오르는 모양이라 그 연주가 바깥이다. 벨로 바꾸니
-- 0.0610 / 0.0690 / 0.0964 가 됐다.
--
-- **벨의 옮김 비용 0.0742 가 0.06 을 넘는다.** 그래도 두었다 — 최종 교차 정렬이
-- 0.0690·0.0964 로 임계 아래이고, 시작이 anchor:head 라 검출값으로 고정돼 있어
-- 옮기는 것은 끝뿐이다. A14 의 오자와(0.0631)와 같은 자리다.
--
-- **벨은 바이올린에서 직접 지휘한다**(ASMF 음악감독). conductor 크레딧을 비우고
-- ORCHESTRA 만 붙였다. A16 의 셸리와 같다.
--
-- **178 은 발췌를 돌리지 않았다.** 세 영상 모두 1번만 담긴 낱 트랙(161~178초)이라
-- 검출 길이가 이미 그 대목의 길이다. A12 의 천인 교향곡·A14 의 Pie Jesu 와 같다.
--
-- **178 의 끝을 셋 다 늘렸다.** 검출이 마지막 화음의 어택 직후 0.5초 안에서 끊어
-- 잔향을 버렸다. 큐가 "종결 화음과 잔향" 이므로 잔향이 잡음 바닥에 붙는 지점까지
-- 늘렸다.
--
--   강클라라주미 172.43 → 175.60   얀선 173.75 → 179.10   바티아슈빌리 155.04 → 162.30
--
-- 비용 변화는 0.0592→0.0615 · 0.0585→0.0584 · 0.0638→0.0647 로 거의 없다.
-- **비용으로 큐를 사지 않는다** — 07-excerpt.md 의 시인의 사랑 선례대로 큐를 따랐다.
--
-- 시작 큐는 아홉 건 모두 오디오로 직접 확인했다(0.05초 간격 광대역·하모닉 RMS +
-- 40~250Hz·250~1200Hz 대역). 166 은 첫 화음 뒤에 1.4초 쉼이 있는 구조인데 검출이
-- 그 조각을 버리지 않았고, 첫 화음에서 감쇠 끝까지가 4.2·4.3·4.4초로 서로 맞는다.
--
-- 165 는 회전 차점이 0.157~0.186 으로 다른 곡보다 낮다. **종소리(campanella)
-- 구간의 조성 성분이 얇아 회전을 돌려도 비용이 덜 오르는 것**이고 0반음 최저는
-- 뚜렷하다. 165 에서 tuning 폭이 가장 큰 쌍(아카르도 +0.09 ↔ 아슈케나시 +0.27)이
-- 오히려 가장 낮은 비용(0.0653)이라 조율 덩어리 문제가 아니다.
--
-- 165 는 3악장만 담긴 낱악장 트랙을 찾아 anchor:head 가 곧 그 악장의 머리가 되게
-- 했다. startCue 를 "관현악 서주(종소리)의 첫 음(악장 시작)" 으로 고쳤다 — 트랙이
-- 서주부터 시작하기 때문이다. 리스트의 <라 캄파넬라> 피아노 독주와 크라이슬러
-- 편곡판은 선정 단계에서 전부 걸렀다.
--
-- 166 은 기준을 셋 다 바꿔 떠도 길이 비율이 1.05배 안쪽으로 안정적이었다. 기준을
-- 바꿀 길이 근거가 없어 원래 순서를 유지했다.
--
-- 202608050193 에서 인물·단체 11곳을 등록했다. 런던 필하모닉은 wikidata 의
-- VIAF 합쳐짐을 걷어 내고 넣었다(사유는 그 마이그레이션에).
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
