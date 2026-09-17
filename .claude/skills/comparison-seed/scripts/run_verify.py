"""검출한 구간이 서로 같은 음악인지 교차 정렬로 확인한다.

    python3 run_verify.py batch.json

임계를 넘는 쌍이 있으면 run_diagnose.py 로 원인을 가린다.
"""
import sys

import align
import batch as batchlib


def main():
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    batch = batchlib.load(sys.argv[1])
    rows = batchlib.read_detected(batch)

    print(f"{'곡':<24}{'연주쌍':<34}{'정렬비용':>9}  판정")
    print("-" * 78)
    flagged = []
    for piece_id, group in batchlib.spans_by_piece(rows).items():
        spans = [(r["videoId"], r["start"], r["end"]) for r in group]
        worst = 0.0
        for i, j, value in align.pair_costs(spans):
            worst = max(worst, value)
            pair = f"{group[i]['artistName'][:14]} ↔ {group[j]['artistName'][:14]}"
            verdict = "같은 곡" if value < align.COST_THRESHOLD else "확인 필요"
            print(f"{group[i]['titleKo'][:22]:<24}{pair:<34}{value:9.4f}  {verdict}")
        if worst >= align.COST_THRESHOLD:
            flagged.append((group[0]["titleKo"], worst))

    print("-" * 78)
    if flagged:
        for title, value in flagged:
            print(f"  확인 필요: {title} (최대 비용 {value:.4f})")
        raise SystemExit(1)
    print("  전부 통과")


if __name__ == "__main__":
    main()
