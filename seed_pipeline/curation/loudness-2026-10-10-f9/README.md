# 음량 곡선 재기 2026-10-10 (film-f9)

영화 속 클래식 9차 배치(`../comparison-film-f9-2026-10-07`)로 새로 발행한 클립 12개(연주 971~982)만 쟀다.
재는 방식과 차례는 `../loudness-2026-10-01/README.md` 와 같다. 목록 SELECT 에 `AND p.id BETWEEN 971 AND 982` 를 더했다. 12/12 성공.

적재는 `deploy/loudness-load-job.yaml` 에 `RUN=loudness-2026-10-10-f9` 로 dry-run → 적재 → dry-run(계획 변경 0) 순이다.
