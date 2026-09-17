"""배치 정의 파일을 읽고 쓴다. 모든 run_*.py 가 이것을 공유한다."""
import json
import os

WORK_DIR = os.environ.get("COMPARISON_WORK_DIR", os.getcwd())


def load(path):
    with open(path, encoding="utf-8") as fh:
        batch = json.load(fh)
    for piece in batch["pieces"]:
        for key in ("pieceId", "workMbid", "composerQid", "titleKo", "titleEn",
                    "composerNameEn", "composerNameKo", "sector", "role", "videos"):
            if key not in piece:
                raise SystemExit(f"piece {piece.get('pieceId','?')}: {key} 가 없음")
    return batch


def videos(batch):
    for piece in batch["pieces"]:
        for video in piece["videos"]:
            yield piece, video


def detected_path(batch):
    return os.path.join(WORK_DIR, f"{batch['batchId']}-detected.json")


def read_detected(batch):
    with open(detected_path(batch), encoding="utf-8") as fh:
        return json.load(fh)


def write_detected(batch, rows):
    with open(detected_path(batch), "w", encoding="utf-8") as fh:
        json.dump(rows, fh, ensure_ascii=False, indent=2)
    return detected_path(batch)


def spans_by_piece(rows):
    out = {}
    for row in rows:
        out.setdefault(row["pieceId"], []).append(row)
    return out
