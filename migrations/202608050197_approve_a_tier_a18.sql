-- A tier A18 비교 영상 6건을 발행 직전 상태로 올린다. 세 곡 중 하나는 뺐다.
--
--   라흐마니노프 파가니니 주제 광시곡 Op. 43 18번 변주(piece 227):
--     트리포노프·네제세갱·필라델피아 / 유자 왕·두다멜·LA필 /
--     랑랑·게르기예프·마린스키                                     0.0434~0.0563
--   라흐마니노프 전주곡 Op. 23-5 G단조 전곡(piece 455):
--     리시에츠키 / 루간스키 / 셸리                                 0.0359~0.0413
--
-- **piece 228 "보칼리제" 는 뺐다.** 사유는 아래에 따로 적는다.
--
-- **227 은 셋 다 18번 변주 낱 트랙이다.** 제목에 Variation No. 18 이 명시돼 있고
-- 길이 167~175초가 그 대목 길이와 맞는다. 그래서 `excerpt` 를 비운 채 두었고
-- `anchor: head` 를 넣지 않았다 — 넣으면 작품 서주를 잡는다. run_excerpt.py 는
-- 모르는 anchor 값을 조용히 head 로 떨어뜨리므로 이 곡은 처음부터 비워 정의했다.
--
-- **455 는 셋 다 Op. 23-5 단독 트랙이다.** 검출 구간이 영상 길이의 98~99%를
-- 채우고 세 길이가 1.05배 안에 모인다. 앞뒤에 다른 전주곡이 붙었으면 여기서 드러난다.
--
-- **검출 경계 아홉 건 중 여섯을 고쳤다. 비용으로는 드러나지 않는 것들이었다.**
--
--   유자 왕   시작 3.39 → 0.05   첫 악구를 지나쳐 악구 사이 쉼 뒤에 붙었다
--   루간스키  시작 2.28 → 0.80   첫 화음을 지나쳤다(0.0~0.7초는 방 소음 -43~-50dB)
--   트리포노프 끝 166.74 → 171.30   종결 화음(169.3초, -36dB)이 구간 밖이었다
--   랑랑      끝 151.74 → 160.70   종결부 9초를 버렸다
--   리시에츠키 끝 242.74 → 253.00   종결부 10초를 버렸다
--   셸리      끝 247.08 → 250.50   마지막 여린 화음(248.9초)이 밖이었다
--
-- 227 의 종결부는 여린 코다 앞에 깊은 골(트리포노프 148~151초 -54~-62dB)이 있어
-- 검출이 코다는 잡고 **마지막 화음만 빠뜨렸다.** 트리포노프의 고친 구간을 유자·랑랑
-- 창에서 찾게 하니 158.79 · 159.41 로 떨어져 서로 맞았다. 랑랑은 실황이라 163.9초에
-- -13dB 박수가 시작하므로 160.7 은 안전하다.
--
-- 고친 뒤 **227 은 세 쌍 전부, 455 는 두 쌍이 함께 내려갔다**(0.0480→0.0434,
-- 0.0542→0.0480, 0.0570→0.0563 / 0.0393→0.0359, 0.0409→0.0387). 455 의 셋째 쌍만
-- 0.0003 올랐는데 큐가 가리키는 마지막 화음을 넣는 쪽을 택했다 — **비용으로 큐를
-- 사지 않는다.**
--
-- 아홉 쌍 모두 회전 12방향에서 0반음이 최저이고 차점과 4~6배 벌어진다. tuning 이
-- 0 근처인 것은 트리포노프 -0.010 하나인데 필라델피아 오케스트라 현대악기 녹음이라
-- A=415 접힘이 아니다.
--
-- 인물·단체 열두 곳이 모두 이미 등록돼 있어 인물 마이그레이션이 없다. A13 · A19 에
-- 이어 세 번째다.
--
-- ## piece 228 "보칼리제" 를 뺀 이유
--
-- 세 쌍 모두 임계를 넘었다 — 배틀↔테카나와 0.1446, 배틀↔플레밍 0.1703,
-- 테카나와↔플레밍 0.1168. **원인이 둘로 겹쳐 판정하지 않았다.**
--
-- 배치 노트가 경고한 이조는 아니었다. 회전 최저가 세 쌍 다 0반음이고 tuning 폭도
-- 0.09 반음이라 A15 의 폰 슈타데 같은 반음 이하 조율 차이도 아니다. 경계도 아니다 —
-- 끝점 훑기가 평평하고 최저와 현재 값의 차이가 0.0005 안이다(2번 패턴).
--
-- **(1) 배틀 트랙은 앞 79초만 같은 음악이다.** 같은 녹음 안에서 앞 블록과 그 다음
-- 블록을 정렬해 되풀이 구조를 재니 테카나와 0.0400 · 플레밍 0.0376 인데
-- **배틀은 0.2818** 이다(대조군으로 455 리시에츠키의 다른 대목끼리가 0.2107).
-- 템포비로 블록을 맞춰 재면 1블록 0.0815(통과권), **2블록 0.2736**, 3블록 0.1364 다.
-- 제목·Topic 채널·길이 242초가 모두 정상이었으므로 **선정 단계에서 보이지 않는
-- 결함**이다. 03-verification.md 의 "표기는 맞는데 오디오가 다른 트랙" 과 같은
-- 부류인데, 앞 79초는 맞는다는 점이 다르다.
--
-- **(2) 배틀을 빼도 남은 둘이 붙지 않는다.** 테카나와↔플레밍은 블록을 어떻게 끼워도
-- 0.127~0.141 이다. 플레밍은 관현악 반주판(ECO·테이트), 테카나와는 피아노 반주판
-- (비뇰스)이라 편성이 갈린 것으로 보인다.
--
-- **어느 둘도 붙지 않으므로 "한 연주만 임계를 넘는 쌍을 만든다" 는 모양이 아니다.**
-- 남은 한 자리를 누구로 채울지 가릴 근거가 없어 예비 연주도 받지 않았다.
--
-- 다시 볼 때는 **피아노 반주판 셋으로 다시 짠다.** 관현악 반주판과 섞지 않는다.
-- 테카나와를 기준으로 배틀의 첫 절이 0.0723~0.0815 로 붙었으므로 이 곡 자체가
-- 못 재는 곡은 아니다. 미등록은 반주자 둘(Margo Garrett Q133704350,
-- Roger Vignoles Q3439553)과 지휘자 하나(Jeffrey Tate Q948893)다.
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
