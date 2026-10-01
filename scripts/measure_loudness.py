#!/usr/bin/env python3
"""공개 클립의 음량 곡선을 잰다.

클리퍼 이미지(ffmpeg 포함) 안에서 클립 캐시를 읽기 전용으로 붙여 돈다.
`deploy/loudness-measure-job.yaml` 이 이 파일과 측정할 클립 목록을 ConfigMap 으로 넣는다.

입력(manifest JSONL, 한 줄에 클립 하나):
    {"clipAssetId": 32, "storageKey": "0FbQZCsYXVg-236000-23000-v1-copy.mp4",
     "sha256": "67f3…", "durationMs": 23040}

출력(표준 출력 JSONL, 한 줄에 클립 하나). 진행·오류는 표준 오류로 낸다.
    {"clipAssetId": 32, "analyzerVersion": "ebur128-short-v1", "clipSha256": "67f3…",
     "stepMs": 500, "durationMs": 23040, "curveRelDb": [-5.8, …],
     "startRelDb": -1.6, "peakMs": 2500, "peakRatio": 0.109, "rangeDb": 4.0}

곡선은 EBU R128 단기 음량(3초 창)을 0.5초 간격으로 뽑고, 가장 센 곳을 0dB 로 둔
상대값이다. 단기 음량은 창이 끝나는 시각에 찍히므로 1.5초 당겨 창 가운데에 둔다.
그래서 곡선의 i 번째 값은 클립의 i*0.5초 가 가운데인 3초 창의 세기다.
녹음마다 전체 레벨이 크게 다르므로 절대값은 남기지 않는다.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import os
import re
import subprocess
import sys
from dataclasses import dataclass
from typing import Iterable

ANALYZER_VERSION = "ebur128-short-v1"
STEP_MS = 500
# 단기 음량 창(3초)의 절반. 창 끝 시각을 창 가운데로 옮긴다
WINDOW_CENTER_SHIFT_MS = 1500
# EBU R128 절대 게이트. 이보다 작으면 무음으로 본다
SILENCE_LUFS = -70.0
# 상대 곡선의 바닥. 무음 구간이 곡선 폭을 끝없이 넓히지 않게 막는다
FLOOR_REL_DB = -60.0
START_WINDOW_MS = 5000

FRAME_PATTERN = re.compile(r"t:\s*(?P<t>[\d.]+)\s+.*?S:\s*(?P<s>-?[\d.]+|-?inf|nan)")


@dataclass(frozen=True)
class Frame:
    end_ms: int
    short_term: float | None


def parse_frames(lines: Iterable[str]) -> list[Frame]:
    """ffmpeg ebur128(framelog=verbose) 출력에서 100ms 마다 찍힌 단기 음량을 읽는다."""
    frames: list[Frame] = []
    for line in lines:
        if "Parsed_ebur128" not in line or " t:" not in line:
            continue
        match = FRAME_PATTERN.search(line)
        if not match:
            continue
        raw = match.group("s")
        try:
            value = float(raw)
        except ValueError:
            value = math.nan
        short_term = value if math.isfinite(value) and value > SILENCE_LUFS else None
        frames.append(Frame(end_ms=round(float(match.group("t")) * 1000), short_term=short_term))
    return frames


def sample_curve(frames: list[Frame], duration_ms: int) -> list[float | None]:
    """창 가운데 기준 0.5초 간격으로 단기 음량을 뽑는다. 창이 아직 차지 않은 앞쪽은 None."""
    by_end = {frame.end_ms: frame.short_term for frame in frames}
    ends = sorted(by_end)
    if not ends:
        return []
    samples: list[float | None] = []
    for index in range(duration_ms // STEP_MS + 1):
        center_ms = index * STEP_MS
        end_ms = center_ms + WINDOW_CENTER_SHIFT_MS
        if end_ms < 3000:
            # 3초 창이 다 차지 않은 값은 앞부분을 0 으로 채운 값이라 낮게 나온다
            samples.append(None)
            continue
        if end_ms > ends[-1]:
            # 클립 끝을 넘는 창은 없다. 마지막 창 값을 쓴다(창이 끝까지 차 있다)
            samples.append(by_end[ends[-1]])
            continue
        nearest = min(ends, key=lambda value: abs(value - end_ms)) if end_ms not in by_end else end_ms
        samples.append(by_end[nearest])
    return samples


def fill_edges(samples: list[float | None]) -> list[float] | None:
    """앞쪽의 빈 값은 처음 잰 값으로, 무음은 바닥으로 채운다. 잰 값이 없으면 None."""
    first = next((value for value in samples if value is not None), None)
    if first is None:
        return None
    filled: list[float] = []
    seen_value = False
    for value in samples:
        if value is not None:
            seen_value = True
            filled.append(value)
        elif not seen_value:
            filled.append(first)
        else:
            filled.append(-math.inf)
    return filled


def percentile(values: list[float], fraction: float) -> float:
    ordered = sorted(values)
    position = (len(ordered) - 1) * fraction
    lower = math.floor(position)
    upper = math.ceil(position)
    if lower == upper:
        return ordered[lower]
    return ordered[lower] + (ordered[upper] - ordered[lower]) * (position - lower)


def summarize(absolute: list[float], duration_ms: int) -> dict[str, object]:
    peak = max(absolute)
    curve = [max(FLOOR_REL_DB, value - peak) for value in absolute]
    peak_index = curve.index(max(curve))
    peak_ms = min(duration_ms, peak_index * STEP_MS)
    start_count = max(1, START_WINDOW_MS // STEP_MS)
    start_values = curve[:start_count]
    return {
        "stepMs": STEP_MS,
        "durationMs": duration_ms,
        "curveRelDb": [round(value, 1) for value in curve],
        "startRelDb": round(sum(start_values) / len(start_values), 1),
        "peakMs": peak_ms,
        "peakRatio": round(peak_ms / duration_ms, 3) if duration_ms > 0 else 0.0,
        "rangeDb": round(percentile(curve, 0.9) - percentile(curve, 0.1), 1),
    }


def run_ffmpeg(path: str) -> list[str]:
    command = [
        # 100ms 마다 찍는 프레임 기록은 verbose 에서만 나온다
        "ffmpeg", "-nostdin", "-hide_banner", "-nostats", "-loglevel", "verbose",
        "-i", path,
        "-map", "a:0",
        "-af", "ebur128=framelog=verbose",
        "-f", "null", "-",
    ]
    result = subprocess.run(command, capture_output=True, text=True, check=False)
    if result.returncode != 0:
        tail = result.stderr.strip().splitlines()[-3:]
        raise RuntimeError(f"ffmpeg 실패({result.returncode}): {' / '.join(tail)}")
    return result.stderr.splitlines()


def file_sha256(path: str) -> str:
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def measure(entry: dict[str, object], cache_dir: str) -> dict[str, object]:
    clip_asset_id = int(entry["clipAssetId"])  # type: ignore[arg-type]
    storage_key = str(entry["storageKey"])
    if "/" in storage_key or storage_key.startswith("."):
        raise ValueError(f"storageKey 가 올바르지 않음: {storage_key}")
    path = os.path.join(cache_dir, storage_key)
    if not os.path.isfile(path):
        raise FileNotFoundError(f"캐시에 파일이 없음: {storage_key}")
    expected_sha = str(entry["sha256"])
    actual_sha = file_sha256(path)
    if actual_sha != expected_sha:
        raise ValueError(f"sha256 이 다름: {storage_key}")
    duration_ms = int(entry["durationMs"])  # type: ignore[arg-type]

    frames = parse_frames(run_ffmpeg(path))
    absolute = fill_edges(sample_curve(frames, duration_ms))
    if absolute is None:
        raise ValueError(f"잰 값이 없음(무음이거나 소리 트랙 없음): {storage_key}")
    return {
        "clipAssetId": clip_asset_id,
        "analyzerVersion": ANALYZER_VERSION,
        "clipSha256": actual_sha,
        **summarize(absolute, duration_ms),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--manifest", required=True)
    parser.add_argument("--cache-dir", required=True)
    parser.add_argument("--limit", type=int, default=None)
    args = parser.parse_args()

    with open(args.manifest, encoding="utf-8") as handle:
        entries = [json.loads(line) for line in handle if line.strip()]
    if args.limit is not None:
        entries = entries[: args.limit]

    failures = 0
    for number, entry in enumerate(entries, start=1):
        try:
            result = measure(entry, args.cache_dir)
        except Exception as error:  # noqa: BLE001 - 한 클립이 실패해도 나머지는 잰다
            failures += 1
            print(f"# 실패 {entry.get('clipAssetId')}: {error}", file=sys.stderr, flush=True)
            continue
        print(json.dumps(result, ensure_ascii=False, separators=(",", ":")), flush=True)
        if number % 25 == 0:
            print(f"# {number}/{len(entries)}", file=sys.stderr, flush=True)

    print(f"# 끝: {len(entries) - failures}/{len(entries)} 성공, {failures} 실패", file=sys.stderr, flush=True)
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
