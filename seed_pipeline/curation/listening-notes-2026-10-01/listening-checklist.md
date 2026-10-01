# 들어 볼 목록 — 연주 노트·추천 비교 초안 30구간

> **2026-10-01 결정: 듣기 확인 없이 초안대로 공개했어요.** 지금 목적은 시드 채우기예요.
>
> - 공개: 구간 안내를 확정한 21구간의 연주 노트·추천 비교 전부(`notes.jsonl`, PUBLISHED). 아래 "먼저 정할 것" 표의 짝도 고른 그대로 공개했어요
> - DRAFT 로 남김: 보류 9구간(81, 84, 85, 181, 83, 86, 82, 38, 190)의 노트·추천 비교, 37 시시킨 노트(잰 값 근거 없음). `notes-draft.jsonl` 에만 있어요
> - 공개한 노트·추천 비교의 `evidence` 에 `{"kind":"listening","status":"skipped","at":"2026-10-01"}` 를 남겼어요. 나중에 들어 보고 고칠 대상은 이 표시로 찾아요
>
>   ```sql
>   SELECT performance_id FROM performance_listening_notes
>   WHERE JSON_CONTAINS(evidence, '{"kind":"listening","status":"skipped"}');
>   SELECT sector_id FROM sector_featured_pairs
>   WHERE JSON_CONTAINS(evidence, '{"kind":"listening","status":"skipped"}');
>   ```
>
> 이 목록은 그대로 둬요. 들어 보고 고칠 때 이 질문으로 시작해요. 고친 줄은 `notes.jsonl` 에서 바로 고치고, 들었으면 `skipped` 를 `done` 으로 바꿔 다시 적재해요.

초안(`performance-notes-drafts.md`, `notes-draft.jsonl`)에서 `들어 봐야 함` 으로 남은 것과, 구간 안내를 보류한 9구간의 질문이에요.
구간마다 앱 링크로 열고, 시점 링크는 그 클립을 그 초부터 틀어요. 답을 적어 주면 초안을 고쳐 PUBLISHED 로 적재해요.

## 먼저 정할 것: 추천 쌍

추천 쌍은 곡선 모양 차이가 가장 큰 짝(1순위)을 기본으로 골랐어요. 아래 구간은 차이가 클립 경계나 녹음 탓으로 보여 다른 짝을 골랐거나, 대비가 약해요. 들어 보고 짝을 정해 주세요.

| 구간 | 고른 짝 | 1순위를 안 고른 까닭 / 걸리는 점 |
|---|---|---|
| 29 술래잡기 | 아르헤리치 ↔ 호로비츠 (2순위) | 1순위(안스네스 ↔ 아르헤리치) 차이 대부분이 안스네스 끝 2초 무음 |
| 87 발라드 1번 서주·제1주제 | 짐머만 ↔ 루빈스타인 (2순위) | 1순위(키신 ↔ 호로비츠) 차이가 호로비츠 처음 5초에서 나옴. 박수·잡음일 수 있음 |
| 69 월광 3악장 | 키신 ↔ 리시차 (2순위) | 1순위(폴리니 ↔ 키신) 차이가 폴리니 5:49~5:58 의 9초 무음(−34.9dB)에 기댐. 클립 경계가 아니라 녹음 틈으로 본 에이전트 판단이라 꼭 봐 주세요 |
| 70 비창 3악장 | 레비트 ↔ 길렐스 (3순위) | 1·2순위 차이가 마지막 10%에 몰림. 레비트 끝 11초 무음 |
| 40 운명 4악장 | 클라이버 ↔ 틸레만 (3순위) | 1·2순위가 정명훈 첫 4초 여린 소리(3악장에서 넘어오는 다리일 수 있음)에서만 갈림 |
| 86 라흐 2 · 3악장 | 조성진 ↔ 페도로바 (3순위) | 1순위 차이가 출발점뿐이고 유자 왕 클립만 11초 짧음 |
| 181 편지 이중창 | 아르농쿠르 ↔ 아바도 (3순위) | 1·2순위 차이가 무티 클립 앞 0:00~0:17 여분 탓 |
| 36 라 캄파넬라 도입 | 랑랑 ↔ 시시킨 | 2순위(키신 ↔ 시시킨)와 거의 동점 |
| 167 밤의 여왕 아리아 | 미클로샤 ↔ 그루베로바 | 2순위(미클로샤 ↔ 조수미)와 거의 동점 |
| 81 라흐 3 · 2악장, 85 라흐 2 · 2악장, 38 차이콥스키 코다, 75 아이네 클라이네 | 1순위 | 곡선 차이가 작아 대비가 약함. 들어 보고 약하면 추천 비교를 빼도 돼요 |

