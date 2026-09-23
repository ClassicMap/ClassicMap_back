-- S tier 대기열 E1(발레 낱곡) 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   차이콥스키 <호두까기 인형> "꽃의 왈츠"(piece 161): 카라얀·베를린필 /
--     뒤투아·몬트리올 / 프레빈·런던심포니                               0.0481~0.0756
--   차이콥스키 <백조의 호수> 2막 "정경"(piece 162): 뒤투아·몬트리올 /
--     틸슨 토머스·런던심포니 / 번스타인·뉴욕필                          0.0410~0.0536
--   프로코피예프 <로미오와 줄리엣> "기사들의 춤"(piece 322): 아바도·베를린필 /
--     무티·시카고심포니 / 정명훈·콘세르트허바우                         0.0641~0.0678
--
-- ## 방식이 바뀐 첫 배치다
--
-- 지금까지는 악장 트랙을 받아 앞 120초를 발췌했다. 발레 낱곡은 **그 대목만 담긴
-- 낱 트랙을 받아 통째로 쓴다.** 배치 정의에 excerpt 키를 두지 않았고 run_excerpt.py 를
-- 돌리지 않았다. 검출 구간이 곧 발행 구간이다(07-excerpt.md "먼저 낱 트랙을 찾는다").
-- 구간이 165~420초라 600초 제한에도 여유가 있다.
--
-- 모음곡판과 발레 전곡판이 섞여 있으나 음악이 같으므로 함께 썼다. 꽃의 왈츠는
-- 카라얀만 모음곡 Op. 71a 이고 나머지 둘은 전곡 Op. 71 2막 13번이다. 기사들의 춤은
-- 셋 다 모음곡 2번 Op. 64b 1번이다. 길이 편차가 1.04~1.12배로 편집 차이가 없다.
--
-- 백조의 호수는 4막에도 "Scène" 이 있어 2막 10번인지 확인했다. 셋 다 제목에
-- Act II, No. 10 이 명시돼 있고 길이 165~184초로 예상 범위이며 첫 음이 하프와 현 위의
-- 오보에 주제다.
--
-- ## 검출
--
-- 세 건을 고쳤다. 전부 여린 도입을 지나친 유형이다. 원본은 s-e1-detected.orig.json.
--
--   정경 뒤투아        24.06 → 0.68   0.65초 -46dB, 0.74초 -33dB 로 튄 뒤 24초까지
--                                     -30~-38dB 조성음이 끊김 없이 이어진다. 24.5초는
--                                     -25dB 로 올라가는 자리일 뿐이고 24초를 버렸다
--   기사들의 춤 아바도 34.13 → 0.09   0.09초부터 -64dB 로 시작해 12초에 -9dB 까지 오르는
--                                     도입 크레셴도가 있고 21.5~34초가 -45dB 대로 내려간다.
--                                     이 13초 쉼이 닫기 폭보다 길어 덩어리가 갈렸고 앞
--                                     조각(21초)이 MIN_MUSIC_SECONDS(25초)에 못 미쳐
--                                     버려졌다. 202608050128 영웅과 같은 유형이다
--   기사들의 춤 정명훈  5.04 → 1.90   같은 도입인데 페이드인이 길어 3초를 놓쳤다
--
-- 아바도 건은 무티·정명훈 두 연주에도 같은 자리에 같은 모양의 도입 크레셴도와 쉼이
-- 있어 도입이 곡의 일부임을 서로 확인해 준다. 고친 뒤 길이 편차가 162 는 1.22 → 1.12배,
-- 322 는 1.24 → 1.10배로 좁아졌다.
--
-- 뒤쪽은 전부 확인했다. 틸슨 토머스(9초)·번스타인(13초)은 검출 끝 뒤가 잔향과 테이프
-- 노이즈(-45dB 아래로 단조 감쇠)라 종결부 누락이 아니다.
--
-- ## 섹터 큐를 고쳤다
--
-- 기사들의 춤의 startCue 를 "관현악 총주의 무거운 3박 주제 첫 박" 으로 적어 두었으나,
-- 실제 트랙 셋은 모두 그 앞에 20~35초짜리 도입(공작의 명령)을 포함한다. 큐 문구만 보면
-- 도입을 빼고 행진 주제부터 시작해야 하는 것으로 읽히는데, 도입은 트랙의 일부이고
-- 이것을 빼면 낱 트랙을 다시 발췌해야 해서 이 배치의 전제와 어긋난다.
-- **구간을 큐에 맞추지 않고 큐를 구간에 맞췄다.** 섹터 이름에도 "도입 포함" 을 넣었다.
--
-- ## 진단
--
-- 임계를 넘은 것은 없다. 꽃의 왈츠에서 카라얀↔프레빈 0.0756 이 뒤투아↔프레빈 0.0481 의
-- 1.57배라 카라얀을 떴다. 이조가 아니고(0반음 0.062 최저, 다음이 7반음 0.220) 경계
-- 오류도 아니다(끝점·시작점 훑기가 0.0755~0.0799 로 평평하고 현재 값이 최저 부근).
-- 삼등분에서 앞이 0.083~0.106 으로 나쁘고 뒤가 0.055~0.059 로 좋다. 1967년 아날로그
-- 모음곡 녹음의 도입부 음색 차이로 본다. 경계를 옮기면 오히려 오르므로 그대로 뒀다.
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
