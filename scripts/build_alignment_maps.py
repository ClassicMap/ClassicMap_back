#!/usr/bin/env python3
"""같은 구간 연주들의 정렬 지도(같은 지점 표)를 만든다.

구간마다 연주의 화성 윤곽(chroma_cens)을 뽑아 기준 연주(길이 중간값)와 DTW 로 맞춘다.
기준 연주의 0.5초마다 이 연주의 같은 지점(ms)을 남긴다. 기준 연주 자신도 한 줄(그대로)이다.
화면은 두 연주가 같은 기준을 가리키면 기준을 거쳐 서로의 같은 지점을 찾는다.

    python3 scripts/build_alignment_maps.py --manifest manifest.jsonl --clips-dir <클립 폴더> > alignment-maps.jsonl

입력(manifest JSONL, 한 줄에 클립 하나). 클립 목록 SELECT 는
seed_pipeline/curation/loudness-2026-10-01/README.md 와 같고 sectorId·performanceId 를 함께 쓴다.
    {"clipAssetId": 32, "storageKey": "0FbQZCsYXVg-236000-23000-v1-copy.mp4",
     "sha256": "67f3…", "durationMs": 23040, "performanceId": 93, "sectorId": 37}

출력(표준 출력 JSONL). 진행·건너뜀은 표준 오류로 낸다.
    {"clipAssetId": 32, "referenceClipAssetId": 41, "analyzerVersion": "chroma-dtw-v1",
     "clipSha256": "…", "referenceClipSha256": "…", "stepMs": 500, "durationMs": 23040,
     "referenceDurationMs": 24000, "cost": 0.0639, "positionsMs": [0, 410, …]}

필요한 것: numpy, librosa, av(PyAV). 실측 2026-10-02 은 맥북에서 680클립 1분 21초(6프로세스).
"""

from __future__ import annotations

import argparse
import concurrent.futures as cf
import hashlib
import json
import multiprocessing
import os
import sys

import av
import librosa
import numpy as np

ANALYZER_VERSION = "chroma-dtw-v1"
SR = 22050
STEP_MS = 500
# DTW 행렬이 이 프레임 수를 넘지 않게 hop 을 키운다(전곡 9분도 4000×4000 안)
MAX_FRAMES = 4000
# 오디오가 영상보다 이만큼 넘게 짧으면(끝이 끊긴 클립) 끝을 맞출 수 없어 지도를 만들지 않는다
TRUNCATED_MS = 1500


def load_audio(path: str) -> np.ndarray:
    """모노 22.05kHz. 잘라 붙인 클립은 깨진 패킷이 있어 그 패킷만 건너뛴다"""
    container = av.open(path)
    resampler = av.AudioResampler(format="flt", layout="mono", rate=SR)
    chunks = []
    for packet in container.demux(container.streams.audio[0]):
        try:
            frames = packet.decode()
        except av.error.InvalidDataError:
            continue
        for frame in frames:
            for out in resampler.resample(frame):
                chunks.append(out.to_ndarray().reshape(-1))
    for out in resampler.resample(None):
        chunks.append(out.to_ndarray().reshape(-1))
    container.close()
    return np.concatenate(chunks).astype(np.float32) if chunks else np.zeros(0, np.float32)


def chroma(y: np.ndarray, hop: int) -> np.ndarray:
    """화성 윤곽. 조율은 클립 전체에서 고르게 뽑은 조각으로 한 번 잰다(align.py 와 같은 까닭)"""
    piece = 15 * SR
    starts = np.linspace(0, max(len(y) - piece, 0), num=8).astype(int)
    sample = np.concatenate([y[s:s + piece] for s in starts]) if len(y) > piece else y
    tuning = float(librosa.estimate_tuning(y=sample, sr=SR))
    c = librosa.feature.chroma_cens(y=y, sr=SR, hop_length=hop, tuning=tuning)
    c = librosa.util.normalize(c, norm=2, axis=0)
    silent = ~c.any(axis=0)
    c[:, silent] = 1.0 / np.sqrt(c.shape[0])
    return c.astype(np.float32)


