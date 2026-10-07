# 음량 곡선 재기 2026-10-07 (film-f4)

영화 속 클래식 4차 배치(`../comparison-film-f4-2026-10-07`)로 새로 발행한 클립 9개(연주 836~844)만 쟀다.
재는 방식과 차례는 `../loudness-2026-10-01/README.md` 와 같다. 목록 SELECT 에 `AND p.id BETWEEN 836 AND 844` 를 더했다.

적재는 `deploy/loudness-load-job.yaml` 에 `RUN=loudness-2026-10-07-f4` 로 dry-run → 적재 → dry-run(계획 변경 0) 순이다.
