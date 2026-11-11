# 남은 원어 seed 정리 (2026-11-11)

4·5·6차 자동 카탈로그가 판단하지 못하고 남겨 둔 원어 seed 609곡(작곡가 69명)을 정리했어요.
대상은 `pieces.origin='seed'`·`editor_locked=0`·숨기지 않은 작품이고, 작곡가도 숨기지 않은 것이에요.
마이그레이션은 `migrations/202611110601` ~ `202611110603` 이에요.

| 파일 | 내용 |
|---|---|
| `202611110601_merge_leftover_seed_duplicates.sql` | 같은 작품이 이미 손 작품으로 있는 seed 22개를 숨기고 남길 작품으로 합쳐요(`dup_decisions.json`) |
| `202611110602_organize_leftover_seeds_01.sql` | 작곡가 25명: 잇기·이름 묶음·음반 묶음 |
| `202611110603_organize_leftover_seeds_02.sql` | 작곡가 나머지: 잇기·이름 묶음 |

## 왜 남아 있었나

대부분 「Antigonae: I. …」·「Première concert: La Flore」·「Scene 2: …」처럼 콜론 앞이 작품 이름인
악장·대목 work 인데, MusicBrainz 에 그 부모 작품이 없거나 부모 관계(parts)가 걸려 있지 않아요
(오르프 「Antigonae」, 하킴 「Theotokos」, 글래스 「A Brief History of Time」은 MB 에서 이 작곡가의
작품을 찾아도 부모 work 가 없어요). 4차 규칙은 이런 콜론 제목을 `odd` 로 빼고, MBID 로 이을 곳이
없으니 `unreviewed` 로 두었어요. 작곡가 화면 맨 위에 낱곡으로 흩어져 보이던 까닭이에요.

## 정한 순서 (`tools/leftover.py`)

1. **중복**: 같은 작품이 이미 손 작품으로 있는 seed 는 중복 정리
   (`../duplicate-pieces-2026-11-11/gen_sql.py`)와 같은 SQL 로 숨기고(`hidden_reason='duplicate'`),
   그 seed 를 가리키던 행(식별자·카드·즐겨찾기 등)을 남길 작품으로 옮기고 남길 작품의 빈 칸을 채워요.
   20개는 MB 식별자가 없는 seed 의 원제가 남길 손 작품의 MB work 제목과 글자까지 같았고,
   2개(보케리니 8145, 알베니스 10216)는 중복 정리 작업이 넘겨 준 짝이에요.
2. **편곡·다른 판**: MB 에서 편곡·다른 판으로 표시됐거나 같은 MB work 를 다른 작품이 이미 쓰면 숨겨요.
   이번에는 해당하는 seed 가 없었어요.
3. **카탈로그 part 에 잇기**: 카탈로그 작품의 part 와 같은 곡이면 그 part 의 `linked_piece_id` 로 잇고
   제목을 「<작품> 중 "<곡>"」으로 바꾼 뒤 잠가요(영어 제목은 seed 의 MB 원제 그대로). 같은 곡으로 보는 조건:
   - MB 제목이 정규화해서 같거나,
   - 콜론 앞 작품번호(Op.·G.·Wq. …)가 겹치고, 악장 번호가 같고, 악장 이름이 같거나 철자만 달라요
     (「Minuetto e Trio」·「Minuetto – Trio」, 「Allemande」·「Allemande Légère」).
   - part 가 이미 다른 작품을 가리키면 그 작품의 중복으로 숨기고, 같은 part 에 seed 가 둘 맞으면
     먼저 것만 잇고 나머지는 그대로 둬요.
