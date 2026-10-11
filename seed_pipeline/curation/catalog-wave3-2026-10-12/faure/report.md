# 포레(47) 작품 카탈로그 3차 보고서

작업 파일: `catalog.json`, `seed_map.json`, `gen_test.sql`(3차 생성기 `wave3/gen/gen_catalog.py --seed-map` 시험 변환, 오류 없음), `hide_test.sql`(`--hide-only` 시험). 스크립트는 `scripts/`
(`build.py` 가 두 JSON 을 만들고 `validate.py`·`wiki_check.py`·`leftover_parts.py`·`map_table.py` 로 검사).

## 1. 개수

- 작품 136: 낱곡 82, 묶음 36, 다악장 18 / part 200 / children 0
  - 작품번호(Op.) 있는 것 112, 「N. 109」 1, 번호 없는 것 23
- 생성기 시험: 새 작품 17, 새 part 200, 기존 작품 119(seed 116 + manual 206·207·208), seed·manual 연결 3(209·984·2134), seed 제목 바꿈 115, 숨김 40
  - 이미 잠긴 seed 469·473·482(「뱃노래 3번 G♭장조 Op. 42」 등 우리말 제목)는 제목을 바꾸지 않음. catalog 제목은 Op. 를 뺀 꼴이라 이 셋만 「Op.」가 붙은 채 남아요
- excerpt_keep: 없음(part 없이 둔 오페라 <프로메테>·<페넬로프>의 대목 seed 가 없음)
- seed 158: work 116 / part 2 / unmatched 40
  - unmatched 까닭: arrangement 21, popular 8, excluded_scope 6, duplicate 4, hymn_translation 1
- 포레의 비교 구간 4개는 모두 manual(206·207·208·209)에 있고 seed 에는 비교 구간이 없어요.

## 2. 운영 기존 작품 대응표

manual 4개: 206 레퀴엠 → `faure-op48`(MBID ccb56514, 1900 관현악판), 207 파반느 → `faure-op50`(MBID fd26fa0f), 208 시칠리엔 → `faure-op78`(MBID d4a90ba5), 209 가곡 <꿈을 꾼 후에> → `faure-op7` part 1(MBID a57e0d98 = Op. 7 No. 1, 작곡가 47 확인. 한국 가곡 아님).
seed 118개 중 116개는 MBID 가 catalog 작품 MBID 와 같아요. 제목으로 이은 것은 레퀴엠 part 2개뿐이에요.

