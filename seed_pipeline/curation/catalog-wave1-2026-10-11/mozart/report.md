# 모차르트 작품 카탈로그 — 보고

데이터만 만들었습니다(DB·git·kubectl 안 씀). 결과는 `catalog.json`, 원자료는 `raw/`, 스크립트는 `scripts/` 입니다.

- 기준: 위키백과 영어판 *List of compositions by Wolfgang Amadeus Mozart* 와 이 문서가 넘겨주는 하위 목록 3개(*List of symphonies…*, *List of solo piano compositions…*, *List of concert arias, songs and canons…*). 연도는 위키백과 *Köchel catalogue* 표(쾨헬 9판 반영)에서 가져왔습니다.
- MusicBrainz: 모차르트 artist(b972f589…) work 5,584개를 browse(aliases+work-rels, 100개씩 56번)로 받았고, 낱개 조회는 레퀴엠 상투스 part 1번뿐입니다. `raw/browse_works.json`, `raw/lookup_works.json`.
- 순서: `defs.py`(손으로 정한 작품·뺀 것) → `mbmatch.py`(MB 후보 점수) → `build.py`(catalog.json) → `validate.py` → `wikicheck.py` → `outside.py` → `report.py`.
- `catalog.json` 에는 SPEC 칸 밖에 `note` 하나를 더 넣었습니다(미완성·판본·의심 같은 사정, 없으면 null).

## 1. 개수

| 갈래 | 작품 | part | children |
|---|---:|---:|---:|
| 묶음(collection) | 32 | 199 | – |
| 다악장(multi_movement) | 273 | 1147 | 58 |
| 낱곡(single) | 226 | – | – |
| 합계 | 531 | 1346 | 58 |

children 은 미사·레퀴엠의 절 아래 세부(예: 글로리아 → Laudamus te)만 있습니다. 묶음 안 곡이 다시 악장으로 나뉘는 경우는 모차르트에는 없습니다.

갈래(genre)별: aria 59, symphony 43, dance 35, violin_sonata 32, song 32, piano_concerto 25, string_quartet 24, piano_piece 23, canon 22, sacred 21, chamber 20, divertimento 20, piano_sonata 18, opera 18, variations 17, church_sonata 17, mass 16, serenade 11, march 11, concerto 9, violin_concerto 8, piano_trio 6, string_quintet 6, piano_four_hands 5, cantata 5, horn_concerto 4, litany 4, cassation 3, organ 3, vespers 3, two_pianos 2, piano_quartet 2, ballet 2, oratorio 2, requiem 1, orchestral 1, incidental_music 1

MB work 가 없는 작품 4개: K. 386(피아노와 관현악을 위한 론도 A장조), K. 535a(3개의 콩트르당스 K. 535a), K. 587(콩트르당스 C장조 "코부르크 영웅의 승리"), K. 89a(네 악기를 위한 카논 A장조). part 중 MBID 없는 것 5개(K. 535a 3곡, K. 66 글로리아·크레도 절 — MB 가 절 단위 work 없이 세부만 둠).

## 2. 운영 기존 작품 대응

| 운영 id | 운영 제목 | key | 이쪽 제목 | 맞춘 근거 | 비고 |
|---:|---|---|---|---|---|
| 66 | 아이네 클라이네 나흐트무지크 | mozart-k525 | 세레나데 13번 G장조 "아이네 클라이네 나흐트무지크" | MBID | 제목 다름 |
| 67 | 교향곡 40번 G단조 | mozart-k550 | 교향곡 40번 G단조 | MBID |  |
| 68 | 교향곡 41번 C장조 "주피터" | mozart-k551 | 교향곡 41번 C장조 "주피터" | MBID |  |
| 69 | 오페라 <피가로의 결혼> | mozart-k492 | 오페라 <피가로의 결혼> | MBID |  |
| 70 | 오페라 <마술피리> | mozart-k620 | 오페라 <마술피리> | MBID |  |
| 71 | 레퀴엠 D단조 | mozart-k626 | 레퀴엠 D단조 | 카탈로그(K. 번호) | 운영 MBID e3442502 는 "Requiem, K. 626 [for piano solo, Klindworth]"(편곡) → 이쪽 mbid 는 32c8943f |
| 72 | 피아노 협주곡 20번 D단조 | mozart-k466 | 피아노 협주곡 20번 D단조 | MBID |  |
| 73 | 피아노 소나타 11번 A장조 "터키 행진곡" | mozart-k331 | 피아노 소나타 11번 A장조 "터키 행진곡" | MBID |  |
| 74 | 클라리넷 협주곡 A장조 | mozart-k622 | 클라리넷 협주곡 A장조 | MBID |  |
| 434 | 호른 협주곡 4번 E♭장조 | mozart-k495 | 호른 협주곡 4번 E♭장조 | MBID |  |
| 435 | 피아노 소나타 16번 C장조 "쉬운 소나타" | mozart-k545 | 피아노 소나타 16번 C장조 "쉬운 소나타" | MBID |  |
| 436 | "아! 어머니께 말씀드리죠" 주제에 의한 변주곡 | mozart-k265 | "아! 어머니께 말씀드리죠" 주제에 의한 12개의 변주곡 C장조 | MBID | 제목 다름; 연도 운영 1781 / 이쪽 1781–1782 |
| 26035 | 네 손을 위한 피아노 소나타 C장조 | mozart-k521 | 네 손을 위한 피아노 소나타 C장조 | MBID |  |
| 26041 | 교향곡 25번 G단조 | mozart-k183 | 교향곡 25번 G단조 | MBID |  |
| 26042 | 세레나데 10번 B♭장조 "그랑 파르티타" | mozart-k361 | 세레나데 10번 B♭장조 "그랑 파르티타" | MBID | 연도 운영 1781 / 이쪽 1783–1784 |
| 26043 | 오페라 <돈 조반니> | mozart-k527 | 오페라 <돈 조반니> | MBID |  |
| 26046 | 두 대의 피아노를 위한 소나타 D장조 | mozart-k448 | 두 대의 피아노를 위한 소나타 D장조 | MBID |  |
| 26058 | 피아노 협주곡 21번 C장조 | mozart-k467 | 피아노 협주곡 21번 C장조 | MBID |  |

