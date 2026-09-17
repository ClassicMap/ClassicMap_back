"""영상에서 음악이 실제로 시작하고 끝나는 지점을 찾는다.

박수와 음악은 음량으로 구분되지 않는다. 둘 다 크다.
구분되는 것은 화성 구조다. 박수는 넓은 대역에 퍼진 잡음이고
음악은 배음이 정렬된 소리다. 조성 성분만 남겨 놓고 경계를 찾는다.

여기 있는 상수는 실측으로 맞춘 값이다. 근거는 references/02-detection.md 에 있다.
바꾸기 전에 그 문서를 읽고, 바꾼 뒤에는 교차 정렬로 결과를 확인한다.

detect(video_id) 를 부르면 (시작초, 끝초) 를 돌려준다.
오디오는 BASE 디렉터리의 <video_id>.wav 에서 읽는다.
"""
import os
import sys
import numpy as np
import librosa
import scipy.ndimage

SR, HOP = 22050, 512
MIN_MUSIC_SECONDS = 25.0
# 오디오와 중간 캐시가 놓이는 곳. run_*.py 가 --work-dir 로 정한다.
BASE = os.environ.get("COMPARISON_WORK_DIR",
                      os.path.dirname(os.path.abspath(__file__)))



def load(vid):
    cache = os.path.join(BASE, f"{vid}.y.npy")
    if os.path.exists(cache):
        return np.load(cache)
    y, _ = librosa.load(os.path.join(BASE, f"{vid}.wav"), sr=SR, mono=True)
    np.save(cache, y)
    return y


def tonal_envelope(vid, y):
    """조성 성분만 남긴 에너지 곡선. 박수는 여기서 크게 줄어든다.

    조화 성분 분리가 느려서 영상마다 한 번만 계산하고 저장한다.
    """
    cache = os.path.join(BASE, f"{vid}.tonal.npy")
    if os.path.exists(cache):
        return np.load(cache)
    harmonic = librosa.effects.harmonic(y, margin=3.0)
    rms = librosa.feature.rms(y=harmonic, hop_length=HOP)[0]
    env = scipy.ndimage.uniform_filter1d(rms, size=int(0.5 * SR / HOP))
    np.save(cache, env)
    return env


def clap_mask(vid, y, frames):
    """박수 구간. 넓은 대역에 고르게 퍼진 소리가 크게 들리는 곳이다."""
    cache = os.path.join(BASE, f"{vid}.clap.npy")
    if os.path.exists(cache):
        mask = np.load(cache)
    else:
        flat = librosa.feature.spectral_flatness(y=y, hop_length=HOP)[0]
        rms = librosa.feature.rms(y=y, hop_length=HOP)[0]
        db = librosa.amplitude_to_db(rms, ref=np.max)
        mask = (flat > np.percentile(flat, 93)) & (db > -38)
        mask = scipy.ndimage.binary_closing(mask, np.ones(int(1.5 * SR / HOP)))
        mask = scipy.ndimage.binary_opening(mask, np.ones(int(1.0 * SR / HOP)))
        np.save(cache, mask)
    if len(mask) < frames:
        mask = np.pad(mask, (0, frames - len(mask)))
    return mask[:frames]


def refine_start(y, coarse_frame, clap, look_back=20.0):
    """조성 곡선이 잡은 시작 앞을 원본 음량으로 훑어 첫 음을 찾는다."""
    rms = librosa.feature.rms(y=y, hop_length=HOP)[0]
    back = int(look_back * SR / HOP)
    lo = max(coarse_frame - back, 0)
    window = rms[lo:coarse_frame + 1]
    if window.size < 3:
        return coarse_frame
    # 그 자리에서 실제로 나는 소리의 세기를 기준으로 삼는다.
    ahead = rms[coarse_frame:coarse_frame + int(5.0 * SR / HOP)]
    if ahead.size == 0:
        return coarse_frame
    level = float(np.median(ahead))
    if level <= 0:
        return coarse_frame
    floor = float(np.percentile(rms[lo:coarse_frame + 1], 10))
    gate = floor + (level - floor) * 0.25

    frame = coarse_frame
    for i in range(window.size - 1, -1, -1):
        absolute = lo + i
        if clap[absolute] or window[i] < gate:
            break
        frame = absolute
    return frame


def detect(vid, y=None):
    y = load(vid) if y is None else y
    env = tonal_envelope(vid, y)
    t = librosa.frames_to_time(np.arange(len(env)), sr=SR, hop_length=HOP)

    # 곡의 본체에서 조성 에너지가 어느 수준인지 먼저 잡는다.
    body = float(np.percentile(env, 70))
    floor = float(np.percentile(env, 5))
    threshold = floor + (body - floor) * 0.18

    loud = env > threshold
    # 박수는 조성 성분을 남기기도 하므로 따로 빼 준다.
    clap = clap_mask(vid, y, len(loud))
    loud &= ~clap
    # 악장 사이 휴지나 여린 대목으로 곡이 토막나지 않게 넉넉히 메운다.
    loud = scipy.ndimage.binary_closing(loud, np.ones(int(12.0 * SR / HOP)))
    loud = scipy.ndimage.binary_opening(loud, np.ones(int(1.0 * SR / HOP)))

    # 해설·인트로가 붙은 영상은 앞쪽에도 조성 성분이 잡힌다.
    # 말소리는 길게 이어지지 않으므로, 충분히 긴 구간 중 가장 이른 것을 곡으로 본다.
    spans, run_start = [], None
    for i, on in enumerate(loud):
        if on and run_start is None:
            run_start = i
        elif not on and run_start is not None:
            spans.append((run_start, i))
            run_start = None
    if run_start is not None:
        spans.append((run_start, len(loud)))
    if not spans:
        return None, None

    min_frames = int(MIN_MUSIC_SECONDS * SR / HOP)
    long_spans = [s for s in spans if s[1] - s[0] >= min_frames]
    chosen = long_spans[0] if long_spans else max(spans, key=lambda s: s[1] - s[0])
    start_frame = chosen[0]
    # 조성 곡선은 평활화 때문에 시작이 뒤로 밀린다.
    # 대략 위치만 받아 두고 정확한 첫 음은 원본 음량으로 되짚는다.
    start_frame = refine_start(y, start_frame, clap)
    # 끝은 마지막으로 이어지는 긴 구간의 끝으로 본다.
    end_frame = (long_spans[-1][1] if long_spans else chosen[1])
    end_frame = min(end_frame, len(t) - 1)

    # 경계를 음 하나 단위로 다듬는다.
    onset_env = librosa.onset.onset_strength(y=y, sr=SR, hop_length=HOP)
    onsets = librosa.onset.onset_detect(onset_envelope=onset_env, sr=SR,
                                        hop_length=HOP, backtrack=True)
    onset_times = librosa.frames_to_time(onsets, sr=SR, hop_length=HOP)

    start = float(t[start_frame])
    near = onset_times[(onset_times >= start - 1.0) & (onset_times <= start + 1.5)]
    if near.size:
        start = float(near[0])
    return start, float(t[end_frame])
