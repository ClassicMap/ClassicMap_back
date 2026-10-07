# 음량 곡선 재기 2026-10-07 (film-f6·f7)

영화 속 클래식 6·7차 배치(`../comparison-film-f6-2026-10-07`, `../comparison-film-f7-2026-10-07`)로 새로 발행한 클립 27개(연주 872~898)만 쟀다.
재는 방식과 차례는 `../loudness-2026-10-01/README.md` 와 같다. 목록 SELECT 에 `AND p.id BETWEEN 872 AND 898` 을 더했다. 27/27 성공.

적재는 `deploy/loudness-load-job.yaml` 에 `RUN=loudness-2026-10-07-f6-f7` 로 dry-run → 적재 → dry-run(계획 변경 0) 순이다.
