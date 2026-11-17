# '기타' 갈래 줄이기 (2026-11-17)

작곡가 화면에서 갈래가 없어 '기타'로 보이는 작품(`pieces.genre IS NULL`)이 4,982곡(보이는 최상위 작품 19,043곡의 26.2%)이었어요.
사용자가 고른 범위(손 카탈로그 표시 옮기기, 제목 낱말 규칙, 한 가지 매체 작곡가, MusicBrainz 다시 받기, 비제·마스네 대본 대목 정리)만 했어요.

**빈 칸만 채워요.** 이미 값이 있는 `genre`·`form_key` 는 건드리지 않고, 틀린 갈래는 '기타'보다 나쁘니 출처끼리 어긋나거나
MusicBrainz 가 가사 유무로 반대하면 비워 둬요.

## 파일

| 파일 | 내용 |
|---|---|
| `opera_excerpts.py` · `opera_excerpts.json` | 비제·마스네 대본 대목 118줄 판정 → `202611170001` |
| `fetch_mb.py` | '기타' 작품 MBID 4,787개의 MusicBrainz work 받기(6차 `fetch.py` 의 간격·User-Agent·캐시) · 묶기 |
| `mb_works.jsonl.gz` | 받은 응답 원문(`inc=artist-rels+work-rels+tags+genres`). 다시 받지 않고 이것만 읽어요 |
| `fill.py` | 출처별 신호 → 판정 → `fills.jsonl` · 마이그레이션 `202611170002`~`0005` |
| `fills.jsonl` | 채운 작품마다 갈래·형식·규칙·근거·같은 답을 낸 다른 규칙 |

## 결과

시험 DB(운영 마이그레이션 202611120701 까지와 pieces·piece_parts 가 덤프와 차이 0)에서 브랜치 백엔드가 sqlx 로 다섯 파일을 넣은 뒤 잰 값이에요.
API `/composers/<id>/catalog` 402명 합계와 SQL 값이 같아요.

| | 보이는 최상위 작품 | '기타' 전 | '기타' 뒤 |
|---|---:|---:|---:|
| 전체 | 19,043 → 18,925 | 4,982 (26.2%) | **3,739 (19.8%)** |
| S | 6,028 | 394 (6.5%) | 122 (2.0%) |
| A | 5,177 → 5,091 | 1,258 (24.3%) | 943 (18.5%) |
| B | 7,603 → 7,571 | 3,263 (42.9%) | 2,644 (34.9%) |
| C | 235 | 67 (28.5%) | 30 (12.8%) |

줄어든 1,243곡 = 숨김 118 + 채움 1,125.

| 마이그레이션 | 줄 | 내용 |
|---|---:|---|
| `202611170001_hide_opera_libretto_excerpt_rows` | 118 | 대본 대목 숨김(duplicate 90, catalog_unmatched 28) |
| `202611170002_fill_genre_from_catalog_marks` | 455 | 1~3차 손 카탈로그 갈래 표시 |
| `202611170003_fill_genre_from_title_words` | 161 | 제목 낱말 |
| `202611170004_fill_genre_from_musicbrainz` | 357 | MusicBrainz |
| `202611170005_fill_genre_by_single_medium_composer` | 152 | 한 가지 매체 작곡가 |

다섯 파일을 sqlx 가 넣는 데 0.67초(0.42·0.12·0.05·0.05·0.03초)예요. 한 트랜잭션으로 한 번 더 넣어도 pieces 해시가 같아요(멱등).
갈래와 형식이 어긋나거나 한쪽만 찬 작품은 전후 모두 0이에요.

## 판정 순서 (`fill.py`)

대상은 보이는 작곡가의 보이는 최상위 작품 중 갈래·형식이 둘 다 빈 것(4,982곡)이에요. 출처마다 갈래 신호를 내고,

1. 출처끼리 갈래가 다르면 비워요(7곡).
2. 같으면 앞 출처(catalog → words → mb → composer)의 형식을 써요.
3. MusicBrainz 가 가사가 있다고 하면(언어가 zxx 가 아니거나 작사가 관계) 기악 갈래를 막고(3곡),
   가사가 없다고 하면(zxx, 목소리가 적힌 설명·성악 유형 없음) 성악 갈래를 막아요(2곡). 무대는 서곡·발레가 있어 막지 않아요.
