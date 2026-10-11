# 말러(49) 작품 카탈로그 3차 보고서

작업 파일: `catalog.json`, `seed_map.json`, `gen_test.sql`(3차 생성기 `wave3/gen/gen_catalog.py --seed-map` 시험 변환, 오류 없음), `hide_test.sql`(`--hide-only` 시험). 스크립트는 `scripts/`
(`build.py` 가 두 JSON 을 만들고 `validate.py`·`wiki_rows.py`·`leftover_parts.py`·`map_table.py` 로 검사).
작품번호 체계가 없어 `catalogue` 는 모두 null 이에요(교향곡 번호·제목으로 구별).

## 1. 개수

- 작품 20: 다악장 11(교향곡 1–10번, <대지의 노래>), 묶음 6(가곡집 4·연가곡집 2), 낱곡 3(<블루미네>, 피아노 4중주 악장, <탄식의 노래>)
- part 93, children 27(교향곡 8번 두 부분 아래 대목)
- 생성기 시험: 새 작품 5, 새 part 82, 기존 part 갱신 38, 기존 작품 15, seed 연결 13, seed 제목 바꿈 21, 숨김 45
  - 이미 잠긴 seed 11293(「교향곡 9번 D장조」)·11933(「교향곡 3번 D단조」)은 제목을 바꾸지 않음(지금 제목이 catalog 와 같음)
- excerpt_keep: 없음(part 없이 둔 큰 작품이 없고, 아다지에토 등 대목 seed 는 모두 남의 편곡)
- seed 68: work 10 / part 13 / unmatched 45
  - unmatched 까닭: arrangement 31, duplicate 6, excluded_scope 3, popular 2, unknown 2, spurious 1
- 비교 구간이 있는 작품 9구간: manual 215·216(3)·217·218·219, seed 11293(9번)·11933(3번) — 모두 work 로 이었고 unmatched 에는 없어요.

## 2. 운영 기존 작품 대응표

manual 5개 모두 MBID 로 맞췄어요(215 → 2번, 216 → 5번, 217 → 1번, 218 → 8번, 219 → 대지의 노래).
manual 215·217·218 에 이미 있던 part(FACTS_VERIFIED, 잠김)는 MBID(part_key)로 `existingPartId` 를 적었어요.

