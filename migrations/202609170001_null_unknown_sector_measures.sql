-- 비교 시드 후보가 마디를 모를 때 자리 채움으로 넣은 'unknown' 을 NULL 로 되돌린다.
-- API 는 값을 가리지 않고 그대로 내보내므로 데이터 쪽을 고친다.
-- 2026-09-17 운영 조회 기준 대상은 시드 섹터 6행이다(편집 잠금 없음).
--   36 라 캄파넬라 도입 종소리 음형   measure_end   unknown
--   37 라 캄파넬라 종결 클라이맥스   measure_start unknown
--   38 차이콥스키 협주곡 1번 3악장 코다 measure_start unknown
--   39 차이콥스키 협주곡 1번 1악장 도입부 measure_end unknown
--   40 베토벤 교향곡 5번 4악장 개선 주제 measure_end unknown
--   41 베토벤 교향곡 5번 1악장 운명 동기 measure_end unknown
-- 작품 끝을 뜻하는 'final' 은 모르는 값이 아니므로 그대로 둔다.
-- 수동 데이터와 편집 잠금 행은 건드리지 않는다. 다시 실행해도 결과가 같다.

UPDATE performance_sectors
SET measure_start = NULL
WHERE origin = 'seed'
  AND editor_locked = FALSE
  AND LOWER(TRIM(measure_start)) = 'unknown';

UPDATE performance_sectors
SET measure_end = NULL
WHERE origin = 'seed'
  AND editor_locked = FALSE
  AND LOWER(TRIM(measure_end)) = 'unknown';
