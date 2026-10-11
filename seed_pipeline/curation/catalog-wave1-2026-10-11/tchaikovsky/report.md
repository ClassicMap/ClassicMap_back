# 차이콥스키 작품 카탈로그 — 1차 확장 보고

데이터 파일만 만들었습니다. 결과는 `catalog.json`, 원자료는 `raw/`, 스크립트는 `scripts/`(defs.py 손 정의 → build.py → wikicheck.py → report.py)입니다.

- MB: 차이콥스키 artist(9ddd7abc…)의 work 1,728개를 browse(`inc=aliases+work-rels`, 100개씩 18번)로 받았습니다(`raw/browse_works.json`). 낱개 조회는 하지 않았습니다.
- 위키백과: 영어 「List of compositions by Pyotr Ilyich Tchaikovsky」(`raw/wiki_list.txt`)가 기준입니다. 이 문서는 작품번호 없는 곡을 일부만 싣고 있어, TH 번호·키릴 원제·연도는 러시아어 위키 「Список произведений Петра Чайковского」의 TH 표(`raw/ru_list.txt` → `raw/ru_th.json`)로 채웠습니다.
- 리드 생성기 `gen/gen_catalog.py` 로 돌려 봤습니다(파이썬 3.13): 오류 없음, `{"pieces": 129, "parts": 308, "children": 6, "existing_pieces": 9}` (`raw/gen_check.sql`).

## 1. 개수

| 갈래 | 작품 | part |
|---|---:|---:|
| 묶음(collection) | 30 | 214 |
| 다악장(multi_movement) | 25 | 94 |
| 낱곡(single) | 83 | 0 |
| 합계 | 138 | 308 (+ children 6) |

- 작품번호 작품 82개(Op. 1–80 에서 Op. 14 를 빼고, 37a·67b·71a 를 더함), 작품번호 없는 TH 작품 56개.
- children 6곡은 Op. 71a <호두까기 인형> 모음곡 II 성격적 춤곡의 a–f 입니다.
- authenticity: authentic 134, completed_by_other 1, self_arrangement 3
- genre: piano 24, song 19, choral 11, opera 9, chamber 8, symphony 7, overture 7, concerto 6, concertante 6, orchestral 6, suite 5, string_quartet 4, incidental_music 4, symphonic_poem 4, sacred_choral 4, cantata 4, ballet 3, piano_sonata 2, vocal_ensemble 2, serenade 1, piano_trio 1, string_sextet 1
- MB work 없는 작품(`mbid: null`): TH 16, TH 22, TH 38, TH 66, TH 67, TH 68, TH 71, TH 73, TH 119. part 는 308개 모두 MB part 와 짝지었습니다.

## 2. 운영 기존 작품 대응

| id | 운영 제목 | → key | 근거 | 운영 MBID | 이 목록 mbid |
|---:|---|---|---|---|---|
| 162 | 발레 <백조의 호수> | tchaikovsky-op20 | MBID | 11f48c5e… | 11f48c5e… |
| 159 | 피아노 협주곡 1번 B♭단조 | tchaikovsky-op23 | MBID(옛 판 work) + 카탈로그 Op. 23 | ba27a04b… | 03c670e9… |
| 160 | 바이올린 협주곡 D장조 | tchaikovsky-op35 | MBID | f7136e19… | f7136e19… |
| 26034 | 피아노 모음곡 <사계> | tchaikovsky-op37a | MBID | 76cd571a… | 76cd571a… |
| 454 | 현을 위한 세레나데 C장조 | tchaikovsky-op48 | MBID | ec6691e5… | ec6691e5… |
| 163 | 1812년 서곡 | tchaikovsky-op49 | MBID | 36dfecf2… | 36dfecf2… |
| 453 | 교향곡 5번 E단조 | tchaikovsky-op64 | MBID | 9e906d77… | 9e906d77… |
| 161 | 발레 <호두까기 인형> | tchaikovsky-op71 | MBID | f3281e81… | f3281e81… |
| 158 | 교향곡 6번 B단조 "비창" | tchaikovsky-op74 | MBID | 15e0a721… | 15e0a721… |

- 운영 차이콥스키 작품 9개 모두 대응됩니다. 운영 중복 작품은 없습니다. 이미 있는 piece_parts 도 없습니다.
- 운영 9개 가운데 묶음 안의 곡으로 들어가는 낱곡은 없습니다. 7개는 이 목록에서 part 를 새로 받습니다(교향곡 5·6번, 협주곡 1번·바이올린 협주곡, 현을 위한 세레나데는 악장, <사계>는 12곡). 발레 2편과 1812년 서곡은 낱곡이라 part 가 없습니다.

