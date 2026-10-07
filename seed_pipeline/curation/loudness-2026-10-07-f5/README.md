# 음량 곡선 재기 2026-10-07 (film-f5)

영화 속 클래식 5차 배치(`../comparison-film-f5-2026-10-07`)로 새로 발행한 클립 3개(연주 824~826)만 쟀다.
재는 방식과 차례는 `../loudness-2026-10-01/README.md` 와 같다. 목록 SELECT 에 `AND p.id IN (824, 825, 826)` 을 더했다. 3/3 성공.

적재는 `deploy/loudness-load-job.yaml` 에 `RUN=loudness-2026-10-07-f5` 로 dry-run → 적재 → dry-run(계획 변경 0) 순이다.