- 운영 모차르트 작품 18개 모두 대응했습니다. 17개는 MBID, 1개(71 레퀴엠)는 K. 번호로 맞췄습니다.
- **71 레퀴엠의 운영 MBID(e3442502)는 클린트보르트의 피아노 독주 편곡 work** 입니다. 이쪽 mbid 는 쥐스마이어 판 work(32c8943f) 로 두었습니다. 운영 piece_identifiers 를 바꿀지는 리드가 정해야 합니다.
- 운영 안에 같은 작품이 둘인 경우는 없습니다. 운영 piece_parts 에 모차르트 part 는 없어 existingPartId 는 모두 null 입니다.
- 운영 제목과 다른 것 2개: 66 은 갈래 이름 꼴(`세레나데 13번 G장조 "아이네 클라이네 나흐트무지크"`), 436 은 곡 수·조성을 더한 꼴로 제안만 했습니다. 운영 제목을 그대로 둘지 리드가 정하면 됩니다.

## 3. 뺀 것과 까닭

위키백과 목록(본 목록+하위 목록)에 K. 번호가 적힌 항목 중 넣지 않은 것은 모두 `defs.EXCLUDED` 에 까닭과 함께 있습니다.

| 갈래 | 개수 |
|---|---:|
| 위작·위작 의심 | 43 |
| 남의 작품·편곡·전사 | 32 |
| 같은 곡의 다른 판 | 2 |
| 단편·미완성·스케치 | 85 |
| 소실 | 9 |
| 연습·습작 | 2 |

(같은 작품이 K1·K6 두 번호로 한 번씩 들어간 것이 몇 있어 작품 수보다 조금 많습니다: 385h/Anh. 34, 562c/Anh. 191.)

### 위작·위작 의심 — 43

- K. 140 — 미사 브레비스 G장조 "전원" — 위키백과 attribution uncertain, K6 Anh. 235d
- K. 177 — 봉헌송 Sub exposito venerabili — doubtful (Anh. C 3.09, 레오폴트 모차르트)
- K. 198 — 봉헌송 Sub tuum praesidium — doubtful (Anh. C 3.08)
- K. 142 — 탄툼 에르고 B♭장조 — K6 Anh. C 3.04
- K. 197 — 탄툼 에르고 D장조 — K6 Anh. C 3.05
- K. 90 — 키리에 D단조 — 위키백과 Fragments 절, 쾨헬 9판 doubtful
- K. 268 — 바이올린 협주곡 "6번" E♭장조 — 에크 작으로 봄 (Anh. C 14.04)
- K. 271a — 바이올린 협주곡 "7번" D장조 "콜프" — doubtful
- K. Anh. 294a — 바이올린 협주곡 "아델라이드" — 카사드쥐 위작
- K. 230a — 바순 협주곡 B♭장조 — Anh. C 14.03, 드비엔 작으로 봄
- K. 294b — 오보에 협주곡 E♭장조 — Anh. C 14.06 doubtful
- K. 297b — 네 관악기를 위한 신포니아 콘체르탄테 — Anh. C 14.01, 남은 악보는 위작 의심 편곡
- K. 19d — 네 손을 위한 소나타 C장조 — doubtful
- K. 630 — 바이올린 소나타 D장조 — doubtful
- K. 562c — 현악 4중주를 위한 카논 C장조 (Anh. 191) — doubtful
- K. Anh. 191 — 현악 4중주를 위한 카논 C장조 (K. 562c) — doubtful
- K. 187 — 디베르티멘토 5번 C장조 — 레오폴트 모차르트 작 (Anh. C 17.12)
- K. 289 — 디베르티멘토 16번 E♭장조 — doubtful
- K. 439b — 세 바셋 호른을 위한 5개의 디베르티멘토 (Anh. 229) — 쾨헬 9판 doubtful
- K. 105 — 6개의 미뉴에트 K. 105 — doubtful, 미하엘 하이든 작
- K. 106 — 서곡과 3개의 콩트르당스 — doubtful
- K. 510 — 9개의 콩트르당스 — Anh. C 13.02 위작
- K. Anh. 65a — 교회 소나타 D장조 — 레오폴트 모차르트 작, 단편
- K. 623a — 합창곡 Laßt uns mit geschlungnen Händen — doubtful
- K. 84 — 교향곡 11번 D장조 — doubtful
- K. 75 — 교향곡 42번 F장조 (GA 42) — doubtful
- K. 76 — 교향곡 43번 F장조 (GA 43) — doubtful
- K. 81 — 교향곡 44번 D장조 (GA 44) — doubtful
- K. 95 — 교향곡 45번 D장조 (GA 45) — doubtful
- K. 96 — 교향곡 46번 C장조 (GA 46) — doubtful
- K. 97 — 교향곡 47번 D장조 (GA 47) — doubtful
- K. Anh. 216 — 교향곡 54번 B♭장조 (K. 74g) — doubtful
- K. Anh. 214 — 교향곡 55번 B♭장조 (K. 45b) — doubtful
- K. 135+61h — 교향곡 D장조 K. 135+61h — 미뉴에트 악장 doubtful
- K. 17 — 교향곡 2번 B♭장조 — 레오폴트 모차르트 작
- K. 18 — 교향곡 3번 E♭장조 — 아벨 작
- K. 444 — 교향곡 37번 G장조 — 서주만 모차르트, 나머지 미하엘 하이든
- K. 98 — 교향곡 56번 F장조 (GA 56) — spurious
- K. Anh. 220 — 교향곡 A단조 "오덴세" (K. 16a) — spurious
- K. 460 — "Come un agnello" 주제에 의한 8개의 변주곡 — doubtful
- K. 498a — 피아노 소나타 B♭장조 — 뮐러 작
- K. 547a — 피아노 소나타 F장조 (Anh. 135) — 남이 K. 547·545 를 엮은 것
- K. 72a — 알레그로 G장조 — 미완성, doubtful

### 남의 작품·편곡·전사 — 32

