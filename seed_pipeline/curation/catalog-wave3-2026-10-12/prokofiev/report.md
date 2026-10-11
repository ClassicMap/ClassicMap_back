# 프로코피예프 작품 카탈로그 — 3차 보고

- 기준: 위키백과 영어판 "List of compositions by Sergei Prokofiev"(작품번호 표 166줄 + 갈래별 목록). 묶음 곡 목록은
  MusicBrainz parts 관계와 러시아어 위키백과 "Список произведений Сергея Прокофьева (по опусам)" 로 맞췄습니다.
- MusicBrainz: artist 0e43fe9d browse 15번(1,405 work). 낱개 조회 24건(애매한 seed 확인용, 녹음 2건 포함).
- 3차 생성기(wave3/gen/gen_catalog.py, `--seed-map` 포함) 시험 통과:
  `{"pieces": 35, "parts": 472, "children": 19, "linked": 5, "updated_parts": 0, "existing_pieces": 129, "retitled_seed": 131}`
- 파일: `catalog.json`, `seed_map.json`, `scripts/`(defs.py 손 정의 → build.py → validate.py·seedmap.py·wikicheck.py),
  `raw/`(MB browse, 위키 원문, align.txt·wikicheck.txt 대조 결과).

## 1. 개수

| 갈래 | 작품 | part | children |
|---|---:|---:|---:|
| 묶음 | 38 | 194 | 12 |
| 다악장 | 61 | 278 | 7 |
| 낱곡 | 65 | 0 | 0 |
| 합계 | 164 | 472 | 19 |

- 새 작품 35, 운영 작품에 이은 것 129(seed 124 + manual 5), part 로 이은 seed 5.
- authenticity: authentic 143, composer_arrangement 20(작곡가 자신의 편성 바꾸기·피아노 편곡: Op. 12bis, 29bis,
  33ter, 34bis, 35bis, 42bis, 43bis, 50bis, 52, 60bis, 65bis, 75, 78bis, 94bis, 95, 96, 97, 97bis, 102, 77bis),
  completed_by_other 1(첼로 소협주곡 Op. 132).
- 작품 MBID 없음 20(Op. 5, 7, 42bis, 61, 66, 69, 71, 77bis, 86, 88, 89bis, 113, 128, 이집트의 밤 부수음악, 영화 음악
  넵스키·레르몬토프·코토프스키·파르티잔·토냐, 가곡 <메기 이야기>). part MBID 없음 22(대부분 MBID 없는 작품의 part).
- catalogue 없음 10(작품번호 없는 곡: 영화 음악 6, 부수음악 <이집트의 밤>, 발레 <공중그네>, 둠카, 가곡 <메기 이야기>).

### seed 대응 (225개 전부)

| 대응 | 수 |
|---|---:|
| work | 124 |
| part | 5 |
| unmatched: arrangement | 53 |
| unmatched: hymn_translation | 11 |
| unmatched: excluded_scope | 11 |
| unmatched: duplicate | 8 |
| unmatched: popular | 7 |
| unmatched: unknown | 3 |
| unmatched: fragment | 1 |
| unmatched: excerpt_keep | 2 |

- 비교 구간 있는 seed 0개(전부 sectors=0). has_link=1 인 seed 70개 중 unmatched 는 25개(편곡 15, 중복 6, 대중음악 2, 범위 밖 1, 다른 언어 1).
- part 로 이은 5개: 11950 → Op. 7 [1] '백조', 11500 → Op. 66 [1] 'Op. 66a 2개의 대중가요', 12007 → Op. 69 [1],
  11952 → Op. 64ter [2] '소녀 줄리엣', 11973 → Op. 64bis [2] '장면'.
- excerpt_keep 2개: 11817 → `영화 음악 <이반 뇌제> 중 "오프리치니키의 춤"` / `Ivan the Terrible: Dance of the Oprichniki`,
  11398 → `발레 <신데렐라> 중 "가보트"` / `Cinderella: Gavotte`(녹음이 함부르크 필·메츠마허 관현악 연주라 원곡으로 봄).

## 2. 운영 기존 작품 대응

- manual 5개: 322 발레 <로미오와 줄리엣>(op064), 323 교향곡 1번(op025), 324 <피터와 늑대>(op067),
  325 피아노 협주곡 3번(op026), 326 피아노 소나타 7번(op083). 전부 MBID 같음. 제목은 그대로 둠.
- seed 124개 work + part 3개(11950·11500·12007)는 전부 MBID 같음. 11952·11973 은 독일어 발췌 음반 트랙이라
  제목·녹음 제목으로 맞춤(4절 5번).
- 전체 표(id → key, 근거): 아래 부록.

### 운영 중복 작품

