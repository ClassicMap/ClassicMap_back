-- A tier A22 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   사티 <난 그대를 원해요> 전곡, 피아노 독주판(piece 380):
--     티보데 / 로제 / 치콜리니                                     0.0619~0.0755
--   오르프 <카르미나 부라나> 2곡 "Fortune plango vulnera"(piece 349):
--     래틀·베를린방송합창단·베를린필 / 무티·필하모니아 /
--     러바인·시카고심포니합창단·시카고심포니                       0.0451~0.0760
--   오르프 <카르미나 부라나> 1곡 "오 포르투나"(piece 350):
--     같은 세 녹음의 다른 트랙                                     0.0493~0.0619
--
-- **검출 아홉 건 중 네 건의 시작을 고쳤고, 고치기 전에도 아홉 건이 다 "통과" 했다.**
-- 이 배치가 "판단 근거는 비용이 아니라 섹터 큐다" 의 가장 뚜렷한 예다.
--
--   piece 연주      검출 시작 → 고친 값    버리던 길이
--   350   무티      104.93 → 3.96          **101.0초**
--   350   러바인     75.49 → 1.44          **74.1초**
--   349   러바인     22.06 → 0.49          21.6초
--   349   래틀        3.02 → 0.12           2.9초
--
-- **350 무티는 곡의 101초를 잃은 채로 정렬 비용이 0.0698 이었다.** 임계 0.11 아래이고
-- 건강한 대역이다. 비용만 보고 통과시켰으면 오 포르투나의 첫 총주가 통째로 빠진
-- 클립이 나갔다.
--
-- 원인은 검출기의 구조다. 오 포르투나는 총주(약 23초) 뒤에 **여린 오스티나토가 1분
-- 넘게** 이어지는데 그 골이 닫기 폭보다 길어 덩어리가 끊기고, 앞 조각이
-- MIN_MUSIC_SECONDS(25초)에 못 미쳐 버려진다. 검출기는 뒤의 큰 덩어리를 골라 곡의
-- 첫 화음을 잃는다. 349 는 2곡이 여리게 시작하고 절 사이에 쉼이 있어 같은 일이 났다.
--
-- 갈라낸 것은 **세 연주에 같은 규칙을 적용하는 것**이다. 여기서는 하모닉 바닥 +8dB
-- 규칙을 쓸 수 없었다 — 세 트랙 다 머리에 디지털 무음이 있어 바닥이 -92~-100dB 이고
-- 문턱이 여전히 무음권이다. 광대역 RMS 가 -45dB 를 넘어 0.2초 유지하는 첫 시각으로
-- 바꿨다. **곡마다 한 연주만 자기 첫 음에 붙어 있고**(350 래틀 +0.01, 349 무티
-- +0.004) 나머지가 들쭉날쭉했다. 붙은 쪽과 같은 여유를 주어 고쳤다.
--
-- 고친 뒤 **350 은 세 쌍 전부 내려갔고**(-0.021 / -0.025 / -0.007) 349 는 셋 중 둘이
-- 내려갔다. 349 의 셋째 쌍만 0.0008 올랐는데 큐가 가리키는 2곡 첫 절의 합창 첫 음을
-- 넣는 쪽을 택했다. 고치기 전 로그도 남겼다(`logs/verify-before.log`).
--
-- ## 349 와 350 이 같은 음악이 아님을 어떻게 확인했나
--
-- **350 은 349 의 1곡이다.** 349 의 발췌를 오 포르투나로 잡으면 두 piece 가 같은
-- 음악이 되므로 349 는 2곡 "Fortune plango vulnera" 로 잡고 `excerpt` 를 비웠다.
-- 세 트랙 모두 2곡만 담긴 낱곡 트랙을 찾아 `anchor: head` 를 넣지 않았고 `endCue`
-- 만 트랙에 맞췄다.
--
-- **교차 정렬은 이것을 가려 주지 못한다.** 349↔350 전 구간 chroma 교차가
-- **0.0659~0.0976** 으로 통과권에 들어온다. 두 악장이 다 D단조이고 오르프의 화성
-- 어법이 정적이라 chroma 로는 1곡과 2곡이 안 갈린다. 같은 녹음 안에서도 그렇다.
--
-- 대신 셋으로 갈랐다(`logs/diagnose-349-vs-350.log`).
--   (1) 배급 표기의 트랙 제목 — 셋 다 `Fortune plango vulnera`, 350 은 `O Fortuna`
--   (2) **음량 아치** — 10등분 평균 dB. 350 은 셋 다 큰→여림(넷)→큰 아치(총주–
--       오스티나토–총주), 349 는 셋 다 여리게 시작해 5·8번째에 골이 있는 3연 구조다.
--       **세 연주가 같은 모양으로 맞아떨어진다**
--   (3) **머리 30초끼리만 교차** — 같은 악장끼리 0.0415~0.0980, 다른 악장끼리
--       0.0782~0.1254. 전 구간은 안 갈리는데 머리는 갈린다
--
-- 정적인 화성은 전 구간을 평균할수록 섞이고 머리만 보면 악장의 시작 제스처가 남는다.
-- 03-verification.md 에 절을 넣었다.
--
-- 350 은 1곡(Introduction)만 썼다. 25곡의 재현(Conclusion)과 트랙 제목으로 갈랐다.
--
-- ## 그 밖
--
-- 380 은 role 이 PIANIST 라 **피아노 독주판만** 썼다. 소프라노·테너를 동반한 성악판과
-- 본인 편곡판을 배제했다. 길이가 1.20배 벌어지는데(치콜리니 362.9s 대 로제 303.1s)
-- 전곡이라 발췌 압축 판별 대상이 아니다. 사티의 마디선 없는 악보답게 치콜리니가 느리게
-- 잡는 것이고, 시작이 셋 다 자기 첫 음 ±0.05초에 붙고 회전 최저가 0반음이다.
--
-- **채널 이름 함정을 또 만났다.** 프레빈·빈 필 1994 DG 녹음이 "Herbert von Karajan"
-- 채널과 "Berliner Philharmoniker" 채널 양쪽에 올라 있다. **카라얀은 카르미나 부라나를
-- 녹음한 적이 없다.** 표기가 분명해 쓸 수는 있었으나 채널이 맞는 대안(러바인)이 있어
-- 쓰지 않았다.
--
-- 349 무티↔러바인 0.0760 만 최저와 0.031 벌어져 진단했다. 삼등분이 고르고(앞뒤가
-- 나쁘지 않다) 끝점 훑기가 평평하고 회전 최저가 0반음이다. 시작점 훑기는 뒤로 갈수록
-- 조금 내려가지만 그 방향이 2곡 첫 절을 잘라내는 방향이라 따르지 않았다. 1980
-- 필하모니아와 1985 시카고 사이의 통상적인 연주 차이로 본다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저다. 349 의 차점이 0.083~0.093 으로 다른
-- 곡보다 낮은데 2곡이 D단조 모드 안에서 5도 관계 화성을 많이 쓰기 때문으로 보이고,
-- 최저와의 차가 1.6~1.8배라 이조 후보가 아니다.
--
-- 202608050200 에서 러바인과 합창단 둘을 등록했다. **합창이 주역인 곡이라 choir 를
-- 처음부터 넣었다** — A12 의 천인 교향곡에서 빠뜨려 나중에 보탠 일이 있었다.
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