## 3. 뺀 것과 까닭

| 분류 | 항목 수 |
|---|---:|
| 옛 판 | 6 |
| 소실 | 8 |
| 미완성·복원 | 6 |
| 편곡(남의 작품) | 5 |
| 민요 편곡 | 3 |
| 자기 작품 편곡(따로 번호 없음·같은 TH) | 1 |
| 자기 작품 편곡 | 2 |
| 확인 못 함 | 5 |
| 작곡가 것이 아닌 모음곡 | 1 |

**옛 판**

- Op. 14 / TH 4 오페라 <대장장이 바쿨라> — <체레비치키>(TH 8, 1885)로 고쳐 쓴 첫 판. 마지막 판만 넣음
- TH 142 나탈리아 왈츠 — 6개의 소품 Op. 51 의 4번 「나타 왈츠」의 첫 판
- Op. 23 피아노 협주곡 1번 1874/75·1879 판 — MB work ba27a04b…(운영 159 가 씀)·71b01883…. 이 목록은 1888년 판 하나로 셈
- Op. 13 / Op. 17 교향곡 1번 1868 원판·2번 1872 원판 — MB work d394090e…·c493e30c…. 개정판만 넣음
- TH 42 <로미오와 줄리엣> 1869·1870 판 — MB work b7a71b0f…·9c4253d0…. 1880년 판만 넣음
- Op. 33 로코코 변주곡 작곡가 원판 — MB work e244de19…. 늘 연주되는 피첸하겐 판만 넣음

**소실**

- TH 2 오페라 <운디네> — 작곡가가 없앰. 몇 곡만 다른 작품으로 옮겨져 남음
- TH 15 <보리스 고두노프> 부수음악 — 악보 전하지 않음
- TH 17 보드빌 <뒤죽박죽> 쿠플레 — 악보 전하지 않음(MB 도 lost 로 적음)
- TH 20 <요정> 노래와 왈츠 — 악보 전하지 않음
- TH 21 <몬테네그로> 활인화 음악 — 악보 전하지 않음
- TH 92 가곡 「밤의 행진」 — 러시아어 위키가 소실로 적음
- TH 137 장송 행진곡(<오프리치니크> 주제) — 러시아어 위키가 소실로 적음
- TH 166 <콜로세움의 로마인들> — 음악원 과제. 악보 전하지 않음

**미완성·복원**

- TH 238 교향곡 E♭장조("7번") — 작곡가가 버린 스케치를 보가티료프가 복원(MB 65151a93…)
- — 교향곡 「인생」 — 스케치만 남음
- TH 149 모멘토 리리코 A♭장조 — 타네예프가 완성(MB 01af6de3…, 34a6bc4b… 두 work 가 TH 149·TH 242 로 갈림)
- TH 203 알레그로 F단조(피아노 소나타 1악장) — 미완성. MB 에 남이 완성한 판 두 가지
- — 첼로 협주곡 — 6번 교향곡 초고 뒷면의 60마디 단편을 바탕으로 남이 지은 것
- TH 247 플루트와 현악을 위한 콘체르트슈튀크 — 영어 위키 목록에 있으나 단편 복원으로 봄

**편곡(남의 작품)**

- TH 88 4중창 「밤」 — 모차르트 환상곡 K. 475 편곡
- TH 168–171 베토벤 「크로이처」·슈만 「교향적 연습곡」·궁글·뒤뷔크 편곡 — 음악원 관현악 편곡 과제
- TH 172·174·177·180·181 타르노프스카야·다르고미시스키·루빈시테인·베버 곡 편곡 — 남의 작품 편곡
- TH 194·197 「바람이 가지를 흔드는 게 아니네」·「스트렐로체크」 — 남의 노래 편곡
- — 영어 위키 「다른 작곡가 작품 편곡」 표 전부 — 보르트냔스키 교회음악 편집, 글린카·르보프 합창 편곡 등

**민요 편곡**

- TH 176 50개의 러시아 민요(피아노 연탄) — 민요 편곡
- TH 120 「강가에서, 다리 곁에서」 — 민요 선율에 의한 피아노 곡
- TH 79 성 키릴로스와 메토디오스 찬가 — 옛 체코 성가 선율을 합창으로 옮긴 것

**자기 작품 편곡(따로 번호 없음·같은 TH)**

- — 관현악곡의 피아노 연탄·2대 피아노 판, TH 1 「막간곡과 시녀들의 춤」 피아노 판, Op. 16 피아노 독주판 — 원곡과 같은 TH 번호의 다른 판

**자기 작품 편곡**