| 남긴 쪽 | 중복 seed | 까닭 |
|---|---|---|
| 324 manual(MBID 812b5cc4) | 576 'Peter and the Wolf, op. 67'(MBID 없음) | 같은 작품 |
| 326 manual | 11317 'Piano Sonata no. 7…'(MBID 없음) | 같은 작품 |
| 325 manual | 11327 'Piano Concerto no. 3…'(MBID 없음, seed part 10) | 같은 작품 |
| 322 manual | 11336 'Romeo and Juliet, op. 64'(MBID 없음, seed part 54) | 같은 작품 |
| 11646 (MB 7048a029, op. 94a) | 11698 (MB 85294d15, op. 94bis) | 바이올린 소나타 2번, MB work 둘 |
| 11470 (Op. 97bis) | 11540 'Adagio, op. 97b' | 같은 아다지오 |
| 11852 (Op. 28) | 11870 'Piano Sonata no. 1 … op. 28: Allegro tempestoso…' | 단악장 소나타 3번의 다른 행 |
| 11660 (Op. 21a = 21bis) | 11932 'Op. 21b (excerpts)' | 같은 모음곡의 발췌 녹음 work |

### 그대로 남는 기존 part (리드 확인용)

- manual 322 에 manual part 54개(막 3 + 번호 51, 납작, name_ko NULL, editor_locked=1). 발레는 낱곡이라 손대지 않음.
- manual 325 에 manual part 10개(악장 3 + 2악장 변주 7, 납작, FACTS_VERIFIED). catalog 에서 2악장 아래 children 7개로
  같은 MBID 를 두어 3차 생성기가 이름·parent 를 고쳐 씀(existingPartId 는 적지 않음).
- manual 326 part 3개(38281–38283, FACTS_VERIFIED)도 같은 MBID 라 생성기가 고쳐 씀.
- 낱곡으로 둔 seed work 14개에 seed part 가 남음(합 273개): 11347 <어릿광대> 17, 11672 <세 개의 오렌지> 6,
  11475 <강철의 걸음> 11, 11667 <탕아> 10, 11882 <드네프르 강가에서> 12, 11343 10월 혁명 칸타타 10,
  11919 <우리 시대의 노래> 9, 11869 <알렉산드르 넵스키> 7, 11294 <신데렐라> 52, 11396 <전쟁과 평화> 59,
  11487 <참된 인간의 이야기> 3, 11474 <석화> 59, 11391 <겨울 모닥불> 8, 11984 <평화의 수호> 10.

### 큰 작품의 한 대목을 따로 둔 운영 작품

- manual 쪽은 없음. seed 쪽 대목(발레 번호·오페라 행진곡 등)은 전부 남의 편곡이라 unmatched arrangement.

## 3. 뺀 것과 까닭

- 작품번호 표에서 뺀 줄 10: 미완성 5(Op. 13 <마달레나>, Op. 37bis, Op. 133 무반주 첼로 소나타, Op. 134 피아노
  협주곡 6번, Op. 137 피아노 소나타 10번 단편), 실현 안 됨 3(Op. 129, 136, 138), 스케치 1(Op. 98 국가 응모 스케치,
  러 위키 'Эскизы'), 버린 발레 1(<알라와 롤리> → Op. 20).
- 갈래별 목록에서 뺀 작품번호 없는 항목 57:
  - 어린 시절 피아노 소품 36(인디언 갤럽, 행진곡·왈츠·론도·폴카, 네 손 소품, Pesenki(각 12곡 소품집) 1–5집,
    치지크 변주곡, 1907년 소품들, 1908년 시험 푸가·미완성 안단테 등)과 Op. 3·4 의 옛 판 2(1907–1908 '4개의 피아노 소품' 두 묶음).
  - 어린 시절 오페라 4(<거인>, <무인도에서>(미완성), <역병 속의 향연>(미완성), <운디네>), 미완성 오페라 2(<칸 부자이>,
    <먼 바다>), 버린 발레 1(<알라와 롤리>, 표 줄과 같음).
  - 어린 시절 교향곡 1항목(1902 G장조 1악장, 1908), 바이올린 3(1903 소나타·노래, 1907 소나타 1악장), 로망스 1(<퍼진 참나무>),
    가곡 스케치 4.
  - 남의 작품 편곡 2(슈베르트 왈츠, <셰에라자드> 환상곡), 민요 편곡 1(5개의 카자흐 노래).
- 러 위키에만 있는 작품번호 없는 곡 중 뺀 것: <체조를 위한 음악>(자료 없음), 자하로프에게 보낸 음악 편지(장난 편지),
  북스테후데 전주곡과 푸가 피아노 편곡(남의 작품).
- 같은 곡의 다른 판: 작품번호가 따로 붙은 개정·편성 판은 리드 지시대로 따로 둠(Op. 5/48 신포니에타, Op. 47/112
  교향곡 4번, Op. 38/135 피아노 소나타 5번, Op. 58/125 첼로 협주곡→교향적 협주곡, 그리고 bis·ter 번호 작품 24개).

## 4. 애매했던 판단

1. **어린 시절 작품 통째로 뺌**(3절). 카탈로그 번호 체계가 없고 대부분 자필로만 전함(fr 위키 목록도 같은 까닭으로 뺌).
   Pesenki 각 집 12곡 목록 출처도 없음. 관련 seed 9개(Pesenki 2–5집, Juvenilia, 타란텔라 D단조, 스케르초 D장조,
   알레그레토 A단조, 시험 푸가)는 excluded_scope. 넣기로 하면 Pesenki 5집을 묶음으로 더하되 곡 목록을 따로 구해야 함.
