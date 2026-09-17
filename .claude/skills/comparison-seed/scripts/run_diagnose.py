"""임계를 넘은 연주의 원인을 가린다.

    python3 run_diagnose.py batch.json <pieceId> <videoId>

지목한 연주를 나머지와 견주며 세 가지를 본다.
  1. 구간 삼등분   앞뒤만 나쁘면 경계를 의심한다
  2. 끝·시작 훑기  곡선의 모양이 원인을 말해 준다
  3. 12방향 회전   특정 회전에서 뚝 떨어지면 이조다

곡선 읽는 법은 references/03-verification.md 에 있다.
"""
import sys

import align
import batch as batchlib


def main():
    if len(sys.argv) != 4:
        raise SystemExit(__doc__)
    batch = batchlib.load(sys.argv[1])
    piece_id, video_id = int(sys.argv[2]), sys.argv[3]
    rows = batchlib.read_detected(batch)
    group = batchlib.spans_by_piece(rows)[piece_id]
    target = next(r for r in group if r["videoId"] == video_id)
    others = [r for r in group if r["videoId"] != video_id]
    if not others:
        raise SystemExit("견줄 연주가 없음")

    names = {r["artistName"][:10]: r for r in others}
    refs = {n: align.chroma(r["videoId"], r["start"], r["end"]) for n, r in names.items()}
    header = "".join(f"  {n:>12}" for n in refs)

    print(f"■ {target['artistName']}  ({video_id})  "
          f"{target['start']:.2f}–{target['end']:.2f}\n")

    print("1. 구간 삼등분 — 앞뒤만 나쁘면 경계 문제")
    mine = align.thirds(video_id, target["start"], target["end"])
    print(f"{'구간':<10}{header}")
    for label, k in (("앞", 0), ("중간", 1), ("뒤", 2)):
        cells = ""
        for n, r in names.items():
            theirs = align.thirds(r["videoId"], r["start"], r["end"])
            cells += f"  {align.cost(mine[k], theirs[k]):12.4f}"
        print(f"{label:<10}{cells}")

    for edge, title in (("end", "2. 끝점 훑기"), ("start", "3. 시작점 훑기")):
        print(f"\n{title}")
        print(f"{'경계(초)':>10}{header}{'최대':>14}")
        for value, costs in align.sweep_edge(
                video_id, target["start"], target["end"], refs, edge=edge):
            cells = "".join(f"  {costs[n]:12.4f}" for n in refs)
            print(f"{value:10.1f}{cells}{max(costs.values()):14.4f}")

    print("\n4. 12방향 회전 — 특정 회전에서 뚝 떨어지면 이조")
    first = next(iter(refs.values()))
    best = None
    line = []
    for shift, value in align.sweep_pitch(
            video_id, target["start"], target["end"], first):
        line.append(f"{shift}:{value:.3f}")
        if best is None or value < best[1]:
            best = (shift, value)
    print("  " + "  ".join(line))
    print(f"  가장 잘 맞는 회전 {best[0]}반음 ({best[1]:.4f})"
          + ("  ← 0반음이면 조성은 같다" if best[0] == 0 else "  ← 이조로 보인다"))


if __name__ == "__main__":
    main()