- TH 114·115 바이올린과 피아노를 위한 안단테 푸네브레·유머레스크 — Op. 30 3악장·Op. 10-2 를 작곡가가 옮긴 것. 러시아어 위키 TH 표에 없고 연도·출판을 확인 못 함(MB e08fabca…·4f14063c…)
- TH 128 <보예보다> 주제에 의한 포푸리 — 자기 오페라 주제 메들리(가명 H. 크라머로 냄)

**확인 못 함**

- TH 18 <세비야의 이발사> 쿠플레 — 악보가 전하는지 위키백과·MB 로 확인 못 함
- TH 76 애국 학교 학생 합창 — 악보가 전하는지 확인 못 함
- TH 156·157·160·161·163·164·165·167·202 음악원 습작(실내악·관현악·피아노) — MB work 없고 완성·현존 여부 확인 못 함. MB 에 있는 습작 7곡(TH 152–155·158·159·162)만 넣음
- TH 224·225 연습곡 A단조, 2개의 로망스 — TH 200번대(미완성·의심 작품 번호대)라 진위·완성 확인 못 함
- — 「삼위일체 찬가」(1877) — 영어 위키 합창 목록에 있으나 TH 번호를 찾지 못함(MB fdd420a5… 정보 없음)

**작곡가 것이 아닌 모음곡**

- Op. 20a·Op. 66a <백조의 호수>·<잠자는 숲속의 미녀> 모음곡 — 출판사·실로티가 엮은 것

## 4. 애매했던 판단

