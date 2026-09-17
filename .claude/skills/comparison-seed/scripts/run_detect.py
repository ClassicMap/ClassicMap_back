"""배치의 영상마다 음악이 시작하고 끝나는 지점을 찾는다.

    python3 run_detect.py batch.json

결과는 <batchId>-detected.json 에 쌓인다. 이 파일은 손으로 고쳐도 된다.
교차 정렬에서 경계 문제로 판정되면 end 값을 고치고 run_verify 를 다시 돌린다.
"""
import sys

import os

import batch as batchlib
import detect_music


def durations(batch):
    """영상 길이는 fetch_videos.sh 가 남긴 메타에서 읽는다. 없으면 생략한다."""
    path = os.path.join(batchlib.WORK_DIR, f"{batch['batchId']}-videometa.txt")
    if not os.path.exists(path):
        return {}
    out = {}
    with open(path, encoding="utf-8") as fh:
        for line in fh:
            parts = line.rstrip("\n").split("|")
            if len(parts) >= 2:
                out[parts[0]] = int(parts[1])
    return out


def main():
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    batch = batchlib.load(sys.argv[1])
    lengths_by_video = durations(batch)
    rows = []
    for piece in batch["pieces"]:
        print(f"\n■ {piece['titleKo']}  (piece {piece['pieceId']})")
        lengths = []
        for video in piece["videos"]:
            start, end = detect_music.detect(video["videoId"])
            if start is None:
                print(f"   {video['artistName']:<22} 검출 실패")
                continue
            lengths.append(end - start)
            total = lengths_by_video.get(video["videoId"], 0)
            tail = f"(영상 {total}s, 앞 {start:.0f}s 뒤 {total - end:.0f}s 잘림)" if total else ""
            print(f"   {video['artistName']:<22} {start:7.2f}–{end:7.2f}  "
                  f"길이 {end - start:6.1f}s  {tail}")
            rows.append({
                "pieceId": piece["pieceId"], "titleKo": piece["titleKo"],
                "videoId": video["videoId"], "artistName": video["artistName"],
                "start": round(float(start), 2), "end": round(float(end), 2),
            })
        if len(lengths) >= 2:
            lo, hi = min(lengths), max(lengths)
            print(f"   길이 편차 {lo:.0f}~{hi:.0f}s ({hi / lo:.2f}배)")

    path = batchlib.write_detected(batch, rows)
    print(f"\n{len(rows)}건 → {path}")


if __name__ == "__main__":
    main()
