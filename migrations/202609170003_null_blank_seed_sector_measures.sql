-- 비교 시드 배치가 마디를 모를 때 넣은 빈 문자열을 NULL 로 되돌린다.
-- 202609170001 은 'unknown' 만 고쳤고, 같은 뜻의 '' 가 2026-09-28 운영 기준 119행 남아 있다.
-- 적재기는 이미 빈 값과 'unknown' 을 NULL 로 넣으므로 기존 행만 정리한다.
-- '1' · 'final' 같은 실제 값과 수동 데이터·편집 잠금 행은 건드리지 않는다. 다시 실행해도 결과가 같다.

UPDATE performance_sectors
SET measure_start = NULL
WHERE origin = 'seed'
  AND editor_locked = FALSE
  AND TRIM(measure_start) = '';

UPDATE performance_sectors
SET measure_end = NULL
WHERE origin = 'seed'
  AND editor_locked = FALSE
  AND TRIM(measure_end) = '';
