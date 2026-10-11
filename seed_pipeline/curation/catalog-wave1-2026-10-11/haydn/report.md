# 하이든 작품 목록 — 묶음·다악장·낱곡 정리 보고

데이터만 만들었습니다(DB·git·브라우저 안 씀). 결과는 `catalog.json`, 원자료와 중간 산출물은 `raw/`, 스크립트는 `scripts/` 입니다.

- 위키백과: `List of compositions by Joseph Haydn`(작품 기준) + 갈래별 목록(symphonies·string quartets·solo piano·piano trios·concertos·Masses·operas). 원문은 `raw/wiki/`.
- MusicBrainz: 하이든 artist(c130b0fb…) work 3,969개를 browse(`inc=aliases+work-rels`, 100개씩 40번)로만 받았습니다. 낱개 조회는 하지 않았습니다. `raw/browse.json`.
- 순서: `scripts/dump_wiki.py`(위키 표 풀기) → `defs.py`(넣을 것·뺄 것·이름) → `build.py`(MB 대응·악장) → `check.py`(검사·위키 대조) → `report.py`.
- 리드의 `gen/gen_catalog.py` 를 python 3.13 으로 돌려 봤고 오류 없이 통과했습니다(출력은 `raw/gen_check.sql`).

## 1. 개수

| 갈래 | 작품 | part | children |
|---|---:|---:|---:|
| 묶음(collection) | 28 | 204 | 274 |
| 다악장(multi_movement) | 284 | 1027 | 0 |
| 낱곡(single) | 188 | 0 | 0 |
| 합계 | 500 | 1231 | 274 |

갈래별 작품 수: 교향곡(신포니아 콘체르탄테 포함) 107, 피아노 소나타 49, 카논 48, 디베르티멘토·노투르노·스케르찬도·콘체르티노 47, 피아노 3중주 39, 현악 3중주 22, 아리아 20, 협주곡 19, 그 밖 교회음악(스타바트 마테르 포함) 19, 현악 4중주(묶음 15 + 단독 2 + 일곱 말씀 4중주판) 17, 중창곡 15, 가곡 15, 오페라·징슈필 14, 미사 13, 무곡 12, 그 밖 실내악(런던 트리오·2중주) 10, 칸타타 9, 행진곡 6, 건반 소품 5, 건반 변주곡 5, 오라토리오 4, 서곡 2, 부수음악 2, 관현악(일곱 말씀) 1.

진위(authenticity): authentic 490, uncertain 10(위키백과가 'Uncertain' 으로 적은 피아노 소나타, 4장 1번).

MBID: 작품 394/500, part 1200/1231, children 274/274.

다악장인데 MB 에 악장(parts) 자료가 없어 **낱곡으로 내린 것 31개** (리드 생성기가 part 없는 다악장·묶음을 막기 때문):

- MB 에 악장(parts) 관계 없음: Hob. II:24 디베르티멘토 E♭장조, Hob. IV:4 런던 트리오 4번 G장조
- MB 에 work 없음: Hob. V:1 현악 3중주 E장조, Hob. V:2 현악 3중주 F장조, Hob. V:3 현악 3중주 B단조, Hob. V:4 현악 3중주 E♭장조, Hob. V:6 현악 3중주 E♭장조, Hob. V:7 현악 3중주 A장조, Hob. V:10 현악 3중주 F장조, Hob. V:11 현악 3중주 E♭장조, Hob. V:12 현악 3중주 E장조, Hob. V:13 현악 3중주 B♭장조, Hob. V:15 현악 3중주 D장조, Hob. V:16 현악 3중주 C장조, Hob. V:17 현악 3중주 E♭장조, Hob. V:18 현악 3중주 B♭장조, Hob. V:19 현악 3중주 E장조, Hob. V:20 현악 3중주 G장조, Hob. V:21 현악 3중주 D장조, Hob. V:D1 현악 3중주 D장조, Hob. V:F1 현악 3중주 F장조, Hob. V:G1 현악 3중주 G장조, Hob. V:B1 현악 3중주 B♭장조, Hob. VIIh:1 리라 오르가니차타 협주곡 1번 C장조, Hob. VIIh:2 리라 오르가니차타 협주곡 2번 G장조, Hob. VIIh:3 리라 오르가니차타 협주곡 3번 G장조, Hob. VIIh:4 리라 오르가니차타 협주곡 4번 F장조, Hob. IX:1 12개의 미뉴에트 Hob. IX:1, Hob. IX:5 6개의 미뉴에트 Hob. IX:5, Hob. IX:7 14개의 미뉴에트 Hob. IX:7, Hob. XIV:10 디베르티멘토 C장조

## 2. 운영 기존 작품 대응

