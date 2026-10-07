# 음량 곡선 재기 2026-10-07

영화 속 클래식 1차 배치(`../comparison-film-f1-2026-10-07`)로 새로 발행한 클립 9개(연주 794~802)만 쟀다.
재는 방식과 차례는 `../loudness-2026-10-01/README.md` 와 같다(`ebur128-short-v1`, `deploy/loudness-measure-job.yaml`).
목록 SELECT 는 그 README 의 것에 `AND p.id BETWEEN 794 AND 802` 를 더했다. 9/9 성공.

적재는 `deploy/loudness-load-job.yaml` 에 `RUN=loudness-2026-10-07` 로 dry-run → 적재 → dry-run(계획 변경 0) 순이다.