- **Op. 14 <대장장이 바쿨라> 뺌.** 작품번호 범위 안이지만 <체레비치키>(TH 8, 1885)의 첫 판이라 SPEC 의 "옛 판은 빼고 마지막 판만"을 따랐습니다. 두 오페라를 따로 세는 관례도 있어서 넣을지 리드 판단이 필요합니다(MB 5575161b…).
- **Op. 23 피아노 협주곡 1번의 MBID.** 운영 159 의 MBID ba27a04b… 는 MB 에서 "original 1874/75 version, rarely performed" work 입니다. 이 목록의 `mbid` 와 악장 3개는 늘 연주되는 1888년 판 work 03c670e9… 를 따랐고, `existingPieceId` 는 159(MBID 가 같은 작품의 옛 판 work 라서 같은 작품으로 보고, 작품번호 Op. 23 도 같음)로 두었습니다. 생성기는 기존 작품의 식별자를 바꾸지 않으므로 159 의 식별자를 1888년 판으로 바꿀지는 따로 정해야 합니다.
- **같은 작품의 판이 여럿인 MB work 는 늘 연주되는 판을 골랐습니다.** 교향곡 1번(1874 개정), 2번(1880 개정), <로미오와 줄리엣>(1880), 로코코 변주곡(피첸하겐 판), 서곡 F장조(1866 판). 로코코 변주곡은 "마지막 판" 기준이면 작곡가 원판이 아니라 피첸하겐이 고친 출판판이 남는 셈이라 표시해 둡니다.
- **Op. 41 <성 요한 크리소스톰의 전례>, Op. 52 <철야 기도>, TH 69 칸타타 <모스크바> 는 part 없이 낱곡.** SPEC 은 미사를 다악장으로 두라고 했는데, 정교회 예배곡의 각 곡은 널리 쓰는 우리말 이름이 없어(교회 슬라브어 원제를 직접 옮겨야 함) 오라토리오처럼 대형 성악 작품으로 보고 낱곡으로 두었습니다. MB parts 는 15·17·6개 있어 다악장으로 바꾸기는 쉽습니다.
- **Op. 71a <호두까기 인형> 모음곡은 3악장 + II 의 children 6곡.** 악보·MB 구조(I 작은 서곡 / II 성격적 춤곡 a–f / III 꽃의 왈츠)를 따랐습니다. 다악장 작품에 children 을 둔 곳은 여기뿐이고, 생성기는 통과합니다. 8곡을 한 줄로 펴길 원하면 말해 주세요.
- **자기 작품을 옮긴 것 3곡을 넣었습니다(authenticity `self_arrangement`).** TH 63 첼로와 현악의 안단테 칸타빌레(Op. 11 2악장), TH 64 첼로와 관현악의 녹턴(Op. 19-4), TH 85 합창곡 <전설>(Op. 54-5). 따로 TH 번호를 받았고 따로 자주 연주돼 쇼팽 때처럼 넣었습니다. 빼려면 authenticity 로 거르면 됩니다. 같은 성격의 TH 114·115(바이올린 편곡)는 연도·출판을 확인 못 해 뺐습니다.
- **Op. 61 <모차르티아나>** 는 모차르트 작품 편곡이지만 작품번호가 있고 리드 메모대로 다악장으로 넣었습니다(authenticity 는 authentic, note 에 적음).
- **Op. 79 <안단테와 피날레>** 는 타네예프가 완성한 것이라 authenticity `completed_by_other` 로 두었습니다. Op. 75 피아노 협주곡 3번은 한 악장뿐이라 낱곡입니다.
- **Op. 67a/67b <햄릿>.** 영어 위키를 따라 서곡=Op. 67a, 부수음악=Op. 67b 로 적었습니다. MB 는 서곡을 op. 67, 부수음악을 op. 67a 로 적고, 러시아어 위키도 서곡 67·부수음악 67а 입니다.
- **Op. 37 / Op. 37a.** 영어 위키 표기("Op. 37 (or 37a)" 그랜드 소나타, "Op. 37a (or 37b)" <사계>)에서 리드 메모대로 소나타=Op. 37, <사계>=Op. 37a 로 했습니다.
- **Op. 39 곡 순서.** 영어 위키 목록은 순서가 섞이고 없는 곡("Peasant Prelude")이 들어간 대신 「나폴리 노래」가 빠져 있어, MB parts·러시아어 위키(1878년 출판 순)를 따랐습니다. 곡 수 24 는 같습니다.
- **TH 번호 없는 곡·악보 확인이 어려운 곡.** 러시아어 위키 TH 표를 기준으로, 소실·편곡·미완성으로 알려진 것은 빼고 나머지는 넣었습니다. 다만 음악원 습작(TH 152–167)은 MB 에 work 가 있는 7곡만 넣었습니다(note "음악원 습작"). 나머지 습작과 TH 18·76·224·225 는 현존·완성 여부를 위키백과·MB 로 확인 못 해 뺐습니다(3절).
- **MB work 없는 작품 9개**(`mbid: null`): TH 16·22·38·66·67·68·71·73·119. TH 16 은 MB 에 두 곡이 따로 있고 묶는 work 가 없습니다.
- **연도.** `yearText` 는 러시아어 위키 TH 표(없으면 영어 위키) 범위, `year` 는 그 끝 해입니다. 고쳐 쓴 작품은 첫 완성 해를 `year` 로 두고 개정 해를 `yearText` 에 붙였습니다(교향곡 1·2번, 협주곡 1번, <로미오와 줄리엣>). TH 121 주제와 변주는 러시아어 위키가 1876–1877 로 적었지만 ČW 96(초기 피아노곡 번호대)과 음악원 습작이라는 점을 보고 1863–1864 로 두었습니다. 확인이 필요합니다.
- **같은 조성 겹침.** Op. 7 과 TH 146 이 둘 다 "왈츠-스케르초 A장조"라 TH 146 에 "(1889)"를 붙였습니다.
- **조성 출처.** Op. 1·2·19·40·51 과 <사계>는 위키백과 조성과 맞췄습니다. Op. 9·10·21·72 의 조성은 위키백과 목록에 없어 확인하지 못했습니다(Op. 10-2 는 MB 제목, Op. 42-3 은 MB 조성과 맞음). TH 9개 성가 조성은 러시아어 위키 표를 따랐습니다.
- **가곡 원제 표기.** 러시아어 원제는 러시아어 위키 TH 표의 키릴 제목을 영어 위키 가곡 표기 꼴(й·ы=y, ь=', 낱말 첫 е=ye)로 옮겼습니다. MB·러시아어 위키가 다른 곳은 MB 를 따랐습니다: Op. 16-2 「Pogodi!」, Op. 54-8 「Kukushka」(러시아어 위키 "Кукушечка"), Op. 57-1 「v teni vetvey」(러시아어 위키 "в тиши"), Op. 57-4 「Usni!」, Op. 60-8 「Prosti!」, Op. 25-6 따옴표. Op. 63-1 은 MB 의 "любил" 대신 러시아어·영어 위키의 "lyubila".

## 5. 직접 옮긴 우리말 이름(검수용)

작품 제목(운영에 이미 있는 9개 제외):

- Op. 2 피아노 모음곡 <합살의 추억> — Souvenir de Hapsal, Op. 2
- Op. 3 오페라 <보예보다> — The Voyevoda
- Op. 12 부수음악 <눈 아가씨> — The Snow Maiden, incidental music
- Op. 13 교향곡 1번 G단조 "겨울날의 환상" — Symphony No. 1 in G minor "Winter Daydreams"
- Op. 15 덴마크 국가에 의한 축전 서곡 D장조 — Festival Overture on the Danish National Anthem in D major
- Op. 17 교향곡 2번 C단조 "소러시아" — Symphony No. 2 in C minor "Little Russian"
- Op. 18 교향적 환상곡 <템페스트> — The Tempest, Symphonic Fantasia in F minor
- Op. 24 오페라 <예브게니 오네긴> — Eugene Onegin
- Op. 26 우울한 세레나데 B♭단조 — Sérénade mélancolique in B♭ minor
- Op. 29 교향곡 3번 D장조 "폴란드" — Symphony No. 3 in D major "Polish"
- Op. 32 교향적 환상곡 <프란체스카 다 리미니> — Francesca da Rimini, Symphonic Fantasia in E minor
- Op. 37 그랜드 소나타 G장조 — Grand Sonata in G major
- Op. 39 피아노 모음곡 <어린이를 위한 앨범> — Album for the Young, Op. 39
- Op. 42 바이올린 소품집 <소중한 곳의 추억> — Souvenir d'un lieu cher, Op. 42
- Op. 50 피아노 3중주 A단조 "위대한 예술가를 추모하며" — Piano Trio in A minor "In Memory of a Great Artist"
- Op. 56 협주적 환상곡 G장조 — Concert Fantasia in G major
- Op. 58 <만프레드> 교향곡 B단조 — Manfred Symphony in B minor
- Op. 61 관현악 모음곡 4번 G장조 "모차르티아나" — Orchestral Suite No. 4 in G major "Mozartiana"
- Op. 66 발레 <잠자는 숲속의 미녀> — The Sleeping Beauty
- Op. 67a 환상 서곡 <햄릿> — Hamlet, Fantasy Overture in F minor
- Op. 67b 부수음악 <햄릿> — Hamlet, incidental music
- Op. 68 오페라 <스페이드의 여왕> — The Queen of Spades
- Op. 69 오페라 <이올란타> — Iolanta
- Op. 70 현악 6중주 D단조 "피렌체의 추억" — String Sextet in D minor "Souvenir de Florence"
- Op. 71a 발레 모음곡 <호두까기 인형> — The Nutcracker Suite
- Op. 76 서곡 <뇌우> — The Storm, Overture in E minor
- Op. 77 교향시 <운명> — Fatum, Symphonic Poem in C minor
- Op. 78 교향적 발라드 <보예보다> — The Voyevoda, Symphonic Ballad in A minor
- TH 3 오페라 <오프리치니크> — The Oprichnik
- TH 6 오페라 <오를레앙의 처녀> — The Maid of Orleans
- TH 7 오페라 <마제파> — Mazeppa
- TH 8 오페라 <체레비치키> — Cherevichki
- TH 9 오페라 <마녀> — The Enchantress
- TH 16 부수음악 <가짜 드미트리와 바실리 슈이스키> — Dmitri the Pretender and Vassily Shuisky, incidental music
- TH 22 부수음악 <보예보다> — The Voyevoda, melodrama for Ostrovsky's play
- TH 42 환상 서곡 <로미오와 줄리엣> — Romeo and Juliet, Fantasy Overture
- TH 43 니콜라이 루빈시테인의 명명일을 위한 세레나데 — Serenade for Nikolai Rubinstein's Name Day
- TH 51 엘레지 G장조 "사마린을 기리며" — Elegy in G major "In Memory of I. V. Samarin"
- TH 52 법률학교 행진곡 D장조 — Jurisprudence March in D major
- TH 66 칸타타 <환희의 송가> — Ode to Joy, Cantata
- TH 67 표트르 대제 탄생 200주년 칸타타 — Cantata for the Bicentenary of Peter the Great
- TH 68 오시프 페트로프 무대 50주년 칸타타 — Cantata for the Golden Jubilee of Osip Petrov
- TH 69 칸타타 <모스크바> — Moscow, Coronation Cantata
- TH 71 꽃과 곤충의 합창 — Chorus of Flowers and Insects
- TH 80 법률학교 노래 — Jurists' Song
- TH 85 합창곡 <전설> — Legend, for chorus
- TH 86 A. G. 루빈시테인에게 보내는 인사 — A Greeting to A. G. Rubinstein
- TH 119 아나스타샤 왈츠 — Anastasie-Valse
- TH 140 의용 함대 행진곡 — The Volunteer Fleet March
- TH 144 즉흥 카프리스 G장조 — Impromptu-caprice in G major
- TH 148 열정적인 고백 E단조 — Aveu passionné in E minor
- TH 150 군대 행진곡 B♭장조 — Military March in B♭ major

묶음 안 곡·악장 이름(갈래어만 옮긴 악장 이름과 원어 그대로인 이름은 뺌):

- Op. 1 2개의 소품 Op. 1: 러시아풍 스케르초 B♭장조(Scherzo à la russe in B♭ major); 즉흥곡 E♭단조(Impromptu in E♭ minor)
- Op. 2 피아노 모음곡 <합살의 추억>: 성의 폐허 E단조(Ruines d'un château in E minor); 스케르초 F장조(Scherzo in F major); 무언가 F장조(Chant sans paroles in F major)
- Op. 9 3개의 소품 Op. 9: 몽상 D장조(Rêverie in D major); 살롱 폴카 B♭장조(Polka de salon in B♭ major); 살롱 마주르카 D단조(Mazurka de salon in D minor)
- Op. 10 2개의 소품 Op. 10: 녹턴 F장조(Nocturne in F major); 유머레스크 G장조(Humoresque in G major)
- Op. 13 교향곡 1번 G단조 "겨울날의 환상": Allegro tranquillo "겨울 여행의 꿈"(I. Allegro tranquillo "Dreams of a Winter Journey"); Adagio cantabile ma non tanto "음울한 땅, 안개의 땅"(II. Adagio cantabile ma non tanto "Land of Desolation, Land of Mists")
- Op. 19 6개의 소품 Op. 19: 저녁의 몽상 G단조(Rêverie du soir in G minor); 유머러스한 스케르초 D장조(Scherzo humoristique in D major); 앨범의 한 장 D장조(Feuillet d'album in D major); 녹턴 C#단조(Nocturne in C# minor); 카프리치오소 B♭장조(Capriccioso in B♭ major); 독창적 주제와 변주 F장조(Thème original et variations in F major)
- Op. 21 하나의 주제에 의한 6개의 소품 Op. 21: 전주곡 B장조(Prélude in B major); 4성 푸가 G#단조(Fugue à 4 voix in G# minor); 즉흥곡 C#단조(Impromptu in C# minor); 장송 행진곡 A♭단조(Marche funèbre in A♭ minor); 마주르카 A♭단조(Mazurka in A♭ minor); 스케르초 A♭장조(Scherzo in A♭ major)
- Op. 37a 피아노 모음곡 <사계>: 1월: 난롯가에서(January: At the Fireside); 2월: 사육제(February: Carnival); 3월: 종달새의 노래(March: Song of the Lark); 4월: 설강화(April: Snowdrop); 5월: 백야(May: Starlit Nights); 6월: 뱃노래(June: Barcarolle); 7월: 풀 베는 이의 노래(July: Song of the Reaper); 8월: 추수(August: Harvest); 9월: 사냥(September: The Hunt); 10월: 가을의 노래(October: Autumn Song); 11월: 트로이카(November: Troika); 12월: 크리스마스(December: Christmas)
- Op. 39 피아노 모음곡 <어린이를 위한 앨범>: 아침 기도(Morning Prayer); 겨울 아침(Winter Morning); 목마 놀이(Playing Hobby-Horses); 엄마(Mama); 나무 병정의 행진(March of the Wooden Soldiers); 아픈 인형(The Sick Doll); 인형의 장례식(The Doll's Funeral); 왈츠(Waltz); 새 인형(The New Doll); 마주르카(Mazurka); 러시아 노래(Russian Song); 아코디언 켜는 농부(The Peasant Plays the Accordion); 카마린스카야(Kamarinskaya); 폴카(Polka); 이탈리아 노래(Italian Song); 옛 프랑스 노래(Old French Song); 독일 노래(German Song); 나폴리 노래(Neapolitan Song); 유모의 옛이야기(Nanny's Story); 바바야가(Baba Yaga); 달콤한 꿈(Sweet Dreams); 종달새의 노래(Lark Song); 손풍금 장수의 노래(The Organ-Grinder Sings); 교회에서(In Church)
- Op. 40 12개의 소품 Op. 40: 연습곡 G장조(Étude in G major); 슬픈 노래 G단조(Chanson triste in G minor); 장송 행진곡 C단조(Marche funèbre in C minor); 마주르카 C장조(Mazurka in C major); 마주르카 D장조(Mazurka in D major); 무언가 A단조(Chant sans paroles in A minor); 시골에서 A단조(Au village in A minor); 왈츠 A♭장조(Valse in A♭ major); 왈츠 F#단조(Valse in F# minor); 러시아 춤 A단조(Danse russe in A minor); 스케르초 D단조(Scherzo in D minor); 중단된 몽상 A♭장조(Rêverie interrompue in A♭ major)
- Op. 42 바이올린 소품집 <소중한 곳의 추억>: 명상 D단조(Méditation in D minor); 스케르초 C단조(Scherzo in C minor); 멜로디 E♭장조(Mélodie in E♭ major)
- Op. 51 6개의 소품 Op. 51: 살롱 왈츠 A♭장조(Valse de salon in A♭ major); 폴카 B단조(Polka peu dansante in B minor); 스케르초풍 미뉴에트 E♭장조(Menuetto scherzoso in E♭ major); 나타 왈츠 A장조(Natha-Valse in A major); 로망스 F장조(Romance in F major); 감상적인 왈츠 F단조(Valse sentimentale in F minor)
- Op. 71a 발레 모음곡 <호두까기 인형>: 작은 서곡(I. Ouverture miniature. Allegro giusto); 성격적 춤곡(II. Danses caractéristiques); 행진곡(a) Marche. Tempo di marcia viva); 사탕 요정의 춤(b) Danse de la Fée-Dragée. Andante ma non troppo); 러시아 춤 (트레팍)(c) Danse russe Trépak. Tempo di trepak, molto vivace); 아라비아 춤(d) Danse arabe. Allegretto); 중국 춤(e) Danse chinoise. Allegro moderato); 갈대 피리의 춤(f) Danse des mirlitons. Moderato assai); 꽃의 왈츠(III. Valse des fleurs. Tempo di valse)
- Op. 72 18개의 소품 Op. 72: 즉흥곡 F단조(Impromptu in F minor); 자장가 A♭장조(Berceuse in A♭ major); 다정한 꾸지람 C#단조(Tendres reproches in C# minor); 성격적 춤곡 D장조(Danse caractéristique in D major); 명상 D장조(Méditation in D major); 춤을 위한 마주르카 B♭장조(Mazurque pour danser in B♭ major); 연주회용 폴로네즈 E♭장조(Polacca de concert in E♭ major); 대화 B장조(Dialogue in B major); 슈만풍으로 D♭장조(Un poco di Schumann in D♭ major); 스케르초-환상곡 E♭단조(Scherzo-fantaisie in E♭ minor); 왈츠-블루에트 E♭장조(Valse-bluette in E♭ major); 장난꾸러기 E장조(L'espiègle in E major); 시골의 메아리 E♭장조(Écho rustique in E♭ major); 엘레지풍 노래 D♭장조(Chant élégiaque in D♭ major); 쇼팽풍으로 C#단조(Un poco di Chopin in C# minor); 5박자 왈츠 D장조(Valse à cinq temps in D major); 아득한 옛날 E♭장조(Passé lointain in E♭ major); 춤 장면 "트레팍으로의 초대" C장조(Scène dansante "Invitation au trépak" in C major)
- TH 78 9개의 성가 TH 78: Kheruvimskaya pesn' F장조(Kheruvimskaya pesn' in F major); Kheruvimskaya pesn' D장조(Kheruvimskaya pesn' in D major); Kheruvimskaya pesn' C장조(Kheruvimskaya pesn' in C major); Tebe poem C장조(Tebe poem in C major); Dostoyno yest' D단조(Dostoyno yest' in D minor); Otche nash F장조(Otche nash in F major); Blazheni, yazhe izbral E♭장조(Blazheni, yazhe izbral in E♭ major); Da ispravitsya D단조(Da ispravitsya in D minor); Nyne sily nebesnyya G장조(Nyne sily nebesnyya in G major)