| id | origin | 운영 제목 | catalog | 근거 | 메모 |
|---|---|---|---|---|---|
| 981 | seed | 2 Songs, op. 1 | faure-op1 | MBID |  |
| 2140 | seed | 2 Songs, op. 2 | faure-op2 | MBID |  |
| 2455 | seed | 2 Songs, op. 3 | faure-op3 | MBID |  |
| 1601 | seed | 2 Songs, op. 4 | faure-op4 | MBID |  |
| 1597 | seed | 3 Songs, op. 5 | faure-op5 | MBID |  |
| 2461 | seed | 3 Songs, op. 6 | faure-op6 | MBID |  |
| 1211 | seed | Trois mélodies, op. 7 | faure-op7 | MBID |  |
| 209 | manual | 가곡 <꿈을 꾼 후에> | faure-op7 [1] | MBID |  |
| 2480 | seed | 3 Songs, op. 8 | faure-op8 | MBID |  |
| 995 | seed | 2 Duets, op. 10 | faure-op10 | MBID |  |
| 11526 | seed | Cantique de Jean Racine, op. 11 | faure-op11 | MBID |  |
| 1424 | seed | Les Djinns, op. 12 | faure-op12 | MBID |  |
| 1281 | seed | Violin Concerto in D minor, op. 14 | faure-op14 | MBID |  |
| 2705 | seed | Piano Quartet no. 1 in C minor, op. 15 | faure-op15 | MBID |  |
| 549 | seed | Berceuse for Violin (or Cello) and Piano in D major, op. 16 | faure-op16 | MBID |  |
| 520 | seed | 3 Songs for Voice and Piano, op. 18 | faure-op18 | MBID |  |
| 1775 | seed | Symphonic Suite in F major, op. 20 | faure-op20 | MBID |  |
| 1604 | seed | Poème d’un jour, op. 21 | faure-op21 | MBID |  |
| 1944 | seed | Le Ruisseau, op. 22 | faure-op22 | MBID |  |
| 1880 | seed | 3 Songs, op. 23 | faure-op23 | MBID |  |
| 518 | seed | Élégie pour violoncelle et piano, op. 24 | faure-op24 | MBID |  |
| 911 | seed | Impromptu no. 1 in E‐flat major, op. 25 | faure-op25 | MBID |  |
| 519 | seed | Barcarolle no. 1 in A minor, op. 26 | faure-op26 | MBID |  |
| 2030 | seed | 2 Songs, op. 27 | faure-op27 | MBID |  |
| 626 | seed | Romance for Violin and Piano in B-flat major, op. 28 | faure-op28 | MBID |  |
| 1157 | seed | La Naissance de Vénus, op. 29 | faure-op29 | MBID |  |
| 570 | seed | Valse‐caprice no. 1 in A major, op. 30 | faure-op30 | MBID |  |
| 1566 | seed | Impromptu no. 2 in F minor, op. 31 | faure-op31 | MBID |  |
| 473 | seed | 마주르카 B♭장조 Op. 32 | faure-op32 | MBID |  |
| 2399 | seed | 3 Nocturnes, op. 33 | faure-op33 | MBID |  |
| 1032 | seed | Impromptu no. 3 in A‐flat major, op. 34 | faure-op34 | MBID |  |
| 1223 | seed | Madrigal, op. 35 | faure-op35 | MBID |  |
| 2279 | seed | Nocturne no. 4 en Mi bémol majeur, op. 36 | faure-op36 | MBID |  |
| 1957 | seed | Nocturne no. 5 en Si bémol majeur, op. 37 | faure-op37 | MBID |  |
| 671 | seed | Valse‐caprice no. 2 in D‐flat major, op. 38 | faure-op38 | MBID |  |
| 2754 | seed | 4 Songs, op. 39 | faure-op39 | MBID |  |
| 595 | seed | Barcarolle no. 2 in G major, op. 41 | faure-op41 | MBID |  |
| 469 | seed | 뱃노래 3번 G♭장조 Op. 42 | faure-op42 | MBID |  |
| 2764 | seed | Deux Mélodies, op. 43 | faure-op43 | MBID |  |
| 502 | seed | Barcarolle no. 4 in A‐flat major, op. 44 | faure-op44 | MBID |  |
| 1504 | seed | Piano Quartet no. 2 in G minor, op. 45 | faure-op45 | MBID |  |
| 1106 | seed | 2 Mélodies, op. 46 | faure-op46 | MBID |  |
| 2736 | seed | 2 Songs, op. 47 | faure-op47 | MBID |  |
| 206 | manual | 레퀴엠 | faure-op48 | MBID |  |
| 984 | seed | Pie Jesu | faure-op48 [4] | 제목 | MB 관계 없는 낱개 work(작곡가만 포레). 제목(「Pie Jesu」)으로 레퀴엠 4곡에 이음 |
| 2134 | seed | Libera Me | faure-op48 [6] | 제목 | MB 관계 없는 낱개 work(작곡가만 포레). 제목(「Libera me」)으로 레퀴엠 6곡에 이음. 1877 바리톤·오르간 원판일 가능성도 있음 |
| 207 | manual | 파반느 | faure-op50 | MBID |  |
| 1765 | seed | 4 Mélodies, op. 51 | faure-op51 | MBID |  |
| 2839 | seed | Caligula : musique de scène op. 52 pour chœur de femmes et orchestre | faure-op52 | MBID |  |
| 1286 | seed | Ecce fidelis servus, op. 54 | faure-op54 | MBID |  |
| 1950 | seed | Tantum ergo, op. 55 | faure-op55 | MBID |  |
| 578 | seed | Dolly, op. 56 | faure-op56 | MBID |  |
| 1732 | seed | 5 Mélodies “de Venise”, op. 58 | faure-op58 | MBID |  |
| 628 | seed | Valse‐caprice no. 3 in G‐flat major, op. 59 | faure-op59 | MBID |  |
| 482 | seed | 왈츠 카프리스 4번 A♭장조 Op. 62 | faure-op62 | MBID |  |
| 1023 | seed | Nocturne no. 6 en Ré bémol majeur, op. 63 | faure-op63 | MBID |  |
| 2607 | seed | 2 Motets, op. 65 | faure-op65 | MBID |  |
| 583 | seed | Barcarolle no. 5 in F‐sharp minor, op. 66 | faure-op66 | MBID |  |
| 842 | seed | 2 Songs, op. 67 | faure-op67 | MBID |  |
| 2854 | seed | Romance, op. 69 | faure-op69 | MBID |  |
| 527 | seed | Barcarolle no. 6 in E‐flat major, op. 70 | faure-op70 | MBID |  |
| 541 | seed | Pleurs d’or, op. 72 | faure-op72 | MBID |  |
| 1305 | seed | Nocturne no. 7 en Ut dièse mineur, op. 74 | faure-op74 | MBID |  |
| 675 | seed | Andante pour violon & piano en si bémol majeur, op. 75 | faure-op75 | MBID |  |
| 943 | seed | Deux Mélodies, op. 76 | faure-op76 | MBID |  |
| 2443 | seed | Papillon, op. 77 | faure-op77 | MBID |  |
| 208 | manual | 시칠리엔 | faure-op78 | MBID |  |
| 591 | seed | Fantaisie pour flûte & piano en ut majeur, op. 79 | faure-op79 | MBID |  |
| 1185 | seed | Prométhée, op. 82 | faure-op82 | MBID |  |
| 2894 | seed | 2 Songs, op. 83 | faure-op83 | MBID |  |
| 1574 | seed | Huit pièces brèves, op. 84 | faure-op84 | MBID |  |
| 2471 | seed | Trois mélodies, op. 85 | faure-op85 | MBID |  |
| 2362 | seed | Impromptu for harp in D-flat major, op. 86 | faure-op86 | MBID |  |
| 948 | seed | 2 Songs, op. 87 | faure-op87 | MBID |  |
| 539 | seed | Quintette pour piano et cordes no. 1 en ré mineur, op. 89 | faure-op89 | MBID |  |
| 505 | seed | Barcarolle no. 7 in D minor, op. 90 | faure-op90 | MBID |  |
| 881 | seed | Impromptu no. 4 in D‐flat major, op. 91 | faure-op91 | MBID |  |
| 2388 | seed | Le Don silencieux, op. 92 | faure-op92 | MBID |  |
| 2241 | seed | Ave Maria, op. 93 | faure-op93 | MBID |  |
| 2093 | seed | Chanson, op. 94 | faure-op94 | MBID |  |
| 1253 | seed | La Chanson d'Ève, op. 95 | faure-op95 | MBID |  |
| 660 | seed | Barcarolle no. 8 in D‐flat major, op. 96 | faure-op96 | MBID |  |
| 1039 | seed | Nocturne no. 9 en Si mineur, op. 97 | faure-op97 | MBID |  |
| 1099 | seed | Sérénade pour violoncelle & piano en si mineur, op. 98 | faure-op98 | MBID |  |
| 2559 | seed | Nocturne no. 10 en Mi mineur, op. 99 | faure-op99 | MBID |  |
| 640 | seed | Barcarolle no. 9 in A minor, op. 101 | faure-op101 | MBID |  |
| 1537 | seed | Impromptu no. 5 in F‐sharp minor, op. 102 | faure-op102 | MBID |  |
| 1915 | seed | 9 Préludes, op. 103 | faure-op103 | MBID |  |
| 1781 | seed | 2 Pièces, op. 104 | faure-op104 | MBID |  |
| 582 | seed | Barcarolle no. 11 in G minor, op. 105 | faure-op105 | MBID |  |
| 2175 | seed | Le Jardin clos, op. 106 | faure-op106 | MBID |  |
| 624 | seed | Barcarolle no. 12 in E‐flat major, op. 106 bis | faure-op106bis | MBID |  |
| 672 | seed | Nocturne no. 12 en Mi mineur, op. 107 | faure-op107 | MBID |  |
| 2881 | seed | Violin Sonata in E minor, op. 108 | faure-op108 | MBID |  |
| 1565 | seed | Sonate pour violoncelle & piano no. 1, op. 109 | faure-op109 | MBID |  |
| 2425 | seed | Une châtelaine en sa tour, op. 110 | faure-op110 | MBID |  |
| 2128 | seed | Fantaisie for piano and orchestra, op. 111 | faure-op111 | MBID |  |
| 1905 | seed | Mirages, op. 113 | faure-op113 | MBID |  |
| 596 | seed | C’est la paix, op. 114 | faure-op114 | MBID |  |
| 646 | seed | Quintette pour piano et cordes no. 2 en ut mineur, op. 115 | faure-op115 | MBID |  |
| 559 | seed | Barcarolle no. 13 in C major, op. 116 | faure-op116 | MBID |  |
| 1628 | seed | Sonate pour violoncelle & piano no. 2, op. 117 | faure-op117 | MBID |  |
| 1164 | seed | L’Horizon chimérique, op. 118 | faure-op118 | MBID |  |
| 1505 | seed | Nocturne no. 13 en Si mineur, op. 119 | faure-op119 | MBID |  |
| 1443 | seed | Piano Trio in D minor, op. 120 | faure-op120 | MBID |  |
| 2646 | seed | String Quartet in E minor, op. 121 | faure-op121 | MBID |  |
| 1590 | seed | Puisque j'ai mis ma lèvre | faure-puisque-jai-mis-ma-levre | MBID |  |
| 2143 | seed | Piano Sonata in F major | faure-piano-sonata-f | MBID |  |
| 1837 | seed | Super flumina Babylonis | faure-super-flumina | MBID |  |
| 2081 | seed | Tristesse d'Olympio | faure-tristesse-dolympio | MBID |  |
| 2122 | seed | L'Aurore, op. posth. | faure-laurore | MBID |  |
| 2194 | seed | Ave Maria in A major, op. posth. | faure-ave-maria-1871 | MBID |  |
| 2415 | seed | Tu es Petrus | faure-tu-es-petrus | MBID |  |
| 2363 | seed | La Passion, N. 109 : Prélude | faure-la-passion-prelude | MBID |  |
| 532 | seed | Sérénade du Bourgeois gentilhomme, op. posth. | faure-serenade-bourgeois-gentilhomme | MBID |  |
| 2805 | seed | Sancta mater | faure-sancta-mater | MBID |  |
| 506 | seed | Allegretto moderato for Two Cellos | faure-morceau-lecture-2vc | MBID | MB 이름 'Allegretto moderato for Two Cellos'(1897) = 위키백과 'Morceau de lecture for two cellos (1897)' |
| 2944 | seed | Chanson de Mélisande | faure-chanson-de-melisande | MBID |  |
| 2360 | seed | Morceau de concours pour flûte et piano (Concours 1898) | faure-morceau-concours-flute | MBID |  |
| 546 | seed | Morceau de concours pour violon & piano (Concours 1903) | faure-morceau-lecture-violin | MBID | MB 이름 'Morceau de concours pour violon & piano (Concours 1903)' = 위키백과 'Morceau de lecture (1903)' |
| 2300 | seed | Messe basse | faure-messe-basse | MBID |  |
| 2155 | seed | Pénélope | faure-penelope | MBID |  |