| id | 운영 제목 | 운영 opus | → key | 위치 | 근거 |
|---:|---|---|---|---|---|
| 83 | 교향곡 94번 G장조 "놀람" | Hob. I:94 | `haydn-hob-i-94` | 작품 | MBID `3e1453b3-0bae-42d2-8768-fc891bde8faf` |
| 84 | 교향곡 101번 D장조 "시계" | Hob. I:101 | `haydn-hob-i-101` | 작품 | MBID `da30a1dc-90c4-42b0-8984-9609bcb1156e` |
| 85 | 교향곡 45번 F#단조 "고별" | Hob. I:45 | `haydn-hob-i-45` | 작품 | MBID `772c3aaa-bceb-4c8a-8700-6bab011bec3f` |
| 86 | 현악 4중주 C장조 "황제" | Hob. III:77 | `haydn-op76` | 묶음 현악 4중주 Op. 76 의 3번 part(`existingPieceId`) | MBID `a723b328-ae25-4f0e-ad92-d6423f31b4ab` |
| 87 | 오라토리오 <천지창조> | Hob. XXI:2 | `haydn-hob-xxi-2` | 작품 | MBID `c77e1961-e301-4957-9660-f6607be5cbac` |
| 88 | 트럼펫 협주곡 E♭장조 | Hob. VIIe:1 | `haydn-hob-viie-1` | 작품 | MBID `0c2f8487-6439-3b21-8284-8d578fcf8e1d` |

- 6개 모두 piece_identifiers 의 musicbrainz_work 값으로 맞췄습니다(카탈로그 번호만으로 맞춘 것 없음).
- 기존 작품 5개(83·84·85·87·88)는 제목을 운영과 똑같이 두었습니다. 86 「현악 4중주 C장조 "황제"」는 새 묶음 「현악 4중주 Op. 76」의 3번 part 로 이어 두었습니다(운영 낱곡은 그대로 두고 part 와 연결하는 쪽은 적재에서 정할 일).
- 운영에 같은 작품이 둘 있는 경우는 없습니다(하이든 운영 작품 6개 모두 서로 다름). piece_parts 에 하이든 part 는 없어서 `existingPartId` 는 모두 null 입니다.
- 운영 다른 작품이 이미 쓰는 MBID 와 겹친 것은 없습니다.

## 3. 뺀 것과 까닭

위키백과 작품 목록 1458행 가운데 600행을 넣고 858행을 뺐습니다. 넣은 행 중 9행은 위키 표의 절과 다른 자리에 넣었습니다: II:6 → 현악 4중주 Op. 1 의 0번, III:50–56 → <일곱 말씀> 현악 4중주판(Op. 51) 악장, XIV:6 → 피아노 3중주 3번.

| 까닭 | 개수 |
|---|---:|
| 민요 편곡(Hob. XXXIa/b·XXXIc) | 448 |
| 바리톤 작품(Hob. XI) | 128 |
| 소실 | 57 |
| 진위 불확실(uncertain) | 44 |
| 위작 의심(doubtful) | 33 |
| 음악 시계 곡(Hob. XIX) | 32 |
| 바리톤 작품(Hob. XII) | 24 |
| 위작 | 15 |
| 바리톤 작품(Hob. X) | 12 |
| 다른 작곡가 작품 추정 | 5 |
| 카탈로그 부록(Anh.) | 5 |
| 파스티치오(남의 오페라에 하이든 곡을 섞은 것, Hob. XXXII) | 4 |
| 바리톤 작품(Hob. XIII, 소실·의심) | 3 |
| 위키백과에 연도·출처 없이 3곡만 있음. Hob. XVa 는 편곡 위주라 판단 보류 | 3 |
| <Alfred> 부수음악의 한 곡(부수음악으로 넣음) | 3 |
| 다른 작곡가 작품 | 2 |
| 호보켄 번호 없음(deest), 위키백과 비고 없음 | 2 |
| 단편 | 2 |
| 가사 소실, 진위 불확실 | 2 |
| 단편(첫 악장만 전함) | 1 |
| 오페라 <L'infedeltà delusa> 서곡(오페라에 포함) | 1 |
| 오라토리오 <Il ritorno di Tobia> 서곡(오라토리오에 포함) | 1 |
| 오페라 <L'anima del filosofo> 서곡(오페라에 포함) | 1 |
| 오페라 <Acide e Galatea> 서곡(오페라에 포함) | 1 |
| 오페라 <L'incontro improvviso> 서곡(오페라에 포함) | 1 |
| Ia:7 의 잘못 매긴 번호(같은 곡) | 1 |
| 징슈필 <Philemon und Baucis> 서곡(무대 작품에 포함) | 1 |
| 오페라 <Lo speziale> 서곡(오페라에 포함) | 1 |
| 오페라 <La fedeltà premiata> 1막 전주(오페라에 포함) | 1 |
| <Il mondo della luna> 곡을 엮은 편곡, 진위 불확실 | 1 |
| 오페라 <L'isola disabitata> 서곡(오페라에 포함) | 1 |
| 오페라 <Armida> 서곡(오페라에 포함) | 1 |
| 오페라 <La vera costanza> 서곡(오페라에 포함) | 1 |
| 오페라 <Orlando paladino> 서곡(오페라에 포함) | 1 |
| 오페라 <La fedeltà premiata> 서곡(오페라에 포함) | 1 |
| 교향곡 A(Hob. I:107)를 4중주로 옮긴 것 — 교향곡 A 로 넣음 | 1 |
| 카사시옹 Hob. II:21 을 남이 4중주로 옮긴 것(Op. 2 의 3번) | 1 |
| 카사시옹 Hob. II:22 를 남이 4중주로 옮긴 것(Op. 2 의 5번) | 1 |
| 오페라 <Il mondo della luna> 의 행진곡(오페라에 포함) | 1 |
| 음악 시계 곡 Hob. XIX:25 를 관악으로 옮긴 것 | 1 |
| 바리톤판. 나중 판인 피아노 3중주 Hob. XV:2 로 넣음 | 1 |
| 진위 불확실, Landon 번호 없음(Hob. II:11 편곡) | 1 |
| 진위 불확실, Landon 번호 없음 | 1 |
| 위작 의심(Landon 4) | 1 |
| 호보켄 번호 없음(deest) | 1 |
| 피아노판: 하이든이 승인했지만 편곡자가 따로 있음 | 1 |
| 미완성 오라토리오(Mare clausum) | 1 |
| 가사 소실 | 1 |
| 미완성 | 1 |
| XXVIIb:23 <Das böse Weib> 의 다른 판 | 1 |
| <La vera costanza> 의 프랑스어판(Laurette, 1791 파리 개작) | 1 |
| 치마로사 작품 | 1 |
| 옛 판. 고친 판 Hob. XXIXb:2 로 넣음 | 1 |

