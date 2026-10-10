# 음량 곡선 재기 2026-10-10 (film-f12)

영화 속 클래식 12차 배치(`../comparison-film-f12-2026-10-07`)로 새로 발행한 클립 12개(연주 1055~1066)만 쟀다.
재는 방식과 차례는 `../loudness-2026-10-01/README.md` 와 같다. 목록 SELECT 에 `AND p.id BETWEEN 1055 AND 1066` 을 더했다. 12/12 성공.

적재는 `deploy/loudness-load-job.yaml` 에 `RUN=loudness-2026-10-10-f12` 로 dry-run → 적재 → dry-run(계획 변경 0) 순이다.