4. `REJECT`(손으로 본 오탐 15곡)와 classify.py 의 `UNDECIDED`(20곡)는 비워요.

### catalog — 1~3차 손 카탈로그 표시 (455곡)

1~3차 카탈로그(`*catalog*/**/catalog.json`, 4~6차 자동 제외)의 `genre` 표시가 이미 있었는데 classify.py 가 읽지 않았어요.
`existingPieceId` 와 작품 MBID 로 이어요. **편성을 말하는 표시만** 옮겨요(`MARK_FORM`: piano·keyboard·organ·songs·part_song·sacred·psalm·
chamber·violin_piano·violin_orchestra·guitar·orchestral 등). 한 작품에 표시가 둘이면 빼요.

옮기지 않은 표시(건수만): 정책이 필요한 canon 16·dance 12·variations 15·melodrama 15(멜로드라마로 셈),
형식만 있고 편성이 없는 divertimento 7·waltz 3·capriccio 2·potpourri 2·suite 2·carillon·concerto·csardas·march·perpetuum·prelude·rhapsody·romance·sonata 각 1.
(드보르자크 「프라하 왈츠」처럼 관현악인 왈츠가 있어서예요. 이 중 일부는 MB 가 편성을 알려 채워졌어요.)
형식 고침 1곡: 멘델스존 리더슈필 「타향에서의 귀향」은 표시가 opera 지만 형식은 오페레타·징슈필.

전수 확인: 455곡을 모두 봤고 틀린 갈래를 못 찾았어요.

### words — 제목 낱말 (161곡)

| 규칙 | 채움 | 확인 |
|---|---:|---|
| 막·발췌(`Carmen: Act II.`, `오페라 <…> 중`, `zur Oper`) | 14 | 전수 15개 확인, 오탐 0. 1곡(브루흐 「Loreley」 서주)은 MB 가 피아노 편곡판이라 어긋나 비움 |
| 무대 작품(`뮤지컬 <`, `발레 음악 <`, `…발레 <`) | 4 | 전수, 오탐 0 |
| 영화(`Music to the Film`, `film scores`, `love theme`, `soundtrack`) | 21 | 전수, 오탐 0 |
| 종교 전례문(`Tantum ergo`·`O salutaris`·`Ave verum`·`Laudate pueri`·`Dixit Dominus`·모테트·시편 …) | 59 | 전수, 오탐 0 |
| 종교 낱말 + MB 가사(`hymn`·`carol`·`canticle`·`credo`·`gloria`·`litany`·`lux aeterna` …) | 23 | 전수, 오탐 0 |
| 노래 묶음(`Lieder`·`Gesänge`·`chansons`·`mélodies`·`folksongs`·`canzonette`·`n중창`·`합창`·`가곡`) | 26 | 전수, 오탐 0. 야나체크 「15 Moravian Folksongs」(피아노)·쾨클랭 「Chansons Bretonnes」(첼로)는 MB zxx 로 막힘 |
| 노래 낱말 + MB 가사(`song`·`lied`·`chant`·`aria`·`voice`·`ode`·`노래` …) | 14 | 전수, 오탐 0 |

버리거나 좁힌 것(처음 넓게 걸었을 때 나온 오탐):
- 영어 `ballet`·`musical`·`prologue`: 베를리오즈 「Le Ballet des ombres」(합창), 파가니니 「Balletto campestre」 변주곡, 로드리고 「Air de ballet」(피아노),
  번스타인 「A Musical Toast」, 베토벤 「음악적 농담」 카논 8곡, 미뇽 「Momento musical」 → 우리말 접두사와 `Ballet Music` 만 남김.
- 영화 `TV`·`드라마`: 케이지 「TV Koln」(피아노), 멜로드라마 → 뺌.
- 종교 낱말을 모두 성악으로 보면: 오르간·건반 버셋(카베손·하킴·바티스트의 찬가·시편, 프랑크·생상스 봉헌송·입당곡, 브리튼 「Voluntary」),
  케이지 「Credo in US」(타악기), 브랜트 「Litany of Tides」, 파가니니 「애국 찬가」 변주곡, 리스트 「2개의 찬가」(피아노), 카웰 「Antiphony」(관현악) →
  오르간 낱말(offertoire·entrée·voluntary·verset·glosa·tiento·choral …)·악기 낱말이 있으면 막고, 건반 작곡가 셋은 빼고, 애매한 낱말은 MB 가사가 있을 때만.