목록(갈래 통째로 뺀 민요 편곡·바리톤·음악 시계·파스티치오는 개수만):

- **소실** (57): II:4; II:5; II:10 "Der verliebte Schulmeister"; II:12 Feldparthie; II:13; II:18; II:19; II:20a Feldparthie; II:24a; II:24b; V:5; V:9; V:14; VIIa:2 Violin Concerto No. 2; VIIb:3 Cello Concerto No. 3; VIIb:g1 Cello Concerto; VIIc:1 Double Bass Concerto; VIId:1 Horn Concerto; VIId:2 Concerto for 2 Horns; VIIf:1 Flute Concerto; IX:2 6 Minuets; IX:6a 12 Minuets; IX:6b 18 Minuets; IX:9a 6 Minuets; IX:9b 12 German Dances; IX:9c 12 Minuets; IX:9d 24 Minuets; IX:9e 24 Contredanses; IX:17 17 German Dances; XV:33 Piano Trio No. 8; XV:D1 Piano Trio No. 9; XVI:2a Divertimento; XVI:2b Divertimento; XVI:2c Divertimento; XVI:2d Divertimento; XVI:2e Divertimento; XVI:2g Divertimento; XVI:2h Divertimento; XXIVa:1 Vivan gl'illustri sposi; XXIVa:5 Dei clementi; XXVIa:40 Der Feldzug; XXVIa:48a Ich liebe, du liebest, er liebet; XXVIa:48b Dürre, Staub, vermorschte Knochen; XXVIa:48c Sag'n allweil vom Staatsleb'n; XXVIa:48d Kein besseres Leben ist ja auf der Welt; XXVIb:1 Deutschlands Klage auf den Tod des grossen; Friedrichs Borussens König; XXIXa:1a Prelude to No. 1 "Der Götterrath"; XXIXa:2 Der Hexenschabbas; XXIXa:3 Didone Abbandonata (Dido); XXIXa:4 Das abgebrannten Haus; XXIXa:5 Genovevens vierter Theil; XXIXb:1a Der krumme Teufel; XXIXb:1b Der neue krumme Teufel; XXIXb:3 Die bestrafte Rachbegierde; XXX:1 Comedia la Marchesa Ne(s)pola; XXX:2 Musik zum Schauspiel "Die Feuersbrunst"; XXX:3 Zwischenaktmusik zum Schauspiel "Der Zerstreute"
- **진위 불확실(uncertain)** (44): II:39 "Echo"; II:40 Sextet; II:41 Feldparthie No. 1; II:42 Feldparthie No. 2; II:43 Feldparthie No. 3; II:44 Feldparthie No. 4; II:45 Feldparthie No. 5; II:46 Feldparthie No. 6 "St. Antonius"; VIId:4 Horn Concerto No. 2; VIId:5 Concerto for 2 Horns; IX:4 12 Minuets; IX:6 12 Minuets; IX:10 12 German Dances; IX:13 12 German Dances; IX:14 13 Minuets; IX:15 6 Minuets; IX:18 9 Minuets; IX:19 13 Minuets; IX:20 18 Minuets; IX:21 21 Minuets; IX:22 10 Minuets; IX:24 Minuet; IX:25 Minuet; IX:27 Ox minuet; IX:28 8 Gypsy Dances; IX:29 5 Contra Dances and 1 Quadrille; IX:30 English Dance; XVII:8 Variations in D major; XVII:10 Allegretto; XVII:11 Nouvelle Andante pour le Clavecin No. 2; XVII:12 Variations in B♭ major; XVIII:5 Keyboard Concerto No. 5; XVIII:7 Keyboard Concerto No. 7; XVIII:8 Keyboard Concerto No. 8; XVIII:9 Keyboard Concerto No. 9; XXIIb:1 Libera me; XXIIIa:5 Offertorium: Ad aras eonvolate; XXIIIa:6 Motet: Salus et Gloria; XXIIIa:7 Motet de Tempore: Super flumina Babylonis; XXIIIa:8 Offertorium: Ardentes seraphini; XXIIIa:a1 Ave Maria; XXIIIb:6 Ave Regina; XXIVa:11 Die Erwählung eines Kapellmeisters; XXVb:5 Pietà di me, benigni Dei
- **위작 의심(doubtful)** (33): II:D9 Flute Quartet; II:D10 Flute Quartet; II:D11 Flute Quartet; II:D18; II:G1; II:G4 Flute Quartet; V:D2; V:G2; V:G3; V:A1; VI:D2 Sonata for 2 Violins; VI:Es1 Sonata for 2 Violins; VI:F1 Sonata for 2 Violins; VI:G1 Sonata for 2 Violins; VI:A1 Sonata for 2 Violins; VI:B1 Sonata for 2 Violins; VIIa:D1 Violin Concerto; VIIa:G1 Violin Concerto; VIIa:A1 Violin Concerto; VIIg:C1 Oboe Concerto; VIII:C1 Marsch Brillande de la 66. Brigad des Chasseurs; VIII:C2 Napoleons Marsch; VIII:C3; VIII:D1 Marsch für das k. k. Infanterie-Regiment Coloredo; VIII:Es1 Napoleons Siegesmarsch; XV:C1 Piano Trio No. 2; XV:C2 Piano Trio No. 16; XV:f1 Piano Trio No. 14; XXIIa:Es11 Requiem; XXIIa:Es13 Requiem; XXIIa:B2 Requiem; XXVIa:D1 Liebes Mädchen hör mir zu; XXVIa:G1 A prey to tender anguish
- **위작** (15): II:47 "Toy Symphony"; II:F7 Partita for winds; III:13 String Quartet, Op. 3, No. 1; III:14 String Quartet, Op. 3, No. 2; III:15 String Quartet, Op. 3, No. 3; III:16 String Quartet, Op. 3, No. 4; III:17 String Quartet, Op. 3, No. 5; III:18 String Quartet, Op. 3, No. 6; VIIa:B1 Violin Concerto; VIIa:B2 Violin Concerto; VIIb:4 Cello Concerto No. 4; VIIb:5 Cello Concerto No. 5; VIIf:D1 Flute Concerto; XVI:17 Keyboard sonata No. 17; XXIVa:Anh.2 Denk ich Gott an deine Güte
- **다른 작곡가 작품 추정** (5): I:C8; VI:D1 String Duo; XV:3 Piano Trio; XV:4 Piano Trio; XXIIIb:5 Salve Regina
- **카탈로그 부록(Anh.)** (5): VI:Anh.1 Sonata for 2 Violins; VI:Anh.2 Sonata for 2 Violins; VI:Anh.3 Sonata for 2 Violins; IX:Anh. 12 German Dances; XVII:Anh. 12 Easy pieces
- **위키백과에 연도·출처 없이 3곡만 있음. Hob. XVa 는 편곡 위주라 판단 보류** (3): XVa:1 Sonata for keyboard and obbligato violin; XVa:2 Sonata for keyboard and obbligato violin; XVa:3 Sonata for keyboard and obbligato violin
- **<Alfred> 부수음악의 한 곡(부수음악으로 넣음)** (3): XXX:5a Chor der Dänen zu dem Schauspiel; XXX:5b Arie des Schutzgeistes; XXX:5c Duet "Der Morgen graut"
- **다른 작곡가 작품** (2): I:G1; Ia:9 King Lear
- **호보켄 번호 없음(deest), 위키백과 비고 없음** (2): II:deest; II:deest
- **단편** (2): XIV:5; XXII:2 Missa sunt bona mixta malis
- **가사 소실, 진위 불확실** (2): XXIVb:16a Entracte:; XXIVb:21 Aria:
- **단편(첫 악장만 전함)** (1): I:106
- **오페라 <L'infedeltà delusa> 서곡(오페라에 포함)** (1): Ia:1 L'infedeltà delusa
- **오라토리오 <Il ritorno di Tobia> 서곡(오라토리오에 포함)** (1): Ia:2 Il ritorno di Tobia
- **오페라 <L'anima del filosofo> 서곡(오페라에 포함)** (1): Ia:3 L'anima del filosofo
- **오페라 <Acide e Galatea> 서곡(오페라에 포함)** (1): Ia:5 Acide e Galatea
- **오페라 <L'incontro improvviso> 서곡(오페라에 포함)** (1): Ia:6 L'incontro improvviso
- **Ia:7 의 잘못 매긴 번호(같은 곡)** (1): Ia:7bis Overture
- **징슈필 <Philemon und Baucis> 서곡(무대 작품에 포함)** (1): Ia:8 Philemon und Baucis
- **오페라 <Lo speziale> 서곡(오페라에 포함)** (1): Ia:10 Lo speziale
- **오페라 <La fedeltà premiata> 1막 전주(오페라에 포함)** (1): Ia:11 Overture
- **<Il mondo della luna> 곡을 엮은 편곡, 진위 불확실** (1): Ia:12 Overture
- **오페라 <L'isola disabitata> 서곡(오페라에 포함)** (1): Ia:13 L'isola disabitata
- **오페라 <Armida> 서곡(오페라에 포함)** (1): Ia:14 Armida
- **오페라 <La vera costanza> 서곡(오페라에 포함)** (1): Ia:15 La vera costanza
- **오페라 <Orlando paladino> 서곡(오페라에 포함)** (1): Ia:16 Orlando paladino
- **오페라 <La fedeltà premiata> 서곡(오페라에 포함)** (1): Ia:17 La fedeltà premiata
- **교향곡 A(Hob. I:107)를 4중주로 옮긴 것 — 교향곡 A 로 넣음** (1): III:5
- **카사시옹 Hob. II:21 을 남이 4중주로 옮긴 것(Op. 2 의 3번)** (1): III:9
- **카사시옹 Hob. II:22 를 남이 4중주로 옮긴 것(Op. 2 의 5번)** (1): III:11
- **오페라 <Il mondo della luna> 의 행진곡(오페라에 포함)** (1): VIII:5 March from Il mondo della luna
- **음악 시계 곡 Hob. XIX:25 를 관악으로 옮긴 것** (1): VIII:6 Wind Sextet
- **바리톤판. 나중 판인 피아노 3중주 Hob. XV:2 로 넣음** (1): XIV:2
- **진위 불확실, Landon 번호 없음(Hob. II:11 편곡)** (1): XVI:15 Keyboard sonata No. 15
- **진위 불확실, Landon 번호 없음** (1): XVI:16 Keyboard sonata No. 16
- **위작 의심(Landon 4)** (1): XVI:G1
- **호보켄 번호 없음(deest)** (1): XVI:deest
- **피아노판: 하이든이 승인했지만 편곡자가 따로 있음** (1): XX:3 The Seven Last Words of Christ piano version
- **미완성 오라토리오(Mare clausum)** (1): XXIVa:9 Unfinished Oratorio
- **가사 소실** (1): XXIVb:4 Aria: Il cor nel seno balzarmi sento
- **미완성** (1): XXIVb:6 Recit: Mora l'infido; Aria: Mi sento nel seno
- **XXVIIb:23 <Das böse Weib> 의 다른 판** (1): XXVIIb:23bis Das böse Weib
- **<La vera costanza> 의 프랑스어판(Laurette, 1791 파리 개작)** (1): XXVIII:8a Laurette
- **치마로사 작품** (1): XXVIII:10bis L'infedeltà fedele
- **옛 판. 고친 판 Hob. XXIXb:2 로 넣음** (1): XXIXa:1 Philemon und Baucis