4. **이름 묶음**: 같은 작곡가에서 콜론 앞 이름이 같은 seed 가 둘 이상이면 그 이름으로 묶음 작품
   (`origin='manual'`, `type='album'`, 잠금)을 새로 만들고 seed 를 그 안 곡으로 이어요(6차 음반 묶음과 같은 꼴).
   - 제목: seed 의 우리말 제목 앞부분(「<파우스트의 겁벌> 중 "…"」의 앞)이 모두 같으면 그것, 아니면
     4차 제목 규칙(`auto_catalog.translate`), 못 옮기면 원제. 이미 있는 제목과 겹치면 원제를 덧붙여요.
   - 곡 순서: 악장 번호가 다 다르면 번호순, 아니면 seed 가 가장 많이 실린 공식 판의 트랙 순서.
   - 묶지 않는 것: 콜론 앞이 갈래 이름뿐인 것(「Himno: …」·「Scherzo: …」), 곡마다 작품번호가 달라
     서로 다른 작품인 것(아이브스 「Scherzo: …, S. 81」·「…, S. 82」, C.P.E. 바흐 「4 Keyboard Pieces」).
   - 카탈로그에 같은 작품이 이미 있으면 새로 만들지 않아요. 같은 작품으로 보는 조건은 이름(정규화)·
     작품번호가 맞거나, seed 의 우리말 앞부분이 그 작품 제목과 같거나, seed 곡 이름 절반 넘게가 그 작품의
     part 이름과 같고 번호·조성이 어긋나지 않을 때예요. 그러면 맞는 part 에 잇고(쿠프랭 비올 모음곡
     1·2번), part 가 없는 곡은 그대로 둬요(거슈윈 「포기와 베스」 두 곡).
   - 같은 이름의 MB 작품이 있으면(베를리오즈 「파우스트의 겁벌」) 그 MBID 를 묶음에 붙여요.
   - 갈래·형식은 `../piece-forms-2026-11-07/classify.py` 규칙으로 바로 정해지면 넣고, 아니면 비워 둬요.
5. **음반 묶음**: 남은 낱개 seed 는 녹음이 실린 MB 음반(release group)이 같은 것끼리 셋 이상이면 음반 이름으로
   묶어요(6차 `film_catalog.py` 의 음반 고르기 순서). 모음집·실황·전집처럼 음반 이름이 작품 이름이 될 수 없는
   음반과, 작품번호가 있어 따로 선 작품인 seed 는 빼고 봐요. 곡 순서는 대표 판의 트랙 순서예요.
6. **그대로**: 그 밖은 손대지 않고 보이게 둬요(판단 보류).

결정마다 근거(MB work URL, 이은 part, 묶음 이름, 음반 URL)를 `decisions.jsonl` 에 남겼어요. 새 묶음 작품의
구조는 `catalog/<작곡가>.json`(4차 `catalog.json` 꼴)이고, SQL 은 4차 `gen_catalog.py` 의 `work_block` 이 만들어요.

## 결과

seed 609 → 잇기 24, 묶음 안 곡 438(이름 묶음 69개 351곡·음반 묶음 4개 87곡), 중복 숨김 22, 그대로 125.

| 작곡가 | seed | 잇기 | 묶음 안 곡 | 새 묶음 | 중복 숨김 | 그대로 |
|---|---:|---:|---:|---:|---:|---:|
| 마이클 나이먼 | 74 | 0 | 73 | 6 | 0 | 1 |
| 니코 멀리 | 44 | 0 | 43 | 4 | 0 | 1 |
| 프랑수아 쿠프랭 | 40 | 10 | 26 | 4 | 0 | 4 |
| 보케리니 | 39 | 13 | 22 | 9 | 1 | 3 |
| 오르프 | 35 | 0 | 35 | 1 | 0 | 0 |
| 베베른 | 30 | 0 | 20 | 4 | 3 | 7 |
| 필립 글래스 | 25 | 0 | 22 | 2 | 0 | 3 |
| 베를리오즈 | 23 | 0 | 21 | 1 | 1 | 1 |
| 아이브스 | 21 | 0 | 0 | 0 | 3 | 18 |
| 나지 하킴 | 19 | 0 | 18 | 3 | 0 | 1 |
| 브리튼 | 18 | 0 | 11 | 1 | 3 | 4 |
| 조지 크럼 | 18 | 0 | 18 | 3 | 0 | 0 |
| 그 밖 57명 | 223 | 1 | 129 | 35 | 11 | 82 |

큰 묶음: 오르프 「Antigonae」 35곡, 나이먼 「McQueen」 30곡·「Man and Boy: Dada」 19곡·「War Work」 8곡·
「트롬본과 관현악을 위한 협주곡」 9악장, 멀리 「Two Boys」 30곡, 베를리오즈 「극적 전설 <파우스트의 겁벌>」 21곡,
글래스 「A Brief History of Time」 20곡, 쿠프랭 「모테트의 7개 절」 14곡, 브리튼 「<The Prince of the Pagodas>
전주곡과 춤곡 Op. 57b」 11곡.

