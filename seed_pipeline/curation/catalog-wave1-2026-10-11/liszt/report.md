# 리스트 작품 카탈로그 — 보고

데이터 파일만 만들었습니다(DB 쓰기·마이그레이션 없음). 결과는 `catalog.json`, 원자료는 `raw/`, 스크립트는 `scripts/` 에 있습니다.

- 위키백과: `List of compositions by Franz Liszt` 위키텍스트(`raw/wiki_list.txt`)를 행 단위로 푼 `raw/wiki_rows.json`(2,095행: 원작 1,046 · 편곡 894 · 부록 155).
- MusicBrainz: 리스트 artist(2cd475bb…) work 2,271개를 browse(`inc=aliases+work-rels`, 100개씩)로 받은 `raw/mb_works.json`. 낱개 조회는 하지 않았습니다.
- 운영 DB: `../db/` 의 리스트 작품 6개와 MBID 목록만 읽었습니다.
- 스크립트 순서: `fetch_mb.py` → `parse_wiki.py` → `mb_index.py` → `defs.py`(손 정의) → `build.py` → `wikicheck.py` → `report.py`. `review_mb.py` 는 MB 후보 검토표(`raw/review_mb.txt`).
- 작품 key 는 `liszt-s<번호>`(예: `liszt-s139`, `liszt-s13-2`), `catalogue` 는 위키 꼴 `S. 139`, `catalogueAlt` 는 그로브 LW 번호(`LW A172`). part 의 `catalogueAlt` 에도 LW 하위 번호를 넣었습니다.

## 1. 개수

| 갈래 | 작품 | part | children |
|---|---:|---:|---:|
| 묶음(collection) | 42 | 201 | 42 |
| 다악장(multi_movement) | 11 | 56 | – |
| 낱곡(single) | 312 | – | – |
| 합계 | 365 | 257 | 42 |

children 은 두 겹 묶음 2개(<나그네의 앨범> S. 156: 책 3권 → 19곡, <헝가리 민요와 광시곡> S. 242: 2권 → 23곡)에만 있습니다.
듣는 단위(낱곡 + 다악장 작품 + 묶음 안 곡)로 세면 561곡입니다.

genre 별 작품 수: song 82, piano 59, sacred_choral 45, album_leaf 41, choral 24, symphonic_poem 13, waltz 11, dance 10, march 8, orchestral 7, etude 6, organ 6, psalm 5, chamber 5, melodrama 5, cantata 4, mass 4, variations 4, rhapsody 4, song_cycle 4, piano_orchestra 3, oratorio 2, symphony 2, concerto 2, ballade 2, polonaise 2, opera 1, requiem 1, incidental 1, sonata 1, piano_duo 1.

MB work 가 없는 작품 59개(`mbid: null`), part·children 가운데 MBID 없는 것 34개(전체 299개 중). 대부분 MB 에 work 가 없는 작은 합창곡입니다(5장 끝 목록).

## 2. 운영 기존 작품 대응

| id | 운영 제목 | 운영 번호 | 이 목록에서 | 이름 | 근거 |
|---:|---|---|---|---|---|
| 142 | 교향시 <전주곡> | S. 97 | liszt-s97 (single) | 교향시 <전주곡> | MBID 5e852053 같음 |
| 450 | 피아노 협주곡 1번 E♭장조 | S. 124 | liszt-s124 (multi_movement) | 피아노 협주곡 1번 E♭장조 | MBID d7793d9f 같음 |
| 143 | 초절기교 연습곡 4번 D단조 "마제파" | S. 139/4 | liszt-s139 의 4번 part | D단조 "마제파" | MBID 3ea62b96 같음 |
| 140 | 파가니니 주제에 의한 대연습곡 3번 "라 캄파넬라" | S. 141/3 | liszt-s141 의 3번 part | G#단조 "라 캄파넬라" | MBID b6a880ce 같음 |
| 141 | 헝가리 광시곡 2번 | S. 244/2 | liszt-s244 의 2번 part | C#단조 | MBID 90929826 같음 |
| 139 | 사랑의 꿈 3번 A♭장조 | S. 541/3 | liszt-s541 의 3번 part | A♭장조 "오, 사랑할 수 있는 한 사랑하라" | MBID 0edc5a7d 같음 |

- 6개 모두 운영 MBID(`db/piece_identifiers.tsv`)와 이 목록의 MBID 가 같습니다. 카탈로그 번호로만 맞춘 것은 없습니다.
- 운영 제목과 이 목록 제목이 다른 것: 142 `교향시 <전주곡>`·450 `피아노 협주곡 1번 E♭장조` 는 같고, part 로 들어간 139·140·141·143 은 part 이름이 `A♭장조 "오, 사랑할 수 있는 한 사랑하라"` 꼴입니다(운영 낱곡 제목은 그대로 두는 것을 권합니다).
- 운영에 같은 작품이 둘인 경우는 없습니다. `db/piece_parts.tsv` 에 리스트 part 가 없어 existingPartId 는 모두 null.

## 3. 뺀 것과 까닭

위키백과 원작 구역 1043행 가운데 596행이 이 목록에 들어가고(작품 머리 행·part·children), 나머지는 아래 까닭으로 뺐습니다. '묶음째'는 머리 행이 빠져 자식 행이 함께 빠진 것입니다.

| 까닭 | 행 수 | 그중 묶음째 |
|---|---:|---:|
| 옛 판 (old) | 216 | 5 |
| 소실 (lost) | 5 | 0 |
| 자기 곡 편곡·성악 악보 (self_arr) | 64 | 10 |
| 다른 판·쉬운 판·카덴차 (alt) | 18 | 0 |
| 미완성·단편·스케치 (incomplete) | 15 | 8 |
| 위작·위작 의심 (spurious) | 18 | 12 |
| 민요·국가·전래 선율 편곡 (folk) | 24 | 5 |
| 같은 곡 다른 번호 (duplicate) | 11 | 0 |
| 남의 곡 편곡·전사·패러프레이즈·판타지 (other) | 44 | 22 |
| 악보 접근 불가 (inaccessible) | 3 | 0 |
| 없어진·옮겨 간 번호 (deleted) | 10 | 0 |
| 다른 곡에서 따온 앨범의 한 페이지·도입부 (excerpt) | 15 | 2 |
| 머리 행(곡은 따로 넣음) (split) | 4 | 2 |

편곡 구역(S. 351 이상) 894행과 부록(미완성·위작 의심·소실) 155행은 S. 514·515·541(자식 3행 포함 6행)만 빼고 모두 넣지 않았습니다.

### 옛 판 (old) — 211

S. 4/1, S. 8/1, S. 13/1, S. 14/1, S. 15/1a, S. 15/1b, S. 15/2a, S. 16/1, S. 17/1, S. 19/2, S. 19/3, S. 20/1, S. 21/1, S. 25, S. 29, S. 31/1, S. 32/1, S. 32/2, S. 34/1, S. 35/1, S. 39/1, S. 41/1, S. 42/1, S. 46/1, S. 69i, S. 69ii, S. 70i, S. 70ii, S. 70iii, S. 74/1, S. 75/1, S. 75/2, S. 84/1, S. 85/1, S. 85/2, S. 90/1a, S. 90/1b, S. 90/2a, S. 90/2b, S. 90/3a, S. 90/4a, S. 90/5a, S. 90/6a, S. 90/7a, S. 90/8a, S. 90/9a, S. 90/10a, S. 90/11a, S. 90/12a, S. 91/1, S. 113/1, S. 126i, S. 136, S. 136/1, S. 136/2, S. 136/3, S. 136/4, S. 136/5, S. 136/6, S. 136/7, S. 136/8, S. 136/9, S. 136/10, S. 136/12, S. 137, S. 137/1, S. 137/2, S. 137/3, S. 137/4, S. 137/5, S. 137/6, S. 137/7, S. 137/8, S. 137/9, S. 137/10, S. 137/11, S. 137/12, S. 138, S. 140, S. 140/1, S. 140/2, S. 140/3, S. 140/4a, S. 140/4b, S. 140/5, S. 140/6, S. 142, S. 154, S. 155a, S. 155a/1, S. 155a/2, S. 155a/3, S. 157a, S. 157b, S. 157c, S. 158a, S. 158b, S. 158c, S. 159, S. 159/3, S. 159/4, S. 162a/1, S. 162a/1a, S. 162a/2, S. 162a/3, S. 162a/4, S. 162b, S. 162c, S. 162e, S. 162d, S. 162f, S. 166h, S. 170a, S. 171a, S. 171a/1, S. 171a/2, S. 171a/4, S. 171a/5, S. 171a/6, S. 171c, S. 171e, S. 172a, S. 172a/1, S. 172a/2, S. 172a/3, S. 172a/4, S. 172a/5, S. 172a/6, S. 172a/7, S. 172a/8, S. 172a/9, S. 172a/11, S. 172c, S. 175a, S. 176a, S. 182a, S. 185a, S. 185a/1, S. 185a/2, S. 185a/3, S. 185a/4, S. 185a/5, S. 185a/6, S. 185a/7, S. 185a/8, S. 185a/9, S. 185a/10, S. 185a/11, S. 185a/12, S. 187a, S. 189a, S. 195a, S. 196a, S. 199a, S. 200/1, S. 205, S. 209, S. 210, S. 210a, S. 212i, S. 215a, S. 226a, S. 227, S. 227a, S. 232, S. 248i, S. 258i, S. 260i, S. 265, S. 269/1, S. 269/2, S. 270a, S. 270a/1, S. 270a/2, S. 270a/3, S. 272/1, S. 273/1, S. 274/1, S. 275/1, S. 275/2, S. 276/1, S. 277/1, S. 278/1, S. 279/1, S. 279/2, S. 279/3, S. 280/1, S. 282/1, S. 283/1, S. 284/1, S. 287/1, S. 289/1, S. 290/1, S. 291/1, S. 292a, S. 292a/1, S. 292a/2, S. 292a/2(둘째 줄), S. 293/1, S. 294/1, S. 297/1, S. 298/1, S. 299/1, S. 301/1, S. 301b/1, S. 301b/2, S. 305/1, S. 306/1, S. 311/1, S. 342/1, S. 342/2.

