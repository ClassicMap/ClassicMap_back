---
name: comparison-seed
description: ClassicMap 비교 영상 시드를 한 배치씩 만든다. 곡과 연주를 고르고, 오디오에서 구간을 검출하고, 교차 정렬로 같은 음악인지 확인하고, 적재·발행·배포까지 간다. 비교 영상·comparison seed·연주 비교·클립 시드 작업에 쓴다.
---

# 비교 영상 시드

한 곡에 연주 3종을 붙여 같은 대목을 나란히 듣게 만드는 일이다.
**구간이 정확해야 한다.** 시작도 끝도 정확한 음에서 맺혀야 하고, 연주마다 템포가
다르니 초를 옮겨 적는 것으로는 맞출 수 없다.

## 이 일의 핵심

세 가지가 순서대로 맞아야 한다. 하나라도 어긋나면 뒤가 무의미하다.

1. **연주 3종을 구할 수 있는 곡인가** — 여기서 대부분 막힌다
2. **구간이 정확한가** — 오디오에서 찾는다. 눈으로 스펙트로그램을 보는 것보다 정확하다
3. **셋이 같은 음악인가** — 교차 정렬로 잰다. 길이나 편성으로는 판정할 수 없다

## 작업 순서

```
곡 고르기 → 충돌 검사 → 영상 찾기 → 오디오 받기 → 구간 검출
   → 교차 정렬 → (어긋나면 진단·교체) → 후보 JSONL
   → 식별자 마이그레이션 → 적재 → 발행 마이그레이션
   → 클립 선생성 → 클립 복사 → 자산 등록·발행 → 커밋 → CI → 배포
```

배치 하나는 **곡 2~3개, 연주 6~9건**이 알맞다. 더 늘리면 한 건이 어긋났을 때
되돌리는 비용이 커진다.

여러 배치를 이어서 돌릴 때는 **배치마다 서브에이전트에 맡긴다.** 검출·정렬 출력이
컨텍스트에 쌓이지 않아 훨씬 싸고, 둘셋을 동시에 돌릴 수 있다. 다만 **DB 에 쓰는
일은 넘기지 않는다.** 나누는 선은 `references/06-subagent.md` 에 있다.

## 먼저 읽을 것

| 단계 | 문서 |
|---|---|
| 곡과 연주를 고를 때 | `references/01-selection.md` |
| 구간을 검출할 때 | `references/02-detection.md` |
| 정렬이 어긋났을 때 | `references/03-verification.md` |
| 적재·발행할 때 | `references/04-loading.md` |
| 막혔을 때 | `references/05-pitfalls.md` |
| 배치를 서브에이전트에 맡길 때 | `references/06-subagent.md` |
| 20분 넘는 곡을 발췌할 때 | `references/07-excerpt.md` |

## 배치 정의

`scripts/example-batch.json` 을 복사해 쓴다. 이 파일 하나로 검출부터 후보
생성까지 돌아간다.

```bash
export COMPARISON_WORK_DIR=<스크래치패드>/comparison
cd .claude/skills/comparison-seed/scripts

./fetch_videos.sh batch.json          # 오디오와 메타
uv run --python 3.12 --with numpy --with scipy --with librosa \
  python run_detect.py batch.json     # 구간 검출
uv run ... python run_excerpt.py batch.json  # 발췌만 쓸 때(07-excerpt.md)
uv run ... python run_verify.py batch.json   # 교차 정렬 — 여기서 걸러진다
python3 build_candidates.py batch.json       # 적재용 JSONL
```

`run_verify.py` 가 임계를 넘는 쌍을 알리면 **넘어가지 말고** 원인을 가린다.
**세 쌍이 모두 넘으면** 한 연주가 아니라 곡이 문제다. 반복 구조가 연주마다
갈리는 곡이므로 그 구간을 포기하고 다른 악장이나 다른 곡으로 간다.

```bash
uv run ... python run_diagnose.py batch.json <pieceId> <videoId>
```

## 판정 기준

정렬 비용 **0.11** 이 임계다. 통과한 배치는 대개 0.04~0.09 에 모인다.

임계 아래라도 **같은 곡의 다른 쌍보다 눈에 띄게 높으면** 진단한다.
0.10 대에서 통과시킨 뒤 나중에 판본이 다른 것으로 드러난 적이 여러 번 있다.

**길이로는 판정하지 않는다.** 1.35배 차이 나는데 0.05 로 통과한 경우가 있고,
길이가 비슷한데 판본이 달라 걸린 경우도 있다. 화성 진행만이 근거다.

## 하지 않는 것

- **구간을 억지로 맞추지 않는다.** 비용이 내려가는 지점을 찾았더라도 그 값이
  음악적 경계가 아니면 연주를 교체한다.
- **작곡가 QID 를 추측하지 않는다.** DB 의 `composers` 에서 읽는다.
- **낱곡 work 을 함부로 쓰지 않는다.** 모음곡의 한 곡이면 전체 work 에 sector 로
  붙인다. 이유는 `01-selection.md` 에 있다.
- **권리를 확보했다고 적지 않는다.** `licensed_self_hosted` 는 내부 검증 표기일
  뿐이고, 마이그레이션마다 그 사실을 남긴다.