| id | origin | 운영 제목 | catalog | 근거 | 메모 |
|---|---|---|---|---|---|
| 217 | manual | 교향곡 1번 D장조 "거인" | mahler-symphony-1 | MBID |  |
| 215 | manual | 교향곡 2번 C단조 "부활" | mahler-symphony-2 | MBID |  |
| 11933 | seed | 교향곡 3번 D단조 | mahler-symphony-3 | MBID |  |
| 11723 | seed | Symphonie n° 4 (Das immlische Leben) | mahler-symphony-4 [4] | 제목 | MBID 90bad68c 는 관계 없는 낱개 work. 제목(「천상의 삶」)으로 4번 4악장에 이음 |
| 216 | manual | 교향곡 5번 C#단조 | mahler-symphony-5 | MBID |  |
| 11368 | seed | Symphonie Nr. 6 in a-Moll | mahler-symphony-6 | MBID |  |
| 2163 | seed | Symphony no. 7 in E minor “Lied der Nacht” | mahler-symphony-7 | MBID |  |
| 218 | manual | 교향곡 8번 E♭장조 "천인 교향곡" | mahler-symphony-8 | MBID |  |
| 11929 | seed | Symphony no. 8 in E-flat major, "Symphony of a Thousand": XVI. Komm! Komm! | mahler-symphony-8 [2, 16] | 제목 | MB 관계 없는 낱개 work. 제목(8번 XVI 「Komm!」)으로 2부 n 대목에 이음 |
| 11867 | seed | Symphony no. 8 in E-flat major, "Symphony of a Thousand": XVIII. Alles Vergängliche | mahler-symphony-8 [2, 18] | 제목 | MB 관계 없는 낱개 work. 제목(8번 XVIII 「Alles Vergängliche」)으로 2부 p 대목에 이음 |
| 219 | manual | 대지의 노래 | mahler-das-lied-von-der-erde | MBID |  |
| 11293 | seed | 교향곡 9번 D장조 | mahler-symphony-9 | MBID |  |
| 2575 | seed | Symphony no. 10 in F-sharp major | mahler-symphony-10 | 제목 | MBID ce9ab8fa 는 10번 'catch-all for unknown versions'. 카탈로그 MBID 는 원본 미완성판 eff9bd21 |
| 11322 | seed | Symphonic Movement “Blumine”: Andante allegretto | mahler-blumine | MBID |  |
| 11558 | seed | Lieder für Tenor | mahler-drei-lieder | MBID |  |
| 11298 | seed | Lieder und Gesänge | mahler-lieder-und-gesaenge | MBID |  |
| 11439 | seed | Lieder aus “Des Knaben Wunderhorn” | mahler-des-knaben-wunderhorn | MBID |  |
| 11589 | seed | Des Knaben Wunderhorn : I. Der Schildwache Nachtlied | mahler-des-knaben-wunderhorn [1] | 제목 | MBID 5c37c763 는 말러 자신의 피아노 반주판(관현악판 dc081a44 의 orchestration 원본). 같은 곡으로 봄 |
| 11408 | seed | Des Knaben Wunderhorn : IV. Wer hat dies Liedlein erdacht? | mahler-des-knaben-wunderhorn [4] | 제목 | MB 관계 없는 낱개 work. 제목(분더호른 IV)으로 이음 |
| 11573 | seed | Des Knaben Wunderhorn : V. Das irdische Leben | mahler-des-knaben-wunderhorn [5] | 제목 | MB 관계 없는 낱개 work. 제목(분더호른 V)으로 이음 |
| 11684 | seed | Des Knaben Wunderhorn : VI. Des Antonius von Padua Fischpredigt | mahler-des-knaben-wunderhorn [6] | 제목 | MB 관계 없는 낱개 work. 제목(분더호른 VI)으로 이음 |
| 11968 | seed | Des Knaben Wunderhorn: VII. Rheinlegendchen | mahler-des-knaben-wunderhorn [7] | 제목 | MB 관계 없는 낱개 work. 제목(분더호른 VII)으로 이음 |
| 11854 | seed | Des Knaben Wunderhorn : IX. Wo die schönen Trompeten blasen | mahler-des-knaben-wunderhorn [9] | 제목 | MB 관계 없는 낱개 work. 제목(분더호른 IX)으로 이음 |
| 11419 | seed | Des Knaben Wunderhorn : X. Lob des hohen Verstandes | mahler-des-knaben-wunderhorn [10] | 제목 | MB 관계 없는 낱개 work. 제목(분더호른 X)으로 이음 |
| 11339 | seed | Rückert-Lieder | mahler-rueckert-lieder | MBID |  |
| 11896 | seed | Rückert Lieder : II. Ich atmet' einen linden Duft | mahler-rueckert-lieder [2] | 제목 | MB 관계 없는 낱개 work. 제목(뤼케르트 II)으로 이음 |
| 12006 | seed | Rückert Lieder : III. Ich bin der Welt abhanden gekommen | mahler-rueckert-lieder [3] | 제목 | MB 관계 없는 낱개 work. 제목(뤼케르트 III)으로 이음 |
| 11888 | seed | Rückert Lieder : V. Liebst du um Schönheit | mahler-rueckert-lieder [5] | 제목 | MB 관계 없는 낱개 work. 제목(뤼케르트 V)으로 이음 |

### 운영 중복 작품

- 교향곡 1번: manual 217(MBID 5b8cb51a) · seed 543(MBID 없음, seed part 4개가 217 과 같은 악장 MBID → duplicate) · seed 11908(1893–94 함부르크판 → excluded_scope)
- 교향곡 2번: manual 215 · seed 614(MBID 없음, part 가 215 와 같음 → duplicate) · seed 11730(발터 연탄 편곡 → arrangement)
- 교향곡 5번: manual 216 · seed 11934(연탄 편곡) · 아다지에토 편곡 seed 11549·11741·11976·11989
- 교향곡 6번: seed 11368(MBID f693fd6d, work) · seed 11438(MB 쪽 중복 work 149be723, part 없음 → duplicate) · seed 11548(연탄 편곡)
- 교향곡 8번: manual 218 · seed 11358(MBID 없음, part 33개가 218 과 같음 → duplicate)
- 교향곡 10번: seed 2575(work) · 11352(피아노 편곡) · 11954(휠러 완성판) · 11981(아다지오 편곡)
- 대지의 노래: manual 219 · seed 14073(쇤베르크·리엔 실내 편곡 → arrangement)
- 분더호른: 「Des Antonius von Padua Fischpredigt」 11684(part)·11550(duplicate), 「Wo die schönen Trompeten blasen」 11854(part)·11837(duplicate, 제목 오타)