가곡 가운데 우리말을 붙인 것은 5곡뿐입니다: Op. 6-6 「오직 그리움을 아는 이만이」, Op. 16-1 「자장가」, Op. 25-3 「미뇽의 노래」, Op. 38-1 「돈 후안의 세레나데」, Op. 54-5 「전설」. 나머지 가곡·합창곡은 원제(라틴 문자) 그대로입니다. Op. 6-6 은 「다만/오직 그리움을 아는 이만이」 등 표기가 갈려서 꼭 봐 주세요.

## 6. 위키백과 대조 결과

`scripts/wikicheck.py` → `raw/wikicheck.json`.

- 영어 위키 작품번호 목록 83항목(Op. 1–80 + 37a·67a/67b·71a): 빠진 것 없음, 일부러 뺀 것 Op. 14.
- 묶음 곡 수: 영어 위키가 곡 수나 곡 목록을 적은 묶음 26개(Op. 1, Op. 2, Op. 6, Op. 9, Op. 10, Op. 16, Op. 19, Op. 21, Op. 25, Op. 27, Op. 28, Op. 37a, Op. 38, Op. 39, Op. 40, Op. 42, Op. 46, Op. 47, Op. 51, Op. 54, Op. 57, Op. 60, Op. 63, Op. 65, Op. 72, Op. 73) 모두 같습니다.
- 조성: 영어 위키가 조성을 적은 곡 24개(Op. 19, Op. 40, Op. 51) 모두 같습니다. Op. 1 두 곡(B♭장조·E♭단조), Op. 2 세 곡(영어 위키 「Souvenir de Hapsal」 문서), <사계> 12곡(「The Seasons (Tchaikovsky)」 문서)도 손으로 맞춰 봤습니다.
- 러시아어 위키 TH 표의 묶음 29개(번호/곡 꼴) 곡 수: 모두 같습니다(TH 132 = Op. 10 은 표에 "132/1" 이 두 번 적힌 오기).
- 연도: 영어 위키 작품번호 목록 연도와 `yearText`(러시아어 위키 범위)가 다른 곳 7개 — Op. 10 영어 1871 / 1871–1872; Op. 16 영어 1872 / 1872–1873; Op. 25 영어 1874 / 1875; Op. 33 영어 1876 / 1876–1877; Op. 36 영어 1877 / 1877–1878; Op. 67a 영어 1889 / 1888; Op. 70 영어 1890 / 1890–1892. 대부분 범위의 앞 해/끝 해 차이입니다.
- 영어 위키 「장르별」 목록의 작품번호 없는 곡: 교향곡 E♭장조·첼로 협주곡·콘체르트슈튀크(미완성·복원), <몬테네그로>(소실), 「삼위일체 찬가」(TH 번호 못 찾음)는 빼고 나머지(로미오와 줄리엣, 대관식 행진곡, 환희의 송가, 페트로프 칸타타, 모스크바, 9개의 성가, 가짜 드미트리, 보예보다 멜로드라마, 의용 함대 행진곡, 아다지오 몰토, 현악 4중주 악장, 합창 전설)는 모두 넣었습니다.
- MB parts 와 위키백과가 어긋난 곳: Op. 39 순서(위 4절, 영어 위키 목록 쪽 오류로 보고 MB=러시아어 위키를 따름), <햄릿> 작품번호(MB op. 67/67a). 그 밖에 MB parts 곡 수는 위키백과·러시아어 위키와 모두 같습니다.
- 검사: 제목 겹침 0(운영 제목 포함), `1번 `·`1악장 ` 으로 시작하는 nameKo 0, 빈 nameKo 0, 다른 작품이 쓰는 MBID 0, 한 작품 안 part MBID 겹침 0.

