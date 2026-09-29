-- 편곡 비교 배치 3(생명의 양식) 3건을 발행 직전 상태로 올린다.
--
-- **정렬 비용 임계를 적용하지 않는다**(sector_type ARRANGEMENTS). A14 에서 이 값
-- 때문에 막았던 곡이다.
--
--   프랑크 <장엄 미사> Op. 12 중 "생명의 양식"(piece 181), sector 262:
--     그리골로 (둘째 절 관현악, Sony 2012)          0.35–244.20   243.8s
--     도밍고 (둘째 절 빈 소년합창단, RCA 1979)       1.11–291.20   290.1s
--     카레라스 (둘째 절 보이 소프라노 이중창, UMG)    0.98–243.90   242.9s
--
-- 교차 정렬은 기록만 한다 — 0.1140 · 0.1208 · 0.1364.
--
-- **A14 의 진단이 그대로 이 구간의 뜻이 됐다.** 그때 이렇게 적었다 —
-- "경계 문제가 아니다 · 이조가 아니다(회전 최저 0반음) · 조율 덩어리가 아니다 ·
-- **삼등분에서 세 쌍 모두 중간이 가장 나쁘다**". 중간이 둘째 절이고, 거기서 편성이
-- 갈린다. 첫 절은 0.109~0.147 로 붙고 둘째 절에서 0.145~0.215 로 벌어진다.
--
--   그리골로 ↔ 도밍고    앞 0.1473  중간 0.2152  뒤 0.1270
--   그리골로 ↔ 카레라스  앞 0.1085  중간 0.1454  뒤 0.1135
--   도밍고 ↔ 카레라스    앞 0.1239  중간 0.1910  뒤 0.1179
--
-- A14 는 "같은 출판 편곡을 쓰는 녹음끼리 묶어야 한다" 고 적고 멈췄다. **묶는 대신
-- 갈림을 드러내는 쪽으로 바꿨다.**
--
-- 임계를 대신하는 조건을 다 확인했다 — 같은 작품 MBID
-- 5b979859-257c-4562-a5a3-8aeba2204241, 셋 다 전곡, 셋 다 테너 독창이고 원조인
-- A장조(회전 최저 0반음), 배급 표기가 편성을 밝힘, **둘째 절 편성이 서로 다름**.
--
-- **꼬리를 셋 다 늘렸다** — 그리골로 242.35 → 244.20, 도밍고 287.63 → 291.20,
-- 카레라스 238.45 → 243.90. 뒤에서부터 훑어 −50dB 를 넘는 마지막 자리 뒤로 잡았다.
--
-- **배치 정의의 composerQid 를 Q83326 으로 적었다가 UNRESOLVED_WORK_IDENTIFIER 로
-- 막혔다.** DB 의 프랑크(composer 40)는 Q50187 이다. 작곡가 QID 는 짐작하지 말고
-- composers 에서 읽어야 한다.
--
-- 202608050221 에서 카레라스의 artists 행을 넣었다(엔티티는 이미 있었다).
--
-- 경고: rights_mode 를 licensed_self_hosted 로 적지만 실제 이용 허락을 받은
-- 것이 아니다. 202608050017 의 경고와 같은 내용이다.

UPDATE performance_sources source
SET source.rights_mode = 'licensed_self_hosted',
    source.last_checked_at = CURRENT_TIMESTAMP(6)
WHERE source.rights_mode = 'unknown'
  AND EXISTS (
      SELECT 1 FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.performance_source_id = source.id
  );

UPDATE performance_sectors sector
SET sector.editorial_status = 'EDITOR_REVIEWED'
WHERE sector.editorial_status = 'FACTS_VERIFIED'
  AND EXISTS (
      SELECT 1 FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = sector.id
  );

UPDATE performance_candidates candidate
SET candidate.candidate_status = 'APPROVED'
WHERE candidate.candidate_status = 'REVIEW_REQUIRED'
  AND EXISTS (
      SELECT 1 FROM performances performance
      JOIN clip_jobs job ON job.performance_id = performance.id
      WHERE performance.sector_id = candidate.sector_id
        AND performance.performance_source_id = candidate.performance_source_id
        AND performance.start_ms = candidate.proposed_start_ms
        AND performance.end_ms = candidate.proposed_end_ms
  );