2. **오페라·발레·영화 음악·부수음악·칸타타·오라토리오는 part 없이 낱곡**(SPEC). 발레 <로미오와 줄리엣>·<신데렐라>의
   번호를 가리키는 seed 는 전부 남의 편곡(catch-all, Borisovsky, Heifetz 등)이라 발레에 part 를 만들 일이 없었음.
   낱곡 대목 seed 중 원곡 대목: <이반 뇌제> '오프리치니키의 춤'과 <신데렐라> '가보트'(관현악 녹음)는 excerpt_keep,
   <이반 뇌제> '만수무강'(37초 합창)은 excluded_scope(MB 에 순서 있는 part 목록이 없고 단독 연주 대목도 아님).
   <석화> 왈츠 seed 11657 은 녹음이 게링가스(첼로)·피아노라 편곡으로 봄(arrangement).
   '가보트'는 발레 1막 10번과 모음곡 2번 2곡에 같은 음악이 있어 어느 쪽 녹음인지까지는 못 가림.
3. **Op. 66 을 두 겹 묶음**으로: [1] Op. 66a '2개의 대중가요'(2곡, seed 11500), [2] Op. 66b '4개의 노래'(4곡).
   영어 위키는 'Six Songs' 하나, 러 위키·MB 는 a/b 로 나눔. seed 11500 이 66a 라서 두 겹으로 잇는 쪽을 고름.
4. **<푸시키니아나> 발췌**(11943 <예브게니 오네긴> 춤곡 3곡, 11966 <보리스 고두노프> '분수 장면과 폴로네즈')는
   로즈데스트벤스키가 엮은 모음곡의 발췌라 arrangement 로 둠. 원작 Op. 71·70bis 는 낱곡(Op. 71 은 MBID 없음).
5. **11952·11973 은 제목·녹음으로 모음곡 part 에 이음**: 'Julia'(녹음 'Julias Kindheit') → 모음곡 2번 2곡,
   'Szene: Im Haus der Capulets'(녹음 'II. Szene') → 모음곡 1번 2곡 '장면'(부제는 안 맞음). 같은 음반의
   11490 은 제목('몬터규가 남자들의 춤')과 녹음('백합을 든 소녀들의 춤')이 달라 unknown.
6. **첼로 소협주곡 Op. 132 는 넣음**(로스트로포비치·카발레프스키 완성판이 표준 연주판, completed_by_other, MB 는
   카발레프스키 판 4479d871). 무반주 첼로 소나타 Op. 133/134(블로크가 단악장으로 완성)는 뺌.
7. **작품번호 없는 영화 음악 5개 넣음**(<알렉산드르 넵스키>·<레르몬토프>·<코토프스키>·<토냐>·<우크라이나 초원의
   파르티잔>) — 영어·프랑스어·러시아어 위키 모두 작품으로 올림. MB work 없음. <키제 중위> 영화 음악은 seed 11367
   (MB f68995c7, Soundtrack)에 이음. 부수음악 <이집트의 밤>도 넣음(모음곡 Op. 61 과 따로).
8. **Op. 61 <이집트의 밤> 모음곡 곡 순서**: MB 없음, 러 위키 순서(… 6 클레오파트라의 최후, 7 Roma militaris)를 따름.
   음반에 따라 6·7 이 바뀐 목록이 있어 확인이 필요함.
9. **Op. 89 '7개의 노래와 행진곡'**: 러 위키 8곡 목록을 따름(MB 는 2–6번만). **Op. 106** 은 MB 순서(1 Every Man
   Marries, 2 The Road to Moscow)와 러 위키 순서가 반대라 러 위키를 따르고 MBID 를 바꿔 붙임.
10. **Op. 104** MB parts 에 'Снежки белые, op. 104 no. 5' 가 2·4번 자리에 겹쳐 있어 순서를 손으로 줌(4번 Snezhki belye).
11. **연도**: 개정판을 넣은 작품은 마지막 판 해(Op. 8 1934, Op. 24 1928, Op. 30 1933, Op. 91 1952, Op. 16 1923).
    yearText 에 처음 해와 개정 해. 둠카·<메기 이야기>는 연도 모름(year null).
12. 피아노 협주곡 1번 Op. 10 은 한 악장 안의 세 부분이지만 MB·관례대로 3 part(다악장)로 둠. 반대로 피아노 소나타
    1번 Op. 1·3번 Op. 28 은 단악장 소나타라 낱곡. 교향적 노래 Op. 57(쉼 없이 세 부분)도 MB 대로 낱곡.
13. 칸타타·오라토리오·어린이 모음곡(Op. 30, 74, 76, 78, 85, 93, 114, 122, 124)은 SPEC 대로 part 없는 낱곡.
    seed 쪽에 MB 악장 part 가 이미 붙은 것(Op. 74·76·78·122·124)은 2절 '그대로 남는 기존 part' 참고.