def sector_maps(clips: list[dict], clips_dir: str) -> tuple[list[dict], list[str]]:
    notes: list[str] = []
    audio = {}
    for clip in clips:
        path = os.path.join(clips_dir, clip["storageKey"])
        with open(path, "rb") as handle:
            if hashlib.sha256(handle.read()).hexdigest() != clip["sha256"]:
                notes.append(f"clip {clip['clipAssetId']} 해시가 다름, 건너뜀")
                continue
        y = load_audio(path)
        if len(y) / SR * 1000 < clip["durationMs"] - TRUNCATED_MS:
            notes.append(
                f"clip {clip['clipAssetId']} 오디오가 {len(y) * 1000 // SR}ms 에서 끊김"
                f"(영상 {clip['durationMs']}ms), 건너뜀"
            )
            continue
        audio[clip["clipAssetId"]] = y
    clips = [clip for clip in clips if clip["clipAssetId"] in audio]
    if len(clips) < 2:
        return [], notes

    longest = max(len(y) for y in audio.values())
    hop = 512 * int(np.ceil(longest / 512 / MAX_FRAMES))
    frame_ms = hop / SR * 1000
    features = {key: chroma(y, hop) for key, y in audio.items()}
    ordered = sorted(clips, key=lambda clip: clip["durationMs"])
    reference = ordered[(len(ordered) - 1) // 2]
    grid = np.arange(0, reference["durationMs"] + 1, STEP_MS)

    rows = []
    for clip in clips:
        if clip is reference:
            positions, cost = grid.astype(float), 0.0
        else:
            distance, path = librosa.sequence.dtw(
                X=features[reference["clipAssetId"]], Y=features[clip["clipAssetId"]], metric="cosine"
            )
            path = path[::-1]
            cost = float(distance[-1, -1]) / len(path)
            # 기준 프레임마다 맞은 이 연주 프레임의 가운데. 되돌아가지 않게 누적 최대로 편다
            ref_frames, self_frames = path[:, 0], path[:, 1]
            unique = np.unique(ref_frames)
            mean_self = np.array([self_frames[ref_frames == index].mean() for index in unique])
            self_ms = np.maximum.accumulate((mean_self + 0.5) * frame_ms)
            positions = np.interp(grid, (unique + 0.5) * frame_ms, self_ms)
            positions[0] = 0
            positions = np.clip(positions, 0, clip["durationMs"])
        rows.append({
            "clipAssetId": clip["clipAssetId"],
            "referenceClipAssetId": reference["clipAssetId"],
            "analyzerVersion": ANALYZER_VERSION,
            "clipSha256": clip["sha256"],
            "referenceClipSha256": reference["sha256"],
            "stepMs": STEP_MS,
            "durationMs": clip["durationMs"],
            "referenceDurationMs": reference["durationMs"],
            "cost": round(cost, 4),
            "positionsMs": [int(round(value)) for value in positions],
        })
    return rows, notes


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--manifest", required=True)
    parser.add_argument("--clips-dir", required=True)
    parser.add_argument("--workers", type=int, default=os.cpu_count() or 1)
    args = parser.parse_args()

    by_sector: dict[int, list[dict]] = {}
    with open(args.manifest, encoding="utf-8") as handle:
        for line in handle:
            if line.strip():
                clip = json.loads(line)
                by_sector.setdefault(clip["sectorId"], []).append(clip)

    rows: list[dict] = []
    # macOS 에서 fork 하면 PyAV·librosa 가 죽는다. spawn 으로 띄운다
    context = multiprocessing.get_context("spawn")
    with cf.ProcessPoolExecutor(args.workers, mp_context=context) as pool:
        futures = {pool.submit(sector_maps, clips, args.clips_dir): sector for sector, clips in by_sector.items()}
        for future in cf.as_completed(futures):
            result, notes = future.result()
            rows += result
            for note in notes:
                print(f"sector {futures[future]}: {note}", file=sys.stderr)
    for row in sorted(rows, key=lambda row: row["clipAssetId"]):
        print(json.dumps(row, separators=(",", ":")))
    print(f"정렬 지도 {len(rows)}개", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