### 운영 중복 작품

- 파반느: manual 207 · seed 676(MBID 없음 → duplicate) · 편곡·대중가요 seed 788·7631·1461·2244·2734·832·2496
- 자장가 Op. 16: seed 549(work) · 2729(MB 중복 work e029d077 → duplicate) · 2772(포레 자신의 바이올린·관현악판 → arrangement)
- 멜리장드의 노래: seed 2944(work) · 2110·1718(영어 원가사 work → duplicate) · 1013(쾨클랭 관현악 → arrangement)
- 레퀴엠: manual 206 · seed 984 「Pie Jesu」·2134 「Libera Me」(part 로 이음) · 2980(Pie Jesu 색소폰 편곡)
- 꿈을 꾼 후에: manual 209(part) · seed 777(편곡)·2717(터키어판)

### catalog 에 들지 않는 seed part (그대로 남음)

- seed 1185 <프로메테> part 3개(막), seed 2155 <페넬로프> part 3개(막): 오페라라 낱곡으로 둠.
- seed 1775 Op. 20 part 1개(「I. Allegro」): 낱곡으로 둠.

## 3. 뺀 것과 까닭

- 번호만 비어 있음(5): Op. 9·53·60·64·100(위키백과 「배정되지 않음」).
- 소실·파기(5): Op. 40 교향곡 D단조(파기, 재료가 Op. 108·109 로), Op. 49 <작은 소품>(위키백과 'now lost' — 단 MB 에 work d44e9387·바순 편곡이 있어 확인 필요), 가곡 「L'aube naît」, <성 뱅상 드 폴 찬가>, <원장 축일 찬가>.
- 남의 선율·편곡(7): Op. 63 bis <아폴론 찬가>(델포이 고대 찬가에 반주를 붙인 것), Op. 68 「Allegro symphonique」(보엘만의 Op. 20 1악장 연탄 편곡, seed 2926), 「Il est né le divin enfant」·「Noël d'enfants」(캐럴 화성 붙임), <페넬로프> 「Les joueuses de flûte」 편곡 3종(연탄·바이올린·플루트), Op. 86 bis(코르토 피아노 편곡, seed 2677).
- 공동 작곡(2): <바이로이트의 추억>(메사제와 함께, 바그너 주제 카드리유), <빌레르빌 어부들의 미사>(메사제와 함께 — 포레 몫은 <Messe basse>로 넣음).
- 옛 판·다른 편성 판(넣지 않고 note 에 적음): 레퀴엠 1888·1890·1893 판, 로망스 Op. 69 의 첼로·오르간 원판(seed 1137), 「장송곡」(1921, 첼로 소나타 2번 2악장의 원형, seed 2857), 「Intermède symphonique」(seed 1166), <마스크와 베르가마스크> 무대판 8곡(seed 859), <펠레아스와 멜리장드> 부수음악 19곡, <샤일록> 부수음악 9곡, 발라드·엘레지·자장가 Op. 16 의 관현악판, <좋은 노래> 현악 5중주 반주판, <돌리> 라보 관현악판.
- 확인 못 해 뺀 것(2): 마주르카 B♭장조(c. 1865) — Op. 32 와 같은 조성이라 같은 곡의 이른 판일 수 있음, 가보트 C#단조(1869) — <마스크와 베르가마스크> 가보트로 재사용.
- 위키백과 목록에 없는 보칼리즈(2): seed 949 「Vocalise no. 29」·1186 「Vocalise no. 20」.

