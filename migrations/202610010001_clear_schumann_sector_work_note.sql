-- 슈만 〈어린이의 정경〉 비교 구간(운영 id 29)의 설명에 들어간 파일럿 작업 메모를 비운다.
-- 적재기가 후보의 editorialNote 를 구간 설명으로 넣으면서 공개 화면에 검수 메모가 보이게 됐다.
-- 메모는 seed_pipeline/curation/pilot-2026-08-05/review-report.md 로 옮겼다.
-- 문구가 정확히 같은 시드 행만 건드리므로 수동 데이터·편집 잠금 행은 안전하고, 다시 실행해도 결과가 같다.

UPDATE performance_sectors
SET description = NULL
WHERE origin = 'seed'
  AND editor_locked = FALSE
  AND sector_key = 'whole-work'
  AND description = '작품 전체가 30초 안팎이라 권장 최소 길이보다 짧아도 전곡 비교를 우선합니다.';
