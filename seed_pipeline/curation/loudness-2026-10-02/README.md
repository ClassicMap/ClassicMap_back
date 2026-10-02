# 음량 곡선 다시 재기 2026-10-02

오디오가 영상보다 짧게 끊겨 있던 클립 14개를 다시 만든 뒤(migration `202610020003`) 그 클립만 다시 쟀다.
재는 방식과 차례는 `../loudness-2026-10-01/README.md` 와 같다(`ebur128-short-v1`, `deploy/loudness-measure-job.yaml`).
목록과 까닭은 `../alignment-2026-10-02/README.md` 의 "오디오가 끊긴 클립 14개" 에 있다.

적재는 `deploy/loudness-load-job.yaml` 에 `RUN=loudness-2026-10-02` 로 dry-run → 적재 → dry-run(계획 변경 0) 순이다.
같은 clipAssetId 의 예전 곡선(예전 해시)을 새 곡선으로 바꾼다.