- K. 37 — 피아노 협주곡 1번 F장조 — 라우파흐·호나우어 등 남의 소나타 악장을 협주곡으로 편곡 (쾨헬 9판 Anh. A 7)
- K. 39 — 피아노 협주곡 2번 B♭장조 — 남의 소나타 편곡 (Anh. A 8)
- K. 40 — 피아노 협주곡 3번 D장조 — 남의 소나타 편곡 (Anh. A 9)
- K. 41 — 피아노 협주곡 4번 G장조 — 남의 소나타 편곡 (Anh. A 16)
- K. 107 — 피아노 협주곡 3곡 K. 107 — J. C. 바흐 소나타 편곡 (Anh. A 29)
- K. 44 — 안티폰 Cibavit eos — 슈타틀마이어 곡 전사 (Anh. A 20)
- K. 152 — Ridente la calma — 미슬리베체크 아리아 편곡 (Anh. A 36)
- K. 236 — 안단티노 E♭장조 — 글루크 아리아 편곡 (Anh. A 41)
- K. Anh. 138 — 안단테 F장조 — 남이 K. 421 2악장을 옮긴 것
- K. 33B — 클라비어 소품 F장조 — 쾨헬 9판 Anh. A 6
- K. Anh. 137 — 클라리넷 5중주 K. 581 피날레 주제에 의한 6개의 변주곡 — 남이 옮긴 것 (Anh. 137)
- K. 626b — 알레그로 D장조 K. 626b/16 (2018년 발견) — 쾨헬 9판 Anh. A 66
- K. 404a — 현악 3중주를 위한 전주곡과 푸가 — J. S.·W. F. 바흐 푸가 편곡
- K. 405 — 현악 4중주를 위한 5개의 푸가 — J. S. 바흐 푸가 편곡
- K. 566 — 헨델 <아시스와 갈라테아> 편곡
- K. 572 — 헨델 <메시아> 편곡
- K. 591 — 헨델 <알렉산더의 향연> 편곡
- K. 592 — 헨델 <성 체칠리아의 날을 위한 송가> 편곡
- K. 101 — 4개의 콩트르당스 (세레나데 2번) — 미하엘 하이든 작 (쾨헬 9판 Anh. A 27)
- K. 104 — 6개의 미뉴에트 K. 104 — 미하엘 하이든 작 (Anh. A 28)
- K. 122 — 미뉴에트 E♭장조 — 쾨헬 9판 Anh. A 34 (남의 곡 전사)
- K. 269b — 체르닌 백작을 위한 콩트르당스 — 미하엘 하이든 작
- K. 61g — 2개의 미뉴에트 K. 61g — 2번이 미하엘 하이든 작이라 묶음으로 성립 안 함
- K. 233 — 카논 Leck mir den Arsch fein recht schön sauber — 트르녜카 작 (Anh. A 39)
- K. 234 — 카논 Bei der Hitz im Sommer eß ich — 트르녜카 작 (Anh. A 40)
- K. 346 — 노투르노 Luci care, luci belle — 쾨헬 9판 Anh. A 47 (자캥)
- K. 436 — 노투르노 Ecco quel fiero istante — 쾨헬 9판 Anh. A 47 (자캥)
- K. 437 — 노투르노 Mi lagnerò tacendo — 쾨헬 9판 Anh. A 47 (자캥)
- K. 438 — 노투르노 Se lontan, ben mio, tu sei — 쾨헬 9판 Anh. A 47 (자캥), 단편
- K. 439 — 노투르노 Due pupille amabili — 쾨헬 9판 Anh. A 47 (자캥)
- K. 625 — <현자의 돌> 2중창 Nun, liebes Weibchen — 공동 작품, 쾨헬 9판 Anh. A 64
- Der Stein der Weisen — 징슈필 <현자의 돌> — 여러 작곡가 공동 파스티초

### 같은 곡의 다른 판 — 2

- K. 208+(102/213c) — 행진곡과 디베르티멘토 C장조 — 행진곡 K. 214 와 교향곡 52번 K. 208+102 를 이어 부를 때의 이름, 따로 작품 아님
- K. 494 — 론도 F장조 — 피아노 소나타 15번 K. 533 의 3악장으로 고쳐 넣은 옛 판

### 단편·미완성·스케치 — 85

