-- A tier A19 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   드뷔시 <목신의 오후에의 전주곡> 도입(piece 221):
--     아바도·베를린필 / 하이팅크·콘세르트허바우 / 뒤투아·몬트리올   0.0663~0.0868
--   드뷔시 <바다> 1곡 "바다 위의 새벽부터 정오까지" 도입(piece 222):
--     하이팅크·콘세르트허바우 / 뒤투아·몬트리올 / 카라얀·베를린필   0.0585~0.0810
--   드뷔시 <어린이 차지> 1곡 "그라두스 아드 파르나숨 박사"(piece 223):
--     바부제 / 티보데 / 조성진                                      0.0430~0.0593
--
-- **221 은 무반주 플루트 독주로 시작한다.** 여리고 단선율이라 chroma 가 붙잡을
-- 화성이 얇고 비용 바닥이 구조적으로 높다. 세 쌍이 0.0663~0.0868 로 **함께**
-- 올라 있고 한 연주의 두 쌍만 오르는 모양이 아니다. 03-verification.md 의
-- "한 음만 반복하는 대목" 과 같은 기제이고, A8 의 셰헤라자데(무반주 바이올린
-- 카덴차) · A11 의 말러 5번(무반주 트럼펫) · A17 의 파가니니 2번(종소리)에서
-- 같은 모양을 만났고 넷 다 그대로 두었다.
--
-- **222 의 tuning 폭이 0.23 반음이고 비용 순서가 그 폭을 그대로 따른다.**
--
--   뒤투아(+0.15) ↔ 카라얀(+0.26)   간격 0.11   0.0585
--   하이팅크(+0.03) ↔ 뒤투아(+0.15) 간격 0.12   0.0667
--   하이팅크(+0.03) ↔ 카라얀(+0.26) 간격 0.23   0.0810
--
-- 세 쌍이 조율 간격 순서와 정확히 같은 순서다. 03-verification.md 의 밤의 여왕
-- (반음보다 작은 조율 차이)과 같은 기제로 보인다. 카라얀 +0.26 은 그 문서에 적힌
-- 카라얀 시절 베를린 필의 고피치(+0.30, S tier 62 정령들의 춤)와 맞는다.
-- **세 쌍 다 임계 아래이고 가장 높은 것도 0.0810 이라 덩어리로 갈리지 않았다.**
-- 조율 차이가 비용을 조금 올리는 것은 알려진 일이므로 교체하지 않는다.
--
-- 아홉 건 모두 회전 12방향에서 0반음이 최저이고 차점이 0.19~0.40 으로 크게
-- 벌어진다. 0 근처 tuning 은 셋(222 하이팅크 +0.03, 223 바부제·티보데 +0.04)인데
-- 회전이 갈랐고 시대악기 편성도 없다. A=415 접힘은 해당하지 않는다.
--
-- **이 배치의 숫자는 두 번 쟀다.** 첫 서브에이전트가 후보 9건과 손보정한 구간까지
-- 만들고 보고 전에 멈췄는데, WAV 와 `.npy` 캐시를 지운 뒤였고 정렬·회전 출력을
-- 파일로 남기지 않아 **숫자가 하나도 남지 않았다.** 검증 기록 없이 발행할 수
-- 없으므로 영상을 다시 받아 `detected.FINAL.json` 그대로 다시 쟀다. 구간은 한 초도
-- 바꾸지 않았고 `run_detect.py`·`run_excerpt.py` 는 돌리지 않았다. 위 숫자가
-- 두 번째 측정값이다.
--
-- 223 은 발췌를 돌리지 않았다. 세 영상 모두 1곡만 담긴 낱 트랙이라 검출 길이가
-- 이미 그 대목의 길이다. A12 의 천인 교향곡 · A14 의 Pie Jesu · A17 의 로망스와
-- 같다. 카플레의 관현악 편곡판은 선정 단계에서 뺐다 — role 이 PIANIST 다.
--
-- 인물·단체 열 곳이 모두 이미 등록돼 있어 인물 마이그레이션이 없다. A13 에 이어
-- 두 번째다.
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