## 5. 직접 옮긴 우리말 이름(검수용)

- 무대·영화: 발레 <어릿광대>(Chout), <강철의 걸음>, <탕아>, <드네프르 강가에서>, <석화>, <공중그네>; 오페라 <도박사>,
  <세 개의 오렌지에 대한 사랑>, <불의 천사>, <세묜 코트코>, <수도원에서의 약혼>, <참된 인간의 이야기>; 영화 음악
  <키제 중위>, <스페이드의 여왕>, <알렉산드르 넵스키>, <이반 뇌제>, <레르몬토프>, <코토프스키>, <토냐>,
  <우크라이나 초원의 파르티잔>; 부수음악 <이집트의 밤>, <보리스 고두노프>, <예브게니 오네긴>, <햄릿>.
- 관현악·성악: 교향적 그림 <꿈>, 교향적 스케치 <가을>, 스키타이 모음곡 <알라와 롤리>, 교향 모음곡(<세 개의 오렌지에
  대한 사랑>, <키제 중위>, <이집트의 밤>, <세묜 코트코>, <1941년>, <여름밤>), 발레 모음곡(<어릿광대>, <강철의 걸음>,
  <탕아>, <드네프르 강가에서>, <로미오와 줄리엣> 1–3번, <신데렐라> 1–3번), <도박사>의 4개의 초상과 대단원,
  어린이 모음곡 <여름날>, 왈츠 모음곡, 푸시킨 왈츠, 교향적 노래, 교향적 행진곡, 축전 시 <30년>, 축전 시 <볼가 강과
  돈 강의 만남>, 전쟁 종결 송가, 러시아 서곡, 미국 서곡, 유대 주제에 의한 서곡, <석화>에서 결혼 모음곡·집시 환상곡·우랄
  랩소디, 칸타타 <그들은 일곱>·<우리 시대의 노래>·<축배>(Zdravitsa)·<이름 없는 소년의 발라드>·<번영하라, 강대한
  땅이여>, 10월 혁명 20주년 칸타타, 오라토리오 <평화의 수호>, 모음곡 <겨울 모닥불>, 음악 동화 <피터와 늑대>(운영 그대로),
  여성 합창과 관현악을 위한 2개의 시, 취주악을 위한 4개의 행진곡, 병사의 행진가.
- 피아노·실내: 피아노 소품집 <풍자>·<덧없는 환영>·<할머니의 옛이야기>·<물자체>·<사색>·<어린이를 위한 음악>,
  토카타, 둠카, 첼로 소협주곡, 교향적 협주곡, 4대의 바순을 위한 유머러스한 스케르초, <신데렐라>·<로미오와 줄리엣>
  피아노 편곡 묶음 제목.
- 가곡: 가곡 <미운 오리 새끼>, 가곡 <메기 이야기>(Про сома), 아흐마토바·발몬트·푸시킨의 시에 의한 가곡집,
  <키제 중위>·<알렉산드르 넵스키>에서 노래, 3개의 어린이 노래, 12개의 러시아 민요, 2개의 2중창, 2개의 대중가요.
  노래 part 이름은 러시아어 음역(nameKo) + 영어 뜻(nameEn), 우리말로 옮기지 않음.
