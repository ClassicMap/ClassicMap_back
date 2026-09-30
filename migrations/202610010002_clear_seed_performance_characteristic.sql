-- 시드 적재기가 performances.characteristic 에 넣어 둔 검증 메모를 비운다.
-- 이 칸은 연주 해석 자리이고 옛 /performances API 가 그대로 내보낸다. 적재기는 62a54c7 부터 넣지 않는다.
-- 메모 문구가 배치마다 달라 문구 일치로는 고를 수 없어 시드 행 전체를 비운다(2026-10-01 운영 기준 680행).
-- 메모 원문은 커밋된 후보 JSONL 의 clip.verificationNote 에 남아 있다.
-- 수작업 행(origin = 'manual')과 편집 잠금 행은 건드리지 않는다. 다시 실행해도 결과가 같다.

UPDATE performances
SET characteristic = NULL
WHERE origin = 'seed'
  AND editor_locked = FALSE
  AND characteristic IS NOT NULL;