### catalog 에 들지 않는 기존 part (그대로 남음)

- manual 218(8번) part 38460·38482·38475·38466: MB 2부 k 대목의 하위 k1–k4. catalog 는 두 겹 제한으로 k 하나(38455)만 두었어요.
- seed 11439(분더호른) seed part 19169 「Das himmlische Leben」, 18465 「Es sungen drei Engel」: 12곡 판에 들지 않는 곡(교향곡 4·3번 악장).

### 교향곡 8번 기존 part

- manual 218 의 part 33개는 모두 `parent_part_id` NULL 로 평평하게 들어가 있어요(FACTS_VERIFIED, 잠김). 3차 생성기는 FACTS_VERIFIED manual part 를 고쳐 쓰므로 두 부분(38456·38480) 아래 대목 27개에 `parent_part_id` 와 seed 11929·11867 의 `linked_piece_id` 가 들어가는 것을 gen_test.sql 에서 확인했어요. k1–k4 4개만 평평한 채 남아요.

## 3. 뺀 것과 까닭

- 소실(9): 오페라 <에른스트 폰 슈바벤 공작>·<아르고 원정대>·<뤼베찰>, 부수음악 <제킹겐의 나팔수>(1곡만 <블루미네>로 남음 → <블루미네>만 넣음), 바이올린 소나타, 피아노 5중주, 피아노 모음곡, 학생 교향곡, 교향곡 A단조. seed 11450 「Polka mit einem Trauermarsch als Einleitung」(어린 시절 소실작)도 여기.
- 단편(2): 피아노 4중주 G단조 스케르초 단편(약 36마디), 가곡 단편 2곡(1876–79).
- 남의 작품 편곡·완성(다수): 베버 <세 명의 핀토> 완성, 바흐 모음곡·베토벤·슈만 교향곡 재관현악, 베토벤 현악 4중주 11번·슈베르트 <죽음과 소녀> 현악 합주 편곡, 브루크너 3번 피아노 2대 편곡 등(MB 에 말러 이름으로 올라 있음).
- 옛 판(3): 교향시 <장례제전>(1888, 2번 1악장의 원형, seed 11369), 교향곡 1번 1889 교향시 「티탄」판·1893–94 함부르크판(seed 11908), <탄식의 노래> 1880 원판(3부) — 같은 작품이라 따로 넣지 않고 note 에만.
- 교향곡 악장이 된 분더호른 노래(3): 「Urlicht」(2번 4악장), 「Es sungen drei Engel」(3번 5악장), 「Das himmlische Leben」(4번 4악장). 독립 작품으로 두지 않음.
- 위작 의심(1): <교향적 전주곡>(seed 11532).
- 10번의 다른 사람 완성판(쿡 I–III, 휠러, 카펜터, 마체티, 바르샤이, 사말레·마추카, 감주): 10번 하나로 두고 완성판은 따로 넣지 않음.

## 4. 애매했던 판단