MB 제목과 다르게 적은 악장 이름(빠르기말을 악보 표기대로 채우거나 갈래어를 붙인 곳. 위키백과 개별 작품 문서는 이번에 받지 않아 악보 표기는 따로 확인이 필요합니다):

- Op. 13 II: MB "Land of Desolation, Land of Mists: Andante cantabile ma non tanto" → "Adagio cantabile ma non tanto "Land of Desolation, Land of Mists""
- Op. 17 III: MB "Scherzo and Trio: Allegro molto vivace" → "Scherzo. Allegro molto vivace"
- Op. 23 I: MB "Allegro non troppo e molto maestoso" → "Allegro non troppo e molto maestoso – Allegro con spirito"
- Op. 36 III: MB "Scherzo. Pizzicato ostinato" → "Scherzo. Pizzicato ostinato. Allegro"
- Op. 43 III: MB "Intermezzo. Andante semplice" → "Intermezzo. Andantino semplice"
- Op. 44 I: MB "Allegro brillante" → "Allegro brillante e molto vivace"
- Op. 48 I: MB "Pezzo in forma di Sonatina" → "Pezzo in forma di sonatina. Andante non troppo – Allegro moderato"
- Op. 48 II: MB "Waltz. Moderato - Tempo di valse" → "Valse. Moderato – Tempo di valse"
- Op. 48 IV: MB "Finale. Tema russo" → "Finale (Tema russo). Andante – Allegro con spirito"
- Op. 50 II: MB "Tema con variazioni" → "Tema con variazioni. Andante con moto – Variazione finale e coda"
- Op. 53 I: MB "Jeu de sons. Andantino un poco rubato" → "Jeu de sons. Andantino un poco rubato – Allegro molto vivace"
- Op. 56 I: MB "Quasi Rondo" → "Quasi rondo. Andante mosso"
- Op. 56 II: MB "Contrastes" → "Contrastes. Andante cantabile – Molto vivace"
- Op. 79 II: MB "Allegro maestoso" → "Finale. Allegro maestoso"
- Op. 80 III: MB "Allegro vivo" → "Scherzo. Allegro vivo"
- Op. 80 IV: MB "Allegro vivo" → "Finale. Allegro vivo"
