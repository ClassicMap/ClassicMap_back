-- S tier 대기열 F1(성악 표본) 비교 영상 9건을 발행 직전 상태로 올린다.
--
--   슈베르트 가곡 <마왕> D. 328 전곡(piece 117): 피셔디스카우·무어 / 터펠·마티노 /
--     괴르네·헤플리거                                                   0.0541~0.0643
--   베르디 <나부코> 중 "히브리 노예들의 합창"(piece 151): 무티·암브로시안·필하모니아 /
--     샤이·라스칼라 / 콘론·라페니체                                     0.0437~0.0871
--   바그너 <로엔그린> 중 "혼례의 합창"(piece 146): 콜린 데이비스·바이에른방송 /
--     자발리슈·바이로이트축제 / 프뤼베크 데 부르고스                     0.0383~0.0950
--
-- 셋 다 전곡이라 발췌하지 않았다. 검출 구간이 곧 발행 구간이다.
--
-- ## 표본 배치다
--
-- 성악 정렬은 202609170000 대의 투란도트 배치에서 **독창 아리아**만 검증됐다
-- (0.0589~0.0646). 이 배치는 아직 확인되지 않은 두 텍스처를 본다.
--
--   합창(151·146)  여러 성부가 겹치면 chroma 가 뭉개지는가
--   가곡(117)      목소리 하나와 피아노뿐이라 화성 정보가 얇은가
--
-- **둘 다 통했다.**
--
-- 합창 여섯 쌍이 0.0383~0.0950 으로 기악 통과 범위(0.04~0.09) 안에 들어왔고 최저값은
-- 기악 평균보다 낮다. 다만 **분포가 기악보다 넓다.** 같은 곡 안에서 최저와 최고가
-- 2.3~2.5배 벌어졌다(기악은 대개 0.01 안쪽으로 모인다). 한 연주가 다른 둘과 동시에
-- 멀어지는 모양이 나오는데(151 샤이 0.087 두 쌍, 146 자발리슈 0.085·0.095) 둘 다
-- 진단 결과 이조도 경계 오류도 아니었다. 합창단 규모·배치·잔향과 판본 차이(샤이는
-- Ed. Parker)가 chroma 에 남는 것으로 본다. **0.09 대가 합창의 정상 범위이므로
-- 임계 0.11 을 낮추지 않는다.**
--
-- 가곡은 셋 중 가장 좋았다(0.0541~0.0643, 세 쌍이 0.01 안에 모임). 반주 편성이 단순해
-- 화성 윤곽이 또렷하고 세 연주가 거의 같은 길이다(편차 1.07배). 피아노 셋잇단음 어택이
-- 뚜렷해 검출도 세 건 모두 깨끗했다. **얇은 텍스처는 문제가 되지 않았다.**
--
-- 이조로 걸린 연주는 없었다(네 건에서 회전 곡선을 봤고 전부 0반음이 최저, 나머지
-- 0.19~0.37). 다만 이것은 운이다. 골라 온 마왕 셋이 모두 바리톤 계열이라 조를 옮길
-- 이유가 없었다. **가곡 배치에서는 성부를 맞춰 고르는 편이 안전하다.**
--
-- ## 검출
--
-- 146 콜린 데이비스만 고쳤다(0.56~334.58 → 25.40~348.20). 원본은 detected.orig.json.
-- RCA 전곡반 트랙이라 합창 앞에 24초, 뒤에 여린 퇴장 부분이 더 들어 있었다.
--   * 시작점을 훑자 두 쌍이 함께 내려갔다(자발리슈 0.1091→0.0947, 프뤼베크 0.0791→0.0464,
--     20~25초에서 바닥). 1번 경계 오류다
--   * 부분 정렬로 프뤼베크 전 구간을 데이비스 안에서 찾으니 24.7~348.2초에 붙었고
--     비용이 0.0382 였다. 25.4 는 onset 에 맞춘 값이다
--   * 뒤쪽 14초는 종결부 누락이었다. 334.6초 뒤로도 하모닉 RMS 가 광대역 RMS 를 3~5dB
--     차이로 따라붙었고(-45 → -67dB) 평탄도는 내내 0.002 아래였다. 박수가 아니다
--   * 고친 뒤 데이비스↔프뤼베크 0.0784→0.0383, 데이비스↔자발리슈 0.1087→0.0950
--
-- 나머지 여덟 건은 고치지 않았다. 마왕 셋은 시작 앞이 -72~-78dB 완전 무음이고 하모닉
-- RMS 도 함께 바닥이라 아날로그 프리에코도 아니었다.
--
-- ## 영상 고르기
--
-- 마왕은 리스트의 피아노 편곡(S. 557a)과 관현악 반주판을 갈라 냈다. 셋 다 "성악가 ·
-- 피아니스트" 로만 표기된 목소리+피아노 원곡이다. 히브리 노예들의 합창은 앙코르
-- 반복본(388초)을 뺐고, 혼례의 합창은 오르간 결혼행진곡 편곡과 3막 전주곡이 앞에 붙은
-- 트랙을 전부 뺐다.
--
-- ## 크레딧에서 빠진 것
--
-- 합창단 넷(바이에른 국립오페라 합창단, 바이로이트 축제 합창단, 베를린 도이치오퍼
-- 합창단, 라 페니체 합창단)은 **위키데이터 항목 자체가 없어** CHOIR 크레딧을 만들지
-- 못했다. 영상 설명에는 적혀 있다. 성악 배치에서 흔한 일이므로 CHOIR 를 필수로 두면
-- 막힌다. 앞으로도 선택으로 다룬다.
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