- K. 422 — 오페라 <카이로의 거위> — 미완성
- K. 430 — 오페라 <속은 신랑> — 미완성
- K. 223 — 호산나 G장조 — 위키백과 Fragments 절, 쾨헬 9판 Anh. H (습작)
- K. Anh. 18 — 키리에 C장조 단편
- K. Anh. 19 — 키리에 D장조 단편
- K. Anh. 17 — 키리에 D장조 — 로이터 곡, 쥐스마이어 완성
- K. Anh. 16 — 키리에 G장조 단편
- K. Anh. 13 — 키리에 C장조 단편
- K. 322 — 키리에 E♭장조 단편 (슈타들러 완성)
- K. Anh. 15 — 키리에 C장조 단편 (슈타들러 완성)
- K. Anh. 20 — 글로리아 C장조 단편
- K. Anh. 14 — 키리에 D장조 단편
- K. 299c — 발레 간주곡 단편
- K. Anh. 103 — <사냥> A장조 단편
- K. 446 — 판토마임 음악 단편
- K. Anh. 109 — 발레 <후궁의 질투> 스케치
- K. 71 — 아리아 Ah, più tremar non voglio 단편
- K. 209a — 아리아 Un dente guasto e gelato 단편
- K. 440 — 아리아 In te spero, oh sposo amato 스케치
- K. 435 — 아리아 Müßt' ich auch durch tausend Drachen 스케치
- K. 433 — 아리아 Männer suchen stets zu naschen 스케치
- K. 434 — 3중창 Del gran regno delle amazzoni 단편
- K. 580 — 아리아 Schon lacht der holde Frühling 단편
- K. Anh. 24a — 2중창 Ach, was müssen wir erfahren! 단편
- K. 389 — 2중창 Welch ängstliches Beben 단편
- K. 532 — 3중창 Grazie agl'inganni tuoi 단편
- K. Anh. 5 — 4중창 Caro mio Druck und Schluck 단편
- K. 615 — 합창 Viviamo felici 단편
- K. Anh. 25 — 가곡 Bardengesang auf Gibraltar 스케치
- K. Anh. 26 — 가곡 Einsam bin ich, meine Liebe 단편
- K. 508a — 카논 스케치 묶음
- K. 370b+371 — 호른 협주곡 E♭장조 — 미완성
- K. 494a — 호른 협주곡 E장조 — 미완성
- K. 584b — 바셋 호른 협주곡 G장조 단편 (클라리넷 협주곡의 초안)
- K. 293 — 오보에 협주곡 F장조 단편
- K. 320e — 바이올린·비올라·첼로 신포니아 콘체르탄테 단편
- K. 315f — 바이올린·피아노 협주곡 D장조 단편
- K. 357 — 네 손을 위한 소나타 G장조 — 미완성
- K. 401 — 푸가 G단조 — 미완성
- K. 681 — 두 대의 피아노를 위한 라르게토와 알레그로 — 단편, 슈타들러 완성
- K. Anh. 44 — 두 대의 피아노를 위한 알레그로 C단조 단편
- K. 402 — 바이올린 소나타 29번 A장조 — 단편, 슈타들러 완성
- K. 403 — 바이올린 소나타 30번 C장조 — 단편, 슈타들러 완성
- K. 404 — 바이올린 소나타 31번 C장조 — 단편
- K. 372 — 바이올린 소나타 34번 B♭장조 — 단편, 슈타들러 완성
- K. 442 — 피아노 3중주 D단조 — 단편 셋을 슈타들러가 완성
- K. Anh. 51 — 피아노 3중주 B♭장조 단편
- K. Anh. 52 — 피아노 3중주 G장조 단편
- K. Anh. 54 — 피아노와 관악 5중주 B♭장조 단편
- K. Anh. 66 — 현악 3중주 G장조 단편
- K. 417d — 현악 4중주 E단조 단편
- K. 587a — 현악 4중주 G단조 단편
- K. 680 — 현악 4중주 E장조 단편
- K. 514a — 현악 5중주 B♭장조 단편
- K. 515c+515a — 현악 5중주 A단조 단편
- K. Anh. 93 — 클라리넷과 세 바셋 호른을 위한 아다지오 F장조 (K. 484c) — 단편
- K. Anh. 94 — 클라리넷과 세 바셋 호른을 위한 아다지오 F장조 (K. 580a) — 미완성 초안, 남이 완성
- K. Anh. 95 — 알레그로 아사이 B♭장조 (K. 484b) — 단편
- K. Anh. 96 — 관악 알레그로 B♭장조 (K. 384c) — 단편
- K. 384B — 관악 안단테 B♭장조 단편
- K. 484e — 바셋 호른 알레그로 단편
- K. 516c — 클라리넷 5중주 단편
- K. 516d — 클라리넷 5중주 단편
- K. 516e — 클라리넷 5중주 단편
- K. 580b — 클라리넷 5중주 단편
- K. 288 — 디베르티멘토 F장조 — 미완성
- K. 320B — 디베르티멘토 D장조 — 미완성
- K. 544 — 행진곡 D장조 단편
- K. 384b — 행진곡 B♭장조 — 미완성
- K. 535b — 콩트르당스 B♭장조 단편
- K. 565a — 콩트르당스 D장조 단편
- K. 607 — 콩트르당스 E♭장조 "여인들의 승리" — 쾨헬 표 fragment
- K. 124c — 교회 소나타 C장조 단편
- K. 153 — 푸가 E♭장조 — 미완성
- K. 154 — 푸가 G단조 — 미완성
- K. Anh. 35 — 오르간 아다지오 D단조 (K. 593a) — 쾨헬 표 fragment
- K. 429 — 칸타타 Dir, Seele des Weltalls — 단편, 슈타들러 완성
- K. 5b — 안단테 B♭장조 — 미완성
- K. 15a — 런던 스케치북 (43곡 습작 수첩)
- K. 312 — 소나타 악장 G단조 — 미완성
- K. 396 — 환상곡 C단조 — 단편(원래 바이올린 소나타), 슈타들러 완성
- K. 400 — 알레그로 B♭장조 — 단편, 슈타들러 완성
- K. 708 — 아다지오 B단조 — 단편 (K. 540 의 앞 초안)
- K. Anh. 34 — 아다지오와 미뉴에트 D장조 (K. 385h) — MB 는 fragments, K1 이 Anh. 번호
- K. 385h — 아다지오와 미뉴에트 D장조 (K. Anh. 34) — MB 는 fragments

### 소실 — 9

- K. 673 — 플루트 협주곡
- K. 47c — 트럼펫 협주곡
- K. 206a — 첼로 협주곡
- K. 718 — 현악 4중주 아다지오 F장조
- K. 676 — 행진곡
- K. 565 — 2개의 콩트르당스
- K. 677 — 교회 소나타 C장조
- K. 365a — 아리아 Zittre, töricht Herz
- K. 569 — 아리아 Ohne Zwang aus eignem Triebe

### 연습·습작 — 2

- K. 616b — 4성 카논 연습
- K. 562a — 4성 카논 B♭장조 — 쾨헬 9판 Anh. H(습작), MB 는 attribution doubtful

### 위키백과 목록 밖이라 넣지 않은 것

SPEC 기준이 위키백과 작품 목록이라, 아래는 목록에 없어서 넣지 않았습니다(넣을지 리드가 판단).

위키백과 *Köchel catalogue* 표에는 있고 표시(fragment·doubtful·lost 등)가 없는데 작품 목록에는 없는 것 46개:

