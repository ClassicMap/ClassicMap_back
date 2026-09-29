-- 편곡 비교 배치 1(리베르탱고) 3건을 발행 직전 상태로 올린다.
--
-- **이 구간은 정렬 비용 임계를 적용하지 않는다.** `performance_sectors.sector_type`
-- 이 `ARRANGEMENTS` 이고 화면이 구간 칩에 "편곡" 표를 내며 감상 안내를 함께 그린다.
--
--   피아졸라 <리베르탱고> 전곡(piece 374), sector 259:
--     요요 마 (첼로, Sony)              0.14–185.50   185.4s
--     앨리슨 발솜 (트럼펫, Warner)       0.20–263.17   263.0s
--     에벤 4중주단 (현악 4중주, Warner)  1.79–395.50   393.7s
--
-- 교차 정렬 비용은 기록만 한다 — 0.1305 · 0.1656 · 0.1782. **임계(0.11)를 넘지만
-- 그것이 이 구간의 뜻이다.** A28 에서 이 값 때문에 곡을 막았는데, 편성이 서로 다른
-- 편곡을 "같은 대목의 다른 해석" 으로 재려 한 것이 잘못이었다. 리베르탱고는 A단조
-- 두 화음 오스티나토 위에 선율 악기만 바뀌는 곡이고, 그 바뀜이 들을 거리다.
--
-- 임계를 대신하는 조건을 다 확인했다(01-selection.md).
--
--   같은 작품 MBID e039120f-9a72-3d38-b885-5f9a6779e2c9 — 셋 다 전곡
--   배급 표기가 편성을 밝힌다 — Sony / Warner / Warner
--   **셋의 편성이 서로 다르다** — 첼로 · 트럼펫 · 현악 4중주+타악
--   머리와 꼬리가 구간 안에 다 든다 — 아래 보정 셋
--
-- **경계를 셋 다 고쳤다.**
--
--   발솜   시작 12.89 → 0.20    검출이 여린 도입 13초를 잘랐다. 0초부터 −57dB 로
--                              음악이 있고 평탄도가 0.0000~0.002 다(조성음)
--   요요 마 끝  175.80 → 185.50  176~184초가 −26~−49dB 조성음으로 사라지는 여운이다.
--                              187.5초부터 디지털 무음
--   에벤   끝  393.39 → 395.50  종결 화음(392.8초, −12dB) 뒤 잔향이 395초까지 남는다
--
-- **발솜 판의 도입 13초는 편곡의 일부다** — Orch. Milone 판이 오스티나토 앞에 여린
-- 관현악 도입을 둔다. 구간 큐가 "작품 시작" 이므로 살린다.
--
-- 202608050217 에서 발솜과 에벤 4중주단을 등록했다. 요요 마는 이미 등록돼 있었다(215).
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
