# 쇼팽 전체 작품 목록 — 묶음·낱곡 정리 보고

데이터만 만들었습니다(DB 쓰기·마이그레이션 없음). 결과는 `catalog.json`, 원자료는 `raw/` 에 있습니다.

- MB: 쇼팽 artist(09ff1fe8…) 의 work 711개를 browse 로 받고, 하나씩 다시 조회(artist-rels·work-rels·aliases·annotation)해 `raw/browse_works.json`, `raw/lookup_works.json` 에 두었습니다. 낱개 응답 캐시는 `raw/mb/`.
- 위키백과: `raw/wiki/` (by opus number rev 1378705206, by genre rev 1377725274).
- 운영 DB(읽기만): `raw/db_pieces.tsv`, `raw/db_ids_parts.tsv`.
- 만든 스크립트: `scripts/` (defs.py 손 정의 → build.py → wikicheck.py → report.py).

## 1. 개수

| 갈래 | 작품 | part |
|---|---:|---:|
| 묶음(collection) | 38 | 164 (Op. 72 의 3번 아래 children 3곡 따로) |
| 낱곡(single) | 71 | – |
| 다악장(multi_movement) | 11 | 41 |
| 합계 | 120 | 205 |

다악장 11개 가운데 악장(partKind=movement)이 7개(소나타 3·협주곡 2·트리오·첼로 소나타), 한 악장 안의 부분(partKind=section)이 4개(Op. 2·13·14·22)입니다.

듣는 단위로 세면(낱곡 + 다악장 작품 + 묶음 안 곡, Op. 72 의 에코세즈는 3곡으로) 248곡입니다.

진위 표시(authenticity):

- 쇼팽 원작: 111
- 위작 의심(위키백과 doubtful 등): 5 — B. 4, B. 9, B. 17, KK Anh. Ia/2–3, (번호 없음) 왈츠 A단조 (2024년 발견)
- 쇼팽이 자기 곡·성가를 옮긴 것: 2 — B. 109, B. 117
- 쇼팽이 민요 선율을 적어 둔 것(KK VIIb): 2 — B. 160b, KK VIIb/7–8

MB work 가 없는 것: 작품 3개(B. 39, B. 160b, KK Anh. Ia/2–3), part 4개(KK Anh. Ia/2–3 1, KK Anh. Ia/2–3 2, KK VIIb/7–8 1, KK VIIb/7–8 2). 모두 `mbid: null`, `mbMissing: true` 로 넣었습니다.

## 2. 이름 규칙(제안 — 이대로 만들었습니다)

운영 DB manual 제목을 먼저 보고 맞췄습니다.