- K1 52 / K6 46c / K9 52 — "Daphne, deine Rosenwangen" (1768)
- K1 – / K6 46d / K9 46d — Violin Sonata in C (1 September 1768)
- K1 – / K6 46e / K9 46e — Violin Sonata in F (1 September 1768)
- K1 Anh. 2 / K6 72b / K9 72b — Aria "Misero tu non sei" (26 January 1770)
- K1 – / K6 73D / K9 73D — Aria for Soprano, "Per quel paterno amplesso" (1766)
- K1 – / K6 168a / K9 168a — Minuet for a String Quartet in F (August 1773)
- K1 – / K6 Anh. A 52 / K9 291,01 — Adagio in D for Orchestra (1780)
- K1 – / K6 296c / K9 296c — Sanctus in E♭ (in conjunction with K. 322/296a) (early 1778)
- K1 Anh. 3 / K6 315b / K9 315b — Scena (late August 1778)
- K1 Anh. 11 / K6 315e / K9 315e — Music to "Semiramis" (November 1778)
- K1 315a / K6 315g / K9 315a — 8 Minuets (early 1779)
- K1 Anh. 97 / K6 370b / K9 370b — Horn Concerto movement in E♭ (21 March 1781)
- K1 371 / K6 371 / K9 371 — Rondo in E♭ for Horn (21 March 1781)
- K1 Anh. 42 / K6 375b / K9 375b — Movement to a Piano Sonata for two Pianos in B♭ (Spring 1782)
- K1 Anh. 43 / K6 375c / K9 375c — Movement to a Piano Sonata for two Pianos in B♭ (Spring 1782)
- K1 408c / K6 383F / K9 408,03 — March in C (1782)
- K1 408b / K6 385a / K9 408,02 — March in D (1782)
- K1 – / K6 441a / K9 441a — Song, "Ja! grüß dich Gott" (1783)
- K1 Anh. 59 / K6 459a / K9 466a — Movement to a Piano Concerto in C (in conjunction with K. 459) (December 1784)
- K1 Anh. 62 / K6 491a / K9 537c — Movement to a Piano Concerto in E♭ (in conjunction with K. 491) (March 1786)
- K1 Anh. 53 / K6 493a / K9 493a — Movement to a Piano Quartet in E♭ (original final movement to K. 493) (3 June 1786)
- K1 Anh. 60 / K6 502a / K9 502a — Movement to a Piano Concerto in C (draft to K. 503) (November 1786)
- K1 Anh. 105 / K6 504a / K9 504a — Movement to a Symphony in G (in conjunction with K. 504) (December 1786)
- K1 – / K6 506a / K9 – — Studies for Thomas Attwood (1785–1786)
- K1 – / K6 509b / K9 – — Comedy "Der Salzburger Lump in Wien" (July 1787?)
- K1 Anh. 87 / K6 515a / K9 515a — Movement for a String Quintet in F (in conjunction with K. 515c) (not before March 1791)
- K1 Anh. 79 / K6 515c / K9 515c — Movement for a String Quintet in A minor (not before March 1791)
- K1 Anh. 108 / K6 522a / K9 522a — Rondo for Orchestra in F (in conjunction with K. 522) (14 June 1787)
- K1 Anh. 69 / K6 525a / K9 525a — Larghetto for Strings in C (draft to K. 525) (10 August 1787)
- K1 Anh. 50 / K6 526a / K9 526a — Movement to a Violin Sonata in A (draft to K. 526) (24 August 1787)
- K1 Anh. 57 / K6 537a / K9 537a — Movement to a Piano Concerto in D (in conjunction with K. 537) (February 1788)
- K1 Anh. 61 / K6 537b / K9 537b — Movement to a Piano Concerto in D minor (in conjunction with K. 537) (February 1788)
- K1 Anh. 88 / K6 581a / K9 581a — Movement for a Clarinet Quintet in A (September 1789)
- K1 Anh. 68 / K6 589a / K9 589a — Movement for a String Quintet B♭ (in conjunction with K. 590) (May 1790)
- K1 Anh. 73 / K6 589b / K9 589b — Movement for a String Quintet F (in conjunction with K. 590) (May 1790)
- K1 Anh. 83 / K6 592b / K9 592b — Movement for a String Quintet in D (draft for K. 593) (August 1790)
- K1 – / K6 615a / K9 615a — Andante in F for a Small Mechanical Organ (1791)
- K1 Anh. 102 / K6 620a / K9 620a — Overture in E♭ (draft to Die Zauberflöte) (September 1791)
- K1 – / K6 – / K9 638 — Instrumental piece in G# minor for orchestra (1766)
- K1 – / K6 – / K9 665 — Trio in C (1773)
- K1 – / K6 – / K9 667 — Recitative "Campagne amene" for soprano and orchestra (for K. 208 No. 3) (1775)
- K1 – / K6 – / K9 669 — Vocal movement in C (1776)
- K1 – / K6 – / K9 671 — Modulating Prelude (F-e) (1776–1777)
- K1 – / K6 – / K9 696 — Canon in E♭ for 3 sopranos and bass (1785)
- K1 – / K6 – / K9 709 — Melodic notation in C (probably for dance ensemble) (1785–1788)
- K1 KV2 Anh. 109d / K6 73x/03 / K9 720 — Melodic notation in D (1772)

이 가운데 K. 46d·46e(바이올린과 베이스를 위한 소나타), K. 315a(8개의 미뉴에트), K. 52(가곡), K. 441a(가곡)은 완성된 원작이라 넣을 만합니다. 나머지는 대부분 완성작의 버려진 초안 악장("Movement to …", "draft to …"), 습작, 9판에 새로 붙은 소품(638~720)입니다. 408b·408c 는 K. 408 의 2·3번(넣음), 371 은 호른 협주곡 K. 370b+371 의 론도(미완성이라 뺌)입니다.

MB 에는 있는데 위키백과 목록에 없는 최상위 work(편곡·단편·의심 표시가 없는 것) 56개 — 대부분 Anh. C 위작, 습작, 위 표의 곡입니다:

