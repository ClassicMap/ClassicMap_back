# 추천 작품 속성 2026-10-04

비교할 수 있는 작품 211곡의 추천 속성이다. 결과는 `features.jsonl` 이고,
`load_piece_reco_features` 가 `piece_reco_features` 에 넣는다. 홈 추천과 온보딩 '아는 곡' 카드가 쓴다.

## 값

| 열 | 값 | 기준 |
|---|---|---|
| `leadSound` | piano · orchestra · strings · winds · voice · ensemble | 귀에 먼저 들어오는 소리. 협주곡은 독주 악기, 오페라·가곡·합창곡은 voice, 현악 4중주·피아노 3중주처럼 주인공이 없으면 ensemble |
| `scale` | solo · chamber · large | solo 는 혼자 또는 반주와 둘(가곡 포함), chamber 는 작은 앙상블, large 는 오케스트라·합창 |
| `familiarity` | everyone · known · deep | everyone 은 클래식을 안 들어도 아는 선율, known 은 즐겨 듣는 사람이면 아는 곡, deep 은 애호가 곡. 한국 청중 기준(교과서·광고·피겨 음악 포함) |
| `startSectorKey` | 구간 키 | 처음 듣는 사람에게 먼저 열 구간. 구간이 둘 이상인 9곡만 정했다 |
| `onboardingOrder` | 1~12 | 온보딩 '아는 곡' 카드. 피아노 3 · 오케스트라 5 · 현악기 1 · 목소리 2 · 앙상블 1 |
| `reviewStatus` | DRAFT · CONFIRMED | 사람이 확인하면 CONFIRMED. 추천은 둘 다 쓴다 |

## 차례

1. 211곡 목록은 공개 비교 작품 SELECT(`src/comparison/repository.rs` 의 `PUBLIC_COMPARISON_CTE`)로 뽑았다
2. 초안은 큐레이터가 작품마다 정했다. 주 연주자 분류로 추론한 편성은 협주곡·피아노 5중주에서 틀려 쓰지 않았다
3. 이 디렉터리에 커밋하고 배포한다(이미지의 `/app/seed/` 로 들어간다)
4. `deploy/reco-features-load-job.yaml` 로 dry-run → 적재 → dry-run(계획 변경 0)
5. 사람이 고친 값은 이 파일에서 고치고 `reviewStatus` 를 CONFIRMED 로 바꿔 다시 적재한다

## 결과 (2026-10-04 초안)

- 주인공 소리: orchestra 83 · piano 62 · voice 27 · strings 19 · ensemble 15 · winds 5
- 편성 규모: large 133 · solo 63 · chamber 15
- 친숙도: known 96 · deep 61 · everyone 54