1. **교향곡 10번**(미완성)을 다악장 5악장으로 넣었어요. 말러가 5악장 초고를 끝까지 썼고 아다지오는 총보까지 완성, 연주는 아다지오 단독이나 쿡 연주판이 관례라 SPEC 의 「연주 관례가 확고한 미완성」으로 봤어요. 카탈로그 MBID 는 MB 의 원본 미완성판(eff9bd21, part 는 I·III 두 개만)이라 II·IV·V 악장 MBID 는 null 이에요. work 로 잇는 seed 는 2575(MB 'catch-all for unknown versions')이고, 휠러 완성판 seed 11954 는 arrangement 로 뺐어요.
2. **피아노 4중주 악장 A단조**(1876)를 낱곡으로 넣었어요. 작품 전체는 미완성이지만 1악장은 완결된 악장이고 위키백과 「남은 작품 요약」에 올라 있어요. SPEC 의 「미완성 단장」을 엄격히 보면 빼야 해요.
3. **분더호른 12곡**: 1899 「유머레스크」판(10곡 + 「Es sungen drei Engel」·「Urlicht」)이 아니라 1901년 이후 판(10곡 + 「Revelge」·「Der Tamboursg'sell」)을 따랐어요. MB 는 14곡(+「Das himmlische Leben」)을 parts 로 묶어 둬서 위키백과 쪽을 따랐어요. 「Revelge」·「Der Tamboursg'sell」은 1905 「최근의 일곱 가곡」으로 처음 출판돼 뤼케르트 가곡과 묶이기도 해요.
4. **교향곡 8번**: 두 부분(Teil)을 part, MB 대목을 children 으로 넣었어요(seed 대목 2개를 잇기 위해). MB 의 k 대목 아래 k1–k4 는 두 겹 제한으로 k 하나로 합쳤어요. 대목 이름은 가사 첫머리 원어.
5. **교향곡 6번 가운데 악장 순서**: MB work f693fd6d(seed 11368)와 국제말러협회 비평판을 따라 Andante(II)–Scherzo(III)로 뒀어요. 초판·많은 음반은 Scherzo–Andante.
6. **<블루미네>**: 교향곡 1번 초기판의 2악장이었다가 빠진 악장. 「옛 판」이 아니라 빠진 악장이고 위키백과에 따로 올라 있어 낱곡으로 넣었어요.
7. **<탄식의 노래>** MBID 는 마지막 판(1898 개정 2부, 15911087). 요즘은 1880 원판 3부도 자주 연주돼요.
8. seed 가곡 대부분이 MBID 로는 남의 관현악 편곡(베리오·Byrns·매슈스·쇤베르크·고트발트)이라 arrangement 로 뺐어요. 특히 **seed 15066 「Lieder eines fahrenden Gesellen」(링크 있음)·14073 「Das Lied von der Erde」(링크 있음)** 은 쇤베르크 실내 편곡 MBID 라 arrangement 예요. 숨기면 링크도 같이 숨어요.
9. seed 11979(MB 'UNUSED' 표시, 5번 1부 두 악장 이름을 이어 붙인 제목)와 11601 「Mahler Neu (n)」(MB 정보가 작곡자뿐)은 unknown.
10. 분더호른·뤼케르트·8번 대목 seed 13개 중 11개는 MB 관계 없는 낱개 work 라 제목(로마 숫자 번호 포함)으로 이었어요. 11589 는 말러 자신의 피아노 반주판 work 라 같은 곡으로 봤어요.

## 5. 직접 옮긴 우리말 이름 (검수용)

- 작품: `가곡집 <젊은 날의 노래>`(Lieder und Gesänge, 한국어 위키백과 이름), `테너를 위한 3개의 가곡`, `피아노 4중주 악장 A단조`, `교향적 악장 <블루미네>`, `칸타타 <탄식의 노래>`(한국어 위키백과), `연가곡집 <방랑하는 젊은이의 노래>`(리드 지정, 한국어 위키는 '방황하는'), `연가곡집 <죽은 아이를 그리는 노래>`, `가곡집 <뤼케르트 가곡>`, `가곡집 <어린이의 이상한 뿔피리>`, 6번 `"비극적"`·7번 `"밤의 노래"`(한국어 위키백과 별명)
- 악장 갈래어: `장송 행진곡`(Trauermarsch), `밤의 음악 I`·`밤의 음악 II`(Nachtmusik), `론도-피날레`, `론도-부를레스케`, `스케르초`, `피날레`
- 8번: `제1부: 찬가 "Veni, creator spiritus"`, `제2부: 괴테 <파우스트>의 마지막 장면`, 대목 `(독창진)`·`(재현)`
- 가곡 우리말: `나는 세상에서 잊혀지고 (Ich bin der Welt abhanden gekommen)` 하나만. 나머지 가곡·<대지의 노래> 악장은 원제 그대로.

## 6. 위키백과 대조 결과

`List of compositions by Gustav Mahler` 의 작품 표 66행을 `scripts/wiki_rows.py` 로 뽑아 하나씩 대조했어요.

- 넣은 것: 교향곡 1–10번(악장 수 1번 4·2번 5·3번 6·4번 4·5번 5·6번 4·7번 5·9번 4 — 위키 비고와 같음, 8번 두 부분), <대지의 노래>, <탄식의 노래>, <블루미네>, 피아노 4중주 a-Moll(1악장), 테너를 위한 3곡, 젊은 날의 노래 14곡(위키 표의 개별 14행과 같은 곡·같은 순서, Lieder und Gesänge 문서의 1–3권 순서), 방랑하는 젊은이의 노래 4곡, 분더호른 개별 15행 중 12곡(나머지 3곡은 교향곡 악장), 뤼케르트 5곡, 죽은 아이를 그리는 노래 5곡.
- 뺀 것: 3절 그대로(소실 9행, 단편 2행, <세 명의 핀토>, <장례제전>).
- MB 와 다른 곳: 분더호른(MB 14곡 vs 위키 12곡), 교향곡 6번 MB 쪽 work 3개(f693fd6d·7ddd907e·149be723) 중복, 10번 MB 원본판 part 2개뿐.

## 부록: seed 미대응 목록

| id | 운영 제목 | 까닭 | 메모 |
|---|---|---|---|
| 1056 | What the Wild Flowers Tell Me | arrangement | 교향곡 3번 2악장의 브리튼 편곡 「What the Wild Flowers Tell Me」 |
| 7996 | Eight Early Songs | arrangement | 베리오 관현악 편곡 「Eight Early Songs」(젊은 날의 노래에서 8곡) |
| 8549 | Des Knaben Wunderhorn: Ablösung im Sommer | arrangement | 「Ablösung im Sommer」 베리오 관현악 편곡 |
| 8672 | Hans und Grete | arrangement | 「Hans und Grete」 관현악 편곡 work(MB orchestration) |
| 9114 | Nicht Wiedersehen! | arrangement | 「Nicht wiedersehen!」 베리오 관현악 편곡 |
| 9153 | Scheiden und Meiden | arrangement | 「Scheiden und Meiden」 관현악 편곡 work(MB orchestration) |
| 9383 | Um schlimme Kinder artig zu machen | arrangement | 「Um schlimme Kinder artig zu machen」 관현악 편곡 work(MB orchestration) |
| 9719 | Phantasie | arrangement | 「Phantasie aus Don Juan」 관현악 편곡 work(MB orchestration) |
| 9866 | Ich ging mit Lust durch einen grünen Wald | arrangement | 「Ich ging mit Lust durch einen grünen Wald」 베리오 관현악 편곡 |
| 10678 | Frühlingsmorgen | arrangement | 「Frühlingsmorgen」 관현악 편곡 work(MB orchestration) |
| 11150 | Fünf frühe Lieder: Nr. 2. Zu Strassburg auf der Schanz' | arrangement | 베리오 관현악 편곡 「5개의 초기 가곡」 2번 「Zu Straßburg auf der Schanz'」 |
| 11217 | Erinnerung | arrangement | 「Erinnerung」 관현악 편곡 work(MB orchestration) |
| 11352 | 10. Sinfonie | arrangement | 교향곡 10번 피아노 편곡(MB 'piano arrangement') |
| 11530 | Des Knaben Wunderhorn: Um schlimme Kinder artig zu machen | arrangement | 「Um schlimme Kinder artig zu machen」 Byrns 관현악 편곡 |
| 11534 | Neun Lieder und Gesänge aus “Der Knaben Wunderhorn” | arrangement | MB 가 분더호른 가곡의 편곡으로 묶은 work(젊은 날의 노래 2·3권 9곡). 카탈로그는 mahler-lieder-und-gesaenge |
| 11548 | Symphony no. 6 | arrangement | 교향곡 6번 피아노 연탄 편곡(MB 451b4232) |
| 11549 | Adagietto From Symphony no. 5 | arrangement | 교향곡 5번 아다지에토 J. Nurse 피아노 5중주 편곡 |
| 11591 | Urlicht | arrangement | 「원광」 고트발트 무반주 합창 편곡 |
| 11707 | Des Knaben Wunderhorn: Frühlingsmorgen | arrangement | 「Frühlingsmorgen」 Byrns 관현악 편곡 |
| 11730 | Symphony no. 2 in C minor | arrangement | 교향곡 2번 브루노 발터 피아노 연탄 편곡 |
| 11741 | Adagietto aus der 5. Symphonie | arrangement | 교향곡 5번 아다지에토 바이올린·피아노 편곡(Wittinger) |
| 11815 | Die zwei blauen Augen | arrangement | 「Die zwei blauen Augen」 고트발트 합창 편곡 |
| 11931 | Lieder und Gesänge Vol. III 11. Ablösung im Sommer | arrangement | 「Ablösung im Sommer」 콜린·데이비드 매슈스 관현악 편곡 |
| 11934 | Symphony no. 5 (arr. for piano 4 hands) | arrangement | 교향곡 5번 피아노 연탄 편곡 |
| 11954 | Symphony no. 10 in F-sharp minor | arrangement | 교향곡 10번 휠러 완성판(1966) — 다른 사람의 완성판 |
| 11963 | Des Knaben Wunderhorn: Selbstgefühl | arrangement | 「Selbstgefühl」 Byrns 관현악 편곡 |
| 11976 | Super‐Adagietto. Intermezzo VIII | arrangement | 교향곡 5번 아다지에토를 바탕으로 한 스기야마 요이치 편곡 |
| 11981 | Symphony no. 10 in F‐sharp minor: I. Adagio | arrangement | 교향곡 10번 아다지오 편곡 catch-all work |
| 11989 | Im Abendrot | arrangement | 교향곡 5번 아다지에토의 고트발트 합창 편곡 「Im Abendrot」(R. 슈트라우스 곡 아님) |
| 14073 | Das Lied von der Erde | arrangement | 대지의 노래 쇤베르크(·리엔) 실내 관현악 편곡. 원곡은 manual 219 |
| 15066 | Lieder eines fahrenden Gesellen | arrangement | 방랑하는 젊은이의 노래 쇤베르크 실내 앙상블 편곡. 원곡은 mahler-lieder-eines-fahrenden-gesellen |
| 543 | Symphony no. 1 in D major “Titan” | duplicate | 교향곡 1번 manual 217 과 같은 작품(MBID 없음, seed part 가 217 과 같은 악장 MBID) |
| 614 | Symphony no. 2 “Resurrection” | duplicate | 교향곡 2번 manual 215 와 같은 작품(MBID 없음, seed part 가 215 와 같은 악장 MBID) |
| 11358 | Symphony no. 8 “Symphony of a Thousand” | duplicate | 교향곡 8번 manual 218 과 같은 작품(MBID 없음, seed part 33개가 218 과 같음) |
| 11438 | Symphonie Nr. 6 | duplicate | 교향곡 6번 MB 중복 work(149be723, part 없음) — mahler-symphony-6(seed 11368)과 겹침 |
| 11550 | Des Antonius von Padua Fischpredigt | duplicate | 「Des Antonius von Padua Fischpredigt」 — 분더호른 6번(seed 11684)과 겹침 |
| 11837 | Wo die shönen Trompeten blasen | duplicate | 「Wo die schönen Trompeten blasen」(제목 오타) — 분더호른 9번(seed 11854)과 겹침 |
| 11369 | Totenfeier | excluded_scope | 교향시 「장례제전」(1888) — 교향곡 2번 1악장의 옛 판이라 뺌 |
| 11450 | Polka mit einem Trauermarsch als Einleitung | excluded_scope | 어린 시절 작품(소실, 악보 전하지 않음) |
| 11908 | Symphony no. 1 in D major "Titan" | excluded_scope | 교향곡 1번 1893–94 함부르크판(5악장, 블루미네 포함) — 옛 판이라 뺌. 최종판은 manual 217 |
| 11379 | The Timeless Moment | popular | Roger Webb 편곡·Norman Newell 가사의 1971년 대중가요 「The Timeless Moment」 |
| 11383 | Adieu | popular | 일본 대중가요(작사 宝野アリカ) 「Adieu」 |
| 11532 | Symphonisches Praeludium | spurious | 「교향적 전주곡」 — 말러 작품 여부 불확실(브루크너·크시자노프스키설), 귀르싱 복원 |
| 11601 | Mahler Neu (n) | unknown | 「Mahler Neu (n)」 — MB 정보가 작곡자뿐. 제목으로는 말러 곡의 재해석으로 보임 |
| 11979 | Symphony no. 5, I. Abteilung: Wie ein Kondukt. Stürmisch bewegt. Mit größter Vehemenz | unknown | MB 가 UNUSED 로 표시한 work. 제목이 5번 1부(1·2악장)를 한데 가리켜 한 악장에 잇지 않음 |