## 36 리스트 파가니니 주제에 의한 대연습곡 3번 "라 캄파넬라" · 도입 종소리 음형

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=140&sectorId=36

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 예브게니 키신 | [0:46](https://kang1027.com/classicmap/clips/0FbQZCsYXVg?end=77&profile=v1-copy&start=17#t=46) | 0:46 이 주제가 가장 크게 펼쳐지는 곳으로 들리나요? |  |
| 예브게니 키신 | [0:03](https://kang1027.com/classicmap/clips/0FbQZCsYXVg?end=77&profile=v1-copy&start=17#t=3) | 0:03~0:08 의 조용한 대목이 종소리 뒤 잠깐 멈추는 곳인가요? |  |
| 랑랑 | [0:42](https://kang1027.com/classicmap/clips/cIxGUAnj46U?end=72&profile=v1-copy&start=7#t=42) | 0:42 까지 세기가 악구마다 올랐다 내려갔다 하나요, 아니면 한 줄로 커지나요? |  |
| 랑랑 | [0:58](https://kang1027.com/classicmap/clips/cIxGUAnj46U?end=72&profile=v1-copy&start=7#t=58) | 0:58 이후 내려앉는 게 연주인가요, 클립 끝 여분(다음 변주 앞 쉼) 탓인가요? |  |
| 드미트리 시시킨 | [0:16](https://kang1027.com/classicmap/clips/kkq_3CrvFUM?end=70&profile=v1-copy&start=6#t=16) | 0:16 무렵 이미 크게 치고 있나요, 아니면 여린 소리 그대로인데 곡선만 올랐나요? |  |
| 드미트리 시시킨 | [0:16](https://kang1027.com/classicmap/clips/kkq_3CrvFUM?end=70&profile=v1-copy&start=6#t=16) | 주제 선율이 뛰는 손 사이로 또렷하게 이어지나요? |  |
| 랑랑 · 드미트리 시시킨 | 0:16 / 0:42 | 두 곳을 번갈아 들으면 '물결 vs 일찍 올라 버티기' 차이가 들리나요? 아니면 키신↔시시킨이 더 선명한가요? |  |
| 예브게니 키신 | [1:00](https://kang1027.com/classicmap/clips/0FbQZCsYXVg?end=77&profile=v1-copy&start=17#t=60) | 키신 클립(60초)이 다른 둘(64·65초)보다 짧은데, 같은 곳(첫 변주 끝)에서 끝나나요? |  |

## 37 리스트 파가니니 주제에 의한 대연습곡 3번 "라 캄파넬라" · 종결 클라이맥스

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=140&sectorId=37

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 드미트리 시시킨 | [0:00](https://kang1027.com/classicmap/clips/kkq_3CrvFUM?end=272&profile=v1-copy&start=247#t=0) | 0:00 상행 질주부터 마지막 화음까지 중간에 숨 돌리는 곳 없이 이어지나요? |  |
| 드미트리 시시킨 | [0:03](https://kang1027.com/classicmap/clips/kkq_3CrvFUM?end=272&profile=v1-copy&start=247#t=3) | 키신처럼 처음부터 최대인가요, 랑랑처럼 끝으로 갈수록 쌓나요, 둘 다 아닌가요? |  |
| 드미트리 시시킨 | [0:25](https://kang1027.com/classicmap/clips/kkq_3CrvFUM?end=272&profile=v1-copy&start=247#t=25) | 곡선이 평평한 게 녹음 압축 탓으로 들리나요(셈여림 차이가 실제로는 들리나요)? |  |

## 87 쇼팽 발라드 1번 G단조 · 서주 & 제1주제

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=129&sectorId=87

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 예브게니 키신 | [0:30](https://kang1027.com/classicmap/clips/SlJEjza0-FQ?end=198&profile=v1-copy&start=2#t=30) | 서주 끝 화음에서 다른 연주보다 오래 머무나요? |  |
| 예브게니 키신 | [1:40](https://kang1027.com/classicmap/clips/SlJEjza0-FQ?end=198&profile=v1-copy&start=2#t=100) | 1:40 부터 2:32 까지 계단처럼 단계적으로 커지나요? |  |
| 크리스티안 짐머만 | [1:50](https://kang1027.com/classicmap/clips/YYUu4Rl7EdE?end=188&profile=v1-copy&start=4#t=110) | 1:50~2:08 의 가라앉음이 다음 오르막 앞의 숨처럼 들리나요? |  |
| 크리스티안 짐머만 | [2:08](https://kang1027.com/classicmap/clips/YYUu4Rl7EdE?end=188&profile=v1-copy&start=4#t=128) | 실제로 오르기 시작하는 시점이 2:08 근처인가요(±10초)? |  |
| 블라디미르 호로비츠 | [0:00](https://kang1027.com/classicmap/clips/eG1Olvh7vCU?end=166&profile=v1-copy&start=0#t=0) | 처음 5초에 박수나 잡음이 섞여 있나요, 아니면 서주 소리뿐인가요? |  |
| 블라디미르 호로비츠 | [0:02](https://kang1027.com/classicmap/clips/eG1Olvh7vCU?end=166&profile=v1-copy&start=0#t=2) | 서주 첫 옥타브를 무겁고 세게 긋나요? |  |
| 블라디미르 호로비츠 | [2:46](https://kang1027.com/classicmap/clips/eG1Olvh7vCU?end=166&profile=v1-copy&start=0#t=166) | 클립 끝이 다른 연주와 같은 곳(제2주제 바로 앞)에서 끝나나요? 88 시작까지 원본 17초가 비어요 |  |
| 조성진 | [0:14](https://kang1027.com/classicmap/clips/taY5oHleS4I?end=196&profile=v1-copy&start=4#t=14) | 0:14~1:22 사이에 서주 끝 화음 뒤 소리가 거의 끊기는 긴 쉼이 있나요? |  |
| 조성진 | [2:42](https://kang1027.com/classicmap/clips/taY5oHleS4I?end=196&profile=v1-copy&start=4#t=162) | 2:42 가 이 대목에서 가장 크게 터지는 곳으로 들리나요? |  |
| 아르투르 루빈스타인 | [1:12](https://kang1027.com/classicmap/clips/l7GtUKE-Ju0?end=171&profile=v1-copy&start=0#t=72) | 1:12~2:00 이 고른 세기로 이어지나요, 아니면 그 안에서도 크게 오르내리나요? |  |
| 아르투르 루빈스타인 | [0:00](https://kang1027.com/classicmap/clips/l7GtUKE-Ju0?end=171&profile=v1-copy&start=0#t=0) | 처음 몇 초에 박수나 잡음이 섞여 있나요(원본 0초 시작)? |  |
| 짐머만 · 루빈스타인 | 2:08 / 1:12 | 번갈아 들으면 '물러섰다 단번에 vs 한 층 올려 이어 가기' 가 들리나요? 아니면 키신↔호로비츠가 더 선명한가요? |  |

## 71 쇼팽 발라드 1번 G단조 · 전곡

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=129&sectorId=71

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 마우리치오 폴리니 | [5:24](https://kang1027.com/classicmap/clips/06-puNWFuMQ?end=508&profile=v1-copy&start=4#t=324) | 5:24 가 제2주제가 ff 로 돌아오는 곳인가요? 첫째인가요, 둘째인가요? |  |
| 마우리치오 폴리니 | [5:52](https://kang1027.com/classicmap/clips/06-puNWFuMQ?end=508&profile=v1-copy&start=4#t=352) | 5:52 이후 마지막 3분이 크게 가라앉지 않고 이어지나요? |  |
| 아르투르 루빈스타인 | [9:09](https://kang1027.com/classicmap/clips/djWwjF11xgs?end=552&profile=v1-copy&start=1#t=549) | 9:09 의 가장 센 소리가 종결 화음인가요, 박수인가요? |  |
| 아르투르 루빈스타인 | [8:15](https://kang1027.com/classicmap/clips/djWwjF11xgs?end=552&profile=v1-copy&start=1#t=495) | 마지막 화음이 곡 전체에서 가장 크게 들리나요? |  |
| 아르투르 루빈스타인 | [9:11](https://kang1027.com/classicmap/clips/djWwjF11xgs?end=552&profile=v1-copy&start=1#t=551) | 클립 끝에 잔향 말고 다른 소리(박수·무음)가 길게 붙어 있나요? |  |
| 블라디미르 아슈케나지 | [0:00](https://kang1027.com/classicmap/clips/rHDPbP6_ue0?end=532&profile=v1-copy&start=3#t=0) | 처음 1분 반이 다른 두 연주보다 귀로도 확연히 여리게 들리나요, 아니면 녹음 레벨 차이 정도인가요? |  |
| 블라디미르 아슈케나지 | [6:10](https://kang1027.com/classicmap/clips/rHDPbP6_ue0?end=532&profile=v1-copy&start=3#t=370) | 6:10~7:03 이 제1주제가 G단조로 돌아오는 대목인가요? |  |
| 블라디미르 아슈케나지 | [7:58](https://kang1027.com/classicmap/clips/rHDPbP6_ue0?end=532&profile=v1-copy&start=3#t=478) | 7:58 이 코다(Presto con fuoco) 안인가요? |  |
| 폴리니 · 아슈케나지 | 5:24 / 7:58 | 번갈아 들으면 '한가운데 정점 vs 끝자락 정점' 이 들리나요? |  |

## 88 쇼팽 발라드 1번 G단조 · 제2주제

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=129&sectorId=88

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 예브게니 키신 | [0:02](https://kang1027.com/classicmap/clips/SlJEjza0-FQ?end=309&profile=v1-copy&start=199#t=2) | 첫머리가 악보의 '속삭이듯 아주 여리게' 로 들리나요, 아니면 처음부터 또렷하게 노래하나요? |  |
| 예브게니 키신 | [1:06](https://kang1027.com/classicmap/clips/SlJEjza0-FQ?end=309&profile=v1-copy&start=199#t=66) | 1:06~1:28 에서 같은 선율이 다시 시작되며 세기를 낮추나요? |  |
| 예브게니 키신 | [1:40](https://kang1027.com/classicmap/clips/SlJEjza0-FQ?end=309&profile=v1-copy&start=199#t=100) | 1:40 이 이 클립에서 가장 크게 들리는 곳인가요? |  |
| 크리스티안 짐머만 | [0:00](https://kang1027.com/classicmap/clips/YYUu4Rl7EdE?end=281&profile=v1-copy&start=188#t=0) | 처음 15초의 세 번 잦아드는 곳(0:00~0:04, 0:08, 0:14)이 악구 사이 숨인가요? |  |
| 크리스티안 짐머만 | [0:56](https://kang1027.com/classicmap/clips/YYUu4Rl7EdE?end=281&profile=v1-copy&start=188#t=56) | 0:56 이 가장 크게 들리나요, 아니면 끝(1:23~)이 비슷하게 큰가요? |  |
| 블라디미르 호로비츠 | [0:00](https://kang1027.com/classicmap/clips/eG1Olvh7vCU?end=256&profile=v1-copy&start=183#t=0) | 클립 첫 음이 제2주제의 첫 음인가요? 87 끝과 원본 17초가 비어요 |  |
| 블라디미르 호로비츠 | [0:50](https://kang1027.com/classicmap/clips/eG1Olvh7vCU?end=256&profile=v1-copy&start=183#t=50) | 0:50 무렵 가라앉은 뒤 같은 선율이 다시 시작되나요? |  |
| 조성진 | [0:00](https://kang1027.com/classicmap/clips/taY5oHleS4I?end=294&profile=v1-copy&start=195#t=0) | 0:00~0:04 의 조용한 곳이 실제 여린 첫 음인가요, 첫 음 앞 무음인가요? |  |
| 조성진 | [0:02](https://kang1027.com/classicmap/clips/taY5oHleS4I?end=294&profile=v1-copy&start=195#t=2) | 첫머리에서 눈에 띄게 늦추며 들어오나요? |  |
| 키신 · 조성진 | 0:02 / 0:02 | 번갈아 들으면 첫머리 세기 차이가 귀로도 들리나요, 아니면 녹음 레벨 차이 정도인가요? |  |

## 89 쇼팽 발라드 1번 G단조 · 코다

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=129&sectorId=89

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 예브게니 키신 | [1:12](https://kang1027.com/classicmap/clips/SlJEjza0-FQ?end=588&profile=v1-copy&start=480#t=72) | 1:12와 1:25에 세기가 내려가는 곳이 쉼(멈춤)인가요, 여리게 치는 대목인가요? |  |
| 예브게니 키신 | [1:32](https://kang1027.com/classicmap/clips/SlJEjza0-FQ?end=588&profile=v1-copy&start=480#t=92) | 1:32 이후 1:40까지 점점 쌓아 올리나요, 한 번에 터지나요? |  |
| 크리스티안 짐머만 | [1:02](https://kang1027.com/classicmap/clips/YYUu4Rl7EdE?end=564&profile=v1-copy&start=469#t=62) | 1:02~1:08에 소리가 거의 멎나요, 아니면 아주 여리게 이어지나요? |  |
| 블라디미르 호로비츠 | [1:27](https://kang1027.com/classicmap/clips/eG1Olvh7vCU?end=518&profile=v1-copy&start=429#t=87) | 클립이 마지막 화음 울림이 끝나기 전에 끊기나요? |  |
| 블라디미르 호로비츠 | [1:16](https://kang1027.com/classicmap/clips/eG1Olvh7vCU?end=518&profile=v1-copy&start=429#t=76) | 1:16 이후 끝까지 쉬지 않고 몰아치는 느낌이 드나요? (예/아니오) |  |
| 블라디미르 호로비츠 | [1:02](https://kang1027.com/classicmap/clips/eG1Olvh7vCU?end=518&profile=v1-copy&start=429#t=62) | 1:02 조용한 대목이 조성진의 1:08 대목과 악보상 같은 자리인가요? |  |
| 조성진 | [1:08](https://kang1027.com/classicmap/clips/taY5oHleS4I?end=578&profile=v1-copy&start=469#t=68) | 1:08~1:14와 1:22~1:30이 쉼을 길게 둔 것인가요, 여린 연주가 이어지는 것인가요? |  |
| 아르투르 루빈스타인 | [0:00](https://kang1027.com/classicmap/clips/l7GtUKE-Ju0?end=550&profile=v1-copy&start=465#t=0) | 0:00 첫 소리가 다른 연주들의 첫 소리와 같은 음(코다 첫 마디)인가요? |  |
| 아르투르 루빈스타인 | [0:00](https://kang1027.com/classicmap/clips/l7GtUKE-Ju0?end=550&profile=v1-copy&start=465#t=0) | 다른 연주보다 빠르게 들리나요? (예/아니오) |  |

## 80 라흐마니노프 피아노 협주곡 3번 D단조 · 1악장 카덴차

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=226&sectorId=80

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 유자 왕 | [0:00](https://kang1027.com/classicmap/clips/5bX_yRzCuM4?end=765&profile=v1-copy&start=672#t=0) | 무거운 화음으로 쌓는 오시아 판인가요, 가볍게 달리는 원래 판인가요? |  |
| 임윤찬 | [0:51](https://kang1027.com/classicmap/clips/DPJL488cfRw?end=772&profile=v1-copy&start=670#t=51) | 0:51 무렵부터 거의 최대 세기로 올라서서 그대로 가나요? (예/아니오) |  |
| 임윤찬 | [0:00](https://kang1027.com/classicmap/clips/DPJL488cfRw?end=772&profile=v1-copy&start=670#t=0) | 오시아 판인가요, 원래 판인가요? |  |
| 랑랑 | [0:00](https://kang1027.com/classicmap/clips/KUbi0nEnUi4?end=821&profile=v1-copy&start=672#t=0) | 오시아 판인가요, 원래 판인가요? 다른 두 연주와 같은 곳에서 시작하나요? |  |
| 랑랑 | [2:20](https://kang1027.com/classicmap/clips/KUbi0nEnUi4?end=821&profile=v1-copy&start=672#t=140) | 클립 끝이 다른 두 연주의 끝과 같은 곳인가요, 더 뒤까지 담겼나요? |  |
| 랑랑 | [0:41](https://kang1027.com/classicmap/clips/KUbi0nEnUi4?end=821&profile=v1-copy&start=672#t=41) | 0:41 이후 세기는 비슷한데 결이 바뀌는 곳이 있나요? 있으면 몇 초인가요? |  |

## 81 라흐마니노프 피아노 협주곡 3번 D단조 · 2악장

- 구간 안내: **보류** — 악장 어디쯤인지 클립 위치로만 추정했어요. 어느 변주인지 몰라요
- 앱: https://kang1027.com/classicmap/compare?pieceId=226&sectorId=81

구간 안내 질문
- [ ] 이 클립은 2악장의 어느 대목인가요? 관현악이 주제를 들려준 뒤 피아노가 이어받는 첫 변주인가요?
- [ ] 클립 안에서 빠르기가 바뀌는 곳(더 빨라지거나 느려지는 곳)이 있나요? 있으면 몇 초인가요?
- [ ] D♭장조 쪽 큰 정점이나 피아노 혼자 치는 짧은 카덴차가 담겼나요?
- [ ] 세 클립이 같은 음에서 시작하나요? (랑랑 영상은 2악장 구간이 300초 남짓 이르게 잡혀 있음)

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 유자 왕 | [1:10](https://kang1027.com/classicmap/clips/5bX_yRzCuM4?end=1517&profile=v1-copy&start=1416#t=70) | 1:10에 가장 크게 울리는 것이 피아노인가요, 관현악인가요? |  |
| 유자 왕 | [1:10](https://kang1027.com/classicmap/clips/5bX_yRzCuM4?end=1517&profile=v1-copy&start=1416#t=70) | 유자 왕 1:10과 랑랑 1:24가 같은 악구인가요? |  |
| 임윤찬 | [0:00](https://kang1027.com/classicmap/clips/DPJL488cfRw?end=1516&profile=v1-copy&start=1428#t=0) | 다른 두 연주와 같은 음에서 시작하고 같은 곳에서 끝나나요? (예/아니오) |  |
| 임윤찬 | [0:58](https://kang1027.com/classicmap/clips/DPJL488cfRw?end=1516&profile=v1-copy&start=1428#t=58) | 다른 두 연주보다 빠르게 들리나요? (예/아니오) |  |
| 랑랑 | [1:24](https://kang1027.com/classicmap/clips/KUbi0nEnUi4?end=1215&profile=v1-copy&start=1113#t=84) | 1:24에 가장 크게 울리는 것이 피아노인가요, 관현악인가요? |  |
| 랑랑 | [0:00](https://kang1027.com/classicmap/clips/KUbi0nEnUi4?end=1215&profile=v1-copy&start=1113#t=0) | 다른 두 연주보다 세기 굴곡이 덜하게 들리나요, 아니면 비슷한가요? |  |

## 83 라흐마니노프 피아노 협주곡 3번 D단조 · 3악장 - 도입부

- 구간 안내: **보류** — 첫 주제를 피아노가 맡는지, 2악장 끝 이음매가 들었는지
- 앱: https://kang1027.com/classicmap/compare?pieceId=226&sectorId=83

구간 안내 질문
- [ ] 클립 첫머리에 2악장 끝 이음매(피아노가 피날레로 넘어가는 대목)가 들어 있나요? (세 연주 각각)
- [ ] 피날레 첫 주제를 피아노가 처음 내놓나요, 관현악이 몇 마디 먼저 나오나요?
- [ ] 세 클립이 같은 음에서 시작하나요? (예/아니오)

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 유자 왕 | [0:16](https://kang1027.com/classicmap/clips/5bX_yRzCuM4?end=1814&profile=v1-copy&start=1745#t=16) | 0:16~0:29 여린 대목에서 선율을 피아노가 맡나요, 관현악이 맡나요? |  |
| 유자 왕 | [0:16](https://kang1027.com/classicmap/clips/5bX_yRzCuM4?end=1814&profile=v1-copy&start=1745#t=16) | 유자 왕 0:16과 임윤찬 0:22가 같은 악구인가요? |  |
| 임윤찬 | [0:00](https://kang1027.com/classicmap/clips/DPJL488cfRw?end=1806&profile=v1-copy&start=1733#t=0) | 0:00~0:37 앞 절반이 한결같은 빠르기로 가나요, 밀었다 당겼다 하나요? |  |
| 랑랑 | [0:38](https://kang1027.com/classicmap/clips/KUbi0nEnUi4?end=1537&profile=v1-copy&start=1460#t=38) | 0:38에 세기가 오를 때 관현악이 크게 들어오나요, 피아노가 세지나요? |  |

## 82 라흐마니노프 피아노 협주곡 3번 D단조 · 3악장 - 클라이맥스

- 구간 안내: **보류** — 마지막 화음이 세 클립에 다 들었는지, 작곡가가 허용한 컷을 썼는지
- 앱: https://kang1027.com/classicmap/compare?pieceId=226&sectorId=82

구간 안내 질문
- [ ] 세 클립 모두 끝에 협주곡 마지막 화음(네 음 리듬)이 담겼나요? 빠진 클립은 어느 것인가요?
- [ ] 임윤찬 클립에 작곡가가 허용한 컷이 있어 다른 두 클립에 있는 악구가 빠졌나요?
- [ ] D장조 둘째 주제가 크게 돌아오는 곳이 각 클립 몇 초인가요?
- [ ] 세 클립이 같은 음에서 시작하나요? 시작이 어느 대목인가요?

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 유자 왕 | [3:01](https://kang1027.com/classicmap/clips/5bX_yRzCuM4?end=2618&profile=v1-copy&start=2317#t=181) | 3:01에 가장 크게 울리는 것이 D장조로 돌아오는 둘째 주제인가요, 다른 대목인가요? |  |
| 유자 왕 | [5:00](https://kang1027.com/classicmap/clips/5bX_yRzCuM4?end=2618&profile=v1-copy&start=2317#t=300) | 클립 끝에 협주곡 마지막 화음이 담겼나요? (예/아니오) |  |
| 임윤찬 | [4:03](https://kang1027.com/classicmap/clips/DPJL488cfRw?end=2553&profile=v1-copy&start=2267#t=243) | 4:03 무렵 빠르기를 넓히나요, 그대로 밀고 가나요? |  |
| 랑랑 | [1:45](https://kang1027.com/classicmap/clips/KUbi0nEnUi4?end=2328&profile=v1-copy&start=2039#t=105) | 1:45~2:08 여린 대목 뒤 2:08부터 점점 쌓나요, 한 번에 올라서나요? |  |
| 랑랑 | [4:30](https://kang1027.com/classicmap/clips/KUbi0nEnUi4?end=2328&profile=v1-copy&start=2039#t=270) | 유자 왕 3:01과 랑랑 4:30이 같은 대목인가요? (예/아니오) |  |

## 29 슈만 어린이의 정경 Op. 15 · 제3곡 술래잡기

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=464&sectorId=29

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 블라디미르 호로비츠 | [0:25](https://kang1027.com/classicmap/clips/IxG3yTedhgk?end=32&profile=v1-copy&start=0#t=25) | 0:25 무렵 오르막이 앞부분 sfp 동기가 돌아오는 자리인가요? |  |
| 레이프 오베 안스네스 | [0:14](https://kang1027.com/classicmap/clips/dcbWEvwIGmo?end=34&profile=v1-copy&start=0#t=14) | 0:14 와 0:25 무렵 두 대목을 비슷한 힘으로 짚나요, 아니면 한쪽이 확실히 더 세게 들리나요? |  |
| 마르타 아르헤리치 | [0:24](https://kang1027.com/classicmap/clips/satKCMMp1E4?end=26&profile=v1-copy&start=0#t=24) | 마지막 화음이 잘리지 않고 끝까지 울리나요? |  |
| 마르타 아르헤리치 | [0:00](https://kang1027.com/classicmap/clips/satKCMMp1E4?end=26&profile=v1-copy&start=0#t=0) | 호로비츠·안스네스보다 확실히 빠르게 달리나요? |  |

## 68 슈만 어린이의 정경 Op. 15 · 제7곡 트로이메라이

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=464&sectorId=68

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 랑랑 | [1:04](https://kang1027.com/classicmap/clips/9zVQk0YviAA?end=165&profile=v1-copy&start=5#t=64) | 1:04~1:20 무렵 실제로 확 여려지나요, 아니면 귀로는 굴곡이 크지 않게 들리나요? |  |
| 랑랑 | [0:06](https://kang1027.com/classicmap/clips/9zVQk0YviAA?end=165&profile=v1-copy&start=5#t=6) | 0:06·0:12·0:18 무렵 짧게 잦아드는 곳이 악구 끝의 숨인가요? |  |
| 랑랑 | [1:00](https://kang1027.com/classicmap/clips/9zVQk0YviAA?end=165&profile=v1-copy&start=5#t=60) | 랑랑 1:00 과 백건우 1:32 는 악보의 같은 대목인가요? |  |
| 마르타 아르헤리치 | [2:12](https://kang1027.com/classicmap/clips/OippNH2lREU?end=170&profile=v1-copy&start=5#t=132) | 2:12~2:28 무렵 오르막이 가장 높은 음에서 길게 멈추는 대목인가요? |  |
| 백건우 | [2:40](https://kang1027.com/classicmap/clips/ujeD7ZT_NQ4?end=178&profile=v1-copy&start=2#t=160) | 다른 둘보다 길게 느껴지는 까닭이 느린 빠르기인가요, 끝 화음 잔향인가요? |  |

## 63 베토벤 피아노 소나타 14번 C#단조 "월광" · 1악장 Adagio sostenuto

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=78&sectorId=63

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 예브게니 키신 | [5:54](https://kang1027.com/classicmap/clips/-aJ9JdV5c5A?end=368&profile=v1-copy&start=2#t=354) | 5:54~6:06 은 끝 화음의 여운인가요, 무음 여분인가요? |  |
| 예브게니 키신 | [3:00](https://kang1027.com/classicmap/clips/-aJ9JdV5c5A?end=368&profile=v1-copy&start=2#t=180) | 키신 3:00 과 폴리니 3:38 은 악보의 같은 대목인가요? |  |
| 이고르 레비트 | [0:00](https://kang1027.com/classicmap/clips/9EGdL_P2iXE?end=295&profile=v1-copy&start=1#t=0) | 셋잇단음 반주가 키신·폴리니보다 확실히 빠르게 흐르나요? |  |
| 이고르 레비트 | [1:50](https://kang1027.com/classicmap/clips/9EGdL_P2iXE?end=295&profile=v1-copy&start=1#t=110) | 귀로도 여린 대목과 센 대목의 차이가 작게 들리나요, 아니면 녹음이 눌린 소리인가요? |  |
| 마우리치오 폴리니 | [3:38](https://kang1027.com/classicmap/clips/AtcPhQB7rh0?end=373&profile=v1-copy&start=12#t=218) | 3:38 에서 첫 선율이 다시 돌아오나요? |  |
| 마우리치오 폴리니 | [0:00](https://kang1027.com/classicmap/clips/AtcPhQB7rh0?end=373&profile=v1-copy&start=12#t=0) | 0:00 부터 셋잇단음 반주가 들리나요, 아니면 처음 몇 초가 무음인가요? |  |

## 69 베토벤 피아노 소나타 14번 C#단조 "월광" · 3악장 Presto agitato

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=78&sectorId=69

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 마우리치오 폴리니 | [4:04](https://kang1027.com/classicmap/clips/JyO8iFLFqec?end=398&profile=v1-copy&start=1#t=244) | 4:04 의 쉼이 키신 3:58·리시차 3:53 과 같은 대목인가요? |  |
| 마우리치오 폴리니 | [5:49](https://kang1027.com/classicmap/clips/JyO8iFLFqec?end=398&profile=v1-copy&start=1#t=349) | 5:49~5:58 은 Adagio 대목인가요, 아니면 소리가 끊긴 녹음 틈인가요? |  |
| 예브게니 키신 | [6:15](https://kang1027.com/classicmap/clips/u92AG9B9y20?end=422&profile=v1-copy&start=5#t=375) | 마지막 40초 남짓은 여린 대목인가요, 끝 화음의 울림인가요? |  |
| 예브게니 키신 | [5:42](https://kang1027.com/classicmap/clips/u92AG9B9y20?end=422&profile=v1-copy&start=5#t=342) | 키신 5:42 와 리시차 5:20 은 악보의 같은 대목(코다 무렵)인가요? |  |
| 발렌티나 리시차 | [5:20](https://kang1027.com/classicmap/clips/zucBfXpCA6s?end=402&profile=v1-copy&start=2#t=320) | 5:20 이후 실제로 앞보다 더 세게 몰아치나요, 아니면 녹음 레벨만 올라간 느낌인가요? |  |

## 70 베토벤 피아노 소나타 8번 C단조 "비창" · 3악장 Rondo. Allegro

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=79&sectorId=70

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 블라디미르 아슈케나지 | [0:00](https://kang1027.com/classicmap/clips/BHKa8yWk99E?end=275&profile=v1-copy&start=0#t=0) | 0:00 부터 론도 주제가 들리나요, 아니면 처음 2초가 무음인가요? |  |
| 이고르 레비트 | [3:06](https://kang1027.com/classicmap/clips/JiHQwmb0DwY?end=239&profile=v1-copy&start=0#t=186) | 3:06 잦아듦 바로 앞이 A♭장조로 비치는 주제이고, 3:11 부터가 C단조 마무리인가요? |  |
| 이고르 레비트 | [0:00](https://kang1027.com/classicmap/clips/JiHQwmb0DwY?end=239&profile=v1-copy&start=0#t=0) | 론도 주제가 길렐스보다 확실히 빠르게 들리나요? |  |
| 에밀 길렐스 | [4:40](https://kang1027.com/classicmap/clips/egodnHGwxVs?end=298&profile=v1-copy&start=1#t=280) | 4:40 이후는 마지막 화음의 울림인가요, 아직 연주가 이어지나요? |  |
| 에밀 길렐스 | [0:00](https://kang1027.com/classicmap/clips/egodnHGwxVs?end=298&profile=v1-copy&start=1#t=0) | 론도 주제가 셋 중 가장 느리게 들리나요? |  |

## 64 베토벤 피아노 소나타 8번 C단조 "비창" · 2악장 Adagio cantabile

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=79&sectorId=64

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 블라디미르 아슈케나지 | [2:32](https://kang1027.com/classicmap/clips/1FP7NosLxkw?end=289&profile=v1-copy&start=4#t=152) | 2:32 가 셋잇단음 반주가 시작된 두 번째 중간 대목 안인가요? |  |
| 블라디미르 아슈케나지 | [4:16](https://kang1027.com/classicmap/clips/1FP7NosLxkw?end=289&profile=v1-copy&start=4#t=256) | 4:16 이후 마지막 주제가 0:00 처음 주제만큼 여리게 들리나요? |  |
| 블라디미르 아슈케나지 | [0:52](https://kang1027.com/classicmap/clips/1FP7NosLxkw?end=289&profile=v1-copy&start=4#t=52) | 0:52 의 조용한 대목이 다른 두 연주의 1:04~1:06 과 같은 자리(첫 주제 부분이 끝난 곳)인가요? |  |
| 윤디 리 | [4:31](https://kang1027.com/classicmap/clips/BuN3yCmHb_U?end=304&profile=v1-copy&start=3#t=271) | 4:31 무렵 셋잇단음 반주 위 선율이 반주보다 뚜렷하게 떠오르나요? |  |
| 윤디 리 | [3:02](https://kang1027.com/classicmap/clips/BuN3yCmHb_U?end=304&profile=v1-copy&start=3#t=182) | 3:02 가 두 번째 중간 대목(셋잇단음 반주) 안인가요, 아니면 마지막 주제가 돌아온 뒤인가요? |  |
| 이고르 레비트 | [2:54](https://kang1027.com/classicmap/clips/_evNH3kzylg?end=295&profile=v1-copy&start=4#t=174) | 2:54 가 둘레보다 확실히 크게 들리나요, 아니면 거의 같은 세기인가요? |  |
| 이고르 레비트 | [0:00](https://kang1027.com/classicmap/clips/_evNH3kzylg?end=295&profile=v1-copy&start=4#t=0) | 처음 주제(0:00)와 마지막 주제가 비슷한 세기로 들리나요? |  |

## 84 라흐마니노프 피아노 협주곡 2번 C단조 · 1악장

- 구간 안내: **보류** — 발전부 정점에서 재현부로 넘어가는 대목이라는 게 추정이에요
- 앱: https://kang1027.com/classicmap/compare?pieceId=225&sectorId=84

구간 안내 질문
- [ ] 세 클립 가운데(유자 왕 0:56, 조성진 1:22, 페도로바 1:08)에서 피아노가 아주 센 화음을 두드리고 호른·트럼펫이 당김음 선율을 부나요?
- [ ] 그 뒤 관현악이 첫 주제를 다시 연주하고 피아노가 행진하듯 화음을 치나요(재현부 진입)? 예/아니오
- [ ] 혹시 E♭장조 둘째 주제(피아노가 홀로 노래하는 대목)인가요? 예/아니오
- [ ] 세 클립이 같은 음에서 시작하고 같은 곳에서 끝나나요? (유자 왕 107초, 조성진 117초, 페도로바 118초)

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 유자 왕 | [0:24](https://kang1027.com/classicmap/clips/NsqXCO0ADwM?end=421&profile=v1-copy&start=314#t=24) | 0:24 에 소리가 확 줄면서 피아노 홀로 남나요, 아니면 관현악까지 거의 쉬나요? |  |
| 유자 왕 | [0:56](https://kang1027.com/classicmap/clips/NsqXCO0ADwM?end=421&profile=v1-copy&start=314#t=56) | 0:56 에서 가장 크게 터지나요, 아니면 그 뒤 1:10 무렵까지도 비슷하게 센가요? |  |
| 조성진 | [0:35](https://kang1027.com/classicmap/clips/YviN1tuXbzc?end=474&profile=v1-copy&start=357#t=35) | 0:35 부터 세지기 시작할 때 피아노가 먼저인가요, 관현악이 먼저인가요? |  |
| 조성진 | [1:22](https://kang1027.com/classicmap/clips/YviN1tuXbzc?end=474&profile=v1-copy&start=357#t=82) | 1:22 가 가장 센 곳으로 들리나요, 아니면 1:00 부터 이미 최대인가요? |  |
| 안나 페도로바 | [0:20](https://kang1027.com/classicmap/clips/rEGOihjqO9w?end=446&profile=v1-copy&start=328#t=20) | 0:20 무렵 앞쪽 대목에서 선율을 피아노가 끄나요, 관현악이 끄나요? |  |
| 안나 페도로바 | [0:00](https://kang1027.com/classicmap/clips/rEGOihjqO9w?end=446&profile=v1-copy&start=328#t=0) | 0:00 첫 몇 초가 다른 두 연주의 첫 몇 초보다 확실히 센 대목인가요, 아니면 녹음이 눌려 있어 그렇게 보이는 건가요? |  |

## 85 라흐마니노프 피아노 협주곡 2번 C단조 · 2악장

- 구간 안내: **보류** — 주제가 돌아오는 첫머리인지 맺음인지 못 가려요
- 앱: https://kang1027.com/classicmap/compare?pieceId=225&sectorId=85

구간 안내 질문
- [ ] 세 클립 안에서 관현악이 2악장 처음 주제를 다시 노래하나요(주제가 돌아오는 첫머리)? 예/아니오
- [ ] 클립 끝에서 관현악이 빠지고 피아노가 E장조로 잦아드나요(맺음)? 예/아니오
- [ ] 세 클립이 같은 음에서 시작하고 같은 곳에서 끝나나요? (유자 왕 40초, 조성진 45초, 페도로바 40초)

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 유자 왕 | [0:20](https://kang1027.com/classicmap/clips/NsqXCO0ADwM?end=1281&profile=v1-copy&start=1241#t=20) | 0:20 에 소리가 줄 때 악구 사이 숨인가요, 피아노만 남는 곳인가요? |  |
| 유자 왕 | [0:16](https://kang1027.com/classicmap/clips/NsqXCO0ADwM?end=1281&profile=v1-copy&start=1241#t=16) | 0:16 이 가장 센 곳으로 들리나요, 아니면 0:04~0:20 이 내내 비슷한가요? |  |
| 조성진 | [0:40](https://kang1027.com/classicmap/clips/YviN1tuXbzc?end=1401&profile=v1-copy&start=1356#t=40) | 0:40 이후 마지막 몇 초가 여리게 거두는 연주로 들리나요, 아니면 악구 중간에서 끊기나요? |  |
| 안나 페도로바 | [0:28](https://kang1027.com/classicmap/clips/rEGOihjqO9w?end=1374&profile=v1-copy&start=1334#t=28) | 0:28 솟음이 0:08 솟음보다 확실히 크게 들리나요? |  |

## 86 라흐마니노프 피아노 협주곡 2번 C단조 · 3악장

- 구간 안내: **보류** — C장조 정점이 클립 안에 온전히 들었는지
- 앱: https://kang1027.com/classicmap/compare?pieceId=225&sectorId=86

구간 안내 질문
- [ ] 세 클립 첫머리(0:00)에서 C장조로 크게 돌아오는 둘째 주제가 클립 안에서 시작되나요, 아니면 이미 진행 중인가요?
- [ ] 세 클립 모두 마지막 네 음 리듬과 마지막 화음까지 담겼나요? 예/아니오
- [ ] 조성진·페도로바의 0:55 무렵 가라앉는 대목이 C장조 정점 뒤 맺음으로 넘어가는 곳인가요?
- [ ] 유자 왕 클립(68초)이 다른 둘(79초)보다 늦게 시작하거나 일찍 끝나나요? 그렇다면 어느 쪽인가요?

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 유자 왕 | [0:02](https://kang1027.com/classicmap/clips/NsqXCO0ADwM?end=1962&profile=v1-copy&start=1894#t=2) | 0:02 부터 이미 관현악 전체가 크게 울리나요? |  |
| 유자 왕 | [0:29](https://kang1027.com/classicmap/clips/NsqXCO0ADwM?end=1962&profile=v1-copy&start=1894#t=29) | 0:29 무렵 선율을 늘이며 끄는 곳이 있나요, 아니면 처음부터 끝까지 고르게 몰아가나요? |  |
| 조성진 | [0:55](https://kang1027.com/classicmap/clips/YviN1tuXbzc?end=2128&profile=v1-copy&start=2049#t=55) | 0:55 에서 가라앉은 뒤 1:11 까지 피아노가 다시 쌓아 올리는 게 들리나요? |  |
| 조성진 | [1:11](https://kang1027.com/classicmap/clips/YviN1tuXbzc?end=2128&profile=v1-copy&start=2049#t=71) | 1:11 이후 마지막 여덟 초가 몰아가는 맺음으로 들리나요? |  |
| 안나 페도로바 | [0:35](https://kang1027.com/classicmap/clips/rEGOihjqO9w?end=2148&profile=v1-copy&start=2069#t=35) | 0:35 무렵 가장 센 대목에서 선율을 넓게 늘이나요, 아니면 같은 빠르기로 지나가나요? |  |

## 41 베토벤 교향곡 5번 C단조 "운명" · 1악장 운명 동기

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=75&sectorId=41

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 정명훈 | [0:12](https://kang1027.com/classicmap/clips/NWWbA5H5pEs?end=67&profile=v1-copy&start=9#t=12) | 0:12 무렵 여린 동기 주고받기에서 곧바로 크레센도가 시작되나요? |  |
| 정명훈 | [0:39](https://kang1027.com/classicmap/clips/NWWbA5H5pEs?end=67&profile=v1-copy&start=9#t=39) | 0:39 가장 센 곳 뒤 0:44 에서 곧바로 여린 대목으로 넘어가나요, 아니면 그 사이에 줄어드는 과정이 들리나요? |  |
| 카를로스 클라이버 | [0:08](https://kang1027.com/classicmap/clips/PPl8nIbzMj0?end=62&profile=v1-copy&start=2#t=8) | 0:08~0:14 여린 대목이 정명훈(0:08~0:12)보다 길게 들리나요, 아니면 같은 길이인데 녹음이 더 여려 그렇게 보이나요? |  |
| 카를로스 클라이버 | [0:26](https://kang1027.com/classicmap/clips/PPl8nIbzMj0?end=62&profile=v1-copy&start=2#t=26) | 0:26 이 현악기가 여리게 동기를 주고받는 대목인가요? 다른 두 연주의 같은 대목보다 확실히 더 작게 들리나요? |  |
| 크리스티안 틸레만 | [0:41](https://kang1027.com/classicmap/clips/q_kw904K2bw?end=110&profile=v1-copy&start=50#t=41) | 0:36~0:42 의 센 화음을 다른 두 연주보다 길게 끄나요, 같나요? |  |
| 크리스티안 틸레만 | [0:48](https://kang1027.com/classicmap/clips/q_kw904K2bw?end=110&profile=v1-copy&start=50#t=48) | 0:48 의 짧은 여림 뒤 0:50 무렵 다시 센 소리가 나오나요? |  |

## 40 베토벤 교향곡 5번 C단조 "운명" · 4악장 개선 주제

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=75&sectorId=40

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 정명훈 | [0:00](https://kang1027.com/classicmap/clips/NWWbA5H5pEs?end=1431&profile=v1-copy&start=1367#t=0) | 첫 4초가 3악장에서 넘어오는 크레센도 끝자락인가요, 아니면 무음·잡음인가요? |  |
| 정명훈 | [0:10](https://kang1027.com/classicmap/clips/NWWbA5H5pEs?end=1431&profile=v1-copy&start=1367#t=10) | 0:10 무렵이 첫 C장조 총주 직후로, 가장 크게 들리나요? |  |
| 카를로스 클라이버 | [0:16](https://kang1027.com/classicmap/clips/PPl8nIbzMj0?end=1415&profile=v1-copy&start=1351#t=16) | 0:16 무렵 소리가 한 번 확 줄었다가 다시 올라오나요? |  |
| 카를로스 클라이버 | [0:35](https://kang1027.com/classicmap/clips/PPl8nIbzMj0?end=1415&profile=v1-copy&start=1351#t=35) | 0:35 무렵 총주가 물러나나요, 아니면 한 성부만 남나요? |  |
| 크리스티안 틸레만 | [0:14](https://kang1027.com/classicmap/clips/q_kw904K2bw?end=1568&profile=v1-copy&start=1510#t=14) | 0:14 무렵에도 첫 화음 때와 거의 같은 세기로 버티나요? |  |
| 크리스티안 틸레만 | [0:58](https://kang1027.com/classicmap/clips/q_kw904K2bw?end=1568&profile=v1-copy&start=1510#t=58) | 클립 끝이 다른 두 연주와 같은 악보 지점에서 끝나나요? (같으면 빠르기 차이, 다르면 경계 차이) |  |

## 39 차이콥스키 피아노 협주곡 1번 B♭단조 · 1악장 도입부

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=159&sectorId=39

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 마르타 아르헤리치 | [0:30](https://kang1027.com/classicmap/clips/2DmfJu3oNDM?end=110&profile=v1-copy&start=20#t=30) | 0:30 무렵 소리가 0:10 때보다 한 단 내려와 있나요? 연주 때문인가요, 녹음 균형 때문인가요? |  |
| 마르타 아르헤리치 | [0:54](https://kang1027.com/classicmap/clips/2DmfJu3oNDM?end=110&profile=v1-copy&start=20#t=54) | 0:54 무렵 잦아드는 곳이 쉼이나 피아노 혼자 남는 자리인가요? 그 뒤 커지는 소리는 관현악인가요, 피아노인가요? |  |
| 랑랑 | [0:31](https://kang1027.com/classicmap/clips/Ybg2BEy_pu0?end=103&profile=v1-copy&start=14#t=31) | 0:31 무렵에도 0:10 무렵과 거의 같은 세기로 버티나요? |  |
| 랑랑 | [0:52](https://kang1027.com/classicmap/clips/Ybg2BEy_pu0?end=103&profile=v1-copy&start=14#t=52) | 0:52 직전에 무엇이 끝나고 무엇이 시작되나요? (예: 현 선율 끝 → 피아노 독주) |  |
| 손열음 | [0:41](https://kang1027.com/classicmap/clips/w2xGStX7ppU?end=162&profile=v1-copy&start=71#t=41) | 0:41 무렵 다시 최고점 가까이 차오르나요? |  |
| 손열음 | [1:17](https://kang1027.com/classicmap/clips/w2xGStX7ppU?end=162&profile=v1-copy&start=71#t=77) | 1:17 무렵 차오르는 대목에서 피아노 화음이 관현악 위로 또렷이 들리나요? |  |
| 손열음 | [0:00](https://kang1027.com/classicmap/clips/w2xGStX7ppU?end=162&profile=v1-copy&start=71#t=0) | 전체적으로 셈여림 폭이 좁게 들리나요? 녹음이 눌린(압축된) 느낌인가요? |  |

## 38 차이콥스키 피아노 협주곡 1번 B♭단조 · 3악장 코다

- 구간 안내: **보류** — 둘째 주제 복귀부터인지 Allegro vivo부터인지
- 앱: https://kang1027.com/classicmap/compare?pieceId=159&sectorId=38

구간 안내 질문
- [ ] 세 클립 모두 첫 음이 서정적인 둘째 주제가 B♭장조로 크게 돌아오는 곳(Molto meno mosso)인가요, 아니면 Allegro vivo 질주의 시작인가요?
- [ ] 클립 안에서 넓게 노래하던 주제가 빠른 질주로 바뀌는 곳이 있나요? 있다면 몇 초쯤인가요(아르헤리치·랑랑·손열음 각각)?
- [ ] 66·72·77초 길이 차이가 연주 빠르기 때문인가요, 아니면 시작·끝 경계(앞 여분·박수)가 달라서인가요?

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 마르타 아르헤리치 | [1:02](https://kang1027.com/classicmap/clips/2DmfJu3oNDM?end=2053&profile=v1-copy&start=1981#t=62) | 1:02 무렵이 가장 크게 들리나요? 이미 빠른 마지막 질주 안인가요? |  |
| 랑랑 | [0:16](https://kang1027.com/classicmap/clips/Ybg2BEy_pu0?end=2129&profile=v1-copy&start=2063#t=16) | 0:16 무렵 소리가 한 번 줄어드나요? 그 자리에서 선율이나 편성이 바뀌나요? |  |
| 랑랑 | [0:56](https://kang1027.com/classicmap/clips/Ybg2BEy_pu0?end=2129&profile=v1-copy&start=2063#t=56) | 0:56 무렵이 가장 크고, 마지막 화음은 그보다 조금 작게 들리나요? |  |
| 손열음 | [0:42](https://kang1027.com/classicmap/clips/w2xGStX7ppU?end=2165&profile=v1-copy&start=2088#t=42) | 0:42 무렵 소리가 한 번 줄어드나요? 랑랑의 0:16과 악보상 같은 자리인가요? |  |
| 손열음 | [1:16](https://kang1027.com/classicmap/clips/w2xGStX7ppU?end=2165&profile=v1-copy&start=2088#t=76) | 1:16 무렵 가장 큰 소리가 마지막 화음인가요, 아니면 박수인가요? |  |

## 190 글루크 <오르페오와 에우리디체> 중 "정령들의 춤" · 전곡

- 구간 안내: **보류** — 세 클립이 세 도막을 다 담았는지, 편성이 다른 판은 아닌지
- 앱: https://kang1027.com/classicmap/compare?pieceId=62&sectorId=190

구간 안내 질문
- [ ] 세 클립(카라얀 402초·솔티 445초·마리너 374초)이 모두 F장조–D단조–F장조 세 도막을 다 담았나요?
- [ ] 각 클립에서 D단조 대목이 시작하는 곳은 몇 초쯤인가요?
- [ ] 세 판 모두 플루트가 현악 반주 위에서 선율을 이끄는 관현악 편성인가요? 합창이나 다른 번호가 섞인 판은 없나요?
- [ ] 길이 차이가 반복 생략 때문인가요, 빠르기 때문인가요?

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 헤르베르트 폰 카라얀 | [1:44](https://kang1027.com/classicmap/clips/_b571ZHue0Q?end=402&profile=v1-copy&start=0#t=104) | 1:44 무렵 2초쯤 끊기는 곳에서 도막이 바뀌나요? |  |
| 헤르베르트 폰 카라얀 | [4:20](https://kang1027.com/classicmap/clips/_b571ZHue0Q?end=402&profile=v1-copy&start=0#t=260) | 4:20 무렵에도 앞부분과 비슷한 세기로 이어지나요? |  |
| 게오르그 솔티 | [0:00](https://kang1027.com/classicmap/clips/kGslb2jArxA?end=445&profile=v1-copy&start=0#t=0) | 첫 2초가 음악인가요, 아니면 클립 앞 여분(무음·잡음)인가요? |  |
| 게오르그 솔티 | [2:40](https://kang1027.com/classicmap/clips/kGslb2jArxA?end=445&profile=v1-copy&start=0#t=160) | 2:40~2:45 끊김이 도막 사이 쉼인가요, 아니면 다른 번호로 넘어가는 이음새인가요? |  |
| 게오르그 솔티 | [4:49](https://kang1027.com/classicmap/clips/kGslb2jArxA?end=445&profile=v1-copy&start=0#t=289) | 4:49 무렵 가운데가 확연히 여리게 들리나요? 녹음 탓으로 들리나요? |  |
| 네빌 마리너 | [2:15](https://kang1027.com/classicmap/clips/nn9Ir6p18e8?end=374&profile=v1-copy&start=0#t=135) | 2:15 무렵 잠깐 끊긴 뒤 선율이 단조로 바뀌나요? |  |
| 네빌 마리너 | [2:51](https://kang1027.com/classicmap/clips/nn9Ir6p18e8?end=374&profile=v1-copy&start=0#t=171) | 2:51 무렵이 가장 크게 들리나요? |  |

## 189 글루크 <오르페오와 에우리디체> 중 "에우리디체 없이 어찌하리" · 전곡

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=63&sectorId=189

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 테레사 베르간사 | [0:00](https://kang1027.com/classicmap/clips/Dgyj3f-aCe8?end=228&profile=v1-copy&start=2#t=0) | 처음 18초가 관현악 전주인가요, 아니면 무음·잡음 같은 앞 여분인가요? |  |
| 테레사 베르간사 | [3:10](https://kang1027.com/classicmap/clips/Dgyj3f-aCe8?end=228&profile=v1-copy&start=2#t=190) | 3:01~3:23 대목이 확 커지나요? 커지는 것은 목소리인가요, 관현악인가요? |  |
| 테레사 베르간사 | [2:32](https://kang1027.com/classicmap/clips/Dgyj3f-aCe8?end=228&profile=v1-copy&start=2#t=152) | 2:32 무렵 한 점이 튀게 크게 들리나요, 아니면 잡음인가요? |  |
| 프레데리카 폰 슈타데 | [3:10](https://kang1027.com/classicmap/clips/Fv5q7nps9FU?end=218&profile=v1-copy&start=1#t=190) | 3:10 무렵이 가장 크게 들리나요? 마지막 선율 복귀 안인가요? |  |
| 베셀리나 카사로바 | [0:00](https://kang1027.com/classicmap/clips/Vj2yrFBtDpk?end=257&profile=v1-copy&start=0#t=0) | 처음 22초가 관현악 전주인가요, 아니면 앞 여분(무음·레치타티보 등)인가요? |  |
| 베셀리나 카사로바 | [2:28](https://kang1027.com/classicmap/clips/Vj2yrFBtDpk?end=257&profile=v1-copy&start=0#t=148) | 2:28 무렵 가장 센 곳이 '에우리디체!'를 부르는 대목인가요? |  |
| 베셀리나 카사로바 | [3:51](https://kang1027.com/classicmap/clips/Vj2yrFBtDpk?end=257&profile=v1-copy&start=0#t=231) | 마지막 26초쯤(3:51 이후)이 여린 노래·후주인가요, 아니면 박수·무음 같은 뒤 여분인가요? |  |

## 75 모차르트 아이네 클라이네 나흐트무지크 · 1악장 Allegro

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=66&sectorId=75

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 볼프강 조보트카 | [0:38](https://kang1027.com/classicmap/clips/OaTbNbna3HY?end=347&profile=v1-copy&start=0#t=38) | 0:38 이 마지막 종결부(5:12 이후)보다 분명히 더 크게 들리나요? |  |
| 볼프강 조보트카 | [0:38](https://kang1027.com/classicmap/clips/OaTbNbna3HY?end=347&profile=v1-copy&start=0#t=38) | 0:38 은 첫 주제 뒤 현이 다 함께 세게 이어 가는 대목인가요? |  |
| 네빌 마리너 | [0:00](https://kang1027.com/classicmap/clips/UhPBT0dA_oA?end=346&profile=v1-copy&start=5#t=0) | 다른 두 연주와 견줘 빠르기나 현의 결에서 한 줄로 쓸 만한 차이가 있나요? 있다면 무엇인가요? |  |
| 사이먼 래틀 | [3:23](https://kang1027.com/classicmap/clips/dC_sCEYmvAM?end=338&profile=v1-copy&start=0#t=203) | 3:23~3:57 은 발전부 끝에서 재현부로 넘어가는 자리인가요? |  |
| 사이먼 래틀 | [3:23](https://kang1027.com/classicmap/clips/dC_sCEYmvAM?end=338&profile=v1-copy&start=0#t=203) | 이 대목을 다른 두 연주보다 눈에 띄게 여리게 줄이나요? |  |
| 볼프강 조보트카 / 네빌 마리너 | 0:38 / 5:32 | 추천 비교: 가장 센 곳 위치 차이가 번갈아 들었을 때 들리나요? 안 들리면 다른 짝으로 바꿀까요? |  |

## 103 모차르트 교향곡 40번 G단조 · 1악장 도입 (Molto allegro 제1주제)

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=67&sectorId=103

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 네빌 마리너 | [0:46](https://kang1027.com/classicmap/clips/CMBLu6xYlNQ?end=90&profile=v1-copy&start=1#t=46) | 0:46 무렵 가라앉는 곳이 B♭장조 둘째 주제가 시작되는 자리인가요? |  |
| 헤르베르트 폰 카라얀 | [1:04](https://kang1027.com/classicmap/clips/RDAjLjvequ4?end=95&profile=v1-copy&start=4#t=64) | 1:04 에서 총주가 다시 세게 들어오나요? 들어오는 악기를 한 줄로 적으면 무엇인가요? |  |
| 리카르도 무티 | [0:50](https://kang1027.com/classicmap/clips/r2-asx8cY0s?end=97&profile=v1-copy&start=1#t=50) | 0:50~1:12 가 다른 두 연주보다 눈에 띄게 느린가요, 아니면 빠르기는 비슷하고 더 여리게 끄나요? |  |
| 리카르도 무티 | [1:30](https://kang1027.com/classicmap/clips/r2-asx8cY0s?end=97&profile=v1-copy&start=1#t=90) | 클립 끝이 다른 두 연주와 같은 마디에서 끝나나요? |  |
| 헤르베르트 폰 카라얀 / 리카르도 무티 | 1:04 / 1:12 | 추천 비교: 번갈아 들었을 때 '일찍 다시 세지기 vs 오래 여리게 머물기' 차이가 들리나요? |  |

## 126 모차르트 교향곡 41번 C장조 "주피터" · 4악장 Molto allegro 도입 (푸가 주제)

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=68&sectorId=126

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 레너드 번스타인 | [0:32](https://kang1027.com/classicmap/clips/8qmhY8-Ejxk?end=123&profile=v1-copy&start=0#t=32) | 0:32~0:42 을 다른 두 연주만큼 여리게 연주하나요, 아니면 눈에 띄게 덜 여린가요? |  |
| 헤르베르트 폰 카라얀 | [0:00](https://kang1027.com/classicmap/clips/AR2ptuDRbh8?end=116&profile=v1-copy&start=0#t=0) | 처음 몇 초에 첫 음 앞 무음이 있나요, 아니면 바로 아주 여린 첫 동기가 시작되나요? |  |
| 헤르베르트 폰 카라얀 | [0:33](https://kang1027.com/classicmap/clips/AR2ptuDRbh8?end=116&profile=v1-copy&start=0#t=33) | 0:33 에서 현이 네 음 동기를 하나씩 쌓는 푸가토가 시작되나요? |  |
| 카를 뵘 | [0:32](https://kang1027.com/classicmap/clips/EVWAhRFyoS0?end=122&profile=v1-copy&start=1#t=32) | 0:32 에서 여려진 뒤 다시 세지기 시작하는 시각은 언제인가요(대략 몇 초)? |  |
| 레너드 번스타인 / 헤르베르트 폰 카라얀 | 0:32 / 0:33 | 추천 비교: 여린 대목의 깊이 차이가 번갈아 들었을 때 들리나요? |  |

## 181 모차르트 오페라 <피가로의 결혼> · 3막 “편지 이중창” (저녁 산들바람은 부드럽게)

- 구간 안내: **보류** — 클립 길이가 126·142·168초로 33% 벌어져요. 대목이 빠지거나 섞였을 수 있어요
- 앱: https://kang1027.com/classicmap/compare?pieceId=69&sectorId=181

구간 안내 질문
- [ ] 세 클립 모두 관현악 전주 첫 박에서 시작하나요? 전주 없이 바로 노래로 시작하는 클립이 있나요?
- [ ] 세 클립 모두 이중창 마지막 화음에서 끝나나요? 뒤에 박수나 다음 장면이 붙은 클립이 있나요?
- [ ] 편지를 둘이 엇갈려 읽는 뒷부분과 두 목소리가 포개지는 끝이 세 클립 모두에 들어 있나요?
- [ ] 앞뒤 여분을 빼고도 아르농쿠르 판이 눈에 띄게 긴가요? 그렇다면 느린 빠르기 때문인가요, 되풀이가 더 들어 있어서인가요?

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 니콜라우스 아르농쿠르 | [0:50](https://kang1027.com/classicmap/clips/WJUwVv3IbTY?end=168&profile=v1-copy&start=0#t=50) | 0:50~1:07 은 어느 대목인가요? 백작부인이 부르고 수산나가 되부르는 앞부분인가요? |  |
| 니콜라우스 아르농쿠르 | [2:16](https://kang1027.com/classicmap/clips/WJUwVv3IbTY?end=168&profile=v1-copy&start=0#t=136) | 2:16 은 두 목소리가 포개지는 끝 대목인가요? |  |
| 니콜라우스 아르농쿠르 | [2:40](https://kang1027.com/classicmap/clips/WJUwVv3IbTY?end=168&profile=v1-copy&start=0#t=160) | 2:40~2:48 은 마지막 화음 뒤 여분(잔향·박수·다음 장면)인가요? |  |
| 리카르도 무티 | [0:00](https://kang1027.com/classicmap/clips/klfGmj0_QC4?end=143&profile=v1-copy&start=1#t=0) | 0:00~0:17 은 관현악 전주인가요, 아니면 앞 레치타티보나 무음인가요? |  |
| 리카르도 무티 | [1:59](https://kang1027.com/classicmap/clips/klfGmj0_QC4?end=143&profile=v1-copy&start=1#t=119) | 1:59 는 두 목소리가 포개지는 끝 대목인가요? |  |
| 클라우디오 아바도 | [0:00](https://kang1027.com/classicmap/clips/xRW3kKwVI9k?end=126&profile=v1-copy&start=0#t=0) | 126초 클립에 처음부터 끝까지 빠진 대목이 없나요? |  |
| 클라우디오 아바도 | [1:46](https://kang1027.com/classicmap/clips/xRW3kKwVI9k?end=126&profile=v1-copy&start=0#t=106) | 1:46 은 두 목소리가 포개지는 끝 대목인가요? |  |
| 니콜라우스 아르농쿠르 / 클라우디오 아바도 | 0:50 / 1:46 | 추천 비교: '일찍 차오르기 vs 끝까지 아껴 두기' 차이가 들리나요? 안 들리면 다른 짝으로 바꿀까요? |  |

## 167 모차르트 오페라 <마술피리> · 2막 “밤의 여왕 아리아” (지옥의 복수가 내 마음에 끓어오르고)

- 구간 안내: 확정
- 앱: https://kang1027.com/classicmap/compare?pieceId=70&sectorId=167

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 에리카 미클로샤 | [1:43](https://kang1027.com/classicmap/clips/WMMj6UXdVBE?end=172&profile=v1-copy&start=0#t=103) | 1:43~2:18 에서 목소리가 여려지나요, 아니면 노래가 쉬고 관현악만 남나요? |  |
| 에디타 그루베로바 | [1:29](https://kang1027.com/classicmap/clips/h9AT24gcMRI?end=178&profile=v1-copy&start=0#t=89) | 0:18~0:36 과 1:29~2:07 이 콜로라투라가 몰아치는 대목인가요? |  |
| 조수미 | [0:00](https://kang1027.com/classicmap/clips/mjceJ1hywLs?end=169&profile=v1-copy&start=0#t=0) | 다른 두 연주와 견줘 여린 곳과 센 곳의 차이가 눈에 띄게 작게 들리나요, 아니면 비슷한가요? |  |
| 에리카 미클로샤 / 에디타 그루베로바 | 1:43 / 1:47 | 추천 비교: 같은 대목에서 미클로샤 쪽이 확실히 더 가라앉게 들리나요? 아니면 미클로샤 ↔ 조수미 짝이 더 선명한가요? |  |

## 120 하이든 교향곡 94번 G장조 "놀람" · 2악장 Andante 도입 (놀람 화음)

- 보류(DRAFT): holdFlags LENGTH_SPREAD: 클립 길이 75·103·91초(1.37배). 가장 센 곳(놀람 화음으로 보이는 0:29·0:42·0:36)의 비율 1.43 이 길이 비율과 비슷해 빠르기 차이일 가능성이 크지만, 세 클립이 같은 마디에서 끝나는지(주제 뒷부분 되풀이·첫 변주 포함 여부) 확인 전에는 대목이 불확실함
- 앱: https://kang1027.com/classicmap/compare?pieceId=83&sectorId=120

구간 안내 질문
- [ ] 세 클립이 모두 악장 첫머리에서 시작해 같은 마디(주제 뒷부분 끝, 첫 변주 앞)에서 끝나는지
- [ ] 길이 차이(75·103·91초)가 빠르기 차이인지, 담긴 범위(되풀이 수행 여부) 차이인지
- [ ] 구간에 놀람 화음 뒤 주제 뒷부분까지 들어 있는지

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 헤르베르트 폰 카라얀 | [0:29](https://kang1027.com/classicmap/clips/14G_PDZWXVE?end=76&profile=v1-copy&start=1#t=29) | 가장 센 곳이 16마디 끝의 놀람 화음인지, 클립 끝이 어느 마디인지 |  |
| 레너드 번스타인 | [0:42](https://kang1027.com/classicmap/clips/oTRi5mTZgcQ?end=103&profile=v1-copy&start=0#t=42) | 가장 센 곳이 놀람 화음인지, 103초 클립이 주제 뒷부분 되풀이나 첫 변주까지 담았는지 |  |
| 네빌 마리너 | [0:36](https://kang1027.com/classicmap/clips/xiytuHvoPdg?end=91&profile=v1-copy&start=0#t=36) | 가장 센 곳이 놀람 화음인지, 클립 끝이 다른 두 연주와 같은 마디인지 |  |

## 139 하이든 현악 4중주 C장조 "황제" · 2악장 Poco adagio cantabile 주제 (황제 찬가)

- 보류(DRAFT): 구간 이름은 '주제'인데 세 클립(1분 55초~2분 16초) 모두 64~68% 지점(1:14·1:17·1:32)에 2초 안팎의 깊은 쉼이 있고 그 뒤로 40초 가까이 큰 세기가 이어짐. 주제(20마디 안팎)는 1분 10~30초 남짓이라, 쉼 뒤는 첫 변주(제2바이올린 선율)일 가능성이 큼. 발췌가 주제에서 끝나는지부터 불확실
- 앱: https://kang1027.com/classicmap/compare?pieceId=86&sectorId=139

구간 안내 질문
- [ ] 발췌 끝이 주제(황제 찬가 한 번)에서 끝나는가, 첫 변주 앞부분까지 들어가는가
- [ ] 첫 변주까지 들어간다면 구간을 주제로 잘라 다시 만들지, 안내를 '주제와 첫 변주 앞부분'으로 고칠지

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 알반 베르크 4중주단 | [1:32](https://kang1027.com/classicmap/clips/HpVah-JbvxM?end=141&profile=v1-copy&start=5#t=92) | 깊은 쉼 뒤에 제2바이올린이 선율을 잡는 첫 변주가 시작되는지 |  |
| 에머슨 현악 4중주단 | [1:14](https://kang1027.com/classicmap/clips/v8ssyi0SvBk?end=115&profile=v1-copy&start=0#t=74) | 깊은 쉼이 주제의 마지막 화음 뒤인지, 클립 끝까지 몇 마디가 더 들어 있는지 |  |
| 아마데우스 4중주단 | [1:17](https://kang1027.com/classicmap/clips/msM3F2Q9334?end=125&profile=v1-copy&start=4#t=77) | 쉼 뒤로 큰 세기가 이어지는 대목이 무엇인지 |  |

## 183 C.P.E. 바흐 플루트 협주곡 D단조 · 1악장 Allegro 도입 (관현악 서주)

- 보류(DRAFT): 구간 이름이 '1악장 Allegro 도입 (관현악 서주)'인데 클립이 1분 57초~2분 19초라 독주 플루트가 안에 들어오는지 알 수 없다. 세 연주 모두 0:40~0:55 무렵(골웨이 둘째·넷째 10분의 1, 갈루아 0:47 −15.3dB, 파위 넷째 10분의 1 −8.4dB) 한 단계 여려지는 자리가 있어 플루트 진입일 가능성이 크다. 그러면 구간 이름의 '관현악 서주'가 틀리고, 안내도 그 자리를 짚어야 해서 대목부터 확인이 필요하다.
- 앱: https://kang1027.com/classicmap/compare?pieceId=105&sectorId=183

구간 안내 질문
- [ ] 클립 안에서 독주 플루트가 들어오는가? 들어오면 연주마다 몇 초인가
- [ ] 들어온다면 구간 이름 '(관현악 서주)'를 '도입'으로 고쳐야 하는가
- [ ] 첫머리가 현악 합주(통주저음 포함)만으로 시작하는가

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 파트리크 갈루아 | [0:47](https://kang1027.com/classicmap/clips/9NbgZKZylMU?end=139&profile=v1-copy&start=0#t=47) | 잦아드는 자리가 서주가 끝나고 플루트가 들어오는 곳인지 |  |
| 엠마누엘 파위 | [0:42](https://kang1027.com/classicmap/clips/kP8TlXoZZrU?end=122&profile=v1-copy&start=1#t=42) | 물러서는 자리에서 독주 플루트가 들어오는지 |  |
| 제임스 골웨이 | [0:47](https://kang1027.com/classicmap/clips/1vHRdmIP6k4?end=117&profile=v1-copy&start=0#t=47) | 플루트가 들어오는 시점과, 뒤 절반이 고르게 높게 이어지는 것이 총주 때문인지 |  |

## 187 J.C. 바흐 신포니아 콘체르탄테 C장조 · 1악장 Allegro 도입 (관현악 서주)

- 보류(DRAFT): 구간 이름이 '1악장 Allegro 도입 (관현악 서주)'인데 클립이 1분 54초~2분 1초라 독주 넷(플루트·오보에·바이올린·첼로)이 안에서 들어오는지 알 수 없다. 세 연주 모두 1:24~1:27 에 가장 크게 올라서고 그 앞(일곱째 10분의 1)이 여려, 서주 끝 총주일 수도 독주 대목 뒤 총주일 수도 있다. 안내가 짚을 자리부터 정해야 한다. 덧붙여 입력의 작품 번호 'W.C 34'와 세 영상 표기 'W.C43'가 다르다.
- 앱: https://kang1027.com/classicmap/compare?pieceId=108&sectorId=187

구간 안내 질문
- [ ] 클립 안에서 독주 넷이 들어오는가? 들어오면 연주마다 몇 초인가
- [ ] 들어온다면 구간 이름 '(관현악 서주)'를 '도입'으로 고쳐야 하는가
- [ ] 서주가 총주로 밝게 시작하는가, 여리게 시작하는가

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 앤서니 홀스테드 | [1:13](https://kang1027.com/classicmap/clips/cLXuJitvqhI?end=114&profile=v1-copy&start=0#t=73) | 깊이 잦아드는 자리가 독주 악기만 남는 대목인지 |  |
| 프란츠요제프 마이어 | [1:27](https://kang1027.com/classicmap/clips/RnCG3GIP8Gw?end=122&profile=v1-copy&start=1#t=87) | 가장 센 자리가 총주가 다시 들어오는 곳인지. 이 판만 현대 음높이(조율 +0.05, 나머지 둘 −0.4 안팎)라 반음 절반쯤 높게 들리는지 |  |
| 사이먼 스탠디지 | [0:57](https://kang1027.com/classicmap/clips/vr2IdnKZYP8?end=114&profile=v1-copy&start=0#t=57) | 중반에 한 번 올라서는 자리에서 독주 악기가 처음 나서는지 |  |

## 188 무치오 클레멘티 피아노 소나타 G단조 "버림받은 디도" · 1악장 Largo patetico e sostenuto 도입

- 보류(DRAFT): holdFlags LENGTH_SPREAD(120·121·89초, 1.36배). review-report 는 매케이브의 실제 템포 차이로 봤지만, 발췌 끝이 '발췌 끝'(시간 기준)이라 셋 다 서주 안에서 끝나는지, 알레그로 첫머리가 섞였는지 확인되지 않음
- 앱: https://kang1027.com/classicmap/compare?pieceId=115&sectorId=188

구간 안내 질문
- [ ] 세 발췌가 모두 느린 서주(Largo patetico e sostenuto) 안에서 끝나는가, 아니면 알레그로 첫머리가 들어 있는가
- [ ] 서주가 센 화음과 여린 악구를 번갈아 내놓는다는 설명이 악보와 맞는가(곡선 세 개가 같은 오르내림을 보인 데서 짐작한 것)
- [ ] '버림받은 디도' 제목과 줄거리를 안내에 쓰는 것이 맞는가(Scena tragica 부제 확인)

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 존 매케이브 | [1:08](https://kang1027.com/classicmap/clips/zkDukLfjJsg?end=90&profile=v1-copy&start=1#t=68) | 1:08~1:16 거의 소리가 없는 곳이 악보의 쉼(늘임표)인지, 그 뒤 1:16~1:29 가 서주의 끝인지 알레그로의 시작인지 |  |
| 하워드 셸리 | [1:41](https://kang1027.com/classicmap/clips/H8RaGYZyiys?end=121&profile=v1-copy&start=0#t=101) | 1:41~1:48 깊은 고요 뒤 2:01 까지 무엇이 나오는지(서주의 마지막 화음인지, 알레그로 첫머리인지) |  |
| 산드로 데 팔마 | [0:31](https://kang1027.com/classicmap/clips/645PN3ig7Bs?end=123&profile=v1-copy&start=3#t=31) | 0:31 에 처음 크게 터지는 화음이 셸리 0:52·매케이브 0:37 과 같은 자리인지 |  |

## 45 쇼팽 연습곡 Op. 10, No. 12 "혁명" · 전곡

- 보류(DRAFT): 조성진 클립이 0~129초(영상 156초)로 키신·폴리니(155초)보다 17% 짧다. 다른 둘은 끝 여린 대목 뒤 종결 화음에서 다시 올라서는데 조성진은 마지막 13초가 여린 채 끝나 종결 화음이 잘렸을 수 있다. 메트로놈(4분음표=160) 기준 2분 6초라 온전한 빠른 연주일 수도 있어 들어서 가려야 한다
- 앱: https://kang1027.com/classicmap/compare?pieceId=127&sectorId=45

구간 안내 질문
- [ ] 조성진 클립 129초가 작품 전체(종결 화음과 잔향까지)를 담는지
- [ ] 원본 영상 129~156초에 음악이 남아 있는지, 박수·무음뿐인지

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 조성진 | [2:00](https://kang1027.com/classicmap/clips/qhYn9sirsJs?end=129&profile=v1-copy&start=0#t=120) | 클립 끝(2:09)까지 마지막 하행 패시지와 종결 화음이 들어 있는지, 아니면 그 앞에서 끊기는지 |  |
| 조성진 | [0:21](https://kang1027.com/classicmap/clips/qhYn9sirsJs?end=129&profile=v1-copy&start=0#t=21) | 가장 센 0:21 이 첫 대목 어느 자리인지 |  |
| 마우리치오 폴리니 | [2:12](https://kang1027.com/classicmap/clips/w2vLEQno9Ks?end=156&profile=v1-copy&start=1#t=132) | 2:12~2:26 여린 대목이 종결 앞 여린 대목인지 |  |

## 48 쇼팽 폴로네즈 6번 A♭장조 "영웅" · 전곡

- 보류(DRAFT): 키신 클립이 323초로 원본(387초)보다 1분 가까이 짧고 마지막 5분의 1이 여리게 잡혀, 곡이 크게 맺는 주제 귀환·종결부가 빠졌을 가능성이 큼. 클립 길이 범위(318~413초)에 맞춰 끝이 잘렸는지 확인 필요. 조성진도 마지막 1분 20초가 한 단계 낮음
- 앱: https://kang1027.com/classicmap/compare?pieceId=130&sectorId=48

구간 안내 질문
- [ ] 세 클립 모두 도입 상행 음형에서 시작해 마지막 종결 화음까지 담는가(특히 키신 0:00~5:23)
- [ ] 가운데 E장조 왼손 옥타브 대목이 세 클립 각각 어디쯤인가

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 예브게니 키신 | [5:23](https://kang1027.com/classicmap/clips/8QT7ITv9Ecs?end=328&profile=v1-copy&start=5#t=323) | 클립 끝이 종결 화음인지, 아니면 주제가 돌아오기 전 여린 대목에서 끊겼는지 |  |
| 예브게니 키신 | [2:54](https://kang1027.com/classicmap/clips/8QT7ITv9Ecs?end=328&profile=v1-copy&start=5#t=174) | 2:54 의 잦아듦이 가운데 E장조 옥타브 대목의 시작인지 |  |
| 조성진 | [6:48](https://kang1027.com/classicmap/clips/d3IKMiv8AHw?end=413&profile=v1-copy&start=5#t=408) | 클립 끝이 종결 화음과 잔향까지 담는지, 4:46 이후 낮아지는 것이 연주 모양인지 |  |
| 블라디미르 호로비츠 | [0:04](https://kang1027.com/classicmap/clips/p1-uOCXQ_0I?end=412&profile=v1-copy&start=12#t=4) | 처음의 여린 자리가 도입 음형인지 무음인지 |  |

## 46 쇼팽 녹턴 E♭장조 · 전곡

- 보류(DRAFT): 세 클립(234·234·238초)이 원본(283·267·264초)보다 26~49초 짧고 길이 범위(229~243초)에 몰려 있음. 곡은 여리게 맺는데 루빈스타인·랑랑은 클립 마지막 10분의 1이 크게 잡히고 가장 센 곳이 둘 다 3:32 로 같아, 카덴차·마지막 화음 전에 끊겼을 가능성이 큼
- 앱: https://kang1027.com/classicmap/compare?pieceId=131&sectorId=46

구간 안내 질문
- [ ] 세 클립 모두 마지막 화음과 잔향까지 담는가
- [ ] 3:32(랑랑·루빈스타인), 3:16(조성진)의 가장 센 곳이 카덴차 직전의 큰 대목(con forza)인가

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 아르투르 루빈스타인 | [3:54](https://kang1027.com/classicmap/clips/Nu48Z45ibxQ?end=236&profile=v1-copy&start=2#t=234) | 클립 끝이 마지막 화음과 잔향인지, 카덴차 앞뒤에서 끊겼는지 |  |
| 랑랑 | [3:54](https://kang1027.com/classicmap/clips/EvNsPyp5O2I?end=234&profile=v1-copy&start=0#t=234) | 클립 끝이 마지막 화음인지 |  |
| 조성진 | [3:34](https://kang1027.com/classicmap/clips/QR10Od1cLaM?end=242&profile=v1-copy&start=4#t=214) | 마지막 20여 초의 여린 소리가 카덴차 뒤 맺음인지 |  |

## 152 베르디 오페라 <나부코> 중 "히브리 노예들의 합창" · 합창 전체

- 보류(DRAFT): holdFlags LENGTH_SPREAD: 길이가 3분 39초·4분 54초·5분 3초로 1.38배까지 벌어져, 샤이 판이 서주나 끝을 빠뜨렸는지 같은 범위인지부터 불확실함
- 앱: https://kang1027.com/classicmap/compare?pieceId=151&sectorId=152

구간 안내 질문
- [ ] 세 판 모두 관현악 서주의 첫 음부터 합창 마지막 화음까지 같은 범위를 담았는지
- [ ] 샤이 판이 짧은 까닭이 빠르기인지, 서주·반복이 빠진 것인지
- [ ] 합창이 끝에서 여리게 맺는다는 안내가 세 판 모두에 맞는지

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 리카르도 샤이 | [0:00](https://kang1027.com/classicmap/clips/XI5wvuB3jAQ?end=219&profile=v1-copy&start=0#t=0) | 관현악 서주의 첫 음에서 시작하는지, 합창 마지막 화음까지 담겼는지 |  |
| 리카르도 샤이 | [1:58](https://kang1027.com/classicmap/clips/XI5wvuB3jAQ?end=219&profile=v1-copy&start=0#t=118) | 가장 센 1:58 과 3분 무렵 다시 부푸는 곳 가운데 어느 쪽이 '황금 하프여' 인지 |  |
| 제임스 콘론 | [0:40](https://kang1027.com/classicmap/clips/aiSSz0snWzA?end=299&profile=v1-copy&start=5#t=40) | 0:40 무렵 크게 부푸는 곳이 서주의 센 대목인지 |  |
| 리카르도 무티 | [2:50](https://kang1027.com/classicmap/clips/zIkVAT-AKew?end=303&profile=v1-copy&start=0#t=170) | 가장 센 2:50 이 '황금 하프여' 인지, 끝 4:20 무렵 다시 부푸는 곳은 무엇인지 |  |

## 106 브람스 헝가리 무곡 5번 G단조 · 전곡

- 보류(DRAFT): holdFlags LENGTH_SPREAD(클립 길이 190·141·161초, 1.35배). 얀손스 클립은 0:00~0:08 이 아주 여려 곡이 총주 첫 타격으로 시작한다는 큐와 맞지 않아, 앞에 무음·박수나 다른 소리가 섞였을 수 있어요
- 앱: https://kang1027.com/classicmap/compare?pieceId=155&sectorId=106

구간 안내 질문
- [ ] 세 클립 모두 총주 첫 타격에서 시작해 종결 화음에서 끝나는지
- [ ] 세 판이 같은 관현악 편곡(팔로 판)인지, 가운데 장조 대목의 느림·빠름 교대가 셋 모두에 있는지

| 연주 | 시점 | 질문 | 답 |
|---|---|---|---|
| 마리스 얀손스 | [0:00](https://kang1027.com/classicmap/clips/4ARjT4QatGY?end=199&profile=v1-copy&start=9#t=0) | 0:00~0:08 이 곡 시작 전 무음·박수인지, 첫 타격이 몇 초에 오는지 |  |
| 마리스 얀손스 | [3:05](https://kang1027.com/classicmap/clips/4ARjT4QatGY?end=199&profile=v1-copy&start=9#t=185) | 3분 10초 안에 같은 곡이 한 번만 들어 있는지(반복·앙코르 멘트·다른 곡 섞임), 아니면 느려지는 자리를 크게 늘린 것인지 |  |
| 클라우디오 아바도 | [0:45](https://kang1027.com/classicmap/clips/QAMxkietiik?end=142&profile=v1-copy&start=1#t=45) | 가장 센 0:45 가 첫 선율 대목 안인지 |  |
| 네빌 마리너 | [1:55](https://kang1027.com/classicmap/clips/WbhlzOoc2s8?end=163&profile=v1-copy&start=2#t=115) | 가장 센 1:55 가 돌아온 첫 선율인지 |  |