- part 이름(우리말로 옮긴 것):
  - Op. 3 옛이야기·농담·행진곡·유령 / Op. 4 회상·충동·절망·악마적 암시 / Op. 12 행진곡·가보트·리고동·마주르카·
    카프리치오·전설·전주곡·알망드·유머러스한 스케르초·스케르초 / Op. 32 춤·미뉴에트·가보트·왈츠 / Op. 59 산책·풍경·
    전원 소나티나 / Op. 65 아침·산책·옛이야기·타란텔라·후회·왈츠·메뚜기의 행진·비와 무지개·술래잡기·행진곡·저녁·달이
    초원 위를 거닐다 / Op. 65bis 같은 이름 7곡 / Op. 52 인테르메초·론도·연습곡·스케르치노·안단테·스케르초 /
    Op. 43bis 디베르티스망·녹턴·춤·에필로그 / Op. 33ter 행진곡·스케르초.
  - Op. 20 벨레스와 알라 숭배·적의 신과 악령의 춤·밤·롤리의 출정과 태양의 행렬 / Op. 21bis 어릿광대와 아내 외 12곡 /
    Op. 33bis 괴짜들·지옥 장면·행진곡·스케르초·왕자와 공주·도주 / Op. 41bis 등장인물의 입장·인민위원, 연설가와 시민·
    수병과 여공·공장 / Op. 49 알렉세이·할머니·장군·폴리나·대단원 / Op. 51bis 전주곡·첫 남성 무용수의 변주·약혼·
    다툼·장면·에필로그 / Op. 60 키제의 탄생·로망스·키제의 결혼·트로이카·키제의 장례 / Op. 61 이집트의 밤·카이사르,
    스핑크스와 클레오파트라·경보·춤·안토니우스·클레오파트라의 최후·Roma militaris / Op. 64bis·64ter·101·75
    (민속 춤, 장면(거리가 깨어나다), 마드리갈, 미뉴에트(손님들의 도착), 가면, 로미오와 줄리엣, 티볼트의 죽음,
    몬터규가와 캐퓰릿가, 소녀 줄리엣, 로런스 신부, 춤, 이별 앞의 로미오와 줄리엣, 백합을 든 소녀들의 춤, 줄리엣의
    무덤 앞의 로미오, 분수 곁의 로미오, 아침 춤, 줄리엣, 유모, 아침 세레나데, 줄리엣의 죽음, 머큐쇼) /
    Op. 81bis 서주·세묜과 어머니·약혼·남쪽의 밤·처형·불타는 마을·장례·우리 편이 왔다 / Op. 90 전투에서·밤에·인류의
    형제애를 위하여 / Op. 95·97·102·107·108·109(신데렐라: 인테르메초, 가보트, 느린 왈츠, 봄·여름·가을·겨울의 요정,
    메뚜기와 잠자리, 오리엔탈리아, 파스피에, 카프리치오, 부레, 아다지오(왕자와 신데렐라), 왈츠(신데렐라와 왕자),
    신데렐라의 변주, 다툼, 왈츠(무도회로 떠나는 신데렐라), 숄 춤, 아모로소, 서주, 요정 할머니와 겨울 요정, 마주르카,
    무도회로 떠나는 신데렐라, 신데렐라의 왈츠, 자정, 신데렐라의 꿈, 춤 수업과 가보트, 봄의 요정과 여름의 요정,
    무도회에 온 신데렐라, 큰 왈츠, 갤럽, 파반, 신데렐라와 왕자, 세 개의 오렌지, 남쪽 나라, 신데렐라를 찾은 왕자) /
    Op. 96 왈츠·콩트르당스·메피스토 왈츠 / Op. 110 처음 만난 그때부터·궁전에서·메피스토 왈츠·동화의 끝·새해 무도회·
    행복 / Op. 120 왈츠 F장조·왈츠 C#단조 / Op. 123 서주·세레나데·미뉴에트·꿈(녹턴)·춤 / Op. 126 사랑의 춤·신부
    친구들의 춤·처녀들의 춤·의식의 춤·결혼 원무 / Op. 127 서주·집시 춤·세베리얀의 춤·집시 여인의 춤·군무 /
    Op. 69 스파르타키아드 행진곡·서정적 행진곡·행군 행진곡·기병 행진곡 / Op. 89 8번 행진곡.

## 6. 위키백과 대조 (`raw/wikicheck.txt`)

- 작품번호 표 166줄: 대응 156, 뺌 10(3절), 대응 없음 0. 표 줄 '–'(작품번호 없음) 5개도 포함.
- 갈래별 목록의 작품번호 없는 항목 64개: 넣음 7(<공중그네>, 영화 음악 4, 둠카, <메기 이야기>), 뺌 57(3절).
- catalog 에만 있는 작품 2: Op. 78bis·Op. 97bis(작품번호 표에는 없고 갈래별 목록에 있음).
- 제목의 곡 수(Two/Three/…/Twenty)와 part 수: 전부 맞음(Op. 66 은 children 6, Op. 89 는 노래 7 + 행진곡 1).
- 연도: 표의 끝 해와 다른 곳 0(위 11번 규칙대로 개정 해를 쓴 곳은 표도 개정 해를 적음).
- MB 와 달라 위키(러)를 따른 곳: Op. 106 순서, Op. 89 곡 목록(MB 5곡만), Op. 104 4번 자리, Op. 60bis·78bis
  (MB 1곡만), Op. 7(MB 묶음 work 없음, 1곡만).
- 제목 겹침 0(운영 포함), 번호 시작 nameKo 0, 빈 nameKo 0, MBID 겹침 0, 다른 작품이 쓰는 MBID 0.
- seed_map 225 = 운영 seed 225, work/part id 와 catalog existingPieceId 일치(seedmap.py 가 catalog 에서 거꾸로 만들고,
  3차 생성기 `--seed-map` 검사도 통과).

## 부록: 운영 작품 대응표

