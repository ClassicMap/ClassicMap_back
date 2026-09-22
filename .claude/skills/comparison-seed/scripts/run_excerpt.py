"""긴 곡의 발췌 구간을 기준 연주에서 정하고 나머지 연주로 옮긴다.

    python3 run_excerpt.py batch.json

`run_detect.py` 를 먼저 돌려 영상마다 음악이 있는 구간을 잡아 둔다. 이 스크립트는
그 구간 안에서 발췌만 남긴다. 결과는 같은 `<batchId>-detected.json` 에 덮어쓴다.

배치 정의의 piece 에 `excerpt` 를 적는다.

    "excerpt": {"anchor": "head", "seconds": 120}          시작부터 120초
    "excerpt": {"anchor": "tail", "seconds": 90}           끝에서 90초
    "excerpt": {"referenceVideoId": "...", "start": 184.0, "end": 262.0}

앞의 둘은 기준 연주를 따로 고르지 않는다. 첫 영상을 기준으로 잡아 그 구간을
나머지로 옮긴다. 셋째는 기준 연주에서 직접 정한 구간을 쓴다.

**옮긴 값을 그대로 믿지 않는다.** 옮긴 뒤 `run_verify.py` 로 세 연주를 교차 정렬해
같은 대목인지 확인한다. 부분열 DTW 는 화성이 반복되는 곡에서 한 마디씩 밀린 자리를
고를 수 있다.
"""
import sys

import align
import batch as batchlib


def reference_span(piece, spans, excerpt):
    """기준 연주와 그 발췌 구간. 없으면 None."""
    video_id = excerpt.get("referenceVideoId") or piece["videos"][0]["videoId"]
    row = next((r for r in spans if r["videoId"] == video_id), None)
    if row is None:
        return None
    if "start" in excerpt and "end" in excerpt:
        return video_id, float(excerpt["start"]), float(excerpt["end"])
    seconds = float(excerpt.get("seconds", 120))
    if excerpt.get("anchor", "head") == "tail":
        return video_id, max(row["end"] - seconds, row["start"]), row["end"]
    return video_id, row["start"], min(row["start"] + seconds, row["end"])


def main():
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    batch = batchlib.load(sys.argv[1])
    rows = batchlib.read_detected(batch)
    by_piece = batchlib.spans_by_piece(rows)

    for piece in batch["pieces"]:
        excerpt = piece.get("excerpt")
        spans = by_piece.get(piece["pieceId"], [])
        if not excerpt:
            continue
        if len(spans) < 2:
            print(f"■ {piece['titleKo']}: 검출된 영상이 모자람")
            continue
        reference = reference_span(piece, spans, excerpt)
        if reference is None:
            print(f"■ {piece['titleKo']}: 기준 영상의 검출값이 없음")
            continue
        ref_id, ref_start, ref_end = reference
        print(f"\n■ {piece['titleKo']}  기준 {ref_id} {ref_start:.2f}–{ref_end:.2f}"
              f"  ({ref_end - ref_start:.0f}s)")

        for row in spans:
            if row["videoId"] == ref_id:
                row["start"], row["end"] = round(ref_start, 2), round(ref_end, 2)
                print(f"   {row['artistName']:<22} 기준")
                continue
            start, end, value = align.locate(
                reference, (row["videoId"], row["start"], row["end"]))
            row["start"], row["end"] = round(start, 2), round(end, 2)
            print(f"   {row['artistName']:<22} {start:7.2f}–{end:7.2f}  "
                  f"길이 {end - start:6.1f}s  옮김 비용 {value:.4f}")

    path = batchlib.write_detected(batch, rows)
    print(f"\n{len(rows)}건 → {path}")
    print("run_verify.py 로 같은 대목인지 반드시 확인한다.")


if __name__ == "__main__":
    main()