## 4. 애매했던 판단

1. **녹턴·뱃노래 단위**: 리드 메모대로 13곡을 하나로 묶지 않고 작품번호마다 따로 뒀어요. 다만 한 작품번호에 여러 곡인 것은 SPEC 규칙대로 묶음이에요 — Op. 33(녹턴 1–3번), Op. 104(녹턴 11번 + 뱃노래 10번), Op. 84(<8개의 짧은 소품>, 8번이 녹턴 8번). 그래서 녹턴 단독 작품은 8개(4·5·6·7·9·10·12·13번), 뱃노래 단독은 12개(10번만 Op. 104 안)예요.
2. **레퀴엠 판**: manual 206 의 MBID 가 1900 관현악판(ccb56514)이라 그대로 두고 7곡을 part 로 넣었어요(입당송과 키리에, 봉헌송, 상투스, Pie Jesu, 아뉴스 데이, Libera me, In paradisum). 1888 원판 5곡, 1890 2판, 1893 판(래터 판 음반이 많음)은 note 에만. seed 「Pie Jesu」(984)·「Libera Me」(2134)는 MB 관계가 없어 제목으로 4·6곡에 이었는데, 2134 는 1877 바리톤·오르간 원판일 수도 있어요.
3. **Nectoux(N.) 번호**: 위키백과 영어·프랑스어 목록 모두 N. 번호가 없고 MB 에도 거의 없어요(「La Passion, N. 109」 하나). 그래서 번호 없는 작품 23개는 `catalogue` null, 「<수난> 전주곡」만 `N. 109` 예요.
4. **위키백과 목록에 없는데 넣은 것**: 「멜리장드의 노래」(1898 부수음악 노래, 사후 출판 — seed 4개가 가리킴), 「<수난> 전주곡」(1890). 둘 다 현존·완성이라 넣었어요. 반대로 위키 목록에 있지만 MB work 가 없는 것(3성 푸가 F장조, 전주곡 C장조(1897), 하프 초견곡, Op. 88 <행복의 베일>, 모테트 <Benedictus>, <아베 마리아> F장조, 모테트 <Tantum ergo> F장조)도 넣었고 MBID 는 null 이에요.
5. **바이올린 협주곡 Op. 14**(미완성, 1악장만 현존)와 **관현악 모음곡 Op. 20**(미출판, 1악장 Allegro 가 남아 연주됨)을 낱곡으로 넣었어요. 말러 피아노 4중주 악장과 같은 기준(완결된 악장이 남은 미완성 작품). 엄격히 보면 빼야 해요.
6. **원판 편성 우선**: 같은 작품번호의 포레 자신의 다른 편성판(발라드 Op. 19 피아노·관현악판, 엘레지·자장가 관현악판, <좋은 노래> 5중주판)은 원판을 MBID 로 두고 note 에 적었어요. 발라드는 피아노·관현악판이 더 많이 연주돼요.
7. **같은 작품번호의 무대 작품과 모음곡**: <펠레아스와 멜리장드>·<샤일록>·<마스크와 베르가마스크>는 위키백과 문서가 가리키는 연주회용 모음곡을 다악장으로 넣고 무대판은 뺐어요. <칼리굴라> Op. 52 는 연주회용 5곡으로 출판된 것이라 다악장으로 뒀어요(SPEC 의 「부수음악은 낱곡」과 다름, seed part 5개와 맞음). <플루트 환상곡> Op. 79 도 seed part 2개(Andantino·Allegro)에 맞춰 다악장.
8. **주제와 변주 Op. 73** 은 1·2차 다수 관례대로 낱곡(변주 part 없음).
9. 바이올린 1903 소품은 MB 이름이 'Morceau de concours', 위키백과는 'Morceau de lecture' — 위키 이름을 따름.