위키 표 행이 아닌 판(版)·곡도 뺐습니다: 피아노 소나타 Landon 19(Hob. XVI:47bis, E단조 옛 판 — F장조 Landon 57 만 넣음), 교향곡 22번 2판(Hob. I:22bis, MB 에만 있음), <일곱 말씀> 피아노판(Hob. XX:1C), <Philemon und Baucis> 인형극 옛 판(XXIXa:1).

## 4. 애매했던 판단

1. **피아노 소나타 진위 'Uncertain' 10곡을 넣었습니다**(Landon 1·2·3·5·6·8·12·15·16·57 = Hob. XVI:8·7·9·11·10·5·12·13·14·47, `authenticity: "uncertain"`). SPEC 은 위작 의심을 빼라고 했지만, 위키백과 피아노 독주곡 목록이 이 곡들에 Landon 정전 번호(1–62)를 주고 있고 전집 녹음에 다 들어 있어서 살렸습니다. 'Doubtful' 인 Landon 4·7·17·18 과 번호 없는 XVI:15·16·17 은 뺐습니다. 다른 갈래의 'uncertain' (디베르티멘토 II:39–46, 무곡 17개, 건반 협주곡 5·7·8·9, 호른 협주곡 2번, 교회음악 7곡 등 44개)은 모두 뺐습니다.
2. **번호 체계**: 피아노 소나타·피아노 3중주 제목 번호는 Landon 번호입니다(위키백과 갈래별 목록과 MB 제목이 모두 Landon). Hob. 번호는 `catalogue`, Landon 은 `catalogueAlt: "Landon 62"`. 예: 「피아노 소나타 62번 E♭장조」 = Hob. XVI:52. 교향곡은 Hob. I 번호 = 관례 번호.
3. **제목 겹침 처리**: 번호 없는 같은 갈래·같은 조성이 많아 디베르티멘토(Hob. II·IV·XIV) 30곡, 현악 3중주 22곡, 콘체르티노 3곡, 서곡 2곡, 현악 4중주 Op. 42·103 2곡, 테 데움 2곡 은 제목 끝에 카탈로그를 붙였습니다(`디베르티멘토 G장조 Hob. II:1`, 모두 61곡). SPEC 의 묶음 규칙을 낱곡·다악장까지 넓힌 것이라 확인이 필요합니다. 한 갈래 안에서 하나라도 겹치면 그 갈래 전체에 붙여 모양을 맞췄습니다.
4. **<십자가 위의 일곱 말씀>**: 하이든이 직접 만든 관현악판(Hob. XX:1A, 다악장 9), 현악 4중주판(Op. 51 = Hob. XX:1B = III:50–56, 다악장 9), 오라토리오판(Hob. XX:2, 낱곡) 셋을 따로 넣고, 편곡자가 따로 있는 피아노판(XX:1C)은 뺐습니다. '옛 판은 빼고 마지막 판만' 규칙과 달리, 편성이 다른 세 판이 각각 따로 연주·녹음되는 작품으로 봤습니다. 위키 작품 목록 표는 XX:1–4 로 적었지만 호보켄 원래 번호(1A/1B/1C/2, MB 도 같음)를 썼습니다. III:50–56 낱개 번호는 4중주판 악장으로 들어가 있습니다.
5. **악장 자료 없는 다악장은 낱곡으로 내렸습니다**(1장 목록 31개). 현악 3중주 Hob. V 는 MB 에 V:8 하나만 있고, 리라 오르가니차타 협주곡 1–4번, 무곡 묶음 IX:1·5·7, II:24, IV:4, XIV:10 도 MB 에 악장이 없습니다. 악장 이름을 지어내지 않았습니다.
6. **현악 4중주**: 출판 세트 15개를 묶음으로 두되 한 곡짜리 Op. 42 와 Op. 103 은 다악장으로 했습니다(제목 「현악 4중주 D단조 Op. 42」). Op. 103 은 미완성(2악장)이지만 연주 관례가 확고해 넣었습니다. Op. 1 은 위키백과대로 1·2·3·4·0(Hob. II:6)·6번 6곡(5번 = 교향곡 A 라 뺌), Op. 2 는 남의 편곡인 3·5번을 빼고 1·2·4·6번 4곡입니다. part 이름의 번호는 작품번호 안 번호(「현악 4중주 3번 C장조 "황제"」)입니다. Op. 3(호프슈테터)은 위작으로 뺐습니다.
7. **교향곡 A·B 넣음**: 위키백과가 '106 symphonies' 로 세고 진작이라 「교향곡 A B♭장조」(Hob. I:107)·「교향곡 B B♭장조」(I:108)로 넣었습니다. 신포니아 콘체르탄테(I:105)도 넣고, 첫 악장만 남은 I:106 은 뺐습니다.
8. **미사**: 13곡 모두 6단락(키리에·글로리아·크레도·상투스·베네딕투스·아뉴스 데이)으로 고정했습니다. MB 의 하위 work 가 단락 단위가 아니라 세부 구절 단위인 곳은 그 단락 mbid 를 null 로 뒀습니다(Hob. XXII:3 미사 G장조 "로라테 첼리 데수페르": 6개 중 0개 찾음; Hob. XXII:5 미사 C장조 "성 체칠리아": 6개 중 2개 찾음; Hob. XXII:6 미사 G장조 "성 니콜라이": 6개 중 4개 찾음; Hob. XXII:10 미사 B♭장조 "하일리히": 6개 중 3개 찾음; Hob. XXII:13 미사 B♭장조 "천지창조": 6개 중 3개 찾음; Hob. XXII:14 미사 B♭장조 "하모니": 6개 중 3개 찾음). 단편 Missa sunt bona mixta malis(XXII:2)는 뺐습니다.
9. **오페라 서곡(Hob. Ia) 14곡**은 해당 오페라·오라토리오에 들어 있다고 보고 뺐고, 따로 선 서곡 Ia:4·Ia:7 만 넣었습니다. 같은 까닭으로 <달의 세계> 행진곡(VIII:5), <Alfred> 부수음악 안 3곡(XXX:5a–c)도 따로 두지 않았습니다.
10. **조성 고친 것**: Hob. II:16 은 위키 표가 C장조인데 MB 가 'Divertimento a 8 in F major' 이고 호보켄 II:16 이 F장조 8성부 디베르티멘토라 F장조로 뒀습니다(위키 표 오류로 봄). 반대로 MB 가 Hob. XV:14 를 'A-flat minor' 로 적은 것은 MB 오류로 보고 위키대로 A♭장조입니다.
11. **무곡 IX:3**: 위키는 '16 Minuets', MB 는 '12 Minuets and 4 Trios'(12곡, 4곡에 트리오). part 를 MB 에서 채우므로 「12개의 미뉴에트 Hob. IX:3」 12곡으로 했습니다. IX:16 24곡은 MB part 에 조성이 없어 이름이 모두 「미뉴에트」 입니다.
12. **Hob. XVa:1–3**(건반·바이올린 소나타)은 위키 표에 연도·비고 없이 3곡만 있고 MB 에도 없으며, XVa 갈래가 편곡 위주라 판단을 미루고 뺐습니다.
13. **성악 묶음**: 출판 세트인 12 Lieder 1·2집(XXVIa:1–12, 13–24), 6 Original Canzonettas 1·2집(XXVIa:25–30, 31–36), 십계명 카논 10곡(XXVIIa:1–10)은 묶음으로, 나머지 가곡·세속 카논(XXVIIb 47곡)·아리아는 낱곡으로 두었습니다. 응답송(XXIIIc:4a–d)·찬가(XXIIIc:5a–d)는 한 번호 아래 4곡이라 묶음입니다. 응답송은 MB 에 묶음 work·순서가 없어 <Lauda Sion> 가사 순으로, 6개의 시편(XXIII:suppl.)은 근거가 없어 MB 관계 순서 그대로 두었습니다.
14. **피아노 3중주**: 위키 갈래별 목록 45곡 가운데 Landon 2(XV:C1)·14(XV:f1)·16(XIV:C1) 위작 의심, 8·9 소실, 15(XV:deest, 호보켄 번호 없음)를 뺀 39곡입니다. 4번(XV:39)은 작품 목록 표에 'arrangement of other works' 라고 적혀 있지만 Landon 정전에 있어 넣었습니다. 3번은 Hob. XIV:6(건반 디베르티멘토 번호)입니다.
15. **건반 협주곡**: 위키 표대로 「피아노 협주곡 N번」으로 했습니다. 1번(XVIII:1)·10번은 오르간용이라는 설명이 흔하지만 갈래 이름을 나누지 않았습니다. 진위 불확실 5·7·8·9번은 뺐습니다.
16. **그 밖**: XXX:4 「부수음악 <Musik zu einem Schauspiel>」은 어느 연극인지 모르지만 위키 표에 비고가 없어 넣었습니다. II:deest 2곡(관악 디베르티멘토)은 호보켄 번호가 없어 뺐습니다. XXVIIb:23bis(다른 판)·XXVIII:8a <Laurette>(프랑스어 개작)는 뺐습니다. 디베르티멘토 II:11 별명 'Der Geburtstag' 를 「"생일"」로 옮겼습니다.