- 32837c11 2 Fugues, K. 154a, Anh. A 61/62
- 38e97c6a 3 Duets for 2 Flutes, K. Anh. 157
- bb2bc970 3 Duets for 2 Flutes, K. Anh. 156
- d964ee0a 2 Piano Pieces, K. 629
- fc25a5c5 5 Solfeggios, K. 393/385b
- e575cb76 8 Minuets for Clavier, K. 315a/315g
- 7ae94823 Abendruhe, K. Anh. C 9.10
- fec252c1 Ah sponse, mi dilecte veni, K. Anh. 112 / Anh. C 3.14
- 925c4bcb Canon for 3 in 1 in C major, K. 508A / KV deest: Canon
- 429e0a4a Contrapuntal Study in B minor (Ach Gott vom Himmel sieh darein), K. 620b
- 612074ad De profundis clamavi
- 3d6e08a2 Die Nacht ist finster, K. Anh. C 9.03/441b
- b42afce4 Die Singstunde, K. Anh. C 9.04/Anh. 441c
- a573ed15 Divertimento in E-flat major, K. Anh. C 17.01/Anh. 226
- fff1f639 Divertimento in E-flat major, K. Anh. C 17.04/Anh. 224
- f324bbbf Duet "Ich nenne dich, ohn' es zu wissen", K. Anh. 24/699
- 22de385e Fugue in C, K. 385m
- 4cb074c5 Fugue in D, K. Anh. H 13,01/73w
- 691f21f6 Fugue in D minor, K. 417c
- 2e8906a6 Kanonische Studien, K. Anh. H 10
- 60b95c7c Kyrie in D major, K. 91 (Süßmayr completion)
- aab62125 Instrumental Piece in B major, K. 638
- 8933be07 La Tartine de beurre
- 41dc12a6 Menuet and Trio in C major, K485a
- ee623968 Melodic notation in D, K. 720
- 72c22a06 Movement for String Quartet in A major, K. 464a/Anh 72 (Erik Smith completion): Rondo
- 8453f789 Molto allegro in G major, K. 636
- 9c19d29e Missa solemnis in C major, K. Anh. C 1.20
- 332fdc6c Musical Dice Game in C minor, K. 516f/deest "Musikalisches Wurfelspiel"
- 57eb4be5 Nine Pieces for Piano, K. Anh. 207
- 7924afd9 Ne pulvis et cinis superbe te geras, K. Anh. 122
- b947d36d Parthia für Bläser F-Dur, K. Anh. C 17.05/Anh. 225
- d251a055 Octet in E-flat major, K. Anh. 228/Anh. C 17.03
- 1628b572 Per la ricuperata salute di Ofelia, K. 477a
- 506a0abb Piano Sonata Movement in B-flat major, K. 569a/Anh. 31
- 65dcedb4 Parthia in F-major, K. Anh. C 17.08
- ace0c450 Pastorale variée, K Anh. 209b
- e9896e95 Piano piece in C, K. 671
- eed4fb2b Romanze in A-flat major, K. Anh. 205
- 4ef7bf4d Rondo zu einem Quintet in A-Dur, K. 581a/Anh. 88
- 9f3a64d3 Salve Regina, K. Anh. C 3.01
- 1446e015 Sextet in E-flat major, K. Anh. 183
- 5eb1f0cf Sextett B-dur, K. Anh. C 17.09
- 0de6e8e6 String Quartet in B-flat major, K. Anh. C 20.01/Anh. 210
- 102fe594 String Quartet in E-flat major, K. Anh 213
- 42ca5db9 String Quartet in C major, K. Anh. IV no. 211
- a0a36547 Sonate in C für Violin und Baß, K. 46d
- d52bcc37 String Quintet Movement in E-flat, K. 613b
- f4caa663 String Quartet in A major, K. Anh. C 20.01/Anh. 212
- f464005f Violin Sonata in C major, K. 56
- 1b2c6289 Violin Sonata in E-flat major, K. 58 (Anh. C23.04)
- 2e640f81 Violin Sonata in F major, K. 46e
- 483aa00a Violin Sonata in F major, K. 57
- bf431738 Violin Sonata in E minor, K. 60
- e308aa7d Violin Sonata in C minor, K. 59
- e929b3ac Violin Sonata in F major, K. 55

## 4. 애매했던 판단