## 5. 직접 옮긴 우리말 이름 (검수용)

- 연가곡·가곡 묶음: `연가곡집 <어느 날의 시>`(Poème d'un jour), `가곡집 <베네치아의 5개의 가곡>`, `연가곡집 <좋은 노래>`, `연가곡집 <이브의 노래>`, `연가곡집 <닫힌 정원>`, `연가곡집 <신기루>`, `연가곡집 <환상의 지평선>`, `2중창 Op. 10`
- 낱 가곡: `2중창 <황금의 눈물>`(Pleurs d'or), `가곡 <조용한 선물>`(Le don silencieux), `가곡 <샹송>`, `가곡 <평화가 왔다>`(C'est la paix !), `가곡 <멜리장드의 노래>`, `보칼리즈-에튀드`. 「Puisque j'ai mis ma lèvre」 등 4곡은 원제 그대로 `가곡 <원제>`.
- 가곡 part 우리말: `꿈을 꾼 후에`(manual 제목과 같게), `달빛`(Clair de lune), `이스파한의 장미`, `요람`(Les berceaux). 나머지는 원제.
- 피아노: `무언가 Op. 17`(Romances sans paroles), `<8개의 짧은 소품>`(Pièces brèves)과 그 곡 `카프리치오`·`환상곡`·`푸가`(Adagietto·Improvisation·Allégresse 는 원어), `피아노 소품 Op. 104`, `피아노 연탄 모음곡 <돌리>`와 1곡 `자장가`, `3성 푸가 F장조`, `왈츠 카프리스`·`뱃노래`·`즉흥곡`(운영 seed 제목에서 쓰던 말)
- 실내악: `자장가 D장조`(Berceuse), `엘레지 C단조`, `로망스`, `안단테 B♭장조`, `<나비>`(Papillon), `세레나데 B단조`, `플루트와 피아노를 위한 환상곡`, `두 대의 첼로를 위한 초견곡`, `플루트와 피아노를 위한 콩쿠르 소품`, `바이올린과 피아노를 위한 초견곡`, `하프를 위한 초견곡`, `하프를 위한 즉흥곡 D♭장조`, `하프 소품 <탑 속의 성주 부인>`
- 관현악·무대: `관현악 모음곡 F장조`, `부수음악 <칼리굴라>`(part `프롤로그. 팡파르 – 행진곡과 합창`, `춤곡`), `모음곡 <샤일록>`(part `샹송`·`간주곡`·`마드리갈`·`축혼가`·`녹턴`·`피날레`), `모음곡 <펠레아스와 멜리장드>`(part `전주곡`·`물레 잣는 여인`·`시칠리엔`·`멜리장드의 죽음`), `서정 비극 <프로메테>`, `부수음악 <행복의 베일>`, `피아노와 관현악을 위한 환상곡`, `모음곡 <마스크와 베르가마스크>`(part `서곡`·`미뉴에트`·`가보트`·`전원곡`), `오페라 <페넬로프>`, `<수난> 전주곡`
- 합창·종교: `<장 라신의 찬가>`, `합창곡 <정령들>`(Les djinns), `합창곡 <시냇물>`(Le ruisseau), `<비너스의 탄생>`, `<마드리갈>`, `모테트 Op. 47·65·67`, `<아베 마리아>`, `미사 <Messe basse>`(원어 유지), 레퀴엠 part `입당송과 키리에`·`봉헌송`

## 6. 위키백과 대조 결과

`scripts/wiki_check.py` 로 「By opus number」 121항목, 가곡 표 94행과 기계 대조했어요.

- catalog 에 없는 위키 작품번호: Op. 9·53·60·64·100(미배정), 40·49(소실·파기), 63 bis·68(편곡) — 3절 그대로.
- 위키에 없는 catalog 작품번호: 없음.
- 묶음 곡 수: 모두 같음(Op. 1–8, 10, 17, 18, 21, 23, 27, 33, 39, 43, 46, 47, 51, 56, 58, 61, 65, 67, 76, 83–85, 87, 95, 103, 104, 106, 113, 118).
- 곡 이름 차이 2: Op. 2 「Dans les ruines d'une abbaye」(위키 오타 'Dans le ruines'), Op. 10 「Tarentelle」(위키 영어식 'Tarantelle'). MB·원제를 따름.
- 가곡 표의 「작품번호/번호」 위치: 모두 catalog part 순서와 같음.
- 위키는 하위 항목이 있지만 catalog 는 낱곡: Op. 73(주제와 11변주).
- MB 와 다른 곳: MB 파반느 원본이 피아노·합창판(8acfbbf0), MB Op. 20 은 part 1개뿐, MB 에 포레 이름으로 남의 곡이 섞여 있음(「Piano Quintet op. 41·51」, 「Symphonie en la mineur op. 24」, 생상스 「Trois rhapsodies sur des cantiques bretons op. 7」 등 — seed 아님, 무시).
- 연도 차이: 위키 두 목록이 다른 것(Op. 24 1880/1883, Op. 28 1883/1877, Op. 45 1887/1885–86, Op. 77 1885/1884)은 작곡 연도 쪽을 씀.

## 부록: seed 미대응 목록

| id | 운영 제목 | 까닭 | 메모 |
|---|---|---|---|
| 777 | Un rêve | arrangement | 「꿈을 꾼 후에」 편곡 work 「Un rêve」 |
| 788 | Pavane, op, 50 | arrangement | 파반느 브라스밴드 편곡(Langford) |
| 1013 | Chanson de Mélisande, op. 159bis | arrangement | 「멜리장드의 노래」 쾨클랭 관현악 편곡 |
| 1030 | Nell, op. 18 no. 1 | arrangement | 「Nell」 그레인저 피아노 편곡 |
| 1136 | Les Berceaux, op. 23, no. 1 | arrangement | 「Les berceaux」 편곡 catch-all work |
| 1318 | Aurore, op. 39, no. 1 | arrangement | 「Aurore」 편곡 catch-all work |
| 1365 | Chant d'automne, op. 5, no. 1 | arrangement | 「Chant d'automne」 편곡 catch-all work |
| 1394 | Le Secret, op. 23, no. 3 | arrangement | 「Le secret」 편곡 catch-all work |
| 1576 | La Chanson du pêcheur (Lamento), op. 4, no. 1 | arrangement | 「Chanson du pêcheur」 편곡 catch-all work |
| 1826 | Tuscan Serenade | arrangement | 「Sérénade toscane」 그레인저 관악 편곡 |
| 1929 | Nell, op. 18, no. 1 | arrangement | 「Nell」 편곡 catch-all work |
| 2008 | Morceau de concours pour violon & piano | arrangement | 바이올린 초견곡(1903) 편곡 catch-all work |
| 2023 | 5 Mélodies, op. 58, « De Venise », no. 2. En sourdine | arrangement | 「En sourdine」 편곡 catch-all work |
| 2305 | Au cimetière, op. 51, no. 2 | arrangement | 「Au cimetière」 편곡 catch-all work |
| 2338 | Au bord de l'eau, op. 8, no. 1 | arrangement | 「Au bord de l'eau」 편곡 catch-all work |
| 2677 | Impromptu no. 6 in D-flat major, op. 86bis | arrangement | 하프 즉흥곡 Op. 86 의 코르토 피아노 편곡(「즉흥곡 6번」 Op. 86 bis) |
| 2772 | Berceuse for Violin and Orchestra, op. 16 | arrangement | 자장가 Op. 16 의 바이올린·관현악판(포레 자신, 1880) — 다른 편성 판 |
| 2893 | Romance for Violin and Orchestra, op. 28 | arrangement | 로망스 Op. 28 의 고베르 관현악 편곡 |
| 2926 | Allegro symphonique, op. 68 | arrangement | Op. 20 모음곡 1악장의 보엘만 피아노 연탄 편곡(「Allegro symphonique」 Op. 68) |
| 2980 | Requiem, op. 48: Pie Jesu | arrangement | 레퀴엠 「Pie Jesu」 색소폰·관현악 편곡(Bauch) |
| 7631 | Pavane, op. 50 | arrangement | 파반느 편곡 catch-all work |
| 676 | Pavane in F-sharp minor, op. 50 | duplicate | 파반느 manual 207 과 같은 작품(MBID 없음) |
| 1718 | Pelleas et Melisande, op. 80: The King's Three Blind Daughers (Lento) | duplicate | 「멜리장드의 노래」 영어 첫 줄 'The King's three blind daughters' work — faure-chanson-de-melisande 와 겹침 |
| 2110 | Mélisande's Song, op. posth. | duplicate | 「멜리장드의 노래」 영어 원가사 work(9804f6fe) — faure-chanson-de-melisande(seed 2944)와 겹침 |
| 2729 | Berceuse pour violon et piano op. 16 | duplicate | 자장가 Op. 16 MB 중복 work(e029d077) — faure-op16(seed 549)과 겹침 |
| 859 | Masques et bergamasques, comédie musicale en 1 acte | excluded_scope | <마스크와 베르가마스크> 1919 무대판(8곡, 대부분 옛 곡 재사용) — 카탈로그는 Op. 112 모음곡(4곡) |
| 949 | Vocalise no. 29 | excluded_scope | 「Vocalise no. 29」 — 위키백과 목록에 없음(포레의 보칼리즈는 「보칼리즈-에튀드」 1곡). 콩세르바투아르 시험용 보칼리즈로 보임 |
| 1137 | Andante (original version of Romance, op. 69) | excluded_scope | 로망스 Op. 69 의 첼로·오르간 원판 「Andante」(1894) — 옛 판 |
| 1166 | Intermède symphonique | excluded_scope | 「Intermède symphonique」 — 위키백과 목록에 없음. Op. 20 모음곡·<마스크와 베르가마스크> 서곡의 원형으로 보임 |
| 1186 | Vocalise no. 20 | excluded_scope | 「Vocalise no. 20」 — 위키백과 목록에 없음(포레의 보칼리즈는 「보칼리즈-에튀드」 1곡). 콩세르바투아르 시험용 보칼리즈로 보임 |
| 2857 | Chant funéraire | excluded_scope | 「장송곡」(1921, 관악) — 첼로 소나타 2번 2악장의 원형. 위키백과 목록에 없음 |
| 2717 | Hayalimde Mes-ut Bir Rüya | hymn_translation | 「꿈을 꾼 후에」 터키어 제목·가사판 |
| 680 | שים שלום | popular | 히브리어 가사(탈마 알리야곤)를 붙인 노래 「שים שלום」 |
| 745 | One Day | popular | <돌리> 자장가를 바탕으로 한 대중가요 「One Day」(Louis Clark 편곡) |
| 825 | The story of the universe | popular | 일본 대중가요 「The story of the universe」 |
| 832 | Viaggio | popular | 파반느를 바탕으로 한 「Viaggio」 |
| 1461 | Pavane (Allez les bleus) | popular | 파반느를 바탕으로 한 「Allez les bleus」 |
| 2244 | Pavane - Das globale Dorf | popular | 파반느에 가사를 붙인 「Das globale Dorf」 |
| 2496 | Canta Con Me ～あの日の歌 | popular | 파반느를 바탕으로 한 일본 노래 「Canta Con Me ～あの日の歌」 |
| 2734 | The Day You Strayed | popular | 파반느를 바탕으로 한 대중가요 「The Day You Strayed」 |