- 조성: `C장조`·`A단조`, 내림은 `♭`(B♭장조), 올림은 `#`(F#장조). 운영 DB manual 제목("폴로네즈 6번 A♭장조", "뱃노래 F#장조", "녹턴 20번 C#단조")과 같습니다. 영어도 `E♭ major`·`C# minor`.
- 별명: 큰따옴표 `"…"`. 운영 DB 제목(`연습곡 Op. 10, No. 3 "이별의 곡"`, `피아노 소나타 2번 B♭단조 "장송"`)이 「」 가 아니라 큰따옴표라 그쪽을 따랐습니다.
- 묶음: `갈래 Op. N`("마주르카 Op. 6", "녹턴 Op. 9", "연습곡 Op. 10"). 이미 있는 seed 제목 "연습곡 Op. 25", "24개의 전주곡 Op. 28" 과 슈베르트 manual "즉흥곡 Op. 90" 꼴. 원제가 따로 있는 묶음만 원제("3개의 새로운 연습곡", "17개의 폴란드 가곡 Op. 74", "녹턴, 장송 행진곡과 3개의 에코세즈 Op. 72", "2개의 부레").
- 낱곡·다악장: 작품번호를 제목에 넣지 않습니다(manual 관례 — 화면이 opus_number 를 제목 아래 따로 보여 줌). "발라드 1번 G단조", "환상곡 F단조", "폴로네즈 5번 F#단조". 번호는 MB·관례 번호가 있을 때만(발라드·스케르초·즉흥곡·소나타·협주곡, 왈츠 1·5·14~19번, 녹턴 20·21번, 폴로네즈 5·6번).
- 같은 갈래·같은 조성이 겹치는 작품번호 없는 곡은 덧말로 가릅니다: 마주르카 A단조 "노트르 탕"/"에밀 가야르", 마주르카 D장조 (첫 판)/(고친 판)/마주레크 D장조(B. 4).
- 묶음 안 곡: `N번 조성` + 별명(`3번 E장조 "이별의 곡"`). 영어는 `No. 3 in E major "Tristesse"`. 빠르기말은 이름에 넣지 않고 `tempo` 칸에 MB 제목에서 떼어 두었습니다(판본마다 달라서).
- 가곡: `N번 "제목"`(`1번 "소원"`), 영어는 폴란드어 원제 + 영어 뜻.
- 악장: `N악장 빠르기말`("1악장 Grave – Doppio movimento"). 악장 머리말만 우리말로(Scherzo→스케르초, Marche funèbre→장송 행진곡, Finale→피날레, Menuetto→미뉴에트, Romance→로망스, Rondo→론도). 빠르기말은 이탈리아어 그대로. 영어는 `I. Grave – Doppio movimento`(슈베르트·프로코피예프 manual part 와 같은 꼴).
- 부분(section): `서주. Largo`, `주제. Allegretto`, `1변주. Brillante` 처럼 번호 없이 머리말 + 빠르기말.
- 연도: `year` 는 위키백과 by opus 범위의 끝 해(완성 연도), `yearText` 는 원문 범위. 그 문서에 없으면 by genre(`yearSource` 로 표시).
- 별명은 MB work 제목·위키백과·운영 DB 제목에 있는 것만 넣고 `nickname.source` 에 출처를 적었습니다. "Clock"(Op. 28-17)처럼 출처는 있어도 국내에서 거의 안 쓰는 것, MB 의 겹친 work 에만 있는 "The Bees"·"Wrong Note"·"Cello" 같은 것은 넣지 않았습니다.

## 3. 운영 DB 쇼팽 작품 17개와의 대응

| id | 운영 제목 | origin | 운영 opus | 이 목록에서 | 제안 이름 | 비고 |
|---:|---|---|---|---|---|---|
| 127 | 연습곡 Op. 10, No. 12 "혁명" | manual | Op. 10, No. 12 | Op. 10 의 12번 part | 12번 C단조 "혁명" | 낱곡 manual 이 묶음 안 곡과 겹침 |
| 128 | 즉흥 환상곡 | manual | Op. 66 | Op. 66 (single) | 즉흥 환상곡 C#단조 | 제목 다름(운영 그대로 둠 권장); 연도 운영 1834 / 위키백과 1835 |
| 129 | 발라드 1번 G단조 | manual | Op. 23 | Op. 23 (single) | 발라드 1번 G단조 | 제목 같음 |
| 130 | 폴로네즈 6번 A♭장조 "영웅" | manual | Op. 53 | Op. 53 (single) | 폴로네즈 6번 A♭장조 "영웅" | 제목 같음 |
| 131 | 녹턴 E♭장조 | manual | Op. 9, No. 2 | Op. 9 의 2번 part | 2번 E♭장조 | 낱곡 manual 이 묶음 안 곡과 겹침 |
| 132 | 피아노 협주곡 1번 E단조 | manual | Op. 11 | Op. 11 (multi_movement) | 피아노 협주곡 1번 E단조 | 제목 같음 |
| 133 | 왈츠 6번 D♭장조 "강아지 왈츠" | manual | Op. 64, No. 1 | Op. 64 의 1번 part | 1번 D♭장조 "강아지 왈츠" | 낱곡 manual 이 묶음 안 곡과 겹침 |
| 445 | 녹턴 20번 C#단조 (유작) | manual | B. 49 | B. 49 (single) | 녹턴 20번 C#단조 (유작) | 제목 같음 |
| 446 | 전주곡 15번 D♭장조 "빗방울" | manual | Op. 28 No. 15 | Op. 28 의 15번 part | 15번 D♭장조 "빗방울" | 낱곡 manual 이 묶음 안 곡과 겹침; 연도 운영 1838 / 위키백과 1838–1839 |
| 447 | 연습곡 Op. 10, No. 3 "이별의 곡" | manual | Op. 10 No. 3 | Op. 10 의 3번 part | 3번 E장조 "이별의 곡" | 낱곡 manual 이 묶음 안 곡과 겹침; 연도 운영 1830 / 위키백과 1832 |
| 463 | 연습곡 Op. 25 | seed | NULL | Op. 25 (collection) | 연습곡 Op. 25 | 제목 같음; 이미 있는 part: 9번→part 1; 연도 운영 NULL / 위키백과 1832–1836 |
| 465 | 24개의 전주곡 Op. 28 | seed | NULL | Op. 28 (collection) | 24개의 전주곡 Op. 28 | 제목 같음; 이미 있는 part: 7번→part 2; 연도 운영 NULL / 위키백과 1836–1839 |
| 26036 | 안단테 스피아나토와 화려한 대폴로네즈 | manual | Op. 22 | Op. 22 (multi_movement) | 안단테 스피아나토와 화려한 대폴로네즈 | 제목 같음; 연도 운영 1835 / 위키백과 1830–1831, 1834 |
| 26047 | 뱃노래 F#장조 | manual | Op. 60 | Op. 60 (single) | 뱃노래 F#장조 | 제목 같음 |
| 26048 | 연습곡 Op. 10, No. 1 C장조 | manual | Op. 10, No. 1 | Op. 10 의 1번 part | 1번 C장조 | 낱곡 manual 이 묶음 안 곡과 겹침; 연도 운영 1829 / 위키백과 1829–1830 |
| 26049 | 피아노 소나타 2번 B♭단조 "장송" | manual | Op. 35 | Op. 35 (multi_movement) | 피아노 소나타 2번 B♭단조 "장송" | 제목 같음 |
| 26050 | 피아노 소나타 3번 B단조 | manual | Op. 58 | Op. 58 (multi_movement) | 피아노 소나타 3번 B단조 | 제목 같음 |

- 17개 모두 MBID 로 맞았습니다(이름이 아니라 piece_identifiers 의 musicbrainz_work 값).
- 이미 있는 piece_parts 는 2개뿐입니다: 463(Op. 25) 의 9번(part id 1), 465(Op. 28) 의 7번(part id 2). 둘 다 `existingPartId` 로 붙였습니다.
- 낱곡 manual 6개(127·447·26048 = Op. 10 의 12·3·1번, 131 = Op. 9-2, 133 = Op. 64-1, 446 = Op. 28-15)는 묶음 안 part 의 `existingPieceId` 로 적었습니다. 묶음 piece 를 새로 만들 때 이 6개를 어떻게 둘지(낱곡 그대로 두고 part 와 이어 줄지)는 적재 쪽에서 정해야 합니다.
- 운영 opus_number 꼴이 섞여 있습니다: `Op. 10, No. 12`(쉼표) / `Op. 10 No. 3`, `Op. 28 No. 15`(쉼표 없음). 이 목록의 opusNumber 는 묶음·낱곡 단위라 `Op. 10` 처럼 번호만 둡니다.

## 4. 위키백과 대비

`scripts/wikicheck.py` 로 기계 대조했습니다.

- 작품번호 Op. 1~74(Op. 4 포함, 결번 없음): 74개 모두 들어 있고, 묶음 안 곡 수도 위키백과 by opus 의 번호 목록과 모두 같습니다.
- 작품번호 없는 곡: 위키백과 by opus 에 적힌 B. 번호가 모두 들어 있습니다. B. 번호 없는 KK 곡(갤럽 "마르키" KK IVb/13, 알레그레토와 마주르카 KK VIIb/7–8, 전주곡과 안단티노 KK Anh. Ia/2–3)과 2024년에 찾은 왈츠 A단조도 넣었습니다.

위키백과에는 있는데 MB work 가 없는 것(mbid 없이 넣음):

- B. 39 가곡 "어떤 꽃, 어떤 화관" (Song "Jakież kwiaty, jakie wianki" (Mazur))
- B. 160b 2개의 부레 (2 Bourrées, B. 160b)
- KK Anh. Ia/2–3 전주곡과 안단티노 아니마토 (Prelude and Andantino animato, KK Anh. Ia/2–3)
- KK Anh. Ia/2–3 의 part 1: 1번 전주곡 F장조
- KK Anh. Ia/2–3 의 part 2: 2번 안단티노 아니마토 D단조
- KK VIIb/7–8 의 part 1: 1번 알레그레토 A장조
- KK VIIb/7–8 의 part 2: 2번 마주르카 D단조

위키백과에 있지만 일부러 뺀 것:

- KK Anh. Ib/7 왈츠 F#단조 "Valse mélancolique" — 샤를 마이어 작품으로 밝혀짐(위키백과 취소선).
- KK Anh. II/1(B. 116) 알레그레토 F#장조 — spurious(마이어 마주르카 축약).
- KK Anh. Ia/6 녹턴 C#단조 "Nocturne oubliée" — spurious.
- 전주곡 E♭단조 "Devil's Trill" — 쇼팽 스케치를 칼버그가 2001년에 완성한 것(남이 완성한 판).
- KK VIIa/1 벨리니 <카스타 디바> 편곡 — 남의 곡을 옮긴 것, 독주판은 위작 가능성.
- KK VIIa/2 케루비니 <대위법과 푸가 강의> 의 3개의 푸가 — 남의 곡을 옮겨 적은 것. MB work 도 없음.
- "Known lost works"(악보가 사라진 곡 25개 남짓) — 들을 수 없는 곡이라 넣지 않았습니다.

## 5. 걸러 낸 MB work

MB 에서 받은 쇼팽 work 711개(browse 결과 전부) 가운데 321개를 목록에 썼고 390개를 걸러 냈습니다. 남은 미분류는 0개입니다. (남의 작품 parts 를 따라 받은 work 는 쇼팽 work 가 아니라 세지 않았습니다.)

| 까닭 | 개수 |
|---|---:|
| 편곡 work(다른 사람 또는 다른 편성) (`arrangement`) | 210 |
| 관현악 편곡 work (`orchestration`) | 22 |
| 쇼팽 곡을 바탕으로 한 다른 사람의 곡 (`based_on`) | 41 |
| 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판 (`other_version`) | 38 |
| 쇼팽이 작곡가로 걸려 있지 않은 work (`not_chopin`) | 9 |
| 같은 곡의 겹친 work (`duplicate`) | 24 |
| 같은 곡의 다른 판(쇼팽 원작이지만 따로 세지 않음) (`version`) | 9 |
| 다른 작곡가와 함께 걸린 곡(대중음악·메들리 등) (`other_composer`) | 25 |
| 이미 넣은 part 의 더 잘게 쪼갠 part (`subpart`) | 2 |
| 어느 곡인지 못 가린 work(위키백과 기준 곡은 이미 넣음) (`unidentified`) | 5 |
| 위작 (`spurious`) | 3 |
| 출판 단위가 아닌 갈래 묶음 (`grouping`) | 2 |

거르는 순서: ① 손으로 적은 까닭(`scripts/defs.py` 의 MANUAL_FILTER — 겹친 work·다른 판·위작·갈래 묶음 등) ② MB work 관계 `arrangement`·`orchestration`·`other version`·`based on`·`revision of` 의 뒤쪽(= 이 work 가 다른 work 를 편곡·바탕으로 함) ③ 크레딧(artist-rels): 작곡가에 쇼팽이 없으면 not_chopin, 쇼팽 말고 다른 작곡가도 있으면 other_composer, 편곡자·관현악 편곡자가 걸려 있으면 arrangement, 작사가만 있으면 based_on ④ 걸러 낸 부모 work 의 part 는 부모 까닭을 따름.

### 편곡 work(다른 사람 또는 다른 편성) — 210개

- `4c77060b` 24 Préludes pour le piano, op. 28 [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: 24 Préludes pour le piano, op. 28
- `3f502dd8` 24 Préludes, op. 28: No. 1 in C major. Agitato [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 1 in C major, op. 28: Agitato
- `d8b73e64` 24 Préludes, op. 28: No. 10 in C‐sharp minor. Allegro molto [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 10 in C‐sharp minor, op. 28: Molto allegro
- `20fadd48` 24 Préludes, op. 28: No. 11 in B major. Vivace [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 11 in B major, op. 28: Vivace
- `27ce9fc6` 24 Préludes, op. 28: No. 12 in G‐sharp minor. Presto [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 12 in G‐sharp minor, op. 28: Presto
- `dba605dd` 24 Préludes, op. 28: No. 13 in F‐sharp major. Lento [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 13 in F‐sharp major, op. 28: Lento
- `4b7c469e` 24 Préludes, op. 28: No. 14 in E‐flat minor. Allegro [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 14 in E‐flat minor, op. 28: Allegro
- `16ccec8c` 24 Préludes, op. 28: No. 15 in D‐flat major. Sostenuto [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 15 in D‐flat major, op. 28 “Raindrop”: Sostenuto
- `0955274f` 24 Préludes, op. 28: No. 16 in B‐flat minor. Presto con fuoco [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 16 in B‐flat minor, op. 28: Presto con fuoco
- `242491d5` 24 Préludes, op. 28: No. 17 in A‐flat major. Allegretto [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 17 in A‐flat major, op. 28: Allegretto
- `a0f026b1` 24 Préludes, op. 28: No. 18 in F minor. Allegro molto [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 18 in F minor, op. 28: Molto allegro
- `0ea6b5d3` 24 Préludes, op. 28: No. 19 in E‐flat major. Vivace [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 19 in E‐flat major, op. 28: Vivace
- `331ad9b3` 24 Préludes, op. 28: No. 2 in A minor. Lento [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 2 in A minor, op. 28: Lento
- `5a9f334e` 24 Préludes, op. 28: No. 20 in C minor. Largo [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 20 in C minor, op. 28: Largo
- `6a3186af` 24 Préludes, op. 28: No. 21 in B‐flat major. Cantabile [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 21 in B‐flat major, op. 28: Cantabile
- `e3af3148` 24 Préludes, op. 28: No. 22 in G minor. Molto agitato [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 22 in G minor, op. 28: Molto agitato
- `ef7fdf43` 24 Préludes, op. 28: No. 23 in F major. Moderato [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 23 in F major, op. 28: Moderato
- `fcf4f467` 24 Préludes, op. 28: No. 24 in D minor. Allegro appassionato [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 24 in D minor, op. 28: Allegro appassionato
- `cd91498b` 24 Préludes, op. 28: No. 3 in G major. Vivace [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 3 in G major, op. 28: Vivace
- `7a855f6d` 24 Préludes, op. 28: No. 4 in E minor. Largo [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 4 in E minor, op. 28: Largo
- `bc1334ad` 24 Préludes, op. 28: No. 5 in D major. Allegro molto [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 5 in D major, op. 28: Molto allegro
- `9cd54a50` 24 Préludes, op. 28: No. 6. in B minor. Lento assai [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 6 in B minor, op. 28: Lento assai
- `dbd96178` 24 Préludes, op. 28: No. 7 in A major. Andantino [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 7 in A major, op. 28: Andantino
- `78e3c47f` 24 Préludes, op. 28: No. 8 in F‐sharp minor. Molto agitato [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 8 in F‐sharp minor, op. 28: Molto agitato
- `cfaad147` 24 Préludes, op. 28: No. 9 in E major. Largo [for orchestra, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 9 in E major, op. 28: Largo
- `380acc58` 6 Chants polonais, S. 480 — MB 에 편곡자가 걸려 있음(instrument arranger: Franz Liszt)
- `e2c1b2c5` 6 Chants polonais, S. 480: 1. Mädchens Wünsch [Życzenie (#1) in Chopin’s Polish Songs] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Song in G major, op. 74 no. 1 “Życzenie”
- `12c2223b` 6 Chants polonais, S. 480: 2. Frühling [Wiosna (#2) in Chopin’s Polish Songs] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Song in G minor, op. 74 no. 2 “Wiosna”
- `13607b8a` 6 Chants polonais, S. 480: 3. Das Ringlein [Pierścień (#14) in Chopin’s Polish Songs] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Song in E‐flat major, op. 74 no. 14 “Pierścień”
- `f912d33f` 6 Chants polonais, S. 480: 4. Bacchanal [Hulanka (#4) in Chopin’s Polish Songs] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Song in E‐flat major, op. 74 no. 4 “Hulanka”
- `ca7981a0` 6 Chants polonais, S. 480: 5. Meine Freuden [Moja pieszczotka (#12) in Chopin’s Polish Songs] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Song in G‐flat major, op. 74 no. 12 “Moja pieszczotka”
- `35a7ec06` 6 Chants polonais, S. 480: 6. Heimkehr [Narzeczony (#15) in Chopin’s Polish Songs] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Song in C minor, op. 74 no. 15 “Narzeczony”
- `b048d0df` Andante spianato et Grande polonaise brillante in E‐flat major, op. 22 [for piano and orchestra, Scharwenka] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Andante spianato et Grande polonaise brillante in E‐flat major, op. 22
- `e49d5859` Andante spianato et Grande polonaise brillante in E‐flat major, op. 22: I. Andante spianato [for piano and orchestra, Scharwenka] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Andante spianato et Grande polonaise brillante in E‐flat major, op. 22: I. Andante spianato
- `dd60bd66` Andante spianato et Grande polonaise brillante in E‐flat major, op. 22: II. Grande polonaise brillante. Allegro molto [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Andante spianato et Grande polonaise brillante in E‐flat major, op. 22: II. Grande polonaise brillante. Allegro molto
- `e80d1d19` Andante spianato et Grande polonaise brillante in E‐flat major, op. 22: II. Grande polonaise brillante. Allegro molto [for piano and orchestra, Scharwenka] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Andante spianato et Grande polonaise brillante in E‐flat major, op. 22: II. Grande polonaise brillante. Allegro molto
- `93830061` Ballade no. 1 in G minor, op. 23 [for violin and piano, Yokoyama] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Ballade no. 1 in G minor, op. 23
- `e0949212` Ballade no. 1 in G minor, op. 23 [for violin and piano, Ysaÿe] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Ballade no. 1 in G minor, op. 23
- `e2309691` Ballade no. 2 in F major, op. 38 [catch‐all arrangement] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Ballade no. 2 in F major, op. 38
- `5eca9220` Ballade no. 2 in F major, op. 38 [for four cellos, Franchomme] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Ballade no. 2 in F major, op. 38
- `c072d7c5` Black Minute Waltz — MB 에 편곡자가 걸려 있음(arranger: James Booker)
- `f031eef0` Chopin in Brazil — MB 에 편곡자가 걸려 있음(arranger: James L. Mack)
- `79f659c7` Chopiniana — MB 에 편곡자가 걸려 있음(arranger: Дмитрий Рогаль-Левицкий)
- `07759ec0` Chopiniana, op. 46 — MB 에 편곡자가 걸려 있음(orchestrator: Александр Константинович Глазунов)
- `a0fdf725` Chopiniana: I. Etude no. 12, op. 10 en ut mineur “Révolutionnaire” — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in C minor, op. 10 no. 12 “Revolutionary”: Allegro con fuoco
- `f570ea0c` Chopiniana: II. Nocturne no. 13 en ut mineur, op. 48 — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 13 in C minor, op. 48 no. 1: Lento
- `fd023281` Chopiniana: III. Mazurka no. 25 en si mineur, op. 33 no. 4 — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 25 in B minor, op. 33 no. 4
- `b727a268` Chopiniana: IV. Valse brilliante no. 14 en mi mineur, op. posthume — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 14 in E minor, B. 56, KK IVa/15
- `4959b4fb` Chopiniana: V. Polonaise no. 6 en la bèmol majeur, op. 51 — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Polonaise in A‐flat major, op. 53 “Heroique”
- `d31fdaeb` Concerto for Piano and Orchestra no. 1 in E minor, op. 11 [chamber version, arr. Richard Hofmann] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11
- `850c489f` Concerto for Piano and Orchestra no. 1 in E minor, op. 11 [chamber version, 1830s] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11
- `0cf08e1f` Concerto for Piano and Orchestra no. 1 in E minor, op. 11 [catch‐all for unknown versions] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11
- `366c68b8` Concerto for Piano and Orchestra no. 1 in E minor, op. 11 [orch. Pletnev] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11
- `9c638d6d` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: I. Allegro maestoso [orch. Pletnev] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: I. Allegro maestoso
- `5499fb41` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: I. Allegro maestoso [chamber version, 1830s] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: I. Allegro maestoso
- `13d9b8d3` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: I. Allegro maestoso [chamber version, arr. Richard Hofmann] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: I. Allegro maestoso
- `bef6510e` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: I. Allegro maestoso [catch‐all for unknown versions] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: I. Allegro maestoso
- `b6f286f9` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: II. Romance. Larghetto [orch. Pletnev] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: II. Romance. Larghetto
- `65b162c8` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: II. Romance. Larghetto [chamber version, arr. Richard Hofmann] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: II. Romance. Larghetto
- `e95976ec` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: II. Romance. Larghetto [chamber version, 1830s] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: II. Romance. Larghetto
- `119a9dc4` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: II. Romance. Larghetto [catch‐all for unknown versions] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: II. Romance. Larghetto
- `364ac845` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: III. Rondo. Vivace [chamber version, arr. Richard Hofmann] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: III. Rondo. Vivace
- `cae2192d` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: III. Rondo. Vivace [chamber version, 1830s] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: III. Rondo. Vivace
- `38c19c13` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: III. Rondo. Vivace [catch‐all for unknown versions] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: III. Rondo. Vivace
- `20a7cf53` Concerto for Piano and Orchestra no. 1 in E minor, op. 11: III. Rondo. Vivace [orch. Pletnev] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: III. Rondo. Vivace
- `700eb50e` Concerto for Piano and Orchestra no. 2 in F minor, op. 21 [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21
- `af6b158f` Concerto for Piano and Orchestra no. 2 in F minor, op. 21 [Burmeister instrumentation] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21
- `bc67bcc9` Concerto for Piano and Orchestra no. 2 in F minor, op. 21 [chamber version] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21
- `c462fe0d` Concerto for Piano and Orchestra no. 2 in F minor, op. 21 [orch. Pletnev] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21
- `5502220c` Concerto for Piano and Orchestra no. 2 in F minor, op. 21: I. Maestoso [chamber version] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: I. Maestoso
- `e9456296` Concerto for Piano and Orchestra no. 2 in F minor, op. 21: I. Maestoso [orch. Pletnev] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: I. Maestoso
- `fdac118e` Concerto for Piano and Orchestra no. 2 in F minor, op. 21: I. Maestoso [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: I. Maestoso
- `7368c323` Concerto for Piano and Orchestra no. 2 in F minor, op. 21: II. Larghetto [orch. Pletnev] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: II. Larghetto
- `95c822c0` Concerto for Piano and Orchestra no. 2 in F minor, op. 21: II. Larghetto [chamber version] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: II. Larghetto
- `89c0348c` Concerto for Piano and Orchestra no. 2 in F minor, op. 21: II. Larghetto [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: II. Larghetto
- `0141319e` Concerto for Piano and Orchestra no. 2 in F minor, op. 21: III. Allegro vivace [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: III. Allegro vivace
- `b445620e` Concerto for Piano and Orchestra no. 2 in F minor, op. 21: III. Allegro vivace [chamber version] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: III. Allegro vivace
- `08a7b20a` Concerto for Piano and Orchestra no. 2 in F minor, op. 21: III. Allegro vivace [orch. Pletnev] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: III. Allegro vivace
- `a2adfe72` Fantaisie‐impromptu in C‐sharp minor, op. 66 [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Fantaisie‐impromptu in C‐sharp minor, op. 66
- `e8c3e01e` Five Studies, Anh. Ia/1 no. 1: Study in F minor after Frédéric Chopin — MB 에 편곡자가 걸려 있음(instrument arranger: Johannes Brahms)
- `c4531c07` Funeral March from Piano Sonata no. 2 (Arr. Breiner) — 제목에 "Arr. Breiner" — 브라이너 편곡
- `ec4e52ac` Herbstlaub (Berceuse) — MB 에 편곡자가 걸려 있음(arranger: James Last)
- `97051e03` Ich gehe mit dir — MB 에 편곡자가 걸려 있음(arranger: Heino Petrik)
- `90d04b29` Largo from the Piano Concerto No. 2 in F minor, Op. 21 [Arrangement for piano by Earl Wild] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 2 in F minor, op. 21: II. Larghetto
- `8ac134b3` Les Sylphides [Ballets Russes production] — 발레 <레 실피드>(쇼팽 곡들을 관현악으로 엮은 발레)
- `d29e0a3b` Les Sylphides [orch. by Douglas] — 발레 <레 실피드>의 로이 더글러스 관현악판
- `7213e1e4` Les Sylphides: I. Prélude [orch. by Douglas] — MB 에 편곡자가 걸려 있음(orchestrator: Roy Douglas)
- `6a6c63ea` Mazurka in B‐flat major “à Alexandra Wolowska”, B. 73, KK. 1223 [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka in B‐flat major “à Alexandra Wolowska”, B. 73, KK IVb/1, KK. 1223
- `1f632576` Mazurka no. 22 in G‐sharp minor, op. 33 no. 1 [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 22 in G‐sharp minor, op. 33 no. 1
- `a678da0e` Mazurka no. 24 in C major, op. 33 no. 3 [for cello and piano, Franchomme] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 24 in C major, op. 33 no. 3
- `281f5c1e` Mazurka no. 44 in C major, op. 67 no. 3 [for string orchestra] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 44 in C major, op. 67 no. 3
- `9dc9405b` Mazurka no. 45 in A minor, op. 67 no. 4 [violin and piano, arr. Kreisler] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 45 in A minor, op. 67 no. 4
- `bbf125d6` Mazurka no. 47 in A minor, op. 68 no. 2 [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 47 in A minor, op. 68 no. 2
- `995b93cd` Mazurka no. 5 in B‐flat major, op. 7 no. 1 [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 5 in B‐flat major, op. 7 no. 1
- `3eefba7e` Mazurka, op. 24 no. 3 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 16 in A‐flat major, op. 24 no. 3
- `a4df9635` Mazurka, op. 33 no. 1 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 22 in G‐sharp minor, op. 33 no. 1
- `c57168e2` Mazurka, op. 33 no. 4 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Mazurka no. 25 in B minor, op. 33 no. 4
- `00ab1963` Mes joies, S. 480/5 bis — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Song in G‐flat major, op. 74 no. 12 “Moja pieszczotka”
- `329be949` Military Polonaise [for brass band, Mortimer] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Polonaise in A major, op. 40 no. 1 “Military”
- `4152294b` Mondschein (Nocturne op. 72 / no. 1) — MB 에 편곡자가 걸려 있음(arranger: James Last)
- `e9551b1f` Nocturne in E minor, op. 72 no. 1 [arr. Auer for violin and piano] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 19 in E minor, op. 72 no. 1: Andante
- `89c5f8c4` Nocturne in E‐flat major, op. 55 no. 2 [for violin and piano, Saint‐Saëns] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 16 in E‐flat major, op. 55 no. 2: Lento
- `802ad305` Nocturne in E‐flat, op. 55 no. 2 [for violin and piano, arr. Heifetz] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 16 in E‐flat major, op. 55 no. 2: Lento
- `71ed655a` Nocturne no. 10 in A‐flat major, op. 32 no. 2: Lento [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 10 in A‐flat major, op. 32 no. 2: Lento
- `fe304a92` Nocturne no. 12 in G major, op. 37 no. 2: Andantino [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 12 in G major, op. 37 no. 2: Andantino
- `197db8aa` Nocturne no. 14 in F‐sharp minor, op. 48 no. 2: Andantino [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 14 in F‐sharp minor, op. 48 no. 2: Andantino
- `c1d87ae3` Nocturne no. 18 in E major, op. 62 no. 2: Lento [for violin and piano, Saint‐Saëns] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 18 in E major, op. 62 no. 2: Lento
- `e019ffca` Nocturne no. 19 in E minor, op. 72 no. 1: Andante [arr. Taneyev] — MB 에 편곡자가 걸려 있음(instrument arranger: Сергей Танеев, instrument arranger: Сергей Танеев)
- `03fe28a6` Nocturne no. 2 in E‐flat major, op. 9 no. 2 [for cello and orchestra, arr. Cullen] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `7689c804` Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante [for cello and piano, David Popper] — MB 에 편곡자가 걸려 있음(instrument arranger: David Popper)
- `47fb07f5` Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `76b4bb84` Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante [for violin and piano, arr. Sarasate] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `dc7516c3` Nocturne no. 2 in E‐flat major, op. 9, no. 2 [arr. R. Pontinen & M. Frost] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `c48ce30b` Nocturne no. 20 in C‐sharp minor [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 20 in C‐sharp minor “Reminiscence”, op. posth. 1 no. 16, B. 49, KKIVa/16
- `43486445` Nocturne no. 20 in C‐sharp minor, op. posth. [for violin and piano, arr. Milstein] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 20 in C‐sharp minor “Reminiscence”, op. posth. 1 no. 16, B. 49, KKIVa/16
- `3f5ae66e` Nocturne no. 20 in C‐sharp minor, op. posth. 1 no. 16, BI 49 “Reminiscence” [for cello and piano, Piatigorsky] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 20 in C‐sharp minor “Reminiscence”, op. posth. 1 no. 16, B. 49, KKIVa/16
- `0f7621c9` Nocturne no. 8 in D‐flat major, op. 27 no. 2: Lento sostenuto [for violin and piano, Sarasate] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 8 in D‐flat major, op. 27 no. 2: Lento sostenuto
- `a1057ecf` Nocturne, op. 27 no. 2 [for violin and piano, arr. Wilhelmj] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 8 in D‐flat major, op. 27 no. 2: Lento sostenuto
- `1883bb88` Nocturne, op. 32 no. 1 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 9 in B major, op. 32 no. 1: Andantino sostenuto
- `edfc256e` Nocturne, op. 37 no. 1 [for violin and piano, arr. A. Wilhelmj] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 11 in G minor, op. 37 no. 1: Andante sostenuto
- `71085559` Nocturne, op. 9 no. 2 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `140f9d05` Opus 5 — MB 에 편곡자가 걸려 있음(arranger: Charlie Shavers)
- `251532aa` Polonaise brillante in C major, op. 3: Introduction. Lento – Alla polacca. Allegro con spirito [arr. Feuermann] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Introduction and Polonaise brillante for cello & piano in C major, op. 3
- `7837a31e` Polonaise in A major, op. 40 no. 1 “Military” [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Polonaise in A major, op. 40 no. 1 “Military”
- `9ffa2793` Polonaise in A‐flat major, op. 53 “Heroique” [concert transcription by Busoni] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Polonaise in A‐flat major, op. 53 “Heroique”
- `2e787d09` Polonaise in A‐flat major, op. 53 “Heroique” [Greeley recension] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Polonaise in A‐flat major, op. 53 “Heroique”
- `9763ecce` Prelude in E Minor [arr. Gerry Mulligan] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 4 in E minor, op. 28: Largo
- `b96ed4f8` Prelude, Op. 28, No. 20 and Variations — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 20 in C minor, op. 28: Largo
- `10cf4009` Prelude, op. 28 no. 15 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 15 in D‐flat major, op. 28 “Raindrop”: Sostenuto
- `e157bd3b` Prelude, op. 28 no. 20 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 20 in C minor, op. 28: Largo
- `767d8bab` Prelude, op. 28 no. 6 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 6 in B minor, op. 28: Lento assai
- `aa36a1bb` Prelude, op. 28 no. 7 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 7 in A major, op. 28: Andantino
- `2be54297` Prélude in A major, op. 28 no. 7: Andantino [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 7 in A major, op. 28: Andantino
- `736334ac` Prélude in D‐flat major, op. 28 no. 15 “Raindrop”: Sostenuto [for cello and piano, Casals] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 15 in D‐flat major, op. 28 “Raindrop”: Sostenuto
- `f350b584` Prélude in E major, S. 662 no. 2 [for organ, Liszt] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 9 in E major, op. 28: Largo
- `c7eac577` Prélude in E minor, S. 662 no. 1 [for organ, Liszt] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 4 in E minor, op. 28: Largo
- `662cbed0` Prélude no. 1 in C major, op. 28: Agitato [catch-all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 1 in C major, op. 28: Agitato
- `a4300361` Prélude no. 15 in D‐flat major, op. 28 “Raindrop”: Sostenuto [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 15 in D‐flat major, op. 28 “Raindrop”: Sostenuto
- `6d80af9f` Prélude no. 20 in C minor, op. 28: Largo [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 20 in C minor, op. 28: Largo
- `eb36ba51` Prélude no. 4 in E minor, op. 28: Largo [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 4 in E minor, op. 28: Largo
- `dd4cbe0f` Prélude no. 7 in A major, op. 28 [for piano and cello, arr. Franchomme] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 7 in A major, op. 28: Andantino
- `2172d95b` Prélude no. 9 in E major, op. 28: Largo [for four cellos, Franchomme] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 9 in E major, op. 28: Largo
- `e91426b8` Romance [for solo piano, Balakirev, from Chopin's Piano Concerto no. 1] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Concerto for Piano and Orchestra no. 1 in E minor, op. 11: II. Romance. Larghetto
- `e2883ae3` Schön wär ein zweites Leben — MB 에 편곡자가 걸려 있음(arranger: Heinz Kiessling)
- `c2c38e5a` Sonata for Piano no. 2 in B‐flat minor, op. 35: III. Marche funèbre. Lento [for four cellos, Franchomme] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Sonata for Piano no. 2 in B‐flat minor, op. 35: III. Marche funèbre. Lento
- `f9ec22a2` Sonata for Piano no. 2 in B‐flat minor, op. 35: III. Marche funèbre. Lento [arr. Édouard Batiste for organ] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Sonata for Piano no. 2 in B‐flat minor, op. 35: III. Marche funèbre. Lento
- `f9d6bee8` Sonata for Piano no. 2 in B‐flat minor, op. 35: III. Marche funèbre. Lento [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Sonata for Piano no. 2 in B‐flat minor, op. 35: III. Marche funèbre. Lento
- `f383228f` Song in A minor, op. 74 no. 13 “Nie ma czego trzeba” [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Song in A minor, op. 74 no. 13 “Nie ma czego trzeba”
- `c092191a` Song in G major, op. 74 no. 1 “Życzenie” [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Song in G major, op. 74 no. 1 “Życzenie”
- `46af5550` Trois Écossaises [for winds, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: 3 Écossaises, op. posth. 72/3
- `d225fbfb` Trois Écossaises: I. Vivace [for winds, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Écossaises, op. 72 no. 3: No. 1 in D major
- `893f03e5` Trois Écossaises: II. […] [for winds, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Écossaises, op. 72 no. 3: No. 2 in G major
- `07a8a60f` Trois Écossaises: III. Giocoso [for winds, Françaix] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Écossaises, op. 72 no. 3: No. 3 in D‐flat major
- `8d17b555` Valse brillante [clarinet sextet] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 4 in F major, op. 34 no. 3
- `3f69368d` Valse, op. 64 no. 1 (The Minute Waltz) [for trombone and piano, Jacobsen] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz”
- `d4932d63` Variations in B‐flat major on “Là ci darem la mano”, op. 2: Introduction. Largo [for solo piano, Chopin] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Variations in B‐flat major on “Là ci darem la mano”, op. 2: Introduction. Largo
- `b1581f93` Variations in B‐flat major on “Là ci darem la mano”, op. 2: Tema. Allegretto [for solo piano, Chopin] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Variations in B‐flat major on “Là ci darem la mano”, op. 2: Tema. Allegretto
- `cef7a711` Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation I. Brillante [for solo piano, Chopin] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation I. Brillante
- `21dfe304` Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation II. Veloce, ma accuratamente [for solo piano, Chopin] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation II. Veloce, ma accuratamente
- `8a9aad87` Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation III. Sempre sostenuto [for solo piano, Chopin] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation III. Sempre sostenuto
- `238f57f8` Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation IV. Con bravura [for solo piano, Chopin] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation IV. Con bravura
- `321505e2` Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation V. Adagio – Alla polacca [for solo piano, Chopin] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation V. Adagio – Alla polacca
- `8dc0e4f9` Variations sur un air populaire allemand [for winds, Françaix] — MB 에 편곡자가 걸려 있음(arranger: Jean Françaix)
- `95bd6a83` Variations sur un air populaire allemand: I. Introduzione. A capriccio [for winds, Françaix] — MB 에 편곡자가 걸려 있음(arranger: Jean Françaix)
- `c30a2f96` Variations sur un air populaire allemand: II. Tema. Andantino [for winds, Françaix] — MB 에 편곡자가 걸려 있음(arranger: Jean Françaix)
- `bf281825` Variations sur un air populaire allemand: III. Variation 1. Elegantamente [for winds, Françaix] — MB 에 편곡자가 걸려 있음(arranger: Jean Françaix)
- `dfdbb104` Variations sur un air populaire allemand: IV. Variation 2. Scherzando [for winds, Françaix] — MB 에 편곡자가 걸려 있음(arranger: Jean Françaix)
- `61d540a5` Variations sur un air populaire allemand: V. Variation 3. Tranquillamente [for winds, Françaix] — MB 에 편곡자가 걸려 있음(arranger: Jean Françaix)
- `ac8a3929` Variations sur un air populaire allemand: VI. Variation 4. Meno mosso [for winds, Françaix] — MB 에 편곡자가 걸려 있음(arranger: Jean Françaix)
- `d8b5e1bc` Variations sur un air populaire allemand: VII. Variation 5. Tempo di valse. Molto brillante [for winds, Françaix] — MB 에 편곡자가 걸려 있음(arranger: Jean Françaix)
- `1178a225` Waltz no. 1 in E‐flat major, op. 18 “Grande valse brillante” [arr. Godowsky] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 1 in E‐flat major, op. 18 “Grande Valse brillante”
- `8d8c14be` Waltz no. 1 in E‐flat major, op. 18 “Grande valse brillante” [catch‐all work for all unspecified transcriptions (usually orchestral). Please do not add an arranger AR to this work, create a new arrangement work instead] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 1 in E‐flat major, op. 18 “Grande Valse brillante”
- `cee39013` Waltz no. 10 in B minor, op. 69 no. 2 [catch‐all arrangement] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 10 in B minor, op. 69 no. 2
- `5cef3d8e` Waltz no. 12 in F minor, op. 70 no. 2 [arr. Godowsky] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 12 in F minor, op. 70 no. 2
- `7431834e` Waltz no. 13 in D‐flat major, op. 70 no. 3 [arr. Godowsky] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 13 in D‐flat major, op. 70 no. 3
- `a2f9a1b0` Waltz no. 14 in E minor, B. 56, KK IVa/15 [for violin and piano, Ysaÿe] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 14 in E minor, B. 56, KK IVa/15
- `6f029a02` Waltz no. 14 in E minor, B. 56, KK IVa/15 [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 14 in E minor, B. 56, KK IVa/15
- `ea2dd923` Waltz no. 19 in A minor, B. 150 [catch‐all arrangement] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 19 in A minor, B. 150, KK IVb/11
- `5df1ff3e` Waltz no. 3 in A minor, op. 34 no. 2 [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 3 in A minor, op. 34 no. 2
- `fcdf8eaf` Waltz no. 3 in A minor, op. 34 no. 2 [for violin and piano, Sarasate] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 3 in A minor, op. 34 no. 2
- `41b59a9d` Waltz no. 4 in F major, op. 34 no. 3 [for violin and piano, Sarasate] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 4 in F major, op. 34 no. 3
- `12a12dea` Waltz no. 5 in A‐flat major, op. 42 “Grande valse” [catch‐all work for all unspecified transcriptions (usually orchestral). Please do not add an arranger AR to this work, create a new arrangement work instead] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 5 in A‐flat major, op. 42 “Grande valse”
- `9cfb73d5` Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz” [catch‐all for unspecified transcriptions. Add any arranger to the recording unless performed by more than one artist] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz”
- `bddc4854` Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz” [arr. Godowsky] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz”
- `d779dbe3` Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz” [arranged by Michałowski] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz”
- `343ed4f6` Waltz no. 7 in C‐sharp minor, op. 64 no. 2 [catch‐all work for all unspecified transcriptions (usually orchestral). Please do not add an arranger AR to this work, create a new arrangement work instead] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 7 in C‐sharp minor, op. 64 no. 2
- `5c382c02` Waltz no. 7 in C‐sharp minor, op. 64 no. 2 [arr. Davydov for piano and cello] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz”
- `8c37b687` Waltz no. 7 in C‐sharp minor, op. 64 no. 2 [arr. Davydov for piano and cello] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 7 in C‐sharp minor, op. 64 no. 2
- `9d5a54d1` Waltz no. 8 in A‐flat major, op. 64 no. 3 [arr. Davydov for piano and cello] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 8 in A‐flat major, op. 64 no. 3
- `aa10f09c` Waltz no. 8 in A‐flat major, op. 64 no. 3 [for violin and piano, Sarasate] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 8 in A‐flat major, op. 64 no. 3
- `3ac359b4` Waltz no. 8 in A‐flat major, op. 64 no. 3 [arr. Godowsky] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 8 in A‐flat major, op. 64 no. 3
- `0a58d45e` Waltz no. 9 in A‐flat major, op. 69 no. 1 [arr. Godowsky] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 9 in A‐flat major, op. 69 no. 1
- `ad3ff45f` Waltz, op. 34 no. 2 [for guitar, Tárrega] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Waltz no. 3 in A minor, op. 34 no. 2
- `82eb7a15` Étude in A minor, op. 10 no. 2: Allegro [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in A minor, op. 10 no. 2: Allegro
- `9ea5f992` Étude in A‐flat major, op. 25 no. 1 “Aeolian Harp”: Allegro sostenuto [for harp, Posse] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in A‐flat major, op. 25 no. 1 “Aeolian Harp”: Allegro sostenuto
- `231c71b5` Étude in C‐sharp minor, op. 10 no. 4: Presto [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in C‐sharp minor, op. 10 no. 4: Presto
- `6e99c8f1` Étude in C‐sharp minor, op. 25 no. 7 [for cello and piano, Glazunov] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in C‐sharp minor, op. 25 no. 7: Lento
- `d8ffbcd7` Étude in C‐sharp minor, op. 25 no. 7 [for cello and piano, arr. Franchomme] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in C‐sharp minor, op. 25 no. 7: Lento
- `f19b79e9` Étude in E major, op. 10 no. 3: Lento ma non troppo [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `da79b783` Étude in E‐flat minor, op. 10 no. 6 [for cello and piano, Glazunov] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in E‐flat minor, op. 10 no. 6: Andante, con molto espressione
- `7fb5add6` Étude in F minor, op. 25 no. 2: Presto [catch‐all for arrangements] — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in F minor, op. 25 no. 2: Presto
- `37eaa4f1` Прелюдия в ми-миноре — MB 에 편곡자가 걸려 있음(arranger: Алексей Козлов)
- `e676ae88` ציור של אהבה — MB 에 편곡자가 걸려 있음(arranger: יונתן בר גיורא)
- `e3e96775` ゲームオーバー — MB 에 편곡자가 걸려 있음(revised by: 植松伸夫)
- `6633e833` ハルナのテーマ — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `07350813` 別れの不安 — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 4 in E minor, op. 28: Largo
- `4f9f5b3d` 彼女の悲しみ — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in E‐flat minor, op. 10 no. 6: Andante, con molto espressione
- `fd25ae22` 必死の救出/それぞれの想い — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Étude in F minor, op. 10 no. 9: Allegro molto agitato
- `7f6f331f` 捜索の日々 — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 17 in A‐flat major, op. 28: Allegretto
- `ce893cb6` 異次元 (lazy world) — 다른 사람(또는 다른 편성)의 편곡 work — 원곡: Prélude no. 17 in A‐flat major, op. 28: Allegretto

### 관현악 편곡 work — 22개

- `98a4bd07` Chopiniana, op. 46: I. Polonaise — 관현악 편곡 work — 원곡: Polonaise in A major, op. 40 no. 1 “Military”
- `af77cc54` Chopiniana, op. 46: II. Nocturne — 관현악 편곡 work — 원곡: Nocturne no. 4 in F major, op. 15 no. 1: Andante cantabile
- `f7d4970c` Chopiniana, op. 46: III. Mazurka — 관현악 편곡 work — 원곡: Mazurka no. 32 in C‐sharp minor, op. 50 no. 3
- `50c18f54` Chopiniana, op. 46: IV. Waltz [added for revised version and used in Les Sylphides] — 관현악 편곡 work — 원곡: Waltz no. 7 in C‐sharp minor, op. 64 no. 2
- `9c8313a6` Chopiniana, op. 46: V. Tarantella — 관현악 편곡 work — 원곡: Tarantelle in A‐flat major, op. 43
- `94fa5541` Funeral March [orchestrated by Elgar] — 관현악 편곡 work — 원곡: Sonata for Piano no. 2 in B‐flat minor, op. 35: III. Marche funèbre. Lento
- `6d3ae5cb` Funeral March from the Piano Sonata no. 2 in B‐flat minor, op. 35 [orch. Wood] — 관현악 편곡 work — 원곡: Sonata for Piano no. 2 in B‐flat minor, op. 35: III. Marche funèbre. Lento
- `f3a7a7aa` Grande Valse Brillante, op. 18 [orch. Igor Stravinsky] — 관현악 편곡 work — 원곡: Waltz no. 1 in E‐flat major, op. 18 “Grande Valse brillante”
- `c5940ff2` Hexaméron, S. 365b [for piano and orchestra] — 관현악 편곡 work — 원곡: Hexaméron, S. 392
- `0f7b0394` Hexaméron, S. 365b: VIIIa. Variation VI. Largo [for piano and orchestra] — 관현악 편곡 work — 원곡: Hexaméron, S. 392: VIIIa. Variation VI. Largo
- `5b33e551` Les Sylphides: III. Walzer (in G‐flat major, op. 70 no. 1) [orch. Roy Douglas] — 관현악 편곡 work — 원곡: Waltz no. 11 in G‐flat major, op. 70 no. 1
- `34cb7fdd` Les Sylphides: IV. Mazurka [orch. by Douglas] — 관현악 편곡 work — 원곡: Mazurka no. 23 in D major, op. 33 no. 2, CT. 73
- `52138f3a` Les Sylphides: V. Mazurka [orch. by Douglas] — 관현악 편곡 work — 원곡: Mazurka no. 44 in C major, op. 67 no. 3
- `e3becd7b` Les Sylphides: VI. Prélude [orch. by Douglas] — 관현악 편곡 work — 원곡: Prélude no. 7 in A major, op. 28: Andantino
- `8462c5af` Les Sylphides: VII. Walzer [orch. by Douglas] — 관현악 편곡 work — 원곡: Waltz no. 7 in C‐sharp minor, op. 64 no. 2
- `59ee2727` Les Sylphides: VIII. Walzer (in E‐flat major, op. 18 no. 1) [orch. by Douglas] — 관현악 편곡 work — 원곡: Waltz no. 1 in E‐flat major, op. 18 “Grande Valse brillante”
- `8e502789` Marche funèbre — 관현악 편곡 work — 원곡: Sonata for Piano no. 2 in B‐flat minor, op. 35: III. Marche funèbre. Lento
- `354b78ab` Mazurka no. 13 in A minor, op. 17 no. 4 [orch. Stokowski] — 관현악 편곡 work — 원곡: Mazurka no. 13 in A minor, op. 17 no. 4
- `2fed3745` Mazurka no. 17 in B‐flat minor, op. 24 no. 4 [orch. Stokowski] — 관현악 편곡 work — 원곡: Mazurka no. 17 in B‐flat minor, op. 24 no. 4
- `7a40c893` Nocturne no. 10 in A‐flat major, op. 32 no. 2: Lento [orch. Igor Stravinsky] — 관현악 편곡 work — 원곡: Nocturne no. 10 in A‐flat major, op. 32 no. 2: Lento
- `5bb70fb2` Prelude in E minor [orch. by Stokowski] — 관현악 편곡 work — 원곡: Prélude no. 4 in E minor, op. 28: Largo
- `53d6e594` Prélude no. 24 in D minor, op. 28 [orch. Stokowski] — 관현악 편곡 work — 원곡: Prélude no. 24 in D minor, op. 28: Allegro appassionato

### 쇼팽 곡을 바탕으로 한 다른 사람의 곡 — 41개

- `6fdda52b` Aime‐moi — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 23 in D major, op. 33 no. 2, CT. 73
- `da383a7c` Atvadīšanās valsis — 라트비아어 대중가요("작별의 왈츠"), 쇼팽 선율을 쓴 노래
- `93453cb8` Berceuse [Viardot arrangement of Mazurka op. 33 no. 3] — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 24 in C major, op. 33 no. 3
- `5f18ed78` Careless Love — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `2c3d39ad` Chant d’allégresse — 쇼팽 선율에 가사를 붙인 노래(작사: Pierre Dac)
- `aad325da` Chopin’s Nocturne in E Flat [Greeley adaptation] — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `2ba1f9aa` Coquette — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 5 in B‐flat major, op. 7 no. 1
- `0a3986ef` Faible cœur — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 7 in F minor, op. 7 no. 3
- `b935fd53` Freddie’s Mood (Chopin’s Nocturne in E‐flat major, op. 9 no. 2) — Op. 9-2 를 바탕으로 한 재즈 곡
- `6a3c80d2` Hexaméron, S. 392 — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: I puritani: Atto II. N°17d “Suoni la tromba, e intrepido” (Giorgio, Riccardo)
- `5758f306` Kurbus — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `d2c74518` La Beauté — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 42 in G major, op. 67 no. 1
- `f0124b8b` La Danse — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 30 in G major, op. 50 no. 1
- `72d36468` La Fête — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 4 in E‐flat minor, op. 6 no. 4
- `15866cd1` La Jeune Fille — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 15 in C major, op. 24 no. 2
- `819cd4ce` La Valse posthume [Carla Bruni song] — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Waltz no. 19 in A minor, B. 150, KK IVb/11
- `ee9334ee` Lemon Incest — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `fa8c6412` L’Oiselet — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 47 in A minor, op. 68 no. 2
- `0cdd3b62` No Other Love [Chopin adaptation] — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `281d19ec` No Other Love (Chopin’s “Etude in E major”) [Greeley adaptation] — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `27bcf2c6` Nocturne in Bb Minor [Ros Stephen’s version] — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Nocturne no. 1 in B‐flat minor, op. 9 no. 1: Larghetto
- `34b667c8` Noktirne — 대중가요("Noktirne"), 쇼팽 녹턴 선율을 쓴 노래
- `02776154` Plainte d'amour — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 1 in F‐sharp minor, op. 6 no. 1
- `671f769f` Rita [Ana Faria song based on Chopin's Grande Valse brillante] — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Waltz no. 1 in E‐flat major, op. 18 “Grande Valse brillante”
- `803d331d` Seize ans — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 31 in A‐flat major, op. 50 no. 2
- `3a78a03f` So Deep Is the Night — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `ad1a1668` Séparation — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Mazurka no. 14 in G minor, op. 24 no. 1
- `9b56bef6` The Minute Waltz [lyrics by Lan O’Kun] — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz”
- `8f9bd170` This Is My Faith — 대중가요("This Is My Faith")
- `ef7b44d8` Triste (“Tristesse”) — Op. 10-3 선율로 만든 노래("Tristesse" 가사판들의 바탕 work)
- `7748f87b` Tristesse [L’ombre s’enfuit] — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `6ad905a3` Valse de l’adieu — 노래("Valse de l'adieu") — Op. 69-1 선율에 가사를 붙인 것으로 보임
- `244f3e2e` We Were Lovers — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `f6f71100` Étude no. 1, op. 10 no. 1 (1st version) C major — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in C major, op. 10 no. 1: Allegro
- `944f42be` Étude no. 5, op. 10 no. 3 D‐flat major (left hand) — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `2e6d53bb` Étude no. 7, op. 10 no. 5 (1st version) G‐flat major — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in G‐flat major, op. 10 no. 5 “Black Keys”: Vivace
- `06d75b7a` בני אדם — 쇼팽 선율에 가사를 붙인 노래(작사: מאיר גולדברג)
- `21cb9b5b` דקותיים — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz”
- `d0271463` 別れの曲 — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `57225d83` 奇跡のプレスト — 쇼팽 선율에 가사를 붙인 노래(작사: Toshl)
- `ab97989c` 英雄〜笑って!ショパン先輩〜 — 쇼팽 곡을 바탕으로 만든 다른 사람의 곡 — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante

### 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판 — 38개

- `4efd568e` Chopin na Bałkanach — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Song in G minor, op. 74 no. 2 “Wiosna”
- `5ccc4609` Chopin na Dzikim Zachodzie — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Waltz no. 6 in D‐flat major, op. 64 no. 1 “Minute Waltz”
- `68534ff4` Chopin na Mazowszu — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Song in G major, op. 74 no. 1 “Życzenie”
- `d6854ca1` Chopin na Syberii — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Rondo à la Krakowiak in F major, op. 14
- `c5bd1ef9` Chopin w Afryce — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Prélude no. 15 in D‐flat major, op. 28 “Raindrop”: Sostenuto
- `1f98ffa7` Chopin w Andaluzji — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Waltz no. 7 in C‐sharp minor, op. 64 no. 2
- `b42a1cac` Chopin w Arabii — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Song in A minor, op. 74 no. 13 “Nie ma czego trzeba”
- `77e8a6eb` Chopin w Armenii — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Song in G minor, op. 74 no. 2 “Wiosna”
- `b583c3ed` Chopin w Brazylii — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `33ce0116` Chopin w Bułgarii — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Mazurka no. 23 in D major, op. 33 no. 2, CT. 73
- `28ed4ad7` Chopin w Chinach — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Étude in E major, op. 10 no. 3: Lento ma non troppo
- `7d14125c` Chopin w Indiach — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Fantaisie‐impromptu in C‐sharp minor, op. 66
- `a6062be6` Chopin w Japonii — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Song in D minor, op. 74 no. 11 “Dwojaki koniec”
- `c05305a8` Chopin w Persji — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Prélude no. 4 in E minor, op. 28: Largo
- `d912e986` Could It Be Magic — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `072157be` Could It Be Magic [version as recorded by Take That] — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `7f8f872c` De minuten wals — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: The Minute Waltz
- `c6dc20a2` Dissolving Colours (a) — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `cb849c25` Dissolving Colours (b) — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `96831a80` Dissolving Colours :30 (a) — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `e7aa8376` Dissolving Colours :30 (b) — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `db393379` Dissolving Colours :60 — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Nocturne no. 2 in E‐flat major, op. 9 no. 2: Andante
- `3c9cfcf9` I’m Always Chasing Rainbows — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Fantaisie‐impromptu in C‐sharp minor, op. 66
- `fea0242d` Jane B. — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Prélude no. 4 in E minor, op. 28: Largo
- `52e3a2fd` Kanssasi tahdon pois — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `0bb11e94` Kdo z nás smí se vrátit — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `659a6a0e` Le Temps qui court — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `66b84484` Lemon Incest — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Lemon Incest
- `b3f587d1` Les Sylphides: II. Nocturne in F major, op. 15 no. 1 [orch. by Douglas] — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Nocturne no. 4 in F major, op. 15 no. 1: Andante cantabile
- `e83aaf6e` Magia [Brazilian Portuguese version of “Could It Be Magic”] — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `27ba642a` Oliver Cromwell — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Polonaise in A‐flat major, op. 53 “Heroique”
- `d7be26b8` Ontmoeting — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `e0efb28b` Puede ser genial — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `b36b9a53` Schau wie es regnet (Could It Be Magic) — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `dcf18dbb` Sera esto magia — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic
- `f9682830` ノクターン — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Nocturne no. 20 in C‐sharp minor “Reminiscence”, op. posth. 1 no. 16, B. 49, KKIVa/16
- `523c8184` ノクターン — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Nocturne no. 20 in C‐sharp minor “Reminiscence”, op. posth. 1 no. 16, B. 49, KKIVa/16
- `ca43640b` 恋はマジック — 쇼팽 곡을 바탕으로 한 다른 사람의 다른 판(대중음악 등) — 원곡: Could It Be Magic

### 쇼팽이 작곡가로 걸려 있지 않은 work — 9개

- `5eaaa3bd` Concerto for Piano and Orchestra no. 1 “Hommage à Frédéric Chopin” — 쇼팽이 작곡가로 걸려 있지 않음(작곡가: Elżbieta Sikora)
- `089505e0` Douze Études, pour piano, L. 136, CD 143 — 쇼팽이 작곡가로 걸려 있지 않음(작곡가: Claude Debussy)
- `ca0e0d4c` Iluminada — 쇼팽이 작곡가로 걸려 있지 않음(작곡가: 없음)
- `1c9ab467` Letters from Composers: I. Frédéric Chopin to a friend — 쇼팽이 작곡가로 걸려 있지 않음(작곡가: Dominick Argento)
- `ba99938e` Nocturne — 쇼팽이 작곡가로 걸려 있지 않음(작곡가: Bronisław Kaper)
- `157a48c0` Nocturne — 쇼팽이 작곡가로 걸려 있지 않음(작곡가: Jean Françaix)
- `e9ff3daa` Sonata for Piano no. 12 in A‐flat major, op. 26 “Funeral March”: II. Scherzo. Allegro molto — 쇼팽이 작곡가로 걸려 있지 않음(작곡가: Ludwig van Beethoven)
- `3900343e` Étude n° 12 Littoral [In Paradisum] — 쇼팽이 작곡가로 걸려 있지 않음(작곡가: Fabien Touchard)
- `3dc03644` Żelazowa Wola, op. 37 — 쇼팽이 작곡가로 걸려 있지 않음(작곡가: Сергей Михайлович Ляпунов)

### 같은 곡의 겹친 work — 24개

- `ec5b2b50` Contredanse en sol bémol majeur — B. 17 콩트르당스(dd9ca5a0)와 같은 곡의 겹친 work
- `03b0a556` Largo in E‐flat major “Boże, coś Polskę”, op. posth. — B. 109 라르고(691dde67)와 같은 곡의 겹친 work
- `75ed325b` Mazurek As‐dur, Nr 58 [WN 45] — B. 85 마주르카 A♭장조(c86873bb)와 같은 곡(WN 45)
- `d89e7997` Mazurek B‐dur, Nr 52 [WN 7] — B. 16-2 마주르카 B♭장조(99f0b765)와 같은 곡(WN 7)
- `d23291dd` Mazurek B‐dur, Nr 56 [WN 41] — B. 73 마주르카 B♭장조(b02da1dd)와 같은 곡(WN 41)
- `ca00123d` Mazurek C‐dur, Nr 57 — B. 82 마주르카 C장조(d8fd2536)와 같은 곡(폴란드어 번호 57)
- `aa02e0cc` Mazurek G‐dur, Nr 53 [WN 8] — B. 16-1 마주르카 G장조(d8f75379)와 같은 곡(WN 8)
- `4f3a47a2` Nocturne N°20 en do dièse mineur op. posthume — B. 49 녹턴 C#단조(a7619cf9)와 같은 곡의 겹친 work
- `7c25e128` Piano Concerto No. 2 in F Minor, Op. 21, B. 43: I. Maestoso (Live) — Op. 21 1악장(160658f6)과 같은 곡, 음반 트랙 제목("Live")으로 만든 work
- `6618a422` Piano Concerto No. 2 in F Minor, Op. 21, B. 43: II. Larghetto (Live) — Op. 21 2악장(7dcac5ec)과 같은 곡, 음반 트랙 제목("Live")으로 만든 work
- `5a0929b6` Piano Concerto No. 2 in F Minor, Op. 21, B. 43: III. Allegro vivace (Live) — Op. 21 3악장(4f2c391e)과 같은 곡, 음반 트랙 제목("Live")으로 만든 work
- `f350d92d` Variations on a Theme from Opera by Mozart “Don Giovanni” for Piano and Orchestra B‐dur, op.2 [for piano and orchestra] — Op. 2 변주곡(76d9aed3)과 같은 곡의 겹친 work
- `9e5fc6a8` Études, Op. 25: No. 1 in A-Flat Major "Aeolian Harp" — Op. 25-1(198affaf)과 같은 곡, 음반 트랙 제목으로 만든 work
- `1db25ff2` Études, Op. 25: No. 10 in B Minor "Octave" — Op. 25-10(299558f7)과 같은 곡, 음반 트랙 제목으로 만든 work
- `5d26ecf7` Études, Op. 25: No. 11 in A Minor "Winter Wind" — Op. 25-11(551b5d69)과 같은 곡, 음반 트랙 제목으로 만든 work
- `f8b252f8` Études, Op. 25: No. 12 in C Minor "Ocean" — Op. 25-12(bdaa998e)와 같은 곡, 음반 트랙 제목으로 만든 work
- `5f382cc6` Études, Op. 25: No. 2 in F Minor "The Bees" — Op. 25-2(33b30b84)와 같은 곡, 음반 트랙 제목으로 만든 work
- `77ee067d` Études, Op. 25: No. 3 in F Major "The Horseman" — Op. 25-3(498da548)과 같은 곡, 음반 트랙 제목으로 만든 work
- `f82c3b33` Études, Op. 25: No. 4 in A Minor "Paganini" — Op. 25-4(5c0a978b)와 같은 곡, 음반 트랙 제목으로 만든 work
- `8fe6bd89` Études, Op. 25: No. 5 in E Minor "Wrong Note" — Op. 25-5(3420d060)와 같은 곡, 음반 트랙 제목으로 만든 work
- `5857efc3` Études, Op. 25: No. 6 in G-Sharp Minor "Thirds" — Op. 25-6(3946dfe0)과 같은 곡, 음반 트랙 제목으로 만든 work
- `0993a26e` Études, Op. 25: No. 7 in C-Sharp Minor "Cello" — Op. 25-7(5b2ad9b8)과 같은 곡, 음반 트랙 제목으로 만든 work
- `45127bce` Études, Op. 25: No. 8 in D-Flat Major "Sixths" — Op. 25-8(5867e3c8)과 같은 곡, 음반 트랙 제목으로 만든 work
- `dc01add0` Études, Op. 25: No. 9 in G-Flat Major "Butterfly" — Op. 25-9(0a957e8a)와 같은 곡, 음반 트랙 제목으로 만든 work

### 같은 곡의 다른 판(쇼팽 원작이지만 따로 세지 않음) — 9개

- `cf983faa` 3 Écossaises Op. posth. 72/3 [original manuscript version] — Op. 72-3 에코세즈의 자필 원고 판. 출판본(96fea892)을 part 로 씀
- `ab112c73` Funeral March in C minor, op. 72 no. 2 [Ekier version] — Op. 72-2 장송 행진곡의 에키에르 판. 퐁타나 판(3a15846a)을 part 로 씀
- `5a4b3f08` Funeral March in C minor, op. 72 no. 2 [Ganche version] — Op. 72-2 장송 행진곡의 강슈 판. 퐁타나 판(3a15846a)을 part 로 씀
- `9dbf43e1` Introduction and Polonaise brillante in C major, op. 3 [for piano] — Op. 3 의 피아노 독주판(MB 에서 편곡으로 묶임). 원판(첼로와 피아노)만 셈
- `c7af640d` Mazurka in A minor, B. 45 [first version of op. 7 no. 2] — Op. 7-2 마주르카의 첫 판(B. 45). 위키백과는 따로 세지 않음
- `42a33ce7` Mazurka in A‐flat major, B. 7 — Op. 7-4 마주르카의 첫 판(B. 7). 위키백과는 따로 세지 않음
- `e7ea87ea` Polonaise in F minor, op. 71 no. 3 [autograph version] — Op. 71-3 폴로네즈의 자필본 판. 출판본(퐁타나 판, 72378af3)을 part 로 씀
- `b97d97c4` Rondo, op. 73 [for piano solo] — Op. 73 론도의 피아노 독주판(쇼팽이 1840년에 옮김). 원판(두 대의 피아노, 039bc553)만 셈
- `40cca70d` Variations in B‐flat major on “Là ci darem la mano”, op. 2 [for solo piano, Chopin] — Op. 2 변주곡의 피아노 독주판. 원판(피아노와 관현악, 76d9aed3)만 셈

### 다른 작곡가와 함께 걸린 곡(대중음악·메들리 등) — 25개

- `1e0167d7` Abyssus abyssum vocat in voce — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `8bd522be` Ascension, Part I — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `b888772e` Ascension, Part II — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `8aa568da` Chopin Ballade [Melane Doane song] — 다른 작곡가와 함께 걸린 곡(Melanie Doane) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `674c39da` Chopinesque — 다른 작곡가와 함께 걸린 곡(Jon Batiste) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `6c209bee` Death and Decadence — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `f61b9e2a` End Credits — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `59587992` Eyes of the Lost — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `21266431` Gearge Sand — 다른 작곡가와 함께 걸린 곡(Franz Liszt, Erna Tauro) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `db85437e` Hooked on Romance (Opus 3) — 다른 작곡가와 함께 걸린 곡(Александр Порфирьевич Бородин, Johannes Brahms, Louis Clark, Camille Saint‐Saëns) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `9cd8f002` My Silent Mood — 다른 작곡가와 함께 걸린 곡(Larry Clinton) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `f95cb3b5` Nocturnal — 다른 작곡가와 함께 걸린 곡(片倉三起也) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `b7e7b8e9` Notturno — 다른 작곡가와 함께 걸린 곡(Luca Turilli) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `15ac0304` Paradise — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `58da84c2` Prelude in E minor (Frederic Chopin – Reimagined) — 다른 작곡가와 함께 걸린 곡(Paul Dinletir, Daniel Nicholas Tauber) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `302d7039` Prison of Desire — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `4f5efb86` Prologue: Into the End of the World — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `e8f580d1` Rera l’ànima del vent — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `d553144a` Retrospective — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `1e681b9d` United States of Eurasia / Collateral Damage — 다른 작곡가와 함께 걸린 곡(Matt Bellamy) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `2ebede7a` Victoria — 다른 작곡가와 함께 걸린 곡(Sathorys Elenorth, Henry Purcell, Antonio Vivaldi) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `bbd8b087` Waltz — 다른 작곡가와 함께 걸린 곡(Esther Kaiser) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `ca464897` ヨロコビノウタ — 다른 작곡가와 함께 걸린 곡(Johann Sebastian Bach, Ludwig van Beethoven, Georges Bizet, George Frideric Handel) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `8a5b2aac` 喫茶ボッサ — 다른 작곡가와 함께 걸린 곡(倉橋ヨエコ) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리
- `552e5737` 革命 [DDRMAX2 Dance Dance Revolution 7thMIX] — 다른 작곡가와 함께 걸린 곡(石川貴之, 前田尚紀) — 쇼팽 선율을 쓴 다른 사람의 곡·메들리

### 이미 넣은 part 의 더 잘게 쪼갠 part — 2개

- `8ff922d3` Variations in B‐flat major on “Là ci darem la mano”, op. 2: Coda. Alla Polacca — Op. 2 5변주(32b5f700) 안의 Coda. Alla polacca 부분. 5변주를 part 로 씀
- `d435704f` Variations in B‐flat major on “Là ci darem la mano”, op. 2: Variation V. Adagio — Op. 2 5변주(32b5f700) 안의 Adagio 부분. 5변주를 part 로 씀

### 어느 곡인지 못 가린 work(위키백과 기준 곡은 이미 넣음) — 5개

- `3e8c7490` Mazurek D‐dur, Nr 54 — "Mazurek D-dur, Nr 54" — B. 31 또는 B. 71 과 같은 곡으로 보이나 어느 판인지 MB 정보로 못 가림(둘 다 이미 넣음)
- `6172dde7` Mazurka in A major — "Mazurka in A major" — MB 주석도 "아마 IMSLP 의 미출판 A장조 마주르카" 정도. 위키백과 목록에 맞는 곡이 없음
- `a8fa15e4` Mazurka in A‐flat major, op. posth. — "Mazurka in A-flat major, op. posth." — B. 85(또는 Op. 7-4 첫 판 B. 7)와 같은 곡으로 보임, MB 정보로 못 가림
- `99f349fb` Valse in E‐flat major, op. posth. — "Valse in E-flat major, op. posth." — B. 46 또는 B. 133 과 같은 곡으로 보임, MB 정보로 못 가림
- `8db1e982` Valse sentimental for Cello and Piano — "Valse sentimental for Cello and Piano" — 위키백과 목록에 없는 곡, 편곡으로 보임

### 위작 — 3개

- `8f29334a` Allegretto in F‐sharp major — KK Anh. II/1 알레그레토 F#장조 — 샤를 마이어 마주르카의 축약으로 봄(위키백과 spurious)
- `539f4954` Nocturne oubliée, KK Anh. Ia/6 — KK Anh. Ia/6 "Nocturne oubliée" — 위키백과 spurious
- `9d6ed72b` Valse mélancolique in F‐sharp minor, op. 332 “Le regret” [wrongly attributed to Chopin as KK Ib/7] — KK Anh. Ib/7 "Valse mélancolique" — 샤를 마이어의 <Le Regret> Op. 332 로 밝혀짐(위키백과)

### 출판 단위가 아닌 갈래 묶음 — 2개

- `680c7826` Ballades — 발라드 4곡을 갈래로 묶은 MB work. 출판 단위가 아님(각 발라드는 낱곡으로 넣음)
- `eb68888d` Polonaises — 폴로네즈 Op. 26·40·71 을 갈래로 묶은 MB work. 출판 단위가 아님

## 6. 판단이 애매한 것

구조

1. **Op. 72 는 두 겹 묶음입니다.** 녹턴 E단조·장송 행진곡 C단조·3개의 에코세즈이고, 3번(에코세즈)이 다시 세 곡입니다. MB 도 두 겹(4bf96240 → 96fea892 → 3곡)이라 3번 part 아래 `children` 으로 세 곡을 두었습니다. piece_parts 의 parent_part_id 로 그대로 넣을 수 있지만, 한 겹으로 펴려면 3-1·3-2·3-3 처럼 이어 붙여야 합니다.
2. **Op. 2·13·14·22 를 다악장(partKind=section)으로 두었습니다.** 소나타처럼 악장이 나뉜 곡은 아니지만 MB 에 부분별 work(Op. 2 7개, Op. 13 4개, Op. 14 2개, Op. 22 2개)가 있고 음반도 그렇게 트랙을 나눕니다. 낱곡(parts 없음)으로 내리려면 이 넷만 바꾸면 됩니다. Op. 2 5변주는 MB 가 다시 Adagio·Coda 로 쪼갰는데 5변주 하나로만 두었습니다.
3. **Op. 74 는 위키백과대로 17곡입니다.** MB 는 "Czary"(B. 51)를 18번으로 붙여 18곡으로 묶었습니다. Czary 와 "Dumka"(B. 132), "Jakież kwiaty"(B. 39, MB 없음)는 작품번호 없는 낱곡으로 넣었습니다. 가곡을 한데 보이고 싶으면 Op. 74 와 이 세 곡을 화면에서 따로 모으는 편이 데이터를 덜 건드립니다.
4. **작품번호 없는 곡 묶음 두 개를 새로 만들었습니다.** "2개의 부레"(B. 160b, MB 부모 work 없음)와 "알레그레토와 마주르카"(KK VIIb/7–8, MB 는 한 work 이고 parts 없음). 둘 다 쇼팽이 민요 선율을 적어 둔 것이라 낱곡 두 개로 나눠도 됩니다. "전주곡과 안단티노 아니마토"(KK Anh. Ia/2–3, 위작 의심 단편)도 같은 식으로 묶었습니다.
5. **묶음 제목에 작품번호를 넣었습니다(지시대로).** 그런데 작곡가 화면(`app/composer/[id].tsx:632`)이 제목 아래 `opus_number · 연도` 를 따로 보여 줘서, opus_number 도 채우면 "마주르카 Op. 6 / Op. 6 · 1830" 처럼 번호가 두 번 보입니다. 이미 있는 463·465 는 opus_number 가 비어 있습니다. 묶음은 opus_number 를 비우거나, 제목에서 번호를 빼는 쪽 중 하나를 정해야 합니다.

넣을지 말지

6. **같은 마주르카의 두 판(B. 31 첫 판, B. 71 고친 판)을 둘 다 넣었습니다.** 위키백과가 따로 올리고 B. 번호도 다릅니다. 반대로 Op. 7-2·7-4 의 첫 판(B. 45·B. 7), Op. 71-3 자필본, Op. 72-2 의 강슈·에키에르 판, Op. 73 독주판, Op. 2·3 의 피아노 독주판은 위키백과가 따로 세지 않아 걸렀습니다.
7. **위작 의심 곡을 넣었습니다**(authenticity=doubtful): B. 4 마주레크, B. 9 플루트 변주곡(치호츠키와 공동일 수 있음), B. 17 콩트르당스, KK Anh. Ia/2–3, 2024년에 찾은 왈츠 A단조(쇼팽 작품인지 아직 논란). 위키백과가 spurious 로 적은 세 곡은 뺐습니다.
8. **쇼팽이 옮긴 곡**: 자기 가곡을 옮긴 안단티노(B. 117)와 성가를 옮긴 라르고(B. 109)는 넣었고(authenticity=chopin_arrangement), 남의 곡을 옮긴 카스타 디바·케루비니 푸가는 뺐습니다. 기준을 "쇼팽 이름으로 전집에 실리는가"로 잡았는데, 라르고는 위키백과가 "독립된 창작곡이 아니다"라고 적어 빼도 됩니다.
9. **함께 쓴 곡**: B. 70 협주풍 대이중주는 프랑숌과 함께 썼고, B. 113 은 리스트 <헥사메론> 의 한 변주입니다. B. 113 의 MBID(731e5306)는 리스트 S. 392 의 part work 라 MB 에서 리스트 작품 아래 있습니다.

번호·표기

10. **카탈로그 번호가 MB 와 위키백과에서 다릅니다**: 부레 B. 160a(MB) / 160b(위키백과), 카논 B. 129a(MB) / 129b(위키백과). catalogue 는 위키백과를 따랐습니다.
11. **묶음 안 순서**: Op. 33(2·3번)과 Op. 41(1번 자리), Op. 7-5/Op. 6 은 내셔널 에디션 순서가 다릅니다. MB parts 순서(= 위키백과가 따르는 통념 순서)를 썼습니다.
12. **연도**: 운영 manual 값과 위키백과 by opus 가 다른 곳이 있습니다(3절 표 비고). 이 목록은 위키백과 범위의 끝 해를 썼고, 기존 manual 값은 건드리지 않는 게 맞아 보입니다. Op. 22 는 "1830–31, 1834" 라 1834 로 두었습니다(운영 26036 은 1835).
13. **번호를 붙인 낱곡**: 왈츠 14~19번(B. 56·44·21·46·133·150)과 녹턴 21번(B. 108)은 MB 제목의 관례 번호입니다. 작품번호 없는 폴로네즈(B. 1·3·5·6·13·36)에는 번호를 붙이지 않았습니다(판본마다 11~16번 매김이 달라서). 운영 445 "녹턴 20번 C#단조 (유작)" 의 "(유작)" 꼴은 다른 유작에는 붙이지 않았습니다.
14. **우리말 이름을 이번에 옮긴 것**(출처 없음, 검수 필요): Op. 74 가곡 17곡 제목과 B. 51 "마법", B. 39 "어떤 꽃, 어떤 화관", B. 132 "둠카"; 변주곡 제목(Op. 2·12, B. 9·12a·14·37·70·113); "마주르카풍 론도"(Op. 5), "크라코비아크풍 론도"(Op. 14), "폴란드 민요에 의한 환상곡"(Op. 13), "연주회용 알레그로"(Op. 46), "앨범의 한 페이지"(B. 151), "갤럽"(KK IVb/13).
15. **별명 고르기**: 국내에서 널리 쓰는지까지는 확인하지 못했습니다. "이별의 곡"(Op. 10-3)은 MB 제목에 없고 운영 DB 447 제목과 국내 관례에서 가져왔습니다. "고양이 왈츠"(Op. 34-3)·"이별의 왈츠"(Op. 69-1)는 위키백과 by genre, "3도"·"6도"·"옥타브"(Op. 25-6·8·10)는 MB 제목의 기술적 별명입니다. 빼고 싶으면 `defs.py` 의 nickKo 만 지우면 됩니다.
