-- 편곡 비교 배치 2(망각 · 부에노스 아이레스의 여름) 6건을 발행 직전 상태로 올린다.
--
-- **두 구간 다 정렬 비용 임계를 적용하지 않는다**(sector_type ARRANGEMENTS).
-- A28·A29 에서 이 값 때문에 막았던 곡이다.
--
--   피아졸라 <망각> 전곡(piece 375), sector 260:
--     카푸송 (첼로+관현악, Warner)        0.50–222.30   221.8s
--     로이드 웨버 (첼로+피아노, Warner)    1.32–220.50   219.2s
--     크레메르 (바이올린+현악합주, UMG)    1.18–287.50   286.3s
--   피아졸라 <부에노스 아이레스의 여름>(piece 377), sector 261:
--     크레메르 (바이올린+현악합주, UMG)    0.60–356.50   355.9s
--     존 윌리엄스 (기타 독주, UMG)        0.49–280.60   280.1s
--     쿠아르테토 라티노아메리카노 (관현악판) 0.63–426.50   425.9s
--
-- 교차 정렬은 기록만 한다.
--   375  카푸송↔크레메르 0.1198 · 로이드웨버↔크레메르 0.3928 · 카푸송↔로이드웨버 0.3937
--   377  크레메르↔쿠아르테토 0.1482 · 크레메르↔윌리엄스 0.2173 · 윌리엄스↔쿠아르테토 0.2338
--
-- **375 의 0.39 는 조성이 갈려서다.** 회전 12방향으로 재면 카푸송↔로이드웨버의 최저가
-- 10반음(0.1725)이고 로이드웨버↔크레메르가 2반음(0.1866)이다. 카푸송과 크레메르는
-- 0반음으로 같은 조다. **로이드 웨버 판만 온음 낮다.** 첼로가 낮은 조에서 더 굵게
-- 울리도록 옮겨 적은 것이고, 그 갈림이 이 구간의 들을 거리다.
--
-- **377 은 셋 다 같은 조다**(회전 최저가 모두 0반음). 조성은 건드리지 않고 편성만
-- 바뀌므로 들리는 차이가 거의 전부 악기의 차이다. 기타 판이 화성과 선율을 한 손에
-- 몰아 담아 가장 짧고(280초) 관현악판이 성부를 펼쳐 가장 길다(426초).
--
-- 임계를 대신하는 조건을 다 확인했다(01-selection.md). 같은 작품 MBID, 셋 다 전곡
-- (377 은 같은 악장), 배급 표기가 편성을 밝힘, **셋의 편성이 서로 다름**, 머리와
-- 꼬리가 구간 안에 다 듦.
--
-- **경계를 다섯 곳 고쳤다. 꼬리가 특히 많이 빠져 있었다.**
--
--   카푸송      시작 10.22 → 0.50    검출이 여린 도입 9.5초를 잘랐다(음악은 0.46초부터)
--   카푸송      끝  217.25 → 222.30  −55dB 위가 222.08 까지 이어진다
--   로이드 웨버  끝  204.85 → 220.50  **15.3초.** 205~220초가 −33~−50dB 에 평탄도
--                                   0.0000~0.0001 로 또렷한 조성음이다
--   크레메르(망각) 끝 284.00 → 287.50  잔향
--   크레메르(여름) 시작 2.55 → 0.60, 끝 354.92 → 356.50
--   윌리엄스     끝  276.83 → 280.60  잔향
--   쿠아르테토   끝  422.67 → 426.50  잔향
--
-- 꼬리를 뒤에서부터 훑어 −55dB 를 넘는 마지막 자리를 끝으로 삼았다. 검출기는 조성
-- 곡선이 먼저 떨어져 일찍 끊는데, 편곡 비교에서는 사라지는 여운도 편곡의 일부다.
--
-- 202608050219 에서 인물·단체 넷을 등록했다. **크레메르는 authority 엔티티가 이미
-- 있고 artists 행만 없어서 행만 붙였다.**
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