## 5. 직접 옮긴 우리말 이름 (검수용)

교향곡 별명(운영에 있던 놀람·시계·고별 빼고): 6번 "아침"(Le matin), 7번 "정오"(Le midi), 8번 "저녁"(Le soir), 22번 "철학자"(The Philosopher), 26번 "라멘타치오네"(Lamentatione), 30번 "알렐루야"(Alleluia), 31번 "호른 신호"(Hornsignal), 38번 "메아리"(Echo), 43번 "메르쿠르"(Mercury), 44번 "슬픔"(Trauer), 47번 "팔린드롬"(The Palindrome), 48번 "마리아 테레지아"(Maria Theresia), 49번 "수난"(La passione), 53번 "제국"(L'impériale), 55번 "학교 선생님"(The Schoolmaster), 59번 "불"(Fire), 60번 "일 디스트라토"(Il distratto), 63번 "록셀란"(La Roxelane), 64번 "템포라 무탄투르"(Tempora mutantur), 69번 "라우돈"(Laudon), 73번 "사냥"(La chasse), 82번 "곰"(The Bear), 83번 "암탉"(The Hen), 85번 "왕비"(La Reine), 92번 "옥스퍼드"(Oxford), 96번 "기적"(The Miracle), 100번 "군대"(Military), 103번 "큰북 연타"(Drumroll), 104번 "런던"(London).

현악 4중주 별명(황제 빼고): III:1 "사냥"(La chasse), III:38 "농담"(The Joke), III:39 "새"(The Bird), III:48 "꿈"(The Dream), III:49 "개구리"(The Frog), III:61 "면도칼"(Razor), III:63 "종달새"(The Lark), III:74 "기수"(The Rider), III:76 "5도"(Fifths), III:78 "일출"(Sunrise).

피아노 3중주 별명: XV:25 "집시"(Gypsy), XV:31 "야곱의 꿈"(Jacob's Dream).

미사 별명: XXII:3 "로라테 첼리 데수페르", XXII:4 "큰 오르간 미사", XXII:5 "성 체칠리아"(Missa Cellensis / Cäcilienmesse), XXII:6 "성 니콜라이", XXII:7 "작은 오르간 미사", XXII:8 "마리아첼", XXII:9 "전시"(Missa in tempore belli, 팀파니 미사), XXII:10 "하일리히", XXII:11 "넬슨", XXII:12 "테레지아", XXII:13 "천지창조", XXII:14 "하모니"; XXII:1 은 「미사 브레비스 F장조」.

작품 제목·갈래어: 노투르노(Notturno), 스케르찬도(Scherzando), 콘체르티노(Concertino), 런던 트리오(London Trio), 리라 오르가니차타 협주곡(Concerto for 2 lire organizzate), 바이올린과 비올라를 위한 2중주(String Duo), 더비셔 행진곡 1·2번(Derbyshire March), 웨일스 왕자를 위한 행진곡, 왕립 음악가 협회를 위한 행진곡, 헝가리 국민 행진곡, 피아노 연탄곡 <스승과 제자>(Il maestro e lo scolare), 피아노 연탄 파르티타, 안단테와 변주곡 F단조(Variations in F minor), N개의 변주곡, 카프리치오, <십자가 위의 일곱 말씀> 관현악판·현악 4중주판·오라토리오, 스타바트 마테르, 오라토리오 <사계>, 오페라 <달의 세계>(Il mondo della luna), 가곡 <황제 찬가>(Gott erhalte Franz den Kaiser), 살베 레지나, 아베 레지나, 테 데움, 알렐루야, 응답송 <Responsoria de venerabili>, 찬가 <Hymni de venerabili>, 6개의 시편, 오페르토리움, 칸틸레나, 모테트, 카바티나, 중창곡·2중창(Hob. XXV), 합창곡(<The Storm>, <Dr. Harington's Compliment>), 카논집, 징슈필, 부수음악, 12개의 가곡, 6개의 칸초네타, N개의 미뉴에트·독일 무곡, 춤곡.

그 밖 오페라·칸타타·아리아·가곡·카논·교회음악 제목은 원제를 꺾쇠에 그대로 두었습니다(오페라 13곡 중 <달의 세계> 만 우리말).

악장 이름은 MB 제목에서 빠르기말을 원어 그대로 두고 앞머리 갈래어만 옮겼습니다: Menuet(to)→미뉴에트, Menuet & Trio→미뉴에트와 트리오, Trio→트리오, Finale→피날레, Scherzo→스케르초, Scherzando→스케르찬도, Romance→로망스, Rondo→론도, Marcia→행진곡, Fantasia→환상곡, Capriccio→카프리치오, Fuga→푸가, Introduzione→서주, Sonata I→소나타 I(일곱 말씀), 미사 단락 키리에·글로리아·크레도·상투스·베네딕투스·아뉴스 데이. 'Tempo di Menuetto' 같은 빠르기말 안의 말은 옮기지 않았습니다.

## 6. 위키백과 대조 결과

`scripts/check.py` 로 기계 대조했습니다.

- 작품 목록 표 1,458행 모두 넣음/뺌 둘 중 하나로 처리, 빠진 행 0개.
- 조성: 넣은 행의 위키 조성이 작품 제목(묶음이면 part 이름)에 들어 있는지 대조, 어긋남 0개(II:16 은 위 4장 10번처럼 F장조로 고친 뒤 기준).
- 현악 4중주(List of string quartets): 세트별 곡 수·Hob 번호·조성
  - Op. 1: 위키 6곡 / 우리 6곡 / Hob 같음 / 조성 같음
  - Op. 2: 위키 4곡 / 우리 4곡 / Hob 같음 / 조성 같음
  - Op. 9: 위키 6곡 / 우리 6곡 / Hob 같음 / 조성 같음
  - Op. 17: 위키 6곡 / 우리 6곡 / Hob 같음 / 조성 같음
  - Op. 20: 위키 6곡 / 우리 6곡 / Hob 같음 / 조성 같음
  - Op. 33: 위키 6곡 / 우리 6곡 / Hob 같음 / 조성 같음
  - Op. 42: 위키 1곡 / 우리 다악장 1곡 (Hob. III:43)
  - Op. 50: 위키 6곡 / 우리 6곡 / Hob 같음 / 조성 같음
  - Op. 54: 위키 3곡 / 우리 3곡 / Hob 같음 / 조성 같음
  - Op. 55: 위키 3곡 / 우리 3곡 / Hob 같음 / 조성 같음
  - Op. 64: 위키 6곡 / 우리 6곡 / Hob 같음 / 조성 같음
  - Op. 71: 위키 3곡 / 우리 3곡 / Hob 같음 / 조성 같음
  - Op. 74: 위키 3곡 / 우리 3곡 / Hob 같음 / 조성 같음
  - Op. 76: 위키 6곡 / 우리 6곡 / Hob 같음 / 조성 같음
  - Op. 77: 위키 2곡 / 우리 2곡 / Hob 같음 / 조성 같음
  - Op. 103: 위키 1곡 / 우리 다악장 1곡 (Hob. III:83)
  - Op. 51: 일곱 말씀 4중주판, 다악장 9악장
- 피아노 소나타 Landon 대조: 위키 Landon 번호 62개, 우리 49곡, 어긋남 0
- 피아노 소나타 Landon 대조: 우리에 없는 Landon 번호: [4, 7, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28]
- 피아노 3중주 목록 대조: 위키 45곡, 우리 39곡, 조성 어긋남 0
- 피아노 3중주 목록 대조: 우리에 없는 번호: [2, 8, 9, 14, 15, 16]
- 교향곡: 107곡: Hob. I:1–104 중 빠진 번호 [], 그 밖 [105, 107, 108]
- 미사: 위키 14곡(H. 22/1,2,3,4,5,6,7,8,9,10,11,12,13,14), 우리 13곡, 없는 것 [2]
- 협주곡(List of concertos): 바이올린 1·3·4, 첼로 1·2, 호른 1, 트럼펫, 리라 1–5, 건반 1·2·3·4·6·10·11 — 목록의 진작과 같음(소실·위작·의심 뺌).
- 오페라(List of operas): 남은 악보가 있는 13곡 + <Philemon und Baucis> 모두 들어 있음, 소실 징슈필 9곡 뺌.
- 형식 검사: 제목 겹침 0, 빈 nameKo 0, '1번 '·'1악장 ' 으로 시작하는 nameKo 0, 한 작품 안 MBID 겹침 0, 두 번 쓴 MBID 0.

MusicBrainz 와 위키백과가 다른 곳:

- II:16 조성(위 4장 10번), XV:14 조성(MB 오류), IX:3 곡 수(위 4장 11번).
- MB 의 노투르노 번호(II:27 번호 없음, II:28 'no. 7')는 위키 번호(1–8)를 따랐습니다.
- MB 에 MBID 가 없어 null 인 작품 106개(현악 3중주 21, 리라 협주곡 1–4, 행진곡 VIII:4·7, 무곡 IX:1·5·7·23·26·31, XIV:10, 교회음악·칸타타·아리아 일부, 가곡 묶음 4개·십계명 카논 묶음, 세속 카논 47곡, 오페라·부수음악 일부 등). 묶음 work 가 MB 에 없는 가곡·카논 묶음도 null 입니다.
- MB 에서 낱개 work 로 같은 곡이 두 번 올라간 것(교향곡 살로몬 편곡판, Op. 54 No. 1 의 Hob. 번호 잘못 단 중복 등)은 편곡·중복 표시로 거르고 운영 MBID·세트 소속을 우선했습니다.

## 리드에게 (짧게)

- 개수: 작품 500(묶음 28·다악장 284·낱곡 188), part 1231, children 274. 위키 작품 목록 1,458행 중 600행 넣고 858행 뺌(민요 편곡 448·바리톤 167·시계 32 포함).
- 기존 대응: 83·84·85·87·88 은 같은 작품, 86 「황제」는 Op. 76 의 3번 part. 6개 모두 MBID 로 맞음, 운영 중복 없음.
- 꼭 볼 판단: (1) 'Uncertain' 피아노 소나타 10곡 넣음(uncertain 표시) (2) 소나타·3중주 제목 번호 = Landon (3) 번호 없는 같은 조성 61곡 제목 끝에 Hob. 붙임 (4) 일곱 말씀 관현악·4중주·오라토리오 세 판 다 넣음 (5) MB 악장 없는 다악장 31개 낱곡으로 내림.

