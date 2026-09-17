"""구간이 같은 음악인지 재고, 어긋나면 원인을 가린다.

같은 곡의 같은 구간이라면 연주가 달라도 화성 진행이 맞물린다.
템포나 편성이 달라도 맞물린다. 맞물리지 않으면 검출이 틀렸거나 다른 음악이다.

판정 기준과 어긋남의 네 가지 모양은 references/03-verification.md 에 있다.
"""
import os

import numpy as np
import librosa

SR, HOP = 22050, 512
# 실측으로 정한 임계. 이 값을 넘으면 사람이 원인을 가려야 한다.
COST_THRESHOLD = 0.11
BASE = os.environ.get("COMPARISON_WORK_DIR",
                      os.path.dirname(os.path.abspath(__file__)))


def chroma(video_id, start, end):
    """구간의 화성 윤곽. 음색과 가사는 여기서 대부분 사라진다."""
    path = os.path.join(BASE, f"{video_id}.y.npy")
    y = np.load(path) if os.path.exists(path) else librosa.load(
        os.path.join(BASE, f"{video_id}.wav"), sr=SR, mono=True)[0]
    a, b = max(int(start * SR), 0), min(int(end * SR), len(y))
    c = librosa.feature.chroma_cens(y=y[a:b], sr=SR, hop_length=HOP)
    c = librosa.util.normalize(c, norm=2, axis=0)
    # 완전 무음 프레임은 0벡터라 코사인 거리가 정의되지 않고 DTW 가 NaN 으로 죽는다.
    # 화성이 없다는 뜻으로 12음을 고르게 채운다. 음악과는 멀어지므로 경계를 훑을 때
    # 무음을 끌어들이면 비용이 오르는 것이 그대로 드러난다.
    silent = ~c.any(axis=0)
    c[:, silent] = 1.0 / np.sqrt(c.shape[0])
    return c


def cost(left, right):
    """두 화성 윤곽을 늘여 맞췄을 때 남는 거리. 경로 길이로 나눠 길이 영향을 지운다."""
    distance, path = librosa.sequence.dtw(
        X=left.astype(np.float32), Y=right.astype(np.float32),
        metric="cosine", subseq=False)
    return float(distance[-1, -1]) / len(path)


def pair_costs(spans):
    """[(video_id, start, end)] 의 모든 쌍 비용. [(i, j, 비용)] 로 돌려준다."""
    features = {vid: chroma(vid, start, end) for vid, start, end in spans}
    out = []
    for i in range(len(spans)):
        for j in range(i + 1, len(spans)):
            out.append((i, j, cost(features[spans[i][0]], features[spans[j][0]])))
    return out


def thirds(video_id, start, end):
    """구간을 셋으로 나눈 화성 윤곽. 앞뒤만 나쁘면 경계를 의심한다."""
    step = (end - start) / 3
    return [chroma(video_id, start + k * step, start + (k + 1) * step)
            for k in range(3)]


def sweep_edge(video_id, start, end, references, edge="end",
               span=(-6.0, 17.0), step=2.5):
    """한쪽 경계를 훑어 비용이 어떻게 움직이는지 본다.

    references 는 {이름: 화성윤곽} 이다.
    돌려주는 것은 [(경계값, {이름: 비용})] 이고, 곡선의 모양으로 원인을 가린다.
    """
    rows = []
    for delta in np.arange(span[0], span[1], step):
        s, e = (start, end + delta) if edge == "end" else (max(start + delta, 0.0), end)
        if e - s < 20.0:
            continue
        feature = chroma(video_id, s, e)
        rows.append((float(e if edge == "end" else s),
                     {name: cost(feature, ref) for name, ref in references.items()}))
    return rows


def sweep_pitch(video_id, start, end, reference):
    """12방향으로 돌려 본다. 특정 회전에서 뚝 떨어지면 이조다.

    성악에서 한 번씩 나온다. 연주자가 음역에 맞춰 조를 옮기기 때문이다.
    """
    feature = chroma(video_id, start, end)
    return [(shift, cost(np.roll(feature, shift, axis=0), reference))
            for shift in range(12)]
