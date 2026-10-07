# 음량 곡선 재기 2026-10-07 (film-f3)

영화 속 클래식 3차 배치(`../comparison-film-f3-2026-10-07`)로 새로 발행한 클립 3개(연주 818~820)만 쟀다.
재는 방식과 차례는 `../loudness-2026-10-01/README.md` 와 같다. 목록 SELECT 에 `AND p.id IN (818, 819, 820)` 을 더했다. 3/3 성공.

적재는 `deploy/loudness-load-job.yaml` 에 `RUN=loudness-2026-10-07-f3` 로 dry-run → 적재 → dry-run(계획 변경 0) 순이다.