- 노래 낱말을 모두 성악으로 보면: 「Gondellied」·「Wiegenlied」(피아노), 사라사테 「Canciones rusas」·「치고이너바이젠」, 생상스 「Chant saphique」(첼로),
  암브로시니 「Canzone」(기악 칸초나), 메시앙 「Chant dans le style de Mozart」, 스트라빈스키 「러시아 민요에 의한 카논」, 「Voices」(현악 4중주) 등 → 애매한 낱말은 MB 가사가 있을 때만.

### mb — MusicBrainz (357곡)

'기타' 작품 MBID 4,787개를 다시 받았어요(`fetch_mb.py`, 1.1초 간격·시드 도구 공용 연락처 User-Agent, 두 프로세스가 잠금 하나로 간격을 나눔, 약 2시간 10분).

| 규칙 | 채움 | 확인 |
|---|---:|---|
| `disambiguation` 의 편성(「for piano」「for voice and piano」「for orchestra」 …, classify.py 의 편성 관문으로 읽음) | 130 | 전수. 오탐 2(슈토크하우젠 「Mixtur」 링 모듈레이터, 딘 「The World's Wife」 메조소프라노) → REJECT |
| 작사가 관계(대본 작가 없음, 제목에 악기 없음) → 성악 | 221 | 전수. 무대·전자·멜로드라마로 본 12곡은 REJECT, 울만 「기수 릴케」 4줄은 멜로드라마(범위 밖) |
| 작품 유형(Symphonic poem·Song·Symphony·Concerto·Soundtrack) | 6 | 전수, 오탐 0 |
| 부모 작품의 갈래 | 0 | 부모 work 가 우리 DB 의 갈래 있는 작품인 경우가 없었음 |

가사 언어만으로는 성악과 무대를 못 가려요. 작사가 규칙에서 나온 무대 작품(거슈윈 「La La Lucille」·「Tip-Toes」·「Scandals of 1924」,
본 윌리엄스 「The Shepherds of the Delectable Mountains」, 브리튼 「This Way to the Tomb」·「The Golden Vanity」 등)은 손으로 보고 비웠어요.
그래서 이 규칙의 형식은 대개 '그 밖의 성악'이에요(제목에 노래·합창·종교 낱말이 있으면 그 형식).

### composer — 한 가지 매체 작곡가 (152곡)

데이터 쏠림이 아니라 작품 목록이 그 매체뿐인 작곡가만 손으로 골랐어요(`COMPOSER_DEFAULTS`). 제목에 다른 편성이 적혀 있으면 붙이지 않아요.

| 작곡가 | 곡 | 갈래/형식 |
|---|---:|---|
| 카베손 | 43 | 피아노(건반)/그 밖의 곡, 「órgano」 제목은 오르간 |
| 공베르 | 35 | 성악/합창곡(전례문 4곡은 낱말 규칙이 모테트·종교곡으로) |
| 타레가 | 20 | 실내악/무반주 독주(기타) |
| 체스노코프 | 20 | 성악/모테트·종교곡 |
| 요베트 | 12 | 실내악/무반주 독주(기타) |
| 고도프스키 | 10 | 피아노/그 밖의 곡 |
| 세르통 | 6 | 성악/합창곡 |
| 바티스트 | 6 | 피아노/오르간 |

넣지 않은 작곡가: 레쿠오나(분류된 곡은 성악이 많지만 남은 건 피아노 춤곡), 소르(오페라·발레·노래도 씀), 브라우어(협주곡·영화음악),
하킴(합창도 씀), 니콜라 렌스(무대·성악 음반 트랙) 등.

## 비제·마스네 대본 대목 118줄 (`opera_excerpts.py`)

4차 자동이 오페라 작품과 그 part 를 만들면서 같은 MusicBrainz work 를 낱개 작품으로도 넣었어요.

| 오페라 | 줄 | 처리 |
|---|---:|---|
| 카르멘(193) 영어 번역 대목 | 59 | part 와 MBID 같음 → `duplicate` |
| 상드리용(8783) | 31 | part 와 MBID 같음 → `duplicate` |
| 진주조개잡이(33156) 독일어 대목 | 27 | 원어 작품과 이어지지 않은 번역판 work → `catalog_unmatched`(번역판 전곡 11541 선례) |
| 마농(33216) 이탈리아어 대목 | 1 | 같음 |

- **잇지 않고 숨긴 까닭**: part 에 `linked_piece_id` 로 이으면 화면이 그 part 의 곡별 링크 대신 이어진 작품의 링크를 써요
  (front `features/composer/components/piece-row.tsx` `PiecePartRow`). 대목 줄은 링크가 하나도 없고 상드리용 part 는 33곳 중 28곳에 링크가 있어,
  이으면 오페라 안 곡의 Apple Music·Spotify 링크가 사라져요.
- **참조 확인**: 11/17 운영 읽기 SELECT 로 118줄을 가리키는 행을 셌어요. 비교 구간·공연·카드·대표곡·관계·별칭·편성·추천 특징·인기 비교·영화 큐·음원 연결·
  part(소유·이어짐)·사용자 즐겨찾기·취향 씨앗·들은 기록 모두 0, 작품의 링크·설명·대표곡 표시도 0이고, 식별자(MBID)만 118행이에요.
  식별자는 part 수준 work 라 오페라 작품으로 옮기지 않아요. SQL 도 이 표들이 비어 있을 때만 숨겨요.
- 9/10 시드 줄 11443 「Carmen: Act II. Entr'acte…」(낱말 규칙이 무대·발췌로 채움)과 이미 갈래가 있는 33206 「상드리용 4막 중 Marche des Princesses」는 손대지 않았어요.

## 범위 밖으로 남긴 것 (건수만, 3,739곡 안)

| 묶음 | 곡 |
|---|---:|
| 글래스·나이먼·멀리·킬라르 낱개 영화 큐(음반 묶음 여부 미정) | 795 (266·231·169·129) |
| 피아졸라 탱고 | 142 |
| 멜로드라마(낭독+피아노·관현악: 시벨리우스·리스트·그리그·스트라빈스키 「페르세포네」·울만 「기수 릴케」·풀랑크 「바바」 등) | 29 + REJECT 1 |
| 전자·테이프(설명·제목에 tape·electronic) | 6 + REJECT 3 |
| 1~3차 표시가 정책 필요(canon·dance·variations) | 43 (일부는 다른 출처로 채워짐) |
| LLM 분류, 생애 시기 | 하지 않음 |

나머지 약 2,700곡은 낱말·MB 신호가 없는 고유 제목이에요(MB 에 편성 설명·가사 정보가 없음).

## 다시 만들기

`seed_pipeline` 에서

```bash
curation/piece-genre-fixes-2026-11-11/tools/dump.sh <덤프>   # classify_input.tsv·composers.tsv·piece_forms.tsv
curation/catalog-wave6-2026-11-10/tools/dump.sh <덤프6>     # piece_parts.tsv
F=curation/piece-genre-fill-2026-11-17
uv run python $F/opera_excerpts.py --db <덤프> --parts <덤프6>/piece_parts.tsv --out $F/opera_excerpts.json \
  --migration ../migrations/202611170001_hide_opera_libretto_excerpt_rows.sql
# MB 를 다시 받을 때만(지금은 mb_works.jsonl.gz 를 그대로 씀)
CM_FETCH_CACHE=<캐시> uv run python $F/fetch_mb.py fetch --mbids $F/mbids.txt
CM_FETCH_CACHE=<캐시> uv run python $F/fetch_mb.py pack --mbids $F/mbids.txt --out $F/mb_works.jsonl.gz
uv run python $F/fill.py --db <덤프> --mb $F/mb_works.jsonl.gz --excerpts $F/opera_excerpts.json \
  --out $F/fills.jsonl --migrations ../migrations
```

이미 적용된 마이그레이션은 고치지 않아요. 다시 고칠 땐 규칙·`REJECT` 를 고치고 새 번호로 만들어요.