(옛 판: 같은 번호의 뒤 판이나 위키가 'Nth version of / rev. as' 로 이은 새 번호를 넣었습니다.)

### 소실 (lost) — 5

- S. 5/1 Sainte Cécile (Die heilige Cäcilia) — 1st version of S. 5/2; lost
- S. 15/3 Psalm 23 (Mein Gott, der ist mein Hirt) — 5th version of S. 15/1a, S. 15/1b, S. 15/2a, S. 15/2b; lost; renumbered from S. 15bis
- S. 17/3 Psalm 137 (An den Wassern zu Babylon) — 3rd version of S. 17/2, S. 17/3; lost
- S. 19/1 Hymne de l'enfant á son réveil (O père qu'adore mon père) — based on S. 171c; 1st version of S. 19/2, S. 19/3, S. 19/4; lost
- S. 172a/12 Ave Maria — 1st version of S. 173/2; now lost

### 자기 곡 편곡·성악 악보 (self_arr) — 54

S. 5/2a, S. 13/2a, S. 14/1a, S. 14/2a, S. 15a/1, S. 15a/2, S. 45, S. 51, S. 71bis, S. 79/2, S. 80bis, S. 80bis/1, S. 80bis/2, S. 80bis/3, S. 80bis/4, S. 81/2, S. 83b, S. 86b, S. 87/1c, S. 87/3b, S. 93/1, S. 93/2, S. 93/3, S. 93/4, S. 93/5, S. 93/6, S. 93/7, S. 111, S. 113a, S. 113a/1, S. 113a/2, S. 117, S. 130a, S. 130b, S. 130c, S. 131, S. 131a, S. 132a, S. 132b, S. 132c, S. 134, S. 134a, S. 158, S. 158/1, S. 158/2, S. 158/3, S. 202, S. 208a, S. 261a, S. 266, S. 267, S. 268a, S. 345/3a, S. 345a.

### 다른 판·쉬운 판·카덴차 (alt) — 18

- S. 7bis Cantantibus organis (Antiphona in festo Santa Caeciliae) — S. 7 의 다른 반주 편성(하프·하모늄·피아노)
- S. 72/1a Rheinweinlied (Wo solch ein Feuer) — 카로이 후버가 관현악 반주를 붙이고 리스트가 고친 판
- S. 144/3a Two additional cadenzas to Un Sospiro — <한숨>에 덧붙인 카덴차 두 개
- S. 160/4a Au bord d'une source — <샘가에서> 1863년 고친 판(스감바티용 코다)
- S. 171b Album Leaf (Consolation No.1) — 위안 1번으로 쓰려던 앨범의 한 페이지
- S. 175/2a St François de Paule, marchant sur les flots — simplified version of S. 175/2; renumbered from S. 175/2bis
- S. 186/7a Schlummerlied — <자장가> 1882년 라흐문트용 3판
- S. 213a Valse-Impromptu — <즉흥 왈츠>에 뒤에 덧붙인 확장판
- S. 213b Valse-Impromptu — version facilitée
- S. 215/3a Valse oubliée No.3 — <잊힌 왈츠 3번> 파리 수고 판
- S. 219a Grand galop chromatique — 2nd (simplified) version of S. 219; Probably the piano reduction of Furioso-Galopp, Op. 114 by Johann Strauss the Elder, published as Liszt's arrangement; renumbered from S. 219bis
- S. 242/13a Ungarische National-Melodie ["Rákóczi-Marsch"] — simplified version of S. 242/13; renumbered from S. 242/13bis
- S. 243/1a (Tempo giusto) (Im leichten Stile bearbeitet) — 3rd (lighter) version of S. 242/5, S. 243/1; renumbered from S. 243bis/1
- S. 243/2a (Animato) (Im leichten Stile bearbeitet) — 3rd (lighter) version of S. 242/4, S. 243/2; renumbered from S. 243bis/2
- S. 243/3a Prélude (Allegretto) (Im leichten Stile bearbeitet) — 3rd (lighter) version of S. 242/11, S. 243/3; renumbered from S. 243bis/3
- S. 244/2a Hungarian Rhapsody No. 2 (Lento a capriccio) — 헝가리 광시곡 2번 카덴차
- S. 244/10a Hungarian Rhapsody No. 10 (Preludio) — 2nd (easier) version of S. 244/10; uses themes from S. 242/16; renumbered from S. 244/10bis
- S. 244/15a Hungarian Rhapsody No. 15 (Rákóczi-Marsch) — simplified (easier) version of S. 244/15; renumbered from S. 244/15bis

### 미완성·단편·스케치 (incomplete) — 7

- S. 18/1 Qui m'a donné la naissance — incomplete
- S. 49a Adeste fidelis — incomplete
- S. 121a De Profundis (Psaume instrumentale) — formerly S. 691; unfinished
- S. 125a Piano Concerto [No.3] — unfinished; performing version realized by Jay Rosenblatt
- S. 158d Adagio — fragment from S. 158c? may also have been formerly S. 998?
- S. 171d Préludes et Harmonies poétiques et religieuses (8): — <시적이고 종교적인 선율과 전주곡> 8곡 수고. 미완성 곡이 섞인 스케치 묶음이고 몇 곡은 S. 172a·173·170 의 옛 판
- S. 241b Magyar Tempo — sketches only

### 위작·위작 의심 (spurious) — 6

- S. 50 Alte deutsche geistliche Weisen — probably misattributed to Liszt, who arr. the pieces as S. 504b and S. 669a
- S. 54 O Roma nobilis — based on a chorus by Giuseppe Baini; Liszt's authorship of Choral, sacred parts doubtful; see also arrs. for org as S. 669c, for pf as S. 506b
- S. 126a Concerto in the Hungarian Style — not by Liszt (see Ungarische Zigeunerweisen [S. 714] by Sophie Menter)
- S. 147a Variationen über Romanze aus Joseph von Méhul — spurious (by Franz Xaver Wolfgang Mozart); see S. 697
- S. 221a Mazurka — now believed to be spurious
- S. 256a Nocturne — arr. of S. 161/5; spurious (not by Liszt)

### 민요·국가·전래 선율 편곡 (folk) — 19

- S. 71 Gaudeamus igitur (Humoreske) — 학생가 <Gaudeamus igitur> 에 의한 유머레스크
- S. 164f Album Leaf ("Rákóczi-Marsch") — 라코치 행진곡 앨범의 한 페이지
- S. 235 God Save the Queen (Paraphrase de concert) — 영국 국가 <God Save the Queen> 연주회용 패러프레이즈
- S. 236/1 Faribolo Pasteur (Chanson tirée du poème de Françonetto de Jacques Jasmin) — 자스맹 시의 샹송 <Faribolo pastour> 편곡
- S. 238 La cloche sonne — 옛 프랑스 노래 <La cloche sonne> 편곡
- S. 239 Vive Henri IV — <앙리 4세 만세> 행진곡 편곡
- S. 240 Gaudeamus igitur (Chanson des étudiants) — 학생가 <Gaudeamus igitur> 편곡
- S. 242a Rákóczi-Marsch — 라코치 행진곡 첫 편곡
- S. 243a Célèbre mélodie hongroise — <유명한 헝가리 선율> 편곡
- S. 244a Rákóczi-Marsch — 라코치 행진곡 피아노판(관현악판 S. 117 의 편곡)
- S. 244b Rákóczi-Marsch — 라코치 행진곡 쉬운 판
- S. 244c Marche de Rákóczy (Édition populaire) — 라코치 행진곡 보급판
- S. 245 Ungarische Volkslieder (Magyar népdal) (5) — <헝가리 민요> 5곡 편곡
- S. 249a Mélodie polonaise — 폴란드 선율 편곡
- S. 249b Dumka — 우크라이나 민요에 의한 <둠카>
- S. 249c Air cosaque — 카자크 선율 편곡
- S. 251 Abschied (Russisches Volkslied) — 러시아 민요 <이별> 편곡
- S. 252a La romanesca (Mélodie du 16ième siècle) — 16세기 선율 <라 로마네스카> 편곡(1판)
- S. 252b La romanesca (Mélodie du 16ième siècle) — 16세기 선율 <라 로마네스카> 편곡(2판)

### 같은 곡 다른 번호 (duplicate) — 11

S. 109a, S. 166a(둘째 줄), S. 194, S. 195, S. 205/1, S. 205/2, S. 205/3, S. 205/4, S. 205/5, S. 205/6, S. 205/7.

### 남의 곡 편곡·전사·패러프레이즈·판타지 (other) — 22