## 다시 만들기 (`seed_pipeline` 에서)

```bash
W=<작업 폴더>
# 1. 결정에 쓰는 읽기 덤프. 운영에 0501(중복 합치기)·0701·0702 가 먼저 들어가므로, 그 셋을 넣은 시험 DB 에서 받았다.
curation/catalog-wave6-2026-11-10/tools/devdb.sh dump $W/devdb
curation/catalog-wave6-2026-11-10/tools/devdb.sh up cm-seed-mysql 3411 $W/devdb
#    (0501·0701·0702 를 시험 DB 에 넣는다)
curation/leftover-seeds-2026-11-11/tools/dump.sh $W/db cm-seed-mysql $W/devdb
# 2. 결정과 마이그레이션. MB 응답은 CM_FETCH_CACHE 에 남는다(1.1초 간격, 연락처 User-Agent).
CM_FETCH_CACHE=$W/cache uv run python curation/leftover-seeds-2026-11-11/tools/leftover.py \
  --db $W/db --dup-decisions curation/leftover-seeds-2026-11-11/dup_decisions.json \
  --dup-gen curation/duplicate-pieces-2026-11-11/gen_sql.py \
  --out curation/leftover-seeds-2026-11-11 --migrations ../migrations --first 202611110601
# 3. 시험: 파일마다 트랜잭션으로 두 번 넣어 시간·멱등성 확인
curation/catalog-wave6-2026-11-10/tools/test_apply.sh cm-seed-mysql $W/devdb ../migrations/20261111060*.sql
```

## 시험

0501·0701·0702 를 먼저 넣은 시험 DB(`cm-seed-mysql`, 운영 카탈로그 읽기 덤프)에 세 파일을 파일마다 한 트랜잭션으로
넣어 1~3초, 한 번 더 넣어도 pieces·piece_parts·식별자가 바뀌지 않았어요. 작품 26,461 → 26,534(새 묶음 73),
숨긴 작품 3,580 → 3,602, part 49,767 → 50,205. 결정한 seed 마다 잇기·묶음은 part 가 가리키고, 중복은 숨겨졌고,
그대로 둔 것은 바뀌지 않았어요. 보이는 작품이 0개인 작곡가는 전과 같아요(60명, 원래부터 작품이 모두 숨겨진 작곡가).
갈래와 형식이 어긋난 작품은 0개예요. 그 DB 로 띄운 백엔드가 마이그레이션을 기록하고 `/composers/<id>/catalog`·
`/pieces/<id>/parts` 를 정상으로 돌려줬어요.

## 애매해서 그대로 두거나 그대로 만든 것

- 거슈윈 1382·2229 「포기와 베스」 아리아: 카탈로그 333 「오페라 <포기와 베스>」의 part 이름과 안 맞아 그대로.
- 쿠프랭 24846 「모음곡 2번 중 "Fuguette"」: 비올 모음곡 2번의 「Fuguète」와 철자가 달라 못 이음.
- 엘가 1884 「성모 마리아를 위한 4개의 연도 Op. 2 중 "Ave Maria"」: 같은 part 에 871 을 이어 그대로(4 Litanies 가 Op. 2 와 같은 곡인지 근거 없음).
- 쿠프랭 「콩세르 1번」·「콩세르 2번」 묶음: MB 원제 「Première/Deuxième concert」를 그대로 옮긴 이름이고 곡(La Flore 등)이
  「왕궁의 콩세르」 1·2번과 달라요. 클라브생 곡을 합주로 엮은 음반 프로그램으로 보여 묶음 이름만 원제를 따랐어요.
- 보케리니 「첼로와 관현악을 위한 협주곡 B♭장조」: 9번(G. 482)과 같은 곡으로 보이지만 제목이 이탈리아어라 닮음을 못 재서 새 묶음으로 뒀어요.
- 아이브스 연습곡 18곡·카베사우에카 10곡 등 낱곡: 따로 선 작품이거나 같은 이름·음반으로 묶을 근거가 없어 그대로.
- 거슈윈 2286 「뮤지컬 <Crazy for You>」: MB 식별자가 없고 손 작품 중복도 아니어서 그대로.