1. **피아노 협주곡 1~4번(K. 37·39·40·41)과 K. 107 3곡을 뺐습니다.** 위키백과가 "early arrangements"(다른 작곡가 소나타 악장을 협주곡으로 옮긴 것)로 따로 적고, 쾨헬 9판도 Anh. A(남의 작품)로 옮겼습니다. 그래서 피아노 협주곡은 5번부터입니다. 넣고 싶으면 `defs.EXCLUDED` 에서 지우고 W(…)를 더하면 됩니다.
2. **위키백과 목록에는 표시가 없지만 쾨헬 9판이 남의 작품(Anh. A)으로 본 것은 뺐습니다**: K. 101(콩트르당스=세레나데 2번, 미하엘 하이든), K. 104(미뉴에트, 미하엘 하이든), K. 122, K. 61g(2곡 중 1곡이 미하엘 하이든), K. 233·234(카논, 트르녜카), K. 346·436·437·438·439(노투르노, 자캥), K. 625(<현자의 돌> 2중창), K. 33B. 반대로 **쾨헬 9판이 doubtful 만 붙이고 위키백과 목록은 표시하지 않은 것은 넣었습니다**: K. 94, 119, 143, 229, 230, 231("Leck mich im Arsch"), 285a(플루트 4중주 2번), 348, 487(2·4·5·7~12번 의심), 517·518(9판 fragment). 각 작품 `note` 에 적었습니다.
3. **미완성인데 연주 관례로 넣은 것**: 레퀴엠 K. 626(쥐스마이어 판 MB work), 대미사 K. 427(MB 는 모차르트가 남긴 fragment 판 work), 호른 협주곡 1번 K. 412(쥐스마이어 완성 론도 포함), 환상곡 D단조 K. 397, 피아노와 관현악을 위한 론도 A장조 K. 386(복원판, mbid 비움), 오페라 <차이데> K. 344, 모음곡 K. 399(사라방드만 미완). 같은 미완성인데 뺀 것: 오페라 <카이로의 거위>·<속은 신랑>, 바이올린 소나타 29·30·31·34번, 환상곡 C단조 K. 396, 피아노 3중주 K. 442, 호른 협주곡 K. 370b+371·494a 등(3절 목록).
4. **교향곡 번호**: 위키백과 교향곡 목록이 doubtful 로 둔 11번(K. 84), GA 42~47·54·55번, K. 135+61h 와 spurious 인 2·3·37·56번·"오덴세"는 뺐습니다. 반대로 번호 없는 K. 19a·45a(옛 람바흐)와 오페라 서곡에 악장을 붙인 48·50·51·52번(K. 111+120, 161/141a, 196+121, 208+102)은 넣었습니다. 48~52번 catalogue 는 `K. 111+120` 꼴이라 오페라 K. 111 등과 따로 섭니다. 세레나데에서 뽑은 교향곡판(K. 204·250·320·409)은 따로 세지 않았습니다.
5. **K. 314 를 둘로 나눴습니다**: 오보에 협주곡 C장조(원곡)와 플루트 협주곡 2번 D장조(모차르트 자신의 편곡). 위키백과도 둘을 따로 적고 MB work 도 둘입니다. catalogue 가 둘 다 `K. 314` 라 key 를 `mozart-k314-oboe`·`mozart-k314-flute` 로 나눴습니다. 같은 식으로 모차르트가 직접 다른 편성으로 옮겨 새 번호를 받은 K. 406(현악 5중주 2번 ← K. 388)·K. 546(← K. 426)은 넣었고, 론도 K. 494 는 피아노 소나타 15번 K. 533 의 3악장으로 고쳐 넣은 옛 판이라 뺐습니다.
6. **K1 이 Anh. 번호인 작품의 catalogue**: 리드 지시("앞쪽 번호")를 그대로 따르면 `K. Anh. 10` 같은 꼴이 되어, 실제 쓰는 6판 번호를 catalogue 로, K1 Anh. 번호를 catalogueAlt 로 두었습니다: K. 299b(<레 프티 리앵>, Anh. 10), K. 285b(플루트 4중주 3번, Anh. 171), K. 621a(아리아, Anh. 245). K9 번호만 있는 K. 646(아리아)·K. 648(간츠 클라이네 나흐트무지크)은 그 번호를 썼습니다. K. 533 은 위키백과가 `K. 533/494` 로 쓰지만 494 는 6판 번호가 아니라(론도 번호) catalogueAlt 를 비웠습니다.
7. **판본이 둘인 work 고르기**: 세레나데 11번 K. 375 는 6중주 첫 판과 8중주 고친 판 중 고친 판, <이집트 왕 타모스> K. 345 는 final version, 교향곡 40번은 운영과 같은 2nd version(클라리넷 있는 판), 모테트 <환호하라, 기뻐하라> K. 165 는 밀라노 원판(잘츠부르크 개정판 따로 있음), 교향곡 31번 "파리"는 안단테 두 판을 모두 part 로(2악장 `Andante`·`Andante (다른 판)`, movementNumber 둘 다 II).
8. **MB 쪽 사정**: K. 534 "천둥"은 관현악 원본이 없고 피아노 판만 전해 MB 도 피아노 판 work 를 썼습니다. K. 535a 는 MB 가 doubtful·에릭 스미스 편곡 work 만 있어 mbid 를 비우고 곡 이름(C·G·G장조)만 MB 제목에서 옮겼습니다. K. 540a·540b·584 는 MB 에 오페라(<돈 조반니>·<코지 판 투테>) 부록 part work 로만 있어 그 part MBID 를 썼습니다. K. 1e·1f 는 MB 가 한 work(K. 1)의 두 part 라 각 part MBID 를 썼습니다. K. 355·432·277·535a 는 MB 가 fragment/doubtful 로 적지만 위키백과 목록에 표시가 없어 넣었습니다.
9. **MB part 순서·번호 손질**: K. 66 미사는 MB part 19개가 순서 없이 세부 단위로만 있어 절(키리에…아뉴스 데이) 6개로 묶고 세부는 children 으로, 순서는 전례문 순으로 놓았습니다(글로리아·크레도 절은 MB work 가 없어 mbid null). K. 359 변주 순서, 레퀴엠의 빈 악장 번호(VII 없이 VIII), 레퀴엠 영성체송 세부 순서(MB ordering-key 17)를 바로잡았습니다. 레퀴엠은 MB 대로 7부분(입당송·키리에·부속가·봉헌송·상투스·아뉴스 데이·영성체송)이고 부속가 6곡·봉헌송 2곡·상투스 2곡(상투스·베네딕투스)·영성체송 2곡은 children 입니다.
10. **같은 제목 피하기(덧말)**: 같은 갈래·같은 조성이 겹치면 쓰임새나 연도를 괄호로 붙였습니다. D장조 행진곡 7개는 붙는 세레나데·디베르티멘토(`행진곡 D장조 (세레나데 5번용)`, K. 249 는 `"하프너"`), 레지나 첼리 C장조 둘은 `(1771년)`·`(1779년)`, 가곡 <Die Zufriedenheit> 둘은 `(1781년)`·`(1785년)`, 난네를 음악 수첩의 미뉴에트 F장조 넷과 알레그로 C장조 둘, 미뉴에트 D장조 둘은 연도·달, 아리아 K. 294·512(같은 가사)는 `(소프라노)`·`(베이스)`.
11. **노래·아리아 제목 꼴**: 아리아는 `아리아 <원제>`, `레치타티보와 아리아 <레치타티보 첫 줄 … 아리아 첫 줄>`, 중창은 `2중창/3중창/4중창 <원제>`, 가곡은 `가곡 <원제>`, 카논은 `카논 <원제>` 입니다. 원제는 옮기지 않았고, 국내에서 확실히 쓰는 것만 우리말로 했습니다(<제비꽃>, <환호하라, 기뻐하라>, <아베 베룸 코르푸스>).
12. **연도**: `year`·`yearText` 는 위키백과 쾨헬 표(9판 연대) 기준입니다. 운영과 다른 것: 26042 그랑 파르티타(운영 1781 / 9판 1783–1784), 436 "아! 어머니께 말씀드리죠" 변주곡(운영 1781 / 1781–1782). 피아노 소나타 1~5번은 9판대로 1775(위키백과 피아노 목록은 1774 가을).

## 5. 직접 옮긴 우리말 이름(검수용)

국내 관례가 확실하지 않은데 제가 옮기거나 음역한 것입니다. 갈래어(교향곡·세레나데·미뉴에트·키리에 등)와 조성은 뺐습니다.