- S. 116 Festmarsch nach Motiven von E.H.z.S.-C.-G. — 에른스트 2세(작센코부르크고타 공작)의 오페라 <디아나 폰 졸랑게> 주제에 의한 행진곡
- S. 120 Grande fantaisie symphonique (über Themen aus Hector Berlioz' Lélio) — 베를리오즈 <렐리오> 주제에 의한 대교향적 환상곡
- S. 122 Fantasie über Motive aus Beethovens Ruinen von Athen — 베토벤 <아테네의 폐허> 주제에 의한 환상곡
- S. 150 Impromptu brillant sur des thèmes de Rossini et Spontini — 로시니·스폰티니 주제에 의한 화려한 즉흥곡
- S. 167c Album Leaf (Poco adagio) — 베토벤 <장엄 미사> 아뉴스 데이에서 따온 앨범의 한 페이지
- S. 167p Album Leaf ("Larghetto in D♭ major") — 헨젤트 협주곡에 의한 앨범의 한 페이지
- S. 168/1 Élégie sur des motifs du Prince Louis Ferdinand de Prusse — 프로이센 왕자 루이 페르디난트의 동기에 의한 비가 1판
- S. 168/2 Élégie sur des motifs du Prince Louis Ferdinand de Prusse — 프로이센 왕자 루이 페르디난트의 동기에 의한 비가
- S. 168a Andante amoroso — S. 395(남의 곡 편곡)에서 나온 것으로 보는 소품
- S. 181 Sarabande und Chaconne aus dem Singspiel Almira — 헨델 <알미라> 의 사라방드와 샤콘
- S. 183/2 Ave Maria d'Arcadelt — 아르카델트 마드리갈(디치 각색)에 의한 <아베 마리아>
- S. 190 La marquise de Blocqueville (Un portrait en musique) — 앙리 에르츠·프랑시스 플랑테와 함께 쓴 곡. 리스트는 3악장만
- S. 234 Hussitenlied (Aus dem 15. Jahrhundert) — 크로프의 노래 <Těšme se blahou nadějí> 에 의한 <후스파의 노래>
- S. 236/2 Chanson du Béarn (Pastorale) — 브라사크 후작의 노래에 의한 <베아른의 샹송>
- S. 237 La Marseillaise (Chant de guerre par Claude-Joseph Rouget de Lisle) — 루제 드 릴 <라 마르세예즈> 편곡
- S. 241 Zum Andenken (Ungarische Werbungstänze) (2): — 파이·비하리의 춤곡에 의한 <헝가리 징병 춤곡> 2곡
- S. 241a Ungarischer Romanzero (Hungarian Romances) (18): — <헝가리 로만체로> 18곡. 여러 곡이 레메니 작곡이고 나머지도 대중 선율 편곡
- S. 246 Puszta-Wehmut (A puszta keserve) — 기지츠카자모이스카의 노래에 의한 <푸스타의 슬픔>
- S. 249d Le rossignol (Air russe d'Alexander Alabieff) — 알랴비예프의 로망스 <나이팅게일> 편곡(1판)
- S. 250 Mélodies russes (Arabesques) (2): — <러시아 선율> 2곡: 알랴비예프 <나이팅게일>, 불라호프 <집시의 노래> 편곡
- S. 252 Rondeau fantastique sur un thème espagnol (El contrabandista) — 가르시아의 오페라 아리아 <El contrabandista> 에 의한 환상적 론도
- S. 257 Grosses Konzertstück über Themen aus Mendelssohns Lieder ohne Worte — 멘델스존 <무언가> 주제에 의한 두 대의 피아노용 대연주회곡

### 악보 접근 불가 (inaccessible) — 3

- S. 126c Trio — formerly S. 717; ms. in private hands; unobtainable
- S. 153a Grand solo caractèristique d'apropos une chansonette de Panseron — formerly S. 754a; unpublished (in private collection)
- S. 167b Miniatur Lieder — unpublished; score inaccessible (in private collection?)

### 없어진·옮겨 간 번호 (deleted) — 10

S. 133, S. 167, S. 167a, S. 222, S. 233c, S. 247, S. 255, S. 256, S. 263, S. 340a.

### 다른 곡에서 따온 앨범의 한 페이지·도입부 (excerpt) — 13

- S. 141/6a Album Leaf ("Introduction to the Grande Étude de Paganini No 6") — 파가니니 대연습곡 6번에 붙인 도입부 앨범의 한 페이지(1884)
- S. 164 Albumblatt ("Feuille d'album" No.1) — <우울한 왈츠> S. 210 에 바탕한 앨범의 한 페이지
- S. 166n Album Leaf ("Freudvoll und leidvoll") — 가곡 S. 280 일부를 옮긴 앨범의 한 페이지
- S. 166o Album Leaf ("Langsam in C# minor") — 초절기교 연습곡 11번 도입부를 쓴 앨범의 한 페이지
- S. 166r Two Album Leaves ("Purgatorio") — <단테 교향곡> 연옥 악장에서 따온 앨범의 한 페이지 2곡
- S. 167d Album Leaf — 교향시 <오르페우스> S. 98 에서 따온 앨범의 한 페이지
- S. 167e Album Leaf — 교향시 <이상> S. 106 에서 따온 앨범의 한 페이지
- S. 167f Album Leaf ("Dante Symphony progression") — <단테 교향곡> 진행을 쓴 앨범의 한 페이지
- S. 167k Album Leaf — <반음계적 대갈롭> S. 219 에 바탕한 앨범의 한 페이지
- S. 167l Album Leaf ("Agitato in G major") — 편곡 S. 576b·577 에 바탕한 앨범의 한 페이지
- S. 167m Album Leaf ("Aus den [Erster] Mephisto-Walzer, Episode aus Lenaus Faust – Der Tanz in der Dorfschenke") — <메피스토 왈츠 1번>에서 따온 앨범의 한 페이지
- S. 167q Album Leaf ("Schlusschor des entfesselten Prometheus – Andante solenne in D♭ major") — <해방된 프로메테우스> 끝 합창에서 따온 앨범의 한 페이지
- S. 167t Album Leaf — <사랑의 찬가> S. 173/10 에 바탕한 앨범의 한 페이지

### 머리 행(곡은 따로 넣음) (split) — 2

- S. 164e Three Album Leaves ("Magyar") — 머리 행. 1번은 2번의 옛 판이라 2·3번만 낱곡으로 둠
- S. 268 Vortragsstücke (2): — <2개의 연주용 소품> 머리 행. 2번은 S. 112/1 편곡이라 1번만 낱곡으로 둠

## 4. 애매했던 판단

- **원작·편곡 경계** — 위키백과 표의 원작 구역(S. 1–350)을 바탕으로 삼고, 편곡 구역(S. 351 이상)은 대표 판 세 개(S. 514·515·541)만 가져왔습니다. 원작 구역 안이라도 남의 특정 곡을 옮기거나 그 주제로 만든 환상곡·패러프레이즈(베를리오즈 <렐리오> S. 120, 베토벤 <아테네의 폐허> S. 122, 로시니·스폰티니 즉흥곡 S. 150, 멘델스존 S. 257, 헨델 S. 181, 알랴비예프·불라호프 S. 249d·250, 가르시아 S. 252, 루이 페르디난트 비가 S. 168 등)는 뺐습니다. 변주곡(S. 147·148·149·180), 바흐 주제 전주곡 S. 179, 코랄 환상곡 <Ad nos> S. 259, 듀오 소나타 S. 127(쇼팽 마주르카 주제), 그랑 듀오 S. 128(라퐁 로망스 주제)은 리스트의 작곡으로 보고 넣었습니다. 파가니니 대연습곡 S. 141 은 리드 메모대로 넣었습니다.
- **민요·국가·전래 선율** — 명세의 '민요 편곡 빼기'에 맞춰 선율 하나를 피아노로 옮긴 곡(라코치 행진곡 단독판 S. 242a·244a·244b·244c·164f, God Save the Queen S. 235, 라 마르세예즈 S. 237, Gaudeamus igitur S. 240·71, 헝가리 민요 5곡 S. 245, 러시아·폴란드·카자크 선율 S. 249a·249b·249c·251, 라 로마네스카 S. 252a·b 등)는 뺐습니다. 헝가리 광시곡 S. 244, 그 앞선 모음 S. 242·243, 스페인 광시곡 S. 254, 스페인 선율 대연주회 환상곡 S. 253, 보로닌체의 이삭줍기 S. 249, 나폴리의 노래 S. 248ii 는 리스트가 크게 다시 지은 곡이라 넣었습니다. 경계가 흐린 곳이라 검토가 필요합니다.
- **메피스토 왈츠** — 1번: 원판인 관현악판은 S. 110 <레나우의 파우스트에 의한 2개의 에피소드> 2번 part 로 들어 있고, 널리 연주되는 피아노판 S. 514 를 따로 낱곡으로 넣었습니다(같은 곡이 두 번 나옴). 2번: 위키가 피아노판 S. 515 를 원판, 관현악판 S. 111 을 그 편곡으로 적어 S. 515 만 넣었습니다. 3·4번은 피아노 원작(S. 216·216b).
- **사랑의 꿈** — 피아노판 S. 541 을 3곡 묶음으로 넣고(운영 139 = 3번 part), 원래 가곡 S. 307(Hohe Liebe)·308(Gestorben war ich)·298/2(O lieb, so lang du lieben kannst)도 가곡 쪽에 따로 넣었습니다. 2번 조성은 위키 표·MB 모두 E♭장조라 그대로 두었는데, E장조로 적는 자료도 있어 확인이 필요합니다.
- **교향시 13번** — 위키는 <요람에서 무덤까지> S. 107 을 피아노판 S. 512 의 편곡으로 적지만 교향시 연번에 들어가는 관현악판을 대표로 두고 MB 대로 3부분을 악장 part 로 나눴습니다.
- **옛 판만 있는 곡** — 위키가 묶음 전체를 옛 판으로 적은 S. 136·137·140·159·171a·172a·185a·205 는 통째로 뺐습니다. 그래서 새 판에 안 실린 곡 몇 개가 빠집니다: <베네치아와 나폴리> 1840년판 1·2번(S. 159/1·2), 12개의 연습곡 11번(S. 136/11), 위안 첫 판 3번(S. 171a/3), <시적이고 종교적인 선율> 첫 판의 <마리아의 연도>(S. 171e·172a/4)와 [찬가](S. 172a/10), <슬픈 곤돌라> 6/8 판(S. 200/1, 위키는 2판). <슬픈 곤돌라>는 연주에서 1·2번 두 곡으로 많이 다루니 S. 200/1 을 살릴지 검토가 필요합니다.
- **옛 판인데 따로 둔 묶음** — <나그네의 앨범> S. 156 은 여러 곡이 순례의 해 제1년 S. 160 의 옛 판이고 3권은 S. 156a 의 옛 판이지만, 위키가 묶음 전체를 옛 판으로 적지 않았고 따로 출판·녹음되는 모음이라 넣었습니다(책 3권 → part, 곡 → children). <헝가리 민요와 광시곡> S. 242 도 같은 까닭으로 넣었습니다(헝가리 광시곡 S. 244 의 앞선 모음, 2권 23곡).
- **머리 행 없는 묶음 S. 90** — 위키에 S. 90 머리 행이 없고 90/1a–12b 가 곡마다 옛 판과 함께 따로 적혀 있습니다. 1860년대 <Für Männergesang> 12곡(각 곡 마지막 판)을 묶음 하나로 만들었습니다. catalogueAlt(LW)는 비워 두었습니다.
- **판 고르기** — 같은 번호 아래 판이 여럿이면 마지막 판(시편 23편은 소실된 5판 대신 4판 S. 15/2b, 시편 137편은 2판)을 넣었습니다. 출판된 묶음 안 곡은 출판본을 두고 뒤의 수고 판·확장판은 뺐습니다(잊힌 왈츠 3번 S. 215/3a, 즉흥 왈츠 S. 213a, 샘가에서 1863년판 S. 160/4a, 자장가 1882년판 S. 186/7a).
- **같은 이름의 앨범의 한 페이지** — 조성·별칭으로 갈리지 않는 S. 166c·166l/1(둘 다 A♭장조)·167h(조성 없음)는 제목 끝에 (S. 번호)를 붙였습니다. 위키에 S. 166a 가 두 줄(E장조 1843, A장조 1870) 있어 MB 와 같은 E장조만 넣었습니다.
- **다른 곡에서 따온 소품** — 앨범의 한 페이지 가운데 자기 곡·남의 곡에서 따오거나 그 위에 지은 것(S. 164, 166n, 166o, 166r, 167c–f, 167k–m, 167p, 167q, 167t)과 파가니니 6번 도입부(S. 141/6a)는 뺐습니다.
- **가곡 제목** — 가곡 82곡·가곡집 4개는 모두 원제를 그대로 썼습니다(우리말 관용 제목이 확실하지 않음). 같은 시에 따로 곡을 붙인 S. 288/1·2·3(Was Liebe sei), S. 280/S. 280a, S. 309/309a 는 위키가 setting(별개 작곡)으로 적어 각각 넣고 I·II·III 을 붙였습니다.
- **<4성부 남성 합창곡> S. 72·<로사리오> S. 56·<바르트부르크의 노래> S. 345** — S. 72 의 1번 관현악 반주판(S. 72/1a, 후버 편성)은 뺐습니다. S. 56 4번 Pater noster 는 로사리오용인지 확실치 않다는 메모가 있지만 4번으로 출판돼 넣었습니다. S. 345 는 서곡 격 An Frau Minne(S. 345/0)를 1번 자리에 두어 7곡입니다.
- **다악장 악장 구성** — 파우스트 교향곡은 MB 가 끝의 신비의 합창을 4번째 part 로 두지만 관례대로 3악장. 세크사르드 미사 S. 8/2 는 MB work 가 없어 미사 통상문 6부분으로 두었습니다(MBID null). 피아노 협주곡 2번·소나타 B단조·죽음의 무도·Ad nos·B-A-C-H 전주곡과 푸가·스케르초와 행진곡은 위키에 자식 행이 없어 낱곡입니다(MB 는 일부를 부분으로 나눔).
- **오라토리오·칸타타** — 명세대로 성 엘리자베트의 전설·그리스도·슈트라스부르크 대성당의 종·베토벤 칸타타 2곡·헤르더 프로메테우스 합창곡·십자가의 길·Septem sacramenta 는 part 없이 낱곡입니다. 미사 4개·레퀴엠·오르간 미사는 다악장.

작품별 메모(defs.py `note`):

- S. 8/2: MB 에 작품·악장 work 없음. 악장은 미사 통상문 6부분으로 둠
- S. 17/2: 3판(S. 17/3)은 소실이라 2판
- S. 18: 1번 Qui m'a donné la naissance 는 미완성이라 뺌(4곡)
- S. 56: 4번 Pater noster 는 로사리오용인지 확실치 않다는 메모가 있으나 4번으로 출판돼 넣음
- S. 90: 위키에 묶음 행이 없고 90/n 마다 옛 판(a·b)이 따로 있음. 1860년대 출판본 <Für Männergesang> 12곡(각 곡 마지막 판)을 묶음으로 만듦
- S. 107: 위키는 피아노판 S. 512 의 편곡이라 적지만 교향시 13번으로 이쪽을 대표 판으로 둠
- S. 108: MB 는 끝의 신비의 합창(Chorus mysticus)을 4번째 part 로 따로 둠. 관례대로 3악장에 포함
- S. 156: 여러 곡이 순례의 해 제1년 S. 160 의 옛 판이고 3권은 S. 156a 의 옛 판이지만, 위키가 묶음 전체를 옛 판으로 적지 않아 따로 둠
- S. 166a: 위키에 S. 166a 가 두 줄(E장조 1843, A장조 1870). MB 와 같은 E장조만 넣음
- S. 166c: 같은 조성 앨범의 한 페이지가 겹쳐 제목에 번호를 붙임
- S. 166l/1: 같은 조성 앨범의 한 페이지가 겹쳐 제목에 번호를 붙임
- S. 167h: 조성·별칭이 없어 제목에 번호를 붙임
- S. 169: 위키는 S. 527 <잊힌 로망스>로 고쳐 썼다고 적으나 30년 뒤 다시 쓴 곡이라 둘을 다른 곡으로 봄. S. 527 은 편곡 구역이라 뺌
- S. 174: 두 판이 있다는 메모만 있고 번호가 하나라 S. 174 로 둠. MBID 는 고친 판(S. 174/2)
- S. 200/2: 위키는 S. 200/1(6/8)을 2판, S. 200/2(4/4)를 3판으로 적음. 마지막 판만 넣음. 연주에서는 1·2번 두 곡으로 많이 다룸
- S. 213: S. 213a 는 뒤에 덧붙인 확장판이지만 출판본 S. 213 을 대표로 둠
- S. 215: 3번은 출판본(S. 215/3), 파리 수고 판 S. 215/3a 는 뺌. 4번은 조성 표기가 없어 이름에 곡 이름을 씀
- S. 242: 헝가리 광시곡 S. 244 의 앞선 모음. 몇 곡(4·5·7·11·23번)은 S. 243·244 의 옛 판이지만 위키가 묶음 전체를 옛 판으로 적지 않아 따로 둠
- S. 268/1: S. 268 <2개의 연주용 소품> 의 2번은 S. 112/1 편곡이라 1번만 낱곡으로 둠
- S. 345: 서곡 격인 An Frau Minne(S. 345/0)를 1번 자리에 둠
- S. 514: 관현악판(S. 110/2)이 원판이고 S. 110 묶음 2번에도 있음. 널리 연주되는 피아노판을 따로 넣음
- S. 515: 위키는 피아노판 S. 515 를 원판, 관현악판 S. 111 을 그 편곡으로 적음. 피아노판을 넣고 S. 111 은 뺌
- S. 541: 가곡판 S. 307·308·298 은 가곡 쪽에 따로 넣음

## 5. 직접 옮긴 우리말 이름(검수용)

가곡·합창곡·멜로드라마는 원제를 그대로 썼습니다. 아래는 제가 옮긴 작품 제목과 part 이름입니다.

### 작품 제목

| S. | titleKo | titleEn |
|---|---|---|
| 1 | 오페라 <돈 산슈> | Opera <Don Sanche, ou Le château de l'amour> |
| 2 | 오라토리오 <성 엘리자베트의 전설> | Oratorio <Die Legende von der heiligen Elisabeth> |
| 3 | 오라토리오 <그리스도> | Oratorio <Christus> |
| 4/2 | <아시시의 성 프란치스코의 태양의 찬가> | Cantico del sol di Francesco d'Assisi |
| 5/2 | <성 체칠리아의 전설> | Sainte Cécile (Die heilige Cäcilia) |
| 6 | 칸타타 <슈트라스부르크 대성당의 종> | Cantata <Die Glocken des Strassburger Münsters> |
| 8/2 | 남성 합창 미사 "세크사르드" | Missa quattuor vocum ad aequales "Szekszárd Mass" |
| 9 | 그란 미사 | Missa solennis "Graner Messe" |
| 10 | 미사 코랄리스 | Missa choralis |
| 11 | 헝가리 대관식 미사 | Hungarian Coronation Mass |
| 12 | 레퀴엠 | Requiem (Missa pro defunctis) |
| 13/2 | 시편 13편 | Psalm 13 "Herr, wie lange willst du meiner so gar vergessen" |
| 14/2 | 시편 18편 | Psalm 18 "Coeli enarrant gloriam Dei" |
| 15/2b | 시편 23편 | Psalm 23 "Mein Gott, der ist mein Hirt" |
| 16/2 | 시편 129편 | Psalm 129 "De profundis" |
| 17/2 | 시편 137편 | Psalm 137 "An den Wassern zu Babylon" |
| 18 | 프랑스어 가사 합창곡 S. 18 | Choruses with French Texts, S. 18 |
| 53 | <십자가의 길> | Via crucis |
| 56 | 합창곡집 <로사리오> | Rosario |
| 59 | 합창곡집 <Pro Papa> | Pro Papa |
| 67 | 칸타타 <본 베토벤 기념비 제막 축전 칸타타> | Festkantate zur Enthüllung des Beethoven-Denkmals in Bonn (Beethoven Cantata No. 1) |
| 68 | 칸타타 <베토벤 탄생 100주년 축전 칸타타> | Zur Säcularfeier Beethovens (Beethoven Cantata No. 2) |
| 69iii | <헤르더의 '해방된 프로메테우스'를 위한 합창곡> | Chöre zu Herders Entfesseltem Prometheus |
| 80 | 남성 합창곡집 <4원소> | Les quatre élémens |
| 83a | <헝가리아 칸타타> | Ungaria-Kantate |
| 90 | 남성 합창곡집 <Für Männergesang> | Für Männergesang, S. 90 |
| 95 | 교향시 <산 위에서 들은 것> | Symphonic Poem <Ce qu'on entend sur la montagne> |
| 96 | 교향시 <타소, 비탄과 승리> | Symphonic Poem <Tasso, lamento e trionfo> |
| 97 | 교향시 <전주곡> | Symphonic Poem <Les Préludes> |
| 98 | 교향시 <오르페우스> | Symphonic Poem <Orpheus> |
| 99 | 교향시 <프로메테우스> | Symphonic Poem <Prometheus> |
| 100 | 교향시 <마제파> | Symphonic Poem <Mazeppa> |
| 101 | 교향시 <축제의 울림> | Symphonic Poem <Festklänge> |
| 102 | 교향시 <영웅의 장송곡> | Symphonic Poem <Héroïde funèbre> |
| 103 | 교향시 <헝가리아> | Symphonic Poem <Hungaria> |
| 104 | 교향시 <햄릿> | Symphonic Poem <Hamlet> |
| 105 | 교향시 <훈족의 싸움> | Symphonic Poem <Hunnenschlacht> |
| 106 | 교향시 <이상> | Symphonic Poem <Die Ideale> |
| 107 | 교향시 <요람에서 무덤까지> | Symphonic Poem <Von der Wiege bis zum Grabe> |
| 108 | 파우스트 교향곡 | A Faust Symphony |
| 109 | 단테 교향곡 | A Symphony to Dante's Divina Commedia |
| 110 | 레나우의 <파우스트>에 의한 2개의 에피소드 | Two Episodes from Lenau's Faust |
| 112 | 3개의 장송 송가 | Three Odes funèbres |
| 113/2 | 관현악곡 <살베 폴로니아> | Salve Polonia |
| 114 | <예술가 축제 행렬> | Künstlerfestzug zur Schillerfeier 1859 |
| 115 | <괴테 기념 축제 행진곡> | Festmarsch zur Goethe-Jubiläumsfeier |
| 118 | <헝가리 대관식 행진곡> | Ungarischer Marsch zur Krönungsfeier in Ofen-Pest |
| 119 | <헝가리 돌격 행진곡> | Ungarischer Sturmmarsch |
| 121 | <저주> E단조 | Malédiction in E minor |
| 123 | 헝가리 환상곡 | Fantasia on Hungarian Folk Melodies |
| 124 | 피아노 협주곡 1번 E♭장조 | Piano Concerto No. 1 in E♭ major |
| 125 | 피아노 협주곡 2번 A장조 | Piano Concerto No. 2 in A major |
| 126ii | <죽음의 무도> | Totentanz |
| 126b | 바이올린과 피아노를 위한 2개의 왈츠 | Two Waltzes for Violin and Piano |
| 127 | 듀오 소나타 C#단조 | Duo (Sonata) in C# minor |
| 128 | "르 마랭" 주제에 의한 그랑 듀오 콘세르탕 | Grand duo concertant sur la romance de M. Lafont "Le marin" |
| 129 | <결혼 축가> | Epithalam |
| 135 | <리하르트 바그너의 무덤에서> | Am Grabe Richard Wagners |
| 139 | 초절기교 연습곡 S. 139 | 12 Transcendental Études, S. 139 |
| 141 | 파가니니 대연습곡 S. 141 | 6 Grandes études de Paganini, S. 141 |
| 143 | 연습곡 E단조 "아브 이라토" | Étude in E minor "Ab irato" |
| 144 | 3개의 연주회용 연습곡 S. 144 | 3 Études de concert, S. 144 |
| 145 | 2개의 연주회용 연습곡 S. 145 | 2 Konzertetüden, S. 145 |
| 146 | <기술적 연습곡> | Technische Studien |
| 147 | 디아벨리 왈츠에 의한 변주 C단조 | Variation on a Waltz by Diabelli in C minor |
| 148 | 8개의 변주곡 A♭장조 | 8 Variations in A♭ major |
| 149 | 로시니 주제에 의한 7개의 화려한 변주곡 | 7 Variations brillantes sur un thème de Rossini |
| 151 | 알레그로 디 브라부라 E♭단조 | Allegro di bravura in E♭ minor |
| 151a | 아다지오 논 트로포 | Adagio non troppo |
| 152 | 론도 디 브라부라 E단조 | Rondo di bravura in E minor |
| 153 | 스케르초 G단조 | Scherzo in G minor |
| 155 | 피아노 모음곡 <환영> | Apparitions |
| 156 | 피아노 모음곡 <나그네의 앨범> | Album d'un voyageur |
| 156a | 피아노 모음곡 <3개의 스위스 소품> | Trois morceaux suisses |
| 157 | 두 개의 스위스 선율에 의한 낭만적 환상곡 | Fantaisie romantique sur deux mélodies suisses |
| 157d | 콰지 마주르카 | Quasi mazurka |
| 160 | 피아노 모음곡 <순례의 해 제1년: 스위스> | Années de pèlerinage I: Suisse |
| 161 | 피아노 모음곡 <순례의 해 제2년: 이탈리아> | Années de pèlerinage II: Italie |
| 162 | 피아노 모음곡 <순례의 해 제2년 보유: 베네치아와 나폴리> | Années de pèlerinage II, Supplément: Venezia e Napoli |
| 163 | 피아노 모음곡 <순례의 해 제3년> | Années de pèlerinage III |
| 163a/1 | 앨범의 한 페이지 F#단조 | Album Leaf in F# minor |
| 163a/2 | 안단티노 E♭장조 | Andantino in E♭ major |
| 163b | 앨범의 한 페이지 A♭장조 "아, 어머니께 말씀드릴게요" | Album Leaf in A♭ major "Ah! vous dirai-je, maman" |
| 163c | 앨범의 한 페이지 C단조 "프레스부르크" | Album Leaf in C minor "Pressburg" |
| 163d | 앨범의 한 페이지 E장조 "라이프치히" | Album Leaf in E major "Leipzig" |
| 163e | 앨범의 한 페이지 C장조 "콰지 마주레크" | Album Leaf in C major "Quasi mazurek" |
| 164a | 앨범의 한 페이지 E장조 "빈" | Album Leaf in E major "Vienna" |
| 164b | 앨범의 한 페이지 E♭장조 "라이프치히" | Album Leaf in E♭ major "Leipzig" |
| 164c | 앨범의 한 페이지 "엑서터 전주곡" | Album Leaf "Exeter Preludio" |
| 164d | 앨범의 한 페이지 E장조 "데트몰트" | Album Leaf in E major "Detmold" |
| 164e/2 | 앨범의 한 페이지 B♭단조 "머저르" | Album Leaf in B♭ minor "Magyar" |
| 164e/3 | 앨범의 한 페이지 D♭장조 "머저르" | Album Leaf in D♭ major "Magyar" |
| 164g | 앨범의 한 페이지 C장조 "베를린 전주곡" | Album Leaf in C major "Berlin Preludio" |
| 164h | 앨범의 한 페이지 D장조 | Album Leaf in D major |
| 164j | 앨범의 한 페이지 "전주곡" | Album Leaf "Preludio" |
| 164k | 앨범의 한 페이지 D♭장조 "모데라토" | Album Leaf in D♭ major "Moderato" |
| 164l | 앨범의 한 페이지 C장조 "아다지오 – 렐리조소" | Album Leaf in C major "Adagio – religioso" |
| 165 | <앨범의 페이지들> A♭장조 | Feuilles d'album in A♭ major |
| 166 | 왈츠 형식의 앨범의 한 페이지 A장조 | Albumblatt in Walzerform in A major |
| 166a | 앨범의 한 페이지 E장조 | Album Leaf in E major |
| 166b | 앨범의 한 페이지 A♭장조 "포르투갈" | Album Leaf in A♭ major "Portugal" |
| 166c | 앨범의 한 페이지 A♭장조 (S. 166c) | Album Leaf in A♭ major (S. 166c) |
| 166d | 앨범의 한 페이지 "리옹 전주곡" | Album Leaf "Lyon Prélude" |
| 166e | 앨범의 한 페이지 "모든 조성의 전주곡" | Album Leaf "Prélude omnitonique" |
| 166f | 앨범의 한 페이지 F#장조 "브라운슈바이크 전주곡" | Album Leaf in F# major "Braunschweig Preludio" |
| 166g | 앨범의 한 페이지 A단조 "세레나데" | Album Leaf in A minor "Serenade" |
| 166j | 앨범의 한 페이지 G장조 "안단테 렐리조사멘테" | Album Leaf in G major "Andante religiosamente" |
| 166k | 앨범의 한 페이지 A장조 "프리스카" | Album Leaf in A major "Friska" |
| 166l/1 | 앨범의 한 페이지 A♭장조 (S. 166l/1) | Album Leaf in A♭ major (S. 166l/1) |
| 166l/2 | 앨범의 한 페이지 G단조 | Album Leaf in G minor |
| 166m | 마리 폰 자인비트겐슈타인 공녀를 위한 앨범의 페이지들 | Albumblätter für Prinzessin Marie von Sayn-Wittgenstein |
| 166p | 앨범의 한 페이지 A♭장조 "안단티노" | Album Leaf in A♭ major "Andantino" |
| 166q | 앨범의 한 페이지 G장조 | Album Leaf in G major |
| 166s | 앨범의 한 페이지 A장조 | Album Leaf in A major |
| 167g | 앨범의 한 페이지 D♭장조 "비바체 마 논 트로포" | Album Leaf in D♭ major "Vivace ma non troppo" |
| 167h | 앨범의 한 페이지 (S. 167h) | Album Leaf (S. 167h) |
| 167j | 앨범의 한 페이지 G단조 "반음계 푸가" | Album Leaf in G minor "Fugue chromatique" |
| 167n | 앨범의 한 페이지 A장조 "알레그레토" | Album Leaf in A major "Allegretto" |
| 167o | 앨범의 한 페이지 E♭장조 "행진곡 빠르기로" | Album Leaf in E♭ major "Tempo di marcia" |
| 167r | 앨범의 한 페이지 E♭장조 "안단테" | Album Leaf in E♭ major "Andante" |
| 167s | 앨범의 한 페이지 C장조 "리옹" | Album Leaf in C major "Lyon" |
| 168b | 녹턴 A장조 "사색" | Pensées (Nocturne) in A major |
| 169 | 로망스 E단조 "오, 왜 그런가" | Romance in E minor "O pourquoi donc" |
| 170 | 발라드 1번 D♭장조 "십자군의 노래" | Ballade No. 1 in D♭ major "Le chant du croisé" |
| 171 | 발라드 2번 B단조 | Ballade No. 2 in B minor |
| 172 | 피아노 모음곡 <위안> | Consolations, S. 172 |
| 172b | <스타바트 마테르> | Stabat mater |
| 173 | 피아노 모음곡 <시적이고 종교적인 선율> | Harmonies poétiques et religieuses, S. 173 |
| 173a | 2개의 찬가 S. 173a | 2 Hymnes, S. 173a |
| 174 | 자장가 D♭장조 | Berceuse in D♭ major |
| 175 | 피아노 모음곡 <2개의 전설> | Deux légendes |
| 176 | 대연주회 독주곡 E단조 | Grosses Konzertsolo in E minor |
| 177 | 스케르초와 행진곡 D단조 | Scherzo und Marsch in D minor |
| 178 | 피아노 소나타 B단조 | Piano Sonata in B minor |
| 179 | 전주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며" | Prelude in F minor "Weinen, Klagen, Sorgen, Zagen" |
| 180 | 바흐 주제에 의한 변주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며" | Variations on a Theme by Bach in F minor "Weinen, Klagen, Sorgen, Zagen" |
| 182 | 아베 마리아 E장조 "로마의 종" | Ave Maria in E major "Die Glocken von Rom" |
| 183/1 | 알렐루야 F장조 | Alleluja in F major |
| 184 | <우르비 에트 오르비> | Urbi et orbi (Bénédiction papale) |
| 186 | 피아노 모음곡 <크리스마스 트리> | Weihnachtsbaum |
| 187 | <성 도로테아> E장조 | Sancta Dorothea in E major |
| 187b | <체념> E장조 | Resignazione in E major |
| 188 | <주님의 거룩한 변모 축일에> | In festo transfigurationis Domini nostri Jesu Christi |
| 191 | 즉흥곡 F#장조 | Impromptu in F# major |
| 192 | 5개의 피아노곡 S. 192 | 5 Klavierstücke, S. 192 |
| 196 | 비가 1번 | Elegy No. 1 |
| 197 | 비가 2번 | Elegy No. 2 |
| 197a | 토카타 C장조 | Toccata in C major |
| 197b | <카이저 빌헬름!> | Kaiser Wilhelm! |
| 198 | <요람의 노래> | Wiegenlied (Chant du berceau) |
| 199 | <잿빛 구름> | Nuages gris (Trübe Wolken) |
| 200/2 | <슬픈 곤돌라> | La lugubre gondola |
| 201 | <R.W. – 베네치아> | R.W. – Venezia |
| 203 | <잠 못 이루고! 물음과 대답> | Schlaflos! Frage und Antwort |
| 204 | <명상> | Recueillement |
| 205a | 피아노 모음곡 <헝가리 역사 인물 초상> | Historische ungarische Bildnisse |
| 206 | 장송 전주곡과 장송 행진곡 | Trauervorspiel und Trauermarsch |
| 207 | 녹턴 "꿈속에서" | En rêve (Nocturne) |
| 207a | 보로딘의 폴카에 의한 전주곡 | Prélude à la Polka de Borodine |
| 208 | <불길한 별!> | Unstern! (Sinistre, disastro) |
| 209a | 왈츠 E♭장조 | Waltz in E♭ major |
| 210b | 왈츠 A장조 | Waltz in A major |
| 211 | 렌틀러 A♭장조 | Ländler in A♭ major |
| 211a | 렌틀러 D장조 | Ländler in D major |
| 212ii | 작은 왈츠 "상트페테르부르크의 추억" | Petite valse favorite "Souvenir de St Pétersbourg" |
| 212a | <마리를 위한 왈츠> | Valse pour Marie |
| 213 | 즉흥 왈츠 | Valse-Impromptu |
| 214 | 3개의 카프리스 왈츠 S. 214 | 3 Caprices-Valses, S. 214 |
| 214a | <펠레나르본 부인의 회전목마> | Carrousel de Madame Pelet-Narbonne |
| 215 | 잊힌 왈츠 S. 215 | 4 Valses oubliées, S. 215 |
| 216 | 메피스토 왈츠 3번 | Mephisto Waltz No. 3 |
| 216a | <조성 없는 바가텔> | Bagatelle sans tonalité |
| 216b | 메피스토 왈츠 4번 | Mephisto Waltz No. 4 |
| 217 | 메피스토 폴카 | Mephisto Polka |
| 218 | 갈롭 A단조 | Galop in A minor |
| 219 | 반음계적 대갈롭 E♭장조 | Grand galop chromatique in E♭ major |
| 220 | <무도회 갈롭> | Galop de bal |
| 221 | 화려한 마주르카 | Mazurka brillante |
| 223 | 2개의 폴로네즈 S. 223 | 2 Polonaises, S. 223 |
| 224 | <죽음의 차르다시> | Csárdás macabre |
| 225 | 2개의 차르다시 S. 225 | 2 Csárdás, S. 225 |
| 226 | <축전 전주곡> | Festvorspiel (Preludio pomposo) |
| 228 | <경의의 행진곡> C장조 | Huldigungsmarsch in C major |
| 229 | <바위에서 바다로!> E♭장조 | Vom Fels zum Meer! (Deutscher Siegesmarsch) in E♭ major |
| 229a | 헝가리 행진곡 B♭장조 | Ungarischer Marsch in B♭ major |
| 230 | <뷜로 행진곡> | Bülow-Marsch |
| 230a | <축전 폴로네즈> | Festpolonaise |
| 231 | 헝가리풍 영웅 행진곡 A단조 | Heroischer Marsch im ungarischen Stil in A minor |
| 233 | 헝가리 급행진곡 | Ungarischer Geschwindmarsch |
| 233a | 승리 행진곡 E♭장조 | Siegesmarsch in E♭ major |
| 233b | 헝가리 행진곡 E♭단조 | Marche hongroise in E♭ minor |
| 242 | 피아노 모음곡 <헝가리 민요와 광시곡> | Magyar dalok & Magyar rapszódiák |
| 243 | 3개의 헝가리 민족 선율 S. 243 | Ungarische Nationalmelodien, S. 243 |
| 244 | 헝가리 광시곡 S. 244 | 19 Hungarian Rhapsodies, S. 244 |
| 248ii | 나폴리의 노래 "녹턴" | Canzone napolitana (Notturno) |
| 249 | 피아노 모음곡 <보로닌체의 이삭줍기> | Glanes de Woronince |
| 253 | 스페인 선율에 의한 대연주회 환상곡 | Grosse Konzertfantasie über spanische Weisen |
| 254 | 스페인 광시곡 | Rhapsodie espagnole |
| 258ii | <비창 협주곡> | Concerto pathétique for two pianos |
| 259 | 코랄 "Ad nos, ad salutarem undam"에 의한 환상곡과 푸가 | Fantasy and Fugue on the Chorale "Ad nos, ad salutarem undam" |
| 260ii | B-A-C-H 주제에 의한 전주곡과 푸가 | Prelude and Fugue on the Name B-A-C-H |
| 261 | 오르간곡 <교황 찬가> | Pio IX (Der Papsthymnus) |
| 264 | 오르간 미사 | Missa pro organo lectarum celebrationi missarum adjumento inserviens |
| 270b | 가곡집 <페트라르카의 3개의 소네트> | Tre sonetti di Petrarca (second version) |
| 292b | 가곡집 <실러의 '빌헬름 텔'에 의한 3개의 가곡> | Lieder aus Schillers Wilhelm Tell (second version) |
| 316 | 가곡집 <Muttergottes-Sträusslein zum Mai-Monate> | Muttergottes-Sträusslein zum Mai-Monate |
| 345 | <바르트부르크의 노래> | Wartburg-Lieder |
| 514 | 메피스토 왈츠 1번 | Mephisto Waltz No. 1 (Der Tanz in der Dorfschenke) |
| 515 | 메피스토 왈츠 2번 | Mephisto Waltz No. 2 |
| 541 | 피아노 모음곡 <사랑의 꿈> | Liebesträume, S. 541 |

### part 이름·별명

| S. | nameKo | nameEn |
|---|---|---|
| 8/2 | 키리에 | I. Kyrie |
| 8/2 | 글로리아 | II. Gloria |
| 8/2 | 크레도 | III. Credo |
| 8/2 | 상투스 | IV. Sanctus |
| 8/2 | 베네딕투스 | V. Benedictus |
| 8/2 | 아뉴스 데이 | VI. Agnus Dei |
| 9 | 키리에. Andante solenne | I. Kyrie. Andante solenne |
| 9 | 글로리아. Allegro, ma non troppo | II. Gloria. Allegro, ma non troppo |
| 9 | 크레도. Andante maestoso, risoluto | III. Credo. Andante maestoso, risoluto |
| 9 | 상투스. Andante solenne | IV. Sanctus. Andante solenne |
| 9 | 베네딕투스. Andante con pietà | V. Benedictus. Andante con pietà |
| 9 | 아뉴스 데이. Adagio non troppo | VI. Agnus Dei. Adagio non troppo |
| 10 | 키리에 | I. Kyrie |
| 10 | 글로리아 | II. Gloria |
| 10 | 크레도 | III. Credo |
| 10 | 상투스 | IV. Sanctus |
| 10 | 베네딕투스 | V. Benedictus |
| 10 | 아뉴스 데이 | VI. Agnus Dei |
| 11 | 키리에 | I. Kyrie |
| 11 | 글로리아 | II. Gloria |
| 11 | 그라두알레 (시편 116편) | III. Graduale (Psalm 116) |
| 11 | 크레도 | IV. Credo |
| 11 | 오페르토리움 | V. Offertorium |
| 11 | 상투스 | VI. Sanctus |
| 11 | 베네딕투스 | VII. Benedictus |
| 11 | 아뉴스 데이 | VIII. Agnus Dei |
| 12 | 레퀴엠 에테르남 | I. Requiem aeternam |
| 12 | 디에스 이레 | II. Dies irae |
| 12 | 오페르토리움 | III. Offertorium |
| 12 | 상투스 | IV. Sanctus |
| 12 | 아뉴스 데이 | V. Agnus Dei |
| 12 | 리베라 메 | VI. Libera me |
| 56 | 환희의 신비 (Mysteria gaudiosa) | Mysteria gaudiosa |
| 56 | 고통의 신비 (Mysteria dolorosa) | Mysteria dolorosa |
| 56 | 영광의 신비 (Mysteria gloriosa) | Mysteria gloriosa |
| 80 | 땅 (La terre) | La terre |
| 80 | 북풍 (Les aquilons) | Les aquilons |
| 80 | 물결 (Les flots) | Les flots |
| 80 | 별 (Les astres) | Les astres |
| 107 | 요람 (Die Wiege) | I. Die Wiege |
| 107 | 생존을 위한 투쟁 (Der Kampf ums Dasein) | II. Der Kampf ums Dasein |
| 107 | 무덤으로, 미래 생명의 요람 (Zum Grabe: die Wiege des zukünftigen Lebens) | III. Zum Grabe: die Wiege des zukünftigen Lebens |
| 108 | 파우스트. Lento assai – Allegro impetuoso | I. Faust |
| 108 | 그레트헨. Andante soave | II. Gretchen |
| 108 | 메피스토펠레스. Allegro vivace, ironico | III. Mephistopheles |
| 109 | 지옥 (Inferno) | I. Inferno |
| 109 | 연옥 – 마니피캇 (Purgatorio – Magnificat) | II. Purgatorio – Magnificat |
| 110 | 밤의 행렬 (Der nächtliche Zug) | Der nächtliche Zug |
| 110 | 마을 주막의 춤 "메피스토 왈츠 1번" (Der Tanz in der Dorfschenke) | Der Tanz in der Dorfschenke (Mephisto Waltz No. 1) |
| 112 | 죽은 이들 (Les morts) | Les morts |
| 112 | 밤 (La notte) | La notte |
| 112 | 타소의 장례 개선 (Le triomphe funèbre du Tasse) | Le triomphe funèbre du Tasse |
| 126b | A장조 (<아마존> 발레 주제) | No. 2 in A major (Waltz from the ballet Die Amazonen) |
| 127 | 주제와 변주 | II. Tema con variazioni |
| 139 | C장조 "전주곡" | No. 1 in C major "Preludio" |
| 139 | F장조 "풍경" | No. 3 in F major "Paysage" |
| 139 | D단조 "마제파" | No. 4 in D minor "Mazeppa" |
| 139 | B♭장조 "도깨비불" | No. 5 in B♭ major "Feux follets" |
| 139 | G단조 "환영" | No. 6 in G minor "Vision" |
| 139 | E♭장조 "영웅" | No. 7 in E♭ major "Eroica" |
| 139 | C단조 "사냥" | No. 8 in C minor "Wilde Jagd" |
| 139 | A♭장조 "회상" | No. 9 in A♭ major "Ricordanza" |
| 139 | D♭장조 "저녁의 선율" | No. 11 in D♭ major "Harmonies du soir" |
| 139 | B♭단조 "눈보라" | No. 12 in B♭ minor "Chasse-neige" |
| 141 | G단조 "트레몰로" | No. 1 in G minor "Tremolo" |
| 141 | E♭장조 "옥타브" | No. 2 in E♭ major "Octave" |
| 141 | G#단조 "라 캄파넬라" | No. 3 in G# minor "La campanella" |
| 141 | E장조 "아르페지오" | No. 4 in E major "Arpeggio" |
| 141 | E장조 "사냥" | No. 5 in E major "La chasse" |
| 141 | A단조 "주제와 변주" | No. 6 in A minor "Theme and Variations" |
| 144 | A♭장조 "탄식" | No. 1 in A♭ major "Il lamento" |
| 144 | F단조 "가벼움" | No. 2 in F minor "La leggierezza" |
| 144 | D♭장조 "한숨" | No. 3 in D♭ major "Un sospiro" |
| 145 | D♭장조 "숲의 속삭임" | No. 1 in D♭ major "Waldesrauschen" |
| 145 | F#단조 "난쟁이의 춤" | No. 2 in F# minor "Gnomenreigen" |
| 155 | 슈베르트 왈츠에 의한 환상곡 | No. 3 Fantaisie sur une valse de François Schubert |
| 156 | 인상과 시 (Impressions et poésies) | I. Impressions et poésies |
| 156 | 리옹 (Lyon) | Lyon |
| 156 | 발렌슈타트 호수 (Le lac de Wallenstadt) | Le lac de Wallenstadt |
| 156 | 샘가에서 (Au bord d'une source) | Au bord d'une source |
| 156 | 제네바의 종 (Les cloches de Genève) | Les cloches de G[enève] |
| 156 | 오베르만의 골짜기 (Vallée d'Obermann) | Vallée d'Obermann |
| 156 | 빌헬름 텔의 성당 (La chapelle de Guillaume Tell) | La chapelle de Guillaume Tell |
| 156 | 시편 (Psaume) | Psaume (de l'église à Genève) |
| 156 | 알프스의 선율의 꽃 (Fleurs mélodiques des Alpes) | II. Fleurs mélodiques des Alpes |
| 156 | 패러프레이즈 (Paraphrases) | III. Paraphrases |
| 156 | 소 부르는 노래 (Ranz de vaches) | Ranz de vaches (Montée aux Alpes: Improvisata) |
| 156 | 산속의 저녁 (Un soir dans les montagnes) | Un soir dans les montagnes (Nocturne pastoral) |
| 156 | 염소 부르는 노래 (Ranz de chèvres) | Ranz de chèvres de F. Huber (Allegro finale) |
| 156a | 소 부르는 노래 (Ranz de vaches) | Ranz de vaches (Mélodie de Ferdinand Huber, avec variations) |
| 156a | 산속의 저녁 (Un soir dans la montagne) | Un soir dans la montagne (Mélodie d'Ernest Knop) |
| 156a | 염소 부르는 노래 (Ranz de chèvres) | Ranz de chèvres (Rondeau) |
| 160 | 빌헬름 텔의 성당 (Chapelle de Guillaume Tell) | Chapelle de Guillaume Tell |
| 160 | 발렌슈타트 호수에서 (Au lac de Wallenstadt) | Au lac de Wallenstadt |
| 160 | 전원곡 (Pastorale) | Pastorale |
| 160 | 샘가에서 (Au bord d'une source) | Au bord d'une source |
| 160 | 뇌우 (Orage) | Orage |
| 160 | 오베르만의 골짜기 (Vallée d'Obermann) | Vallée d'Obermann |
| 160 | 목가 (Églogue) | Eglogue |
| 160 | 향수 (Le mal du pays) | Le mal du pays (Heimweh) |
| 160 | 제네바의 종 (Les cloches de Genève) | Les cloches de Genève |
| 161 | 혼례 (Sposalizio) | Sposalizio |
| 161 | 생각에 잠긴 사람 (Il penseroso) | Il penseroso |
| 161 | 살바토르 로사의 칸초네타 (Canzonetta del Salvator Rosa) | Canzonetta del Salvator Rosa |
| 161 | 페트라르카의 소네트 47번 (Sonetto 47 del Petrarca) | Sonetto 47 del Petrarca |
| 161 | 페트라르카의 소네트 104번 (Sonetto 104 del Petrarca) | Sonetto 104 del Petrarca |
| 161 | 페트라르카의 소네트 123번 (Sonetto 123 del Petrarca) | Sonetto 123 del Petrarca |
| 161 | 단테를 읽고: 소나타풍 환상곡 (Après une lecture du Dante: Fantasia quasi Sonata) | Après une lecture du Dante (Fantasia quasi Sonata) |
| 162 | 곤돌라 뱃노래 (Gondoliera) | Gondoliera |
| 162 | 칸초네 (Canzone) | Canzone |
| 162 | 타란텔라 (Tarantella) | Tarantella |
| 163 | 삼종기도! 수호천사에게 드리는 기도 (Angelus! Prière aux anges gardiens) | Angelus! Prière aux anges gardiens |
| 163 | 에스테 장의 사이프러스에게: 애가 I (Aux cyprès de la Villa d'Este: Thrénodie I) | Aux cyprès de la Villa d'Este (Thrénodie I) |
| 163 | 에스테 장의 사이프러스에게: 애가 II (Aux cyprès de la Villa d'Este: Thrénodie II) | Aux cyprès de la Villa d'Este (Thrénodie II) |
| 163 | 에스테 장의 분수 (Les jeux d'eaux à la Villa d'Este) | Les jeux d'eaux à la Villa d'Este |
| 163 | 눈물 어린 것들, 헝가리 선법으로 (Sunt lacrymae rerum, en mode hongrois) | Sunt lacrymae rerum, en mode hongrois |
| 163 | 장송 행진곡 (Marche funèbre) | Marche funèbre |
| 163 | 마음을 드높이 (Sursum corda) | Sursum corda (Erhebet eure Herzen) |
| 166m | 백합 (Lilie) | Lilie |
| 166m | 마주레크 A장조 | Mazurek in A major |
| 166m | 크라코비악 F장조 | Krakowiak in F major |
| 173 | 기원 (Invocation) | Invocation |
| 173 | 아베 마리아 (Ave Maria) | Ave Maria |
| 173 | 고독 속의 신의 축복 (Bénédiction de Dieu dans la solitude) | Bénédiction de Dieu dans la solitude |
| 173 | 죽은 이들의 회상 (Pensée des morts) | Pensée des morts |
| 173 | 주님의 기도 (Pater noster) | Pater noster |
| 173 | 잠에서 깬 아이의 찬가 (Hymne de l'enfant à son réveil) | Hymne de l'enfant à son réveil |
| 173 | 장송 (Funérailles) | Funérailles |
| 173 | 팔레스트리나풍 미제레레 (Miserere d'après Palestrina) | Miserere d'après Palestrina |
| 173 | 안단테 라그리모소 (Andante lagrimoso) | Andante lagrimoso |
| 173 | 사랑의 찬가 (Cantique d'amour) | Cantique d'amour |
| 173a | 밤의 찬가 (Hymne de la nuit) | Hymne de la nuit |
| 173a | 아침의 찬가 (Hymne du matin) | Hymne du matin |
| 175 | 새들에게 설교하는 아시시의 성 프란치스코 (St François d'Assise: la prédication aux oiseaux) | St François d'Assise: la prédication aux oiseaux |
| 175 | 물 위를 걷는 파올라의 성 프란치스코 (St François de Paule marchant sur les flots) | St François de Paule: marchant sur les flots |
| 186 | 옛 크리스마스 노래 (Psallite) | Altes Weihnachtslied (Psallite) |
| 186 | 오 거룩한 밤 (O heilige Nacht!) | O heilige Nacht! |
| 186 | 구유 곁의 목자들 (Die Hirten an der Krippe) | Die Hirten an der Krippe ("In dulci jubilo") |
| 186 | 아데스테 피델레스 (Adeste fideles) | Adeste fideles (Gleichsam als Marsch der heiligen drei Könige) |
| 186 | 스케르초소 (Scherzoso) | Scherzoso (Man zündet die Kerzen des Baumes an) |
| 186 | 카리용 (Carillon) | Carillon |
| 186 | 자장가 (Schlummerlied) | Schlummerlied |
| 186 | 옛 프로방스 크리스마스 노래 (Altes provenzalisches Weihnachtslied) | Altes provenzalisches Weihnachtslied |
| 186 | 저녁 종 (Abendglocken) | Abendglocken |
| 186 | 옛날 (Ehemals) | Ehemals |
| 186 | 헝가리풍 (Ungarisch) | Ungarisch |
| 186 | 폴란드풍 (Polnisch) | Polnisch |
| 192 | "한숨!" (Sospiri!) | No. 5 "Sospiri!" |
| 205a | 세체니 이슈트반 (Széchenyi István) | Széchenyi István |
| 205a | 데아크 페렌츠 (Deák Ferenc) | Deák Ferenc |
| 205a | 텔레키 라슬로 (Teleki László) | Teleki László |
| 205a | 외트뵈시 요제프 (Eötvös József) | Eötvös József |
| 205a | 뵈뢰슈머르티 미하이 (Vörösmarty Mihály) | Vörösmarty Mihály |
| 205a | 페퇴피 샨도르 (Petőfi Sándor) | Petőfi Sándor |
| 205a | 모소니 미하이 (Mosonyi Mihály) | Mosonyi Mihály |
| 206 | 장송 전주곡 (Preludio funebre) | Preludio funebre |
| 206 | 장송 행진곡 (Marcia funebre) | Marcia funebre |
| 214 | B♭장조 "화려한 왈츠" | No. 1 in B♭ major "Valse de bravoure" |
| 214 | E장조 "우울한 왈츠" | No. 2 in E major "Valse mélancolique" |
| 214 | A장조 "<루치아>와 <파리시나> 주제에 의한 연주회용 왈츠" | No. 3 in A major "Valse de concert sur deux motifs de Lucia et Parisina" |
| 215 | 잊힌 왈츠 4번 | No. 4 |
| 223 | C단조 "우울한 폴로네즈" | No. 1 in C minor "Polonaise mélancolique" |
| 225 | 차르다시 | No. 1 Csárdás |
| 225 | 고집스러운 차르다시 (Csárdás obstinée) | No. 2 Csárdás obstinée |
| 242 | 헝가리 민요 (Magyar dalok) | Magyar dalok (Ungarische Nationalmelodien) |
| 242 | 헝가리 광시곡 (Magyar rapszódiák) | Magyar rapszódiák |
| 242 | E단조 "영웅적 비가" | No. 12 in E minor "Héroïde élégiaque" |
| 242 | A단조 "라코치 행진곡" | No. 13 in A minor "Rákóczi-Marsch" |
| 242 | G단조 "루마니아 광시곡" | No. 20 in G minor "Romanian Rhapsody" |
| 242 | E♭장조 "페스트의 사육제" | No. 22 in E♭ major "Pester Karneval" |
| 242 | C#단조 "꿈과 환상" | No. 23 in C# minor "Rêves et fantaisies" |
| 243 | B♭장조 "전주곡" | No. 3 in B♭ major "Prélude" |
| 244 | E단조 "영웅적 비가" | No. 5 in E minor "Héroïde-élégiaque" |
| 244 | E♭장조 "페스트의 사육제" | No. 9 in E♭ major "Pester Karneval" |
| 244 | E장조 "전주곡" | No. 10 in E major "Preludio" |
| 244 | A단조 "라코치 행진곡" | No. 15 in A minor "Rákóczi-Marsch" |
| 249 | 우크라이나 발라드 (Ballade d'Ukraïne) | Ballade d'Ukraïne (Dumka) |
| 249 | 폴란드 선율 (Mélodies polonaises) | Mélodies polonaises |
| 249 | 애가 (Complainte) | Complainte (Dumka) |
| 264 | 키리에 | I. Kyrie |
| 264 | 글로리아 | II. Gloria |
| 264 | 그라두알레 | III. Graduale |
| 264 | 크레도 | IV. Credo |
| 264 | 오페르토리움 | V. Offertorium |
| 264 | 상투스 | VI. Sanctus |
| 264 | 베네딕투스 | VII. Benedictus |
| 264 | 아뉴스 데이 | VIII. Agnus Dei |
| 541 | A♭장조 "고귀한 사랑" | No. 1 in A♭ major "Hohe Liebe" |
| 541 | E♭장조 "축복받은 죽음" | No. 2 in E♭ major "Seliger Tod" |
| 541 | A♭장조 "오, 사랑할 수 있는 한 사랑하라" | No. 3 in A♭ major "O lieb, so lang du lieben kannst" |

## 6. 위키백과 대조 결과

- 원작 구역 1043행 전부가 '넣음' 또는 뺀 까닭을 가집니다(까닭 없는 행 0).
- 옛 판으로 뺀 행은 같은 무리의 새 판이 목록에 있는지 기계로 확인했습니다(사슬 'rev. as' 따라감). 새 판이 없는 것은 <마리아의 연도>(S. 171e·172a/4) 하나이고 4장에 적었습니다.
- 묶음 part 수는 위키 자식 행 수(4장에 적은 skip 뺀 것)와 같고, part 이름의 조성은 위키 key 칸과 모두 같습니다(다른 것 0).
- 제목 겹침 0(운영 제목 포함), nameKo 가 `1번 `·`1악장 ` 으로 시작하거나 빈 것 0, MBID 겹침 0.
- 위키 표 오탈자를 nameEn·titleEn 에서 고쳤습니다: Guilaume → Guillaume; Ville d'Este → Villa d'Este; Petofi → Petőfi; á son réveil → à son réveil; Das Schlüsselblumen → Die Schlüsselblumen; Es rufet Got → Es rufet Gott; (Psalite) → (Psallite); In dulce jubilo → In dulci jubilo; Sonata). → Sonata); Goethe's → Goethes; Benedetto sia'l → Benedetto sia 'l.

### MB parts 와 위키가 다른 곳(위키를 따름)

- S. 2 오라토리오 <성 엘리자베트의 전설>: 위키는 낱곡, MB 는 part 7개
- S. 3 오라토리오 <그리스도>: 위키는 낱곡, MB 는 part 3개
- S. 6 칸타타 <슈트라스부르크 대성당의 종>: 위키는 낱곡, MB 는 part 2개
- S. 18 프랑스어 가사 합창곡 S. 18: 위키 4 / MB 0
- S. 30 <Responsorien und Antiphonen>: 위키는 낱곡, MB 는 part 5개
- S. 52 <Septem sacramenta>: 위키는 낱곡, MB 는 part 7개
- S. 53 <십자가의 길>: 위키는 낱곡, MB 는 part 15개
- S. 67 칸타타 <본 베토벤 기념비 제막 축전 칸타타>: 위키는 낱곡, MB 는 part 4개
- S. 69iii <헤르더의 '해방된 프로메테우스'를 위한 합창곡>: 위키는 낱곡, MB 는 part 9개
- S. 108 파우스트 교향곡: 위키 3 / MB 4
- S. 126ii <죽음의 무도>: 위키는 낱곡, MB 는 part 10개
- S. 146 <기술적 연습곡>: 위키는 낱곡, MB 는 part 1개
- S. 177 스케르초와 행진곡 D단조: 위키는 낱곡, MB 는 part 2개
- S. 259 코랄 "Ad nos, ad salutarem undam"에 의한 환상곡과 푸가: 위키는 낱곡, MB 는 part 3개
- S. 260ii B-A-C-H 주제에 의한 전주곡과 푸가: 위키는 낱곡, MB 는 part 2개
- S. 347 멜로드라마 <Vor hundert Jahren>: 위키는 낱곡, MB 는 part 15개

### MB 손 지정

자동 고르기(S. 번호·판 설명·편곡자 이름 거름)가 틀리거나 못 찾은 26개는 `defs.MB_OVERRIDE` 에 근거와 함께 적었습니다. MB 번호 체계가 위키와 다른 곳: 위키 212ii = MB 212a, 위키 212a = MB 212b, 위키 248ii = MB 248a, 위키 280a = MB 280 bis, 위키 309a = MB 309 bis, 위키 126ii = MB 126/2. S. 290/2 는 MB 에 판이 셋(위키 둘)이라 어느 것인지 몰라 null.

### MBID 없는 작품

S. 1, S. 8/2, S. 14/2, S. 15/2b, S. 16/2, S. 17/2, S. 19/4, S. 21/2, S. 22, S. 23, S. 24, S. 26, S. 27, S. 31/2, S. 35/2, S. 37, S. 39/2, S. 40, S. 43, S. 47, S. 48, S. 55, S. 59, S. 62, S. 64, S. 65, S. 70iv, S. 72, S. 73, S. 74/2, S. 75/3, S. 76, S. 76a, S. 77, S. 78, S. 79/1, S. 80, S. 81/1, S. 81a, S. 82, S. 83a, S. 84/2, S. 85/3, S. 86a, S. 88, S. 89, S. 90, S. 91/2, S. 92, S. 94, S. 113/2, S. 152a, S. 157d, S. 166m, S. 173a, S. 290/2, S. 298a, S. 306b, S. 342/3.