| id | origin | 운영 제목 | key | 근거 |
|---:|---|---|---|---|
| 322 | manual | 발레 <로미오와 줄리엣> | op064 | MBID 같음(91ceabb1) |
| 323 | manual | 교향곡 1번 D장조 "고전 교향곡" | op025 | MBID 같음(5983b48e) |
| 324 | manual | 음악 동화 <피터와 늑대> | op067 | MBID 같음(812b5cc4) |
| 325 | manual | 피아노 협주곡 3번 C장조 | op026 | MBID 같음(7598a5f7) |
| 326 | manual | 피아노 소나타 7번 B♭장조 "전쟁 소나타" | op083 | MBID 같음(45d6ee5d) |
| 11291 | seed | Le Fils prodigue: Suite symphonique tirée du ballet, Op. 46bis | op046bis | MBID 같음(03ca9654) |
| 11294 | seed | Cinderella, op. 87 | op087 | MBID 같음(0ec132df) |
| 11297 | seed | Шесть пьес из балета «Золушка» для Фортепиано, соч. 102 | op102 | MBID 같음(1d61b5ec) |
| 11302 | seed | String Quartet no. 2 in F major, op. 92, on Kabardian themes | op092 | MBID 같음(24164a65) |
| 11303 | seed | Autumnal Sketch, op. 8 | op008 | MBID 같음(270306e1) |
| 11304 | seed | Five Poems of Konstantin Balmont, op. 36 | op036 | MBID 같음(3500c682) |
| 11308 | seed | Расцветай, могучий край, op. 114 | op114 | MBID 같음(3849a254) |
| 11312 | seed | The Queen of Spades, op. 70 | op070 | MBID 같음(3d22f822) |
| 11316 | seed | Скифская сюита, соч. 20 | op020 | MBID 같음(440a162c) |
| 11320 | seed | Symphony no. 5 in B-flat major, op. 100 | op100 | MBID 같음(4c31264a) |
| 11323 | seed | Piano Sonata no. 4 in C minor, Op. 29 | op029 | MBID 같음(599739eb) |
| 11325 | seed | Boris Godunov, op. 70bis | op070bis | MBID 같음(63defac0) |
| 11328 | seed | Сказки старой бабушки, соч. 31 | op031 | MBID 같음(7795f9a3) |
| 11329 | seed | Здравица, op. 85 | op085 | MBID 같음(7850705f) |
| 11330 | seed | Hamlet, op. 77 | op077 | MBID 같음(7bef1ba1) |
| 11331 | seed | 4 Pieces for Piano, op. 32 | op032 | MBID 같음(7e055489) |
| 11333 | seed | Five Poems of Anna Akhmatova, op. 27 | op027 | MBID 같음(8891a3c3) |
| 11335 | seed | Sonata for Violin and Piano no. 1 in F minor, op. 80 | op080 | MBID 같음(8ebb47bc) |
| 11337 | seed | Violin Concerto no. 1 in D major, op. 19 | op019 | MBID 같음(931b4200) |
| 11338 | seed | Cinq Mélodies, op. 35 | op035 | MBID 같음(96c0225f) |
| 11340 | seed | Etudes for piano, op. 2 | op002 | MBID 같음(9c6ded1f) |
| 11343 | seed | Кантата к двадцатилетию Октября, соч. 74 | op074 | MBID 같음(abb2116f) |
| 11346 | seed | Piano Concerto no. 1 in D-flat major, op. 10 | op010 | MBID 같음(b18bb93c) |
| 11347 | seed | Chout, op. 21 | op021 | MBID 같음(c4e44d6f) |
| 11349 | seed | Three Romances, op. 73 | op073 | MBID 같음(c72c2efb) |
| 11351 | seed | Sonate pour deux violons, op. 56 | op056 | MBID 같음(d074428f) |
| 11353 | seed | Four Pieces, op. 4 | op004 | MBID 같음(d420709e) |
| 11359 | seed | Десять пьес из балета «Золушка» для Фортепиано, соч. 97 | op097 | MBID 같음(e0f3763b) |
| 11361 | seed | Symphony-Concerto for Cello and Orchestra in E minor, op. 125 | op125 | MBID 같음(e28e0c50) |
| 11363 | seed | Piano Sonata no. 6 in A major, op. 82 | op082 | MBID 같음(e70d0050) |
| 11367 | seed | Поручик Киже | film-kije | MBID 같음(f68995c7) |
| 11391 | seed | Winter Bonfire, op. 122 | op122 | MBID 같음(0090a0d0) |
| 11395 | seed | Symphony no. 6 in E-flat minor, op. 111 | op111 | MBID 같음(0293e20b) |
| 11396 | seed | War and Peace, op. 91 | op091 | MBID 같음(03b4640c) |
| 11402 | seed | Pensées, op. 62 | op062 | MBID 같음(07b4750d) |
| 11405 | seed | 12 Russian Folksongs, op. 104 | op104 | MBID 같음(08ccdfb3) |
| 11422 | seed | Огненный ангел, op. 37 | op037 | MBID 같음(0f8e4907) |
| 11429 | seed | 10 Pieces from Romeo and Juliet, op. 75 | op075 | MBID 같음(111ef4a5) |
| 11430 | seed | Waltz Suite, op. 110 | op110 | MBID 같음(1369b15a) |
| 11432 | seed | Violin Concerto no. 2 in G minor, op. 63 | op063 | MBID 같음(13d340ea) |
| 11437 | seed | Overture on Hebrew Themes, op. 34 | op034 | MBID 같음(146e01cf) |
| 11448 | seed | Quintet in G minor, op. 39 | op039 | MBID 같음(17c9f61b) |
| 11461 | seed | Three Pieces from Cinderella, op. 95 | op095 | MBID 같음(1e8a9a91) |
| 11470 | seed | Adagio "Cinderella and the Prince", op. 97bis | op097bis | MBID 같음(21a17bb5) |
| 11474 | seed | The Tale of the Stone Flower, op. 118 | op118 | MBID 같음(22bb3a02) |
| 11475 | seed | Le Pas d'acier | op041 | MBID 같음(2314acc5) |
| 11482 | seed | They Are Seven, Cantata op. 30 | op030 | MBID 같음(254bde4a) |
| 11487 | seed | The Story of a Real Man, op. 117 | op117 | MBID 같음(28532dc7) |
| 11495 | seed | Piano Sonata no. 5, op. 38 | op038 | MBID 같음(2af25560) |
| 11496 | seed | Ballade in C minor, for cello and piano, op. 15 | op015 | MBID 같음(2b087bb6) |
| 11499 | seed | Cello Concerto in E minor, op. 58 | op058 | MBID 같음(2d38d3aa) |
| 11500 | seed | 2 Choruses, op. 66a | op066 [1] | MBID 같음(2d448635) |
| 11501 | seed | Sonata for Cello and Piano in C major, op. 119 | op119 | MBID 같음(2e07dba6) |
| 11506 | seed | Overture in B-flat major, for 17 instruments (or orchestra) ("American | op042 | MBID 같음(2f9aabb0) |
| 11508 | seed | Ballade for the Boy Who Remained Unknown, Op. 93 | op093 | MBID 같음(3012c5be) |
| 11510 | seed | 2 Songs from Lieutenant Kijé, Op. 60bis | op060bis | MBID 같음(306a677c) |
| 11517 | seed | The Year 1941, op. 90 | op090 | MBID 같음(3324c6ee) |
| 11539 | seed | Summer Night Suite from "The Duenna", op. 123 | op123 | MBID 같음(40f961c6) |
| 11543 | seed | Symphony no. 4 in C major, op. 112 | op112 | MBID 같음(43788a31) |
| 11555 | seed | Piano Concerto no. 4 in B-flat major, op. 53 | op053 | MBID 같음(491c53ed) |
| 11565 | seed | Symphony no. 4 in C major, op. 47 | op047 | MBID 같음(4ea991a9) |
| 11566 | seed | Symphony no. 2 in D minor, op. 40 | op040 | MBID 같음(4f0ad7d0) |
| 11569 | seed | Игрок, op. 24 | op024 | MBID 같음(50a01eeb) |
| 11575 | seed | Music for Children, op. 65 | op065 | MBID 같음(5362528e) |
| 11579 | seed | Piano Sonata no. 8 in B-flat major, op. 84 | op084 | MBID 같음(57513a93) |
| 11590 | seed | Four Pieces, op. 3 | op003 | MBID 같음(5c84c2e8) |
| 11593 | seed | Sarcasms, op. 17 | op017 | MBID 같음(5d5753e0) |
| 11595 | seed | Dreams, op. 6 | op006 | MBID 같음(5ea80758) |
| 11614 | seed | Trapèze | ballet-trapeze | MBID 같음(6513edba) |
| 11619 | seed | Piano Concerto no. 5 in G major, op. 55 | op055 | MBID 같음(66dadd60) |
| 11632 | seed | Sonata for Solo Violin in D major, op. 115 | op115 | MBID 같음(6a790a0f) |
| 11640 | seed | Things in Themselves, op. 45 | op045 | MBID 같음(6d107a4b) |
| 11646 | seed | Sonata for Violin and Piano no. 2 in D major, op. 94a | op094bis | MBID 같음(7048a029) |
| 11647 | seed | Soldiers’ Marching Song, op. 121 | op121 | MBID 같음(70bdb407) |
| 11648 | seed | Andante from Piano Sonata no. 4, op. 29bis | op029bis | MBID 같음(712fa58d) |
| 11653 | seed | Cinderella Suite no. 2, op. 108 | op108 | MBID 같음(7281bf17) |
| 11654 | seed | March and Scherzo from The Love for Three Oranges, op. 33ter | op033ter | MBID 같음(72b5fbfe) |
| 11660 | seed | Chout (The Buffoon) Suite, op. 21a | op021bis | MBID 같음(74c32a9f) |
| 11667 | seed | The Prodigal Son, op. 46 | op046 | MBID 같음(7872b88d) |
| 11669 | seed | Gypsy Fantasy, op. 127 | op127 | MBID 같음(791ff805) |
| 11672 | seed | L'Amour des trois oranges, op. 33 | op033 | MBID 같음(7b49e538) |
| 11674 | seed | Piano Sonata no. 2 in D minor, op. 14 | op014 | MBID 같음(7c2b2fbe) |
| 11692 | seed | Symphony no. 7 in C-sharp minor, op. 131 | op131 | MBID 같음(823c1986) |
| 11693 | seed | Piano Sonata no. 9, op. 103 | op103 | MBID 같음(82cd7fc6) |
| 11711 | seed | 5 Poems, op. 23 | op023 | MBID 같음(8ab86281) |
| 11720 | seed | A Summer Day, op. 65b | op065bis | MBID 같음(8f95adf7) |
| 11733 | seed | Cinderella Suite no. 1, op. 107 | op107 | MBID 같음(93d2a361) |
| 11742 | seed | Three Pieces for piano, op. 59 | op059 | MBID 같음(961c6f4c) |
| 11745 | seed | Pushkin Waltzes, op. 120 | op120 | MBID 같음(97153f16) |
| 11752 | seed | Andante, op. 50bis | op050bis | MBID 같음(98620fee) |
| 11763 | seed | Semyon Kotko, symphonic suite, op. 81bis | op081bis | MBID 같음(9b59a764) |
| 11767 | seed | String Quartet no. 1 in B minor, op. 50 | op050 | MBID 같음(9e02aca2) |
| 11772 | seed | Russian Overture, op. 72 | op072 | MBID 같음(9fd09d79) |
| 11775 | seed | Ten Small Pieces, op. 12 | op012 | MBID 같음(a146eddc) |
| 11776 | seed | 3 Pieces for Piano, op. 96 | op096 | MBID 같음(a17f6db3) |
| 11784 | seed | Scherzo humoristique, op. 12bis | op012bis | MBID 같음(a47c57f5) |
| 11805 | seed | 3 детские песни, op. 68 | op068 | MBID 같음(ab6b5360) |
| 11810 | seed | Symphonic Song, op. 57 | op057 | MBID 같음(ae12b285) |
| 11818 | seed | Sonata for Flute and Piano in D major, op. 94 | op094 | MBID 같음(b0571a57) |
| 11819 | seed | 3 Songs from Alexander Nevsky, Op. 78bis | op078bis | MBID 같음(b066a40a) |
| 11822 | seed | Dumka | dumka | MBID 같음(b1c4ac55) |
| 11825 | seed | 2 Duets, op. 106 | op106 | MBID 같음(b2f65b0e) |
| 11826 | seed | The Steel Step Suite, op. 41bis | op041bis | MBID 같음(b3018be2) |
| 11836 | seed | Sinfonietta, op. 48 | op048 | MBID 같음(b667e30f) |
| 11844 | seed | Sonatinas for piano, op. 54 | op054 | MBID 같음(b8fc915b) |
| 11852 | seed | Piano Sonata no. 3 in A minor, op. 28 | op028 | MBID 같음(bb6a6a90) |
| 11862 | seed | Divertimento, op. 43 | op043 | MBID 같음(be6815f1) |
| 11863 | seed | "The Gambler", four portraits, op. 49 | op049 | MBID 같음(bea1416a) |
| 11868 | seed | Piano Sonata no. 1, op. 1 | op001 | MBID 같음(bf8cbe23) |
| 11869 | seed | Alexander Nevsky, op. 78 | op078 | MBID 같음(bfa47ae2) |
| 11879 | seed | Six Pieces, op. 52 | op052 | MBID 같음(c5b03742) |
| 11882 | seed | On the Dnieper, op. 51 | op051 | MBID 같음(c870f7b4) |
| 11883 | seed | Two Poems, op. 9 | op009 | MBID 같음(c873fb15) |
| 11886 | seed | 7 Songs, op. 79 | op079 | MBID 같음(c941f2c6) |
| 11894 | seed | Suite from "Love for Three Oranges", op. 33A | op033bis | MBID 같음(cc2d3f24) |
| 11898 | seed | Symphony no. 3 in C minor, op. 44 | op044 | MBID 같음(ced0d6b7) |
| 11918 | seed | Five Melodies for Violin and Piano, op. 35bis | op035bis | MBID 같음(d57aa142) |
| 11919 | seed | Songs of Our Days, op. 76 | op076 | MBID 같음(d5ac7215) |
| 11949 | seed | Wedding Suite, op. 126 | op126 | MBID 같음(e3506d28) |
| 11950 | seed | Two Poems for Female Chorus and Orchestra, op. 7: 1. White Swan | op007 [1] | MBID 같음(e38fea6b) |
| 11952 | seed | Romeo und Julia: Auszüge aus der Orchestersuite Nr. 1, op. 64 A und Nr | op064ter [2] | 제목·녹음 제목(MBID 는 발췌 음반 work) |
| 11959 | seed | Ode to the End of the War, op. 105 | op105 | MBID 같음(e92039d2) |
| 11973 | seed | Romeo und Julia: Auszüge aus der Orchestersuite Nr. 1, op. 64 A und Nr | op064bis [2] | 제목·녹음 제목(MBID 는 발췌 음반 work) |
| 11977 | seed | Divertissement, op. 43bis | op043bis | MBID 같음(efc6ce7e) |
| 11982 | seed | Lieutenant Kijé Suite, op. 60 | op060 | MBID 같음(f168363e) |
| 11984 | seed | On Guard for Peace, op. 124 | op124 | MBID 같음(f250f64f) |
| 12003 | seed | Cinderella Suite no. 3, op. 109 | op109 | MBID 같음(fce44c02) |
| 12004 | seed | The Meeting of the Volga and the Don, op. 130 | op130 | MBID 같음(fcf1f4a5) |
| 12007 | seed | Athletic Festival March, op. 69, no. 1 | op069 [1] | MBID 같음(fe89110a) |