- **작품 별명**: "옛 람바흐"(K. 45a Alte Lambacher), "뤼초"(K. 246 Lützow), "주놈"(K. 271 Jeunehomme/Jenamy), "스트라스부르"(K. 216), "터키풍"(K. 219), "뒤르니츠"(K. 284), "로디"(K. 80), "봄"(K. 387), "사냥"(K. 458), "불협화음"(K. 465), "호프마이스터"(K. 499), "안트레터"(K. 185), "콜로레도"(K. 203), "세레나타 노투르나"(K. 239), "로드론 1번/2번"(K. 247·287), "난네를 7중주"(K. 251), "음악의 농담"(K. 522), "케겔슈타트"(K. 498), "간츠 클라이네 나흐트무지크"(K. 648), "고아원"(K. 139 Waisenhaus), "도미니쿠스"(K. 66), "삼위일체"(K. 167 Trinitatis), "참새"(K. 220 Spatzen), "크레도"(K. 257), "피콜로미니"(K. 258), "오르간 독주"(K. 259)
- **무곡 별명**: "천둥"(K. 534 Das Donnerwetter), "전투"(K. 535 La Bataille), "코부르크 영웅의 승리"(K. 587), "짓궂은 아가씨들"(K. 610 Les filles malicieuses), "허디거디 연주자"(K. 611·602-3 Die Leyerer), "카나리아"(K. 600-5), "썰매 타기"(K. 605-3)
- **오페라·무대**: <아폴로와 히아킨투스>, <라 핀타 셈플리체>(음역; '가짜 바보 아가씨' 등 정착된 말 없음), <바스티앙과 바스티엔>, <폰토의 왕 미트리다테>, <알바의 아스카니오>, <스키피오네의 꿈>, <루치오 실라>, <가짜 여정원사>, <양치기 왕>, <차이데>, <이도메네오>, <후궁 탈출>(후궁으로부터의 도피/유괴 등 여러 꼴 있음), <극장 지배인>, <코지 판 투테>, <티토 황제의 자비>, <이집트 왕 타모스> 부수음악, 발레 <레 프티 리앵>, <이도메네오> 발레 음악
- **교회·성악**: 종교극 <첫째 계명의 의무>, 수난 칸타타 <그랍무지크>(음역), 오라토리오 <해방된 베툴리아>, 칸타타 <회개하는 다윗>, 칸타타 <프리메이슨의 기쁨>, 프리메이슨 장송 음악, 작은 독일 칸타타, 작은 프리메이슨 칸타타, 모테트 <하느님은 우리의 피난처>, 성모 호칭 기도(Litaniae Lauretanae), 성체 호칭 기도(Litaniae de venerabili altaris sacramento), 주일을 위한 장엄 저녁기도, 증거자를 위한 장엄 저녁기도, 딕시트 도미누스와 마니피캇, 레지나 첼리, 미세레레, 테 데움, 봉헌송·안티폰(갈래어), 대미사, 미사 브레비스·미사 롱가·장엄 미사
- **기악 갈래·제목**: 카사치오네, 콘체르토네(K. 190), 네 개의 오케스트라를 위한 노투르노(K. 286), 갈리마티아스 무지쿰(K. 32), 교향적 미뉴에트(K. 409), 콩트르당스, 렌틀러, 작은 장송 행진곡(K. 453a), 작은 지그(K. 574), 카프리치오(K. 395), 자동 오르간을 위한 …(K. 594·608·616), 글라스 하모니카, 바셋 호른, 수수께끼 카논(K. 89a II), 두 대의 호른을 위한 12개의 2중주(K. 487)
- **행진곡 덧말**: 카사치오네 D장조용, 세레나데 3번 "안트레터"용, 세레나데 4번 "콜로레도"용, 세레나데 5번용, 디베르티멘토 7번용, 디베르티멘토 17번용
- **악장·절 이름**: 미뉴에트, 트리오, 론도, 피날레, 로망스, 주제(와 변주), N변주, 폴로네즈, 서곡, 알르망드, 쿠랑트, 사라방드, 지그, 가보트, 파스피에, 샤콘, 파사칼리아, 시칠리아노, 서주, 레치타티보, 코다, (다른 판); 미사·레퀴엠: 키리에, 글로리아, 크레도, 상투스, 베네딕투스, 아뉴스 데이, 입당송(Introitus), 부속가(Sequentia), 봉헌송(Offertorium), 영성체송(Communio), 마니피캇. 전례문 첫 구절(Laudamus te, Dies irae, Dixit Dominus 등)은 원어 그대로

## 6. 위키백과 대조 결과

`scripts/wikicheck.py` 로 기계 대조했습니다(`raw/wikicheck.json`).

- 위키백과 목록 항목 중 K. 번호가 있는 것 802개: 넣은 것과 맞음 613, 뺀 것 목록과 맞음 189, **어디에도 없는 것 0**.
- 넣은 작품 531개 중 위키백과 항목과 짝이 없는 것 0개.
- 묶음 곡 수: 위키백과 제목에 곡 수가 있는 묶음 28개 모두 parts 수와 같음(어긋남 0). 나머지 4개(K. 463 2곡, K. 343 2곡, K. 89a II 4곡, K. 487 12곡)는 위키백과 제목에 숫자 꼴이 달라 눈으로 확인했고 모두 같습니다.
- 조성: 위키백과에 조성이 적힌 327개 모두 titleEn 조성과 같음(어긋남 0).
- 번호: 위키백과의 "No. N" 220개 모두 titleEn 번호와 같음(어긋남 0).
- 묶음 곡 수를 MB parts 와 견준 결과 어긋난 것 0개. K. 461 은 MB 제목이 "6 Minuets"지만 part 는 5개(6번은 단편)로 위키백과 5곡과 같습니다.
- 제목 겹침(운영 제목 포함) 0, nameKo 가 `1번 `·`1악장 ` 으로 시작하는 것 0, 빈 nameKo 0 (`scripts/validate.py`).
- 다른 작품이 이미 쓰는 MBID 를 가져온 것 0(`db/all_mbids_taken.tsv` 대조; 기존 작품 17개의 MBID 만 같음).
- 빌드 중 손질: mozart-k359: MB 변주 순서가 어긋나 변주 번호 순으로 다시 놓음; mozart-k626: MB 악장 번호에 빈 번호가 있어 차례대로 다시 매김

