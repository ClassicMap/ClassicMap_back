# 베토벤 작품 카탈로그 — 1차 확장 보고

데이터 파일만 만들었습니다(DB·kubectl·git 손대지 않음). 결과는 `catalog.json`, 원자료와 중간 산출물은 `raw/`, 스크립트는 `scripts/` 입니다.

- 위키백과: "List of compositions by Ludwig van Beethoven" (`raw/wiki_list.txt`). 번호 목록(Op.·WoO·Anh.·Hess·Biamonti)과 갈래별 표를 함께 썼습니다(`scripts/wikiparse.py` → `raw/wiki_rows.json`).
- MusicBrainz: 베토벤 artist(1f9df192…) work 를 browse(`inc=aliases+work-rels`, 100개씩 31번)로 3037개 받았습니다(`raw/browse_works.json`). 낱개 조회는 하지 않았습니다.
- 순서: `defs.py`(손 정의) → `build.py`(MB parts 로 악장·곡 채움, 연도, 운영 대응) → `validate.py` → `wikicheck.py` → `excluded_extra.py` → `report.py`.

## 1. 개수

| 갈래 | 작품 | part |
|---|---:|---:|
| 묶음(collection) | 50 | 261 (묶음 안 곡의 악장 children 162) |
| 다악장(multi_movement) | 75 | 280 |
| 낱곡(single) | 231 | 0 |
| 합계 | 356 | 541 |

- children(묶음 안 소나타·4중주·3중주의 악장): 162개.
- authenticity: authentic 349, composer_arrangement 4(베토벤이 자기 곡을 옮김: Op. 38, Op. 61a, Op. 134, Hess 34), supervised_arrangement 3(남이 옮기고 베토벤이 고쳐 승인: Op. 41, Op. 42, Op. 104).
- MB work 를 쓴 곳 1051개(작품·part·children 합). 작품 단위 MBID 없음 6개: WoO 160, WoO 168, WoO 181, WoO 226, WoO 228a, WoO 228b. part MBID 없음: WoO 118 의 두 곡.
  - WoO 160·168·181 은 MB 에 묶음 work 가 없고 곡별 work 만 있어 part 에만 MBID 가 있습니다. WoO 226·228a·228b 는 MB 에 work 가 없습니다.
- 연도 없음 19개: WoO 205, WoO 210, WoO 211, WoO 212, WoO 213a, WoO 213b, WoO 213c, WoO 213d, WoO 216a, WoO 216b, WoO 217, WoO 218, WoO 219, WoO 223, WoO 224, WoO 225, WoO 226, WoO 228a, WoO 228b. 위키백과 표에 연도가 없는 2014 신판 WoO 번호(비아몬티 스케치북 소품 등)와 WoO 205 입니다.

범위: Op. 1–138, WoO 1–205, 그리고 위키백과 "Added works: WoO 206–228" 가운데 완성 곡, Hess 번호만 있는 것 중 위키백과 갈래별 표에 완성 곡으로 오른 3개(Hess 34·229·274). 이 밖의 Hess·Biamonti·Anh.·Unv. 는 모두 뺐습니다(3절).

## 2. 운영 기존 작품 대응

운영 베토벤 작품 14개가 모두 MBID(piece_identifiers 의 musicbrainz_work)로 맞았습니다. 카탈로그 번호로만 맞춘 것은 없습니다.

| piece id | 운영 제목 | 운영 opus | 이 목록 | 우리 이름 | 제목 같음 |
|---:|---|---|---|---|---|
| 75 | 교향곡 5번 C단조 "운명" | Op. 67 | `beethoven-op67` (Op. 67) | 교향곡 5번 C단조 "운명" | 예 |
| 76 | 교향곡 9번 D단조 "합창" | Op. 125 | `beethoven-op125` (Op. 125) | 교향곡 9번 D단조 "합창" | 예 |
| 77 | 교향곡 3번 E♭장조 "영웅" | Op. 55 | `beethoven-op55` (Op. 55) | 교향곡 3번 E♭장조 "영웅" | 예 |
| 78 | 피아노 소나타 14번 C#단조 "월광" | Op. 27, No. 2 | `beethoven-op27/2` (Op. 27 의 2번 part) | 피아노 소나타 14번 C#단조 "월광" | 예 |
| 79 | 피아노 소나타 8번 C단조 "비창" | Op. 13 | `beethoven-op13` (Op. 13) | 피아노 소나타 8번 C단조 "비창" | 예 |
| 80 | 피아노 협주곡 5번 E♭장조 "황제" | Op. 73 | `beethoven-op73` (Op. 73) | 피아노 협주곡 5번 E♭장조 "황제" | 예 |
| 81 | 바이올린 협주곡 D장조 | Op. 61 | `beethoven-op61` (Op. 61) | 바이올린 협주곡 D장조 | 예 |
| 82 | 엘리제를 위하여 | WoO 59 | `beethoven-woo59` (WoO 59) | 엘리제를 위하여 | 예 |
| 437 | 교향곡 6번 F장조 "전원" | Op. 68 | `beethoven-op68` (Op. 68) | 교향곡 6번 F장조 "전원" | 예 |
| 438 | 교향곡 7번 A장조 | Op. 92 | `beethoven-op92` (Op. 92) | 교향곡 7번 A장조 | 예 |
| 439 | 바이올린 소나타 5번 F장조 "봄" | Op. 24 | `beethoven-op24` (Op. 24) | 바이올린 소나타 5번 F장조 "봄" | 예 |
| 440 | 피아노 소나타 23번 F단조 "열정" | Op. 57 | `beethoven-op57` (Op. 57) | 피아노 소나타 23번 F단조 "열정" | 예 |
| 441 | 피아노 3중주 7번 B♭장조 "대공" | Op. 97 | `beethoven-op97` (Op. 97) | 피아노 3중주 7번 B♭장조 "대공" | 예 |
| 26029 | 바이올린 소나타 9번 A장조 "크로이처" | Op. 47 | `beethoven-op47` (Op. 47) | 바이올린 소나타 9번 A장조 "크로이처" | 예 |

- 78 「월광」은 새 묶음 Op. 27 의 2번 part 의 `existingPieceId` 로 적었습니다. 묶음 piece 를 새로 만들 때 78 을 낱곡으로 둘지 part 와 이어 줄지는 적재 쪽에서 정해야 합니다.
- 운영 중복 작품: 없음(베토벤 운영 작품 14개 모두 서로 다른 곡). 운영 piece_parts 에 베토벤 part 는 없어서 `existingPartId` 는 모두 null 입니다.
- `db/all_mbids_taken.tsv` 에서 다른 작곡가·다른 작품이 쓰는 MBID 와 겹친 것: 없음.
- 운영 opus 꼴 `Op. 27, No. 2`(78)은 이 목록에서 묶음 `Op. 27` + part 2 로 나뉩니다.

## 3. 뺀 것과 까닭

### 3-1. 위키백과 번호 목록의 Op.·WoO 가운데 뺀 것 (31개)

| 까닭 | 개수 |
|---|---:|
| 위작 의심 (`doubtful`) | 4 |
| 위작 (`spurious`) | 5 |
| 민요 편곡 (`folk_arrangement`) | 11 |
| 단편·미완성 (`fragment`) | 6 |
| 남의 편곡만 전함 (`arrangement`) | 1 |
| 음악 시계 곡 (`clock`) | 1 |
| 같은 곡의 옛 판 (`old_version`) | 1 |
| 소실 (`lost`) | 2 |

- **위작 의심**: Op. 63 피아노 3중주 E♭장조 — 현악 5중주 Op. 4 를 옮긴 것, 위키백과 doubtful; WoO 9 두 대의 바이올린과 베이스를 위한 미뉴에트 6곡 — 진위 확인 안 됨; WoO 17 <뫼들링 무곡> 11곡 — 위작 가능성 높음; WoO 27 클라리넷과 바순을 위한 2중주 3곡 — 위작 가능성 높음
- **위작**: Op. 64 첼로 소나타 E♭장조 — 현악 3중주 Op. 3 을 옮긴 것, 위키백과 spurious(편곡자 불명); WoO 12 관현악 미뉴에트 12곡 — 동생 카를의 작품; WoO 16 관현악 에코세즈 12곡 — 위작(fraudulent); WoO 162 카논 <Ta ta ta, lieber Mälzel> — 신들러가 지은 것으로 봄; WoO 204 음악적 농담 <Holz, Holz, geigt die Quartette so> — 카를 홀츠 작품
- **민요 편곡**: Op. 108 스코틀랜드 노래 25곡 — 민요 선율에 반주를 붙인 편곡; WoO 152 아일랜드 노래 25곡; WoO 153 아일랜드 노래 20곡; WoO 154 아일랜드 노래 12곡; WoO 155 웨일스 노래 26곡; WoO 156 스코틀랜드 노래 12곡; WoO 157 여러 나라 노래 12곡; WoO 158a 여러 나라 노래 23곡; WoO 158b 영국 노래 7곡; WoO 158c 여러 나라 노래 6곡; WoO 158d <Air Français>
- **단편·미완성**: WoO 5 바이올린 협주곡 C장조 — 1악장 일부만 전함; WoO 51 피아노 소나타 C장조 — 단편, 리스가 완성; WoO 62 현악 5중주 C장조 — 단편, 피아노 편곡으로만 전함; WoO 131 가곡 <Erlkönig> — 스케치, 베커가 완성; WoO 207 로망스 칸타빌레 E단조 (Hess 13) — 단편, 빌리 헤스가 완성; WoO 208 관악 5중주 E♭장조 (Hess 19) — 단편
- **남의 편곡만 전함**: WoO 23 군악 에코세즈 G장조 — 원판은 없어지고 체르니의 피아노 편곡만 전함
- **음악 시계 곡**: WoO 33 음악 시계를 위한 소품 5곡 — 명세상 음악 시계 곡은 뺌
- **같은 곡의 옛 판**: WoO 202 수수께끼 카논 <Das Schöne zu dem Guten> 첫 판 — 둘째 판 WoO 203 만 넣음
- **소실**: WoO 206 오보에 협주곡 F장조 (Hess 12) — 소실, 첫머리와 2악장 초안만 전함; WoO 220 <Kriegslied für die verbündeten Heere> (Hess 123) — 소실

### 3-2. 번호는 넣었지만 그 안에서 뺀 판·부속

- <레오노레> 1805·1806년 판(위키백과 Op. 72a·72b 의 오페라 판, MB `Leonore, Hess 109`)과 1807년 판(Op. 138 의 오페라 판): 같은 오페라의 옛 판이라 오페라는 <피델리오>(Op. 72, 1814) 하나만 넣었습니다. Op. 72a·72b·138 번호에는 <레오노레> 서곡 2·3·1번을 낱곡으로 넣었습니다.
- 피아노 4중주판 Op. 16(위키백과 갈래별 표 "Op. 16b"): 같은 작품번호의 다른 편성 판이라 5중주판만 넣었습니다.
- 카덴차: 자기 협주곡(Op. 15·19·37·58·61a)용 카덴차(Hess 76–85 등)는 따로 넣지 않았습니다. 모차르트 협주곡용 WoO 58 만 WoO 번호라 넣었습니다.
- 첫 판·옛 판: <Opferlied> 1822년 첫 판(번호 없음), WoO 105 첫 판(Hess 125), WoO 185 첫 판(E장조), WoO 140 첫 판, WoO 116 의 두 판(Hess 129·130)은 각 번호의 나중 판 MBID 로 한 작품만 넣었습니다. <Te solo adoro> 의 앞 판 Hess 263·264 는 WoO 186 만 넣었습니다.
- WoO 11 렌틀러: MB 에는 코다가 8번째 part 로 있으나 위키백과 "Seven Ländler" 에 맞춰 7곡만 넣었습니다.
- Op. 130: MB 의 순서 없는 "대체 피날레" part 를 뺐습니다(6악장 Finale 하나만). 원래 피날레였던 대푸가는 Op. 133 로 따로 있습니다.
- 갈래별 표에만 있는 번호 없는 줄(군악 행진곡 WoO 18–20 의 1822년 트리오, 1796–97 카논, 1826 "Bester Magistrat", 편지 속 음악적 인사들 등)은 넣지 않았습니다.

### 3-3. Anh.·Unv.·Hess·Hess Anh.·Biamonti 번호 (위키백과 목록 180줄)

| 처리 | 개수 |
|---|---:|
| 넣음 | 4 |
| 다른 번호로 이미 넣음 | 5 |
| 위작 | 8 |
| 위작 의심 | 28 |
| 단편·스케치·미완성 | 33 |
| 소실 | 2 |
| 옛 판·버린 악장 | 10 |
| 편곡(남의 곡 또는 자기 곡 옮김) | 21 |
| 카덴차 | 4 |
| 습작·연습 | 10 |
| 민요 편곡 | 1 |
| WoO 99 로 이미 넣음 | 1 |
| 번호 묶음만 있고 곡별 정보 없음(대부분 스케치·판본) | 6 |
| 위키백과 갈래별 표에 작품으로 오르지 않음(스케치북 소품, 완성 여부 불명) | 47 |

- **넣음**: Hess 34 String Quartet in F major (arrangement of Op. 14, No. 1) (1801–02); Hess 64 Fugue in C for Piano (1794–1795); Hess 69 Allegretto for piano in C minor (1794); Hess 274 Canons in G major (1803)
- **다른 번호로 이미 넣음**: Bia 1 Variations in C minor for piano on a march by Ernst Cristoph Dressle…; Bia 2 Three Piano Sonatas in E-Flat, F minor and D major (1782–83) (= WoO …; Bia 4 Rondo in C major for Piano (1783) (= WoO 48); Bia 5 Rondo in A major for piano (1783) (= WoO 49); Bia 9 An einen Säugling: Noch weisst du nicht, for Voice and Piano (1783) …
- **위작**: KH Anh. 1 Symphony in C major ("Jena Symphony") (spurious, actually composed b…; KH Anh. 3 Piano trio in D major (spurious, actually composed by Beethoven's br…; KH Anh. 5 Two piano sonatinas (probably spurious); KH Anh. 6 Rondo for piano in B♭ major (spurious, actually composed by Beethove…; KH Anh. 8 Three pieces for piano four-hands (spurious, actually composed by Le…; KH Anh. 12 "Pariser Einzugsmarsch" march for piano in C major (spurious, actual…; KH Anh. 13 Funeral march for piano in F minor (spurious, actually composed by J…; KH Anh. 14 Six piano waltzes (probably spurious)
- **위작 의심**: KH Anh. 2 Six string quartets (doubtful; possible authorship by Kaspar Anton K…; KH Anh. 4 Sonata for piano and flute in B♭ major (not certain); KH Anh. 7 Piano concerto (Allegro) in D major (first movement) (probably by Jo…; KH Anh. 9 Nine German dances for piano four-hands (probably doubtful); KH Anh. 10 Eight variations on the song "Ich hab'ein kleines Hüttchen nur" for …; KH Anh. 11 "Alexandermarsch" for Louis Duport ballet "Der blode Ritter" march f…; KH Anh. 15 "Glaube, Liebe, und Hoffnung" waltz for piano in F major, most known…; KH Anh. 16 Four piano waltzes; KH Anh. 17 "Introduction and Waltz (Klavierstück)" waltz for piano in F major (…; KH Anh. 18 "An Sie" or "Nachruf" song in A♭ major (Voice and Piano or Guitar) (…; Hess Anh. 3 Marches zur großen Wachtparade (not certain); Hess Anh. 4 Marsch in geschwinden tempo (not certain); Hess Anh. 5 Twelve waltzes for 2 Violins and Bass, with 2 Flutes and 2 Horns ad …; Hess Anh. 8 Quintet for Flute, Violin, 2 Violas, and Cello (not certain); Hess Anh. 9 Sonata for 2 Violins and Cello (not certain); Hess Anh. 10 Andante favori for string quartet (arrangement of WoO 57) (not certa…; Hess Anh. 17 Adagio and Andante for violin and piano (not certain); Hess Anh. 21 Bagatelle "An Laura" for piano (arrangement of WoO 112) (doubtful); Hess Anh. 22 Funeral March in C Minor (not certain); Hess Anh. 38–56 Songs (not certain); Hess Anh. 57 Fugue "Dona nobis pacem" (now thought genuine) (1795); Hess Anh. 58 Bundeslied (not certain); Hess Anh. 59 Folksong "As I was wandering" (not certain); Hess Anh. 60 Canon in C major (probably spurious); Hess Anh. 61–62 Canons (spurious); Hess Anh. 63–64 Canons (not certain); Hess Anh. 65 Cantata Karfreitagskantate (not certain); Hess Anh. 66 Two fragments for chorus (not certain)
- **단편·스케치·미완성**: Unv. 1 Symphony in C minor = Hess 298; Unv. 2 Sketches for a symphony in C (parts of which were reused for Symphon…; Unv. 3 Symphony No. 10 = Biamonti 838; Unv. 4 Sketches for a BACH Overture = Biamonti 832; Unv. 5 Concertante in D = Gardi 3; Unv. 6 Piano Concerto #6 in D = Hess 15; Unv. 7 String Quintet movement in D minor = Hess 40; Unv. 8 Duo for Violin and Cello in E-flat = Gardi 2; Unv. 9 Allegretto in E-flat for Piano Trio = Hess 48; Unv. 10 Piano Trio in F minor = Biamonti 637; Unv. 11 Violin Sonata in A = Hess 46; Unv. 12 Fantasia/Piano Sonata in D = Biamonti 213; Unv. 13 Piano Sonata in E-flat (found at Fischhof 42v, previously uncatalogu…; Unv. 14 Variations for Piano in A (found at Fischhof 25v through 26v, previo…; Unv. 15 Opera, Vestas Feuer = Hess 115; Unv. 16 Opera, Macbeth = Biamonti 454 (Beethoven is believed to have intende…; Unv. 17 Cantata, Europens Befreiungsstunde = Hess 317; Unv. 18 Östreich über alles, Song for Chorus and Orchestra, Biamonti 477; Unv. 19 Cantata for voice and piano in B-flat, (found in Fischhof f.1v, Kafk…; Unv. 20 Lamentations of Jeremiah = Gardi 4; Unv. 21 Song, "Traute Henriette" = Hess 151; Unv. 22 Song, "Rastlose Liebe" = Hess 149; Unv. 23 Song, "Heidenröslein" = Hess 150; Hess 40 Prelude for String Quintet (incomplete) (1817); Hess 46 Violin Sonata in A major (fragment) (c.1790); Hess 60 Draft in A for Piano (1793); Hess 116 Fragment for Solo Voice(s): "Ritterblatt"; Hess 299–305 Sketches for canons; Hess 329–330 Sketches; Hess 334 Draft for String Quartet in A major (1799); Bia 3 Sonata in A major for piano and violin (Fragments) (1783); Bia 8 Second movement for the trio, Hess 48 (1783); Bia 849 Draft for piano (last notes written by Beethoven) (1827)
- **소실**: Hess 11 Romance No. 3 for violin & orchestra (1816); Hess 39 String Quintet in F major (lost)
- **옛 판·버린 악장**: Hess 1 Original ending to first movement of Symphony No. 8 (1812); Hess 14 Fragment of original version of Piano Concerto No. 2 (1794–95); Hess 16 Original introduction to the Choral Fantasy (1808); Hess 25 String Trio, Op. 3 (first version) (1793); Hess 28 Movement in A♭ major for string trio, Op. 9, No. 1 (second trio to t…; Hess 32 String Quartet in F major (first version of Op. 18, No. 1) (1799); Hess 110–114 Parts from 'Leonore; Hess 121–122 Arias from Leonore; Hess 263–264 Two canons; Bia 547 Symphony No. 8 with the original ending of Hess 1 (1812)
- **편곡(남의 곡 또는 자기 곡 옮김)**: Hess 35 Bach fugue arranged for string quartet (fragment) (1817); Hess 36 Handel fugue arranged for string quartet (1798); Hess 37 Mozart fugue arranged for piano four hands; Hess 38 Bach fugue arranged for string quintet (1801–02); Hess 47 Allegro con brio in E♭ major for piano trio (arrangement of String T…; Hess 63 Arrangement of Christian Friedrich Daniel Schubart's "Kaplied" for p…; Hess 65 Concerto excerpt (arrangement of Op. 37) (1820–01); Hess 87 Grenadiermarsch for piano (arrangement of WoO 29) (1797–98); Hess 88 Minuet for piano (arrangement of WoO 209) (1790–92); Hess 89 Ritterballet for piano (arrangement of WoO 1) (1791); Hess 90 The Creatures of Prometheus for piano (arrangement of Op. 43) (1801); Hess 96 Fragment of Symphony No. 7 for piano (1813); Hess 97 Wellington's Victory for piano and two cannons (arrangement of Op. 9…; Hess 98 Scherzo for piano (1794–99); Hess 99 Yorckscher Marsch (piano arrangement of WoO 18) (1809–10); Hess 100 Twelve German dances (piano arrangement of WoO 8) (1795); Hess 101 Twelve Minuets (piano arrangement of WoO 7) (1795); Hess 102 Nine contredanses (piano arrangement of nos. 1–2, 4–5, 7–10, 12 from…; Hess 107 Grenadiermarsch (musical clock arrangement of WoO 29) (1798); Hess 108 Wellington's Victory (panharmonicon arrangement of the second part o…; Hess 118 Music for The Consecration of the House (from Op. 113) (1822)
- **카덴차**: Hess 76–83 Cadenzas for Piano; Hess 84 Piano cadenza for Op. 61a (1807); Hess 85 Piano cadenza for Op. 61a (1809); Hess 296 Little Cadenza for Instrument(s) (1822)
- **습작·연습**: Hess 29–31 Preludes and Fugues for Albrechtsberger (1794–95); Hess 58 Piano Exercise in B♭ major (1800); Hess 59 Piano Exercise in C (1792–1800); Hess 233–246 Counterpoint exercises; Hess 335 Two exercises on the song "Gedenke Mein"; Bia 347 Passage for piano through all the keys (1803); Bia 383 Exercise for piano; Bia 447 Passage for piano (1808); Bia 624 Etude, study of prosody on a text of Homer (1815); Bia 638 Exercise for piano (1815)
- **민요 편곡**: Hess 152–207 Folksong settings
- **WoO 99 로 이미 넣음**: Hess 208–232 Italian partsongs
- **번호 묶음만 있고 곡별 정보 없음(대부분 스케치·판본)**: Hess 91–95 Five Songs; Hess 123–147 Songs; Hess 306–309 Four canons; Hess 311–312 Two canons; Hess 318–319 String Quintets; Hess 321–324 Melodies
- **위키백과 갈래별 표에 작품으로 오르지 않음(스케치북 소품, 완성 여부 불명)**: Hess 3 Twelve Ecossaise for piano or orchestra; Hess 44 Adagio ma non troppo for mandolin & harpsichord in E♭ major; Hess 49 Piano Trio in E♭ major (1786); Hess 50 Piano Trio in B♭ major (1786); Hess 52 Piano Sonata in C major; Hess 54 Piano variations on Freudvoll und Liedvoll; Hess 57 Bagatelle in C major (1824); Hess 66 Allegretto in C minor (1796–97); Hess 67 Two German dances for piano (1811); Hess 70 Adagio for piano in G major (1803–04); Hess 71 Molto adagio for piano in G major (1803–04); Hess 72 Variations for piano in A major (1803); Hess 254 Canon in G major: "Hol dich der Teufel" (1801); Hess 297 Adagio for three horns (1815); Hess 310 Prelude in C for Organ; Hess 313 Song: "Te solo adoro" (1824); Hess 314 Funeral Cantata (1781); Hess 315 Fugue; Hess 316 Quintet (1793); Hess 320 Andante for String Quartet in G major (1815); Hess 325 Piece for piano in D major (1802); Hess 326 Fugue for piano in C major (1800–01); Hess 327 Two little melodies (1803); Hess 331 Minuet for piano in B♭ major; Hess 332 Pastorella for String Quartet in D major (1799); Hess 333 Minuet-Scherzo for String Quartet in A major (1799); Bia 6 Two-part Fugue in D major for organ (fortepiano) (1783); Bia 10 Andante for String Quartet in C major (1793); Bia 277 Presto for piano in G major (1793); Bia 279 Allegro for piano in C major (1793); Bia 291 Andante, for a symphony (1801); Bia 292 March with variations (1801); Bia 319 Finale for piano (1802); Bia 322 Piece for piano in C minor (1802); Bia 323 Piece for piano (1802); Bia 346 Fuga Antique for piano in C major (1803); Bia 359 Rondo for "all the instruments" (1803); Bia 380 Song "Zur Erde sank die Ruh' vom Himmel nieder" (1803); Bia 389 Piece for viola, cello, horn and double bass (1803); Bia 392 Rondo for piano (1803); Bia 606 Andante for pizzicati basses with clarinets in B minor (1815); Bia 621 Allemande for piano (1815); Bia 622 Pastorella for piano in C major (1815); Bia 632 Song "Die Zufrieddenheit" (1815); Bia 634 German dance for piano trio in F minor (1815); Bia 797 Adagio for String Quartet in E major (1824); Bia 811 Canon in C minor (1825)

넣은 Hess 번호: Hess 34(현악 4중주 F장조, 피아노 소나타 Op. 14-1 을 베토벤이 옮김), Hess 229(수수께끼 카논), Hess 274(카논 G장조). 그 밖에 Hess 33·61·64·68·69·73·74·275·276·277 은 2014 신판 WoO 209–227 번호로 넣었습니다.

### 3-4. MB 에만 있는 work

browse 로 받은 3037개 가운데 1051개를 목록에 썼습니다. 나머지는 남의 편곡·관현악 편곡·대중음악 인용("Ode to Joy" 노래, "Für Elise" 변형 등), 같은 곡의 겹친 work(독일어 제목 악장 work, catch-all), 위에서 뺀 번호의 work, 그리고 위키백과 번호에 없는 스케치북 소품("12 Piano Miniatures from the Sketchbooks", Kafka·Fischhof 잡록 소품 등)입니다. 스케치북 소품은 위키백과 기준이 아니어서 넣지 않았습니다.

## 4. 애매했던 판단

- **민요 편곡을 뺐습니다.** Op. 108(스코틀랜드 노래 25곡)과 WoO 152–158 은 작품번호가 있어도 명세의 "민요 편곡 제외"(하이든 Hob. XXXIa/b 와 같은 성격)를 따랐습니다. 민요 주제에 의한 변주곡 Op. 105·107 은 베토벤 창작이라 넣었습니다.
- **변주곡은 낱곡으로 두었습니다.** Op. 34·35·76·120, WoO 63–80 등 변주곡 작품은 MB 에 변주별 part 가 있어도 part 를 두지 않았습니다(명세의 다악장 = 악장으로 나뉜 작품). Op. 105·107 은 변주곡 여러 벌을 묶은 출판이라 묶음, 각 벌은 낱곡 part 입니다. 변주를 part 로 원하면 MB parts 로 바로 펼 수 있습니다.
- **2014 신판 WoO 206–228 과 Hess 3개를 넣었습니다.** 리드 메모의 범위는 WoO 1–205 였지만, WoO 206 이후는 Hess·Biamonti 소품에 새로 붙은 번호라 "Hess·Biamonti 는 완성 곡만" 규칙으로 다뤘습니다. 완성 곡 24개(WoO 209–219, 221–228 의 낱번호, 213·216·228 은 a–d 를 각각 하나로)는 넣고 소실·단편 4개(206·207·208·220)는 뺐습니다. 이들 대부분은 위키백과에 연도가 없어 year 가 null 이고, 3개는 MB work 도 없습니다. 빼는 편이 낫다면 `key` 가 `beethoven-woo2`로 시작하는 것과 Hess 3개를 빼면 됩니다.
- **베토벤의 자기 편곡을 넣었습니다.** 작품번호를 받은 Op. 38(7중주 → 3중주), Op. 61a(바이올린 협주곡 → 피아노 협주곡), Op. 134(대푸가 → 네 손)와 Hess 34(소나타 → 현악 4중주)는 `composer_arrangement`, 남이 옮기고 베토벤이 고친 Op. 41·42·104 는 `supervised_arrangement` 로 표시했습니다. Op. 4 는 Op. 103 을 새로 고쳐 쓴 별개 작품이라 authentic 입니다. 위작 의심 편곡 Op. 63, 위작 Op. 64 는 뺐습니다.
- **Op. 124·Op. 114·WoO 98 MBID.** MB 의 `Die Weihe des Hauses, op. 124` work 는 서곡과 합창·행진곡 등 부수음악 전체를 part 로 묶고 있고, `Die Ruinen von Athen, op. 114` work 는 part 가 WoO 98 합창과 Op. 124 서곡으로 엉켜 있습니다. 위키백과대로 Op. 124 = 서곡, Op. 114 = 행진곡과 합창, WoO 98 = 합창으로 보고 각각 해당 part work(3aeba557·be1ae8f6·a7fa3462)를 MBID 로 썼습니다.
- **<레오노레> 서곡.** Op. 72a·72b·138 번호에 서곡 2·3·1번을 낱곡으로 넣었습니다(리드 메모 "서곡이 따로 작품번호면 낱곡"). 서곡 2번 MBID(68c28f5b)는 MB 에서 `Leonore, Hess 109` 의 part 입니다. <에그몬트>·<프로메테우스>·<아테네의 폐허>·<슈테판 왕> 서곡은 따로 번호가 없어 부수음악 작품 안에 둡니다.
- **WoO 2b 이름.** 위키백과는 "1805년 <레오노레> 2막 서주(버림)"로, MB 는 "<타르페야> 2막 입장 음악"으로 적습니다. 위키백과를 따라 `<레오노레> 2막 서주 (1805)` 로 두고 note 에 남겼습니다.
- **WoO 4 피아노 협주곡 0번**은 관현악 단서가 적힌 피아노 악보로만 전하지만(연주는 복원판) 카탈로그의 완성 작품이라 다악장으로 넣었습니다. **WoO 219 렌틀러 C단조**는 MB 가 미완성으로 적지만 위키백과는 완성 곡으로 올려 넣었습니다.
- **WoO 99 이탈리아어 다성 가곡**(살리에리에게 배울 때의 연습곡)은 2014 신판 번호대로 23곡 묶음으로 넣었습니다. 같은 가사의 a·b·c 는 서로 다른 작곡이라 각각 part 이고, nameKo 끝에 `(5a)` 처럼 번호를 붙였습니다(part 의 catalogueAlt 에 Hess 번호).
- **무대·대형 성악은 part 없음**: 오페라 <피델리오>, 발레 <프로메테우스의 창조물>·<기사 발레>, 부수음악(<에그몬트>·<아테네의 폐허>·<슈테판 왕>·<레오노레 프로하스카>), 오라토리오, 칸타타(Op. 112·136, WoO 87·88·103·106), 합창 환상곡. 미사 두 곡(Op. 86·123)은 다악장(5부분), <웰링턴의 승리>는 2부(전투·승리 교향곡)로 다악장입니다.
- **같은 이름 가르기**: 같은 제목이 겹치는 곳은 조성이나 연도를 덧붙였습니다 — 가곡 <희망에 부쳐> (1805)/(1815), 카논 <Kurz ist der Schmerz> F단조/F장조, <Glück zum neuen Jahr!> E♭장조/F장조, <Ars longa, vita brevis> C장조 (1816)/F장조/C장조 (1825), 바가텔 C단조 "Allegretto" WoO 53 과 (1795–96) WoO 214. 가곡 <Merkenstein> WoO 144 와 2중창 <Merkenstein> Op. 100, 가곡 <Sehnsucht> WoO 146 과 (네 가지 작곡) WoO 134 는 갈래어로 가렸습니다.
- **겹친 MB work 고르기**: WoO 54·60·92·139·159·168·211·218·227·98 은 MB 에 같은 곡 work 가 둘 이상이라, 위키백과 제목과 가장 가까운 것(장면과 아리아 WoO 92 는 Scene and Aria 쪽, WoO 105·185·140 은 나중 판)을 골랐습니다. Op. 121b 는 MB disambiguation 이 "first version, for soprano, choir and orchestra"인 work 를 골랐습니다(출판된 Op. 121b 편성과 같음).
- **연도**: 위키백과 갈래별 표의 "작곡; 초연" 칸에서 작곡 부분을 쓰고, 번호 목록 연도가 작곡 시작과 초연 사이면 그것을 완성 연도로 썼습니다. 표 값이 이상한 Op. 19(1795), Op. 37(1803), Op. 55(1804), Op. 72(1814 최종판), Op. 104(1817), WoO 1(1791) 은 손으로 정했습니다. 고친 해(rev.)가 있으면 year 는 고친 해입니다(WoO 52·56·81 등).
- **Op. 39 2번 조성**: MB 는 2번을 C단조로 적지만, 두 곡 모두 C장조에서 시작해 모든 장조를 거치는 곡이라 둘 다 `C장조` 로 두었습니다.

## 5. 직접 옮긴 우리말 이름 (검수용)

원어를 그대로 둔 가곡·카논 제목이 대부분이고, 아래만 우리말로 옮겼습니다. "널리 씀"은 국내에서 이미 굳은 이름이라고 본 것, "직접"은 제가 옮긴 것입니다.

| 곳 | 우리말 | 원어 | 구분 |
|---|---|---|---|
| Op. 32·94 제목 | 희망에 부쳐 | An die Hoffnung | 직접 |
| Op. 46 제목 | 아델라이데 | Adelaide | 널리 씀(음역) |
| Op. 65 제목 | 아! 배신자여 | Ah! perfido | 널리 씀 |
| Op. 98 제목 | 멀리 있는 연인에게 | An die ferne Geliebte | 널리 씀 |
| WoO 123 제목 | 그대를 사랑해 | Zärtliche Liebe ("Ich liebe dich") | 널리 씀 |
| Op. 128 제목 | 입맞춤 | Der Kuss | 직접 |
| Op. 118 제목 | 비가 | Elegischer Gesang | 직접 |
| Op. 48 제목 | 겔레르트 시에 의한 6개의 가곡 | 6 Lieder (Gellert) | 직접 |
| Op. 83 제목 | 괴테 시에 의한 3개의 가곡 | 3 Gesänge von Goethe | 직접 |
| Op. 82 제목 | 4개의 아리에타와 2중창 | 4 Ariettas and a Duet | 직접 |
| Op. 85 제목 | 감람산 위의 그리스도 | Christus am Ölberge | 널리 씀 |
| Op. 112 제목 | 고요한 바다와 즐거운 항해 | Meeresstille und glückliche Fahrt | 널리 씀 |
| Op. 136 제목 | 영광의 순간 | Der glorreiche Augenblick | 직접 |
| Op. 113·117 제목 | 아테네의 폐허 / 슈테판 왕 | Die Ruinen von Athen / König Stephan | 널리 씀 |
| Op. 114·124, WoO 98 제목 | 헌당식 | Die Weihe des Hauses | 널리 씀 |
| Op. 115 제목 | 명명축일 | Zur Namensfeier | 널리 씀 |
| Op. 91 제목 | 전쟁 교향곡 <웰링턴의 승리> | Wellingtons Sieg (Battle Symphony) | 널리 씀 |
| WoO 1 제목 | 기사 발레 | Ritterballett | 직접 |
| WoO 2a 제목 | <타르페야>를 위한 개선 행진곡 | Triumphal March for Tarpeja | 직접 |
| WoO 3 제목 | 축하 미뉴에트 | Gratulations-Menuett | 직접 |
| WoO 71 제목 | 숲의 처녀 | Das Waldmädchen | 직접 |
| WoO 87·88 제목 | 황제 요제프 2세의 죽음에 부치는 칸타타 / 황제 레오폴트 2세의 즉위에 부치는 칸타타 | Cantata on the Death of Joseph II / on the Accession of Leopold II | 직접 |
| WoO 95 제목 | 연합국 군주들을 위한 합창 | Chor auf die verbündeten Fürsten | 직접 |
| WoO 106 제목 | 로브코비츠 공 생일 칸타타 | Birthday Cantata for Prince Lobkowitz | 직접 |
| WoO 99 제목 | 이탈리아어 다성 가곡집 | Mehrstimmige italienische Gesänge | 직접 |
| WoO 205 제목 | 음악적 인사 | Musical greetings / Notenscherze | 직접 |
| WoO 200 제목 | 루돌프 대공의 변주곡을 위한 주제 | Theme for variations by Archduke Rudolph | 직접 |
| 별명 | 가센하우어(Op. 11), 템페스트(Op. 31-2), 사냥(Op. 31-3), 테레제(Op. 78), 고별(Op. 81a), 함머클라비어(Op. 106), 세리오소(Op. 95), 하프(Op. 74), 유령(Op. 70-1), 라주모프스키(Op. 59) | Gassenhauer, Tempest, The Hunt, À Thérèse, Les Adieux, Hammerklavier, Serioso, Harp, Ghost, Razumovsky | 널리 씀 |
| 별명 | 선제후(WoO 47), 안경(WoO 32), 요르크 행진곡(WoO 18), 안단테 파보리(WoO 57), 잃어버린 동전에 대한 분노(Op. 129) | Kurfürsten, mit zwei obligaten Augengläsern, Yorckscher Marsch, Andante favori, Rage over a Lost Penny | 널리 씀(안경은 줄임) |
| Op. 48-4 part | 자연에서의 신의 영광 | Die Ehre Gottes aus der Natur | 널리 씀 |
| Op. 52-7, Op. 75-1 part | 마르모트 / 미뇽 | Marmotte / Mignon | 음역 |
| Op. 105·107 part 머리 | 스코틀랜드·티롤·오스트리아·러시아·소러시아 노래 | Air écossais / tirolien / autrichien / russe / de la petite Russie | 직접 |
| Op. 68 악장 | 시골에 도착했을 때의 즐거운 기분 / 시냇가의 정경 / 시골 사람들의 즐거운 모임 / 천둥, 폭풍 / 목동의 노래. 폭풍 뒤의 기쁨과 감사 | Erwachen heiterer Empfindungen… / Szene am Bach / Lustiges Zusammensein der Landleute / Gewitter, Sturm / Hirtengesang… | 널리 씀(표현은 책마다 조금 다름) |
| Op. 81a 악장 | 고별 / 부재 / 재회 | Das Lebewohl / Abwesenheit / Das Wiedersehen | 널리 씀 |
| Op. 132 3악장 | 리디아 선법에 의한, 병에서 나은 이가 신께 바치는 거룩한 감사의 노래 | Heiliger Dankgesang eines Genesenen an die Gottheit, in der lydischen Tonart | 직접 |
| Op. 135 4악장 | 어렵게 내린 결심 | Der schwer gefasste Entschluss | 직접 |
| Op. 26 3악장 | 영웅의 죽음을 애도하는 장송 행진곡 | Marcia funebre sulla morte d'un eroe | 직접 |
| Op. 59-1 4악장 | 러시아 주제 | Thème russe | 직접 |
| Op. 91 part | 전투 / 승리 교향곡 | Schlacht / Siegessinfonie | 직접 |
| WoO 134 part | 첫째·둘째·셋째·넷째 작곡 | 1st–4th setting | 직접 |
| WoO 58 part | Allegro 악장 카덴차 / Rondo 악장 카덴차 | Cadenza for the Allegro / Rondo | 직접 |
| WoO 50 1악장 | (빠르기말 없음) | [no tempo marking] | 직접 |

갈래어만 옮긴 것(검수 불필요로 봄): 미뉴에트, 스케르초, 피날레, 론도, 로망스, 서주, 푸가, 카바티나, 아리에타, 트리오, 코다, 주제와 변주, 장송 행진곡, 행진곡(머리말 Marcia), 키리에·글로리아·크레도·상투스·아뉴스 데이. `Tempo di menuetto`·`Alla marcia`·`alla polacca` 같은 빠르기말 속 낱말은 옮기지 않았습니다.

## 6. 위키백과 대조 결과

- 번호 빠짐: 위키백과 번호 목록의 Op.·WoO 384개(WoO 107–151, 159–198 범위는 낱번호로 펼침) 가운데 넣음 353, 뺌 31(3-1절), **빠짐 0**.
- 묶음 곡 수: 묶음 50개를 위키백과의 번호 목록 `**No.` 줄, 제목 수사("Seven Bagatelles" 등), 갈래별 표 곡 목록·`/N` 행과 88번 대조, **다른 곳 0**. (곡 수를 대조할 근거가 없는 WoO 99 는 아래 번호 대조로 갈음.)
- 묶음 안 곡 조성: 위키백과에 조성이 적힌 91곳 대조, **다른 곳 0**.
- WoO 99: 2014 신판 번호 23개(1, 2, 3, 4, 5a–c, 6, 7, 8, 9, 10a–b, 11a–c, 12a–b, 13a–c, 14a–b; 15번은 소실)가 MB parts 순서·번호와 그대로 맞습니다.
- 제목 겹침 0(운영 제목 포함), nameKo 가 `1번 `·`1악장 ` 으로 시작하는 것 0, 빈 nameKo 0, 같은 MBID 두 번 쓴 곳 0, 세 겹 묶음 0 (`raw/validate.json`).

MB parts 와 위키백과(또는 표준 악보)가 다른 곳 — 위키백과를 따랐습니다:

- WoO 11: MB part 8개(7곡 + 코다) → 위키백과 "Seven Ländler" 대로 7개.
- Op. 130: MB part 에 순서 없는 "Alternative finale" 하나가 더 있음 → 뺌.
- Op. 39: MB 2번 "C minor" → C장조(4절 판단 참고).
- Op. 5-1: MB 1악장 제목이 "I. Adagio sostenuto / II. Allegro…" 로 두 악장이 섞여 있음 → "Adagio sostenuto – Allegro" 로 고침(2악장 Rondo 는 그대로).
- Op. 27-1: MB 1·4악장 제목이 줄어 있음("Andante", "Allegro vivace") → "Andante – Allegro – Tempo I", "Allegro vivace – Presto".
- Op. 61a: MB 3악장 "Rondo" → "Rondo. Allegro".
- Op. 68·Op. 132: MB 악장 표제가 영어 번역 → 독일어 원문(nameEn)과 우리말(nameKo)로 바꿈.
- Op. 124·114, WoO 98: MB work 구조가 위키백과와 다름 → 4절 판단 참고.
- Op. 53: MB 에 초판(Andante favori 를 2악장으로 둔 4악장 판) work 가 따로 있음 → 최종 3악장 판 work(a3c9dc10) 사용. WoO 56·57 MBID 는 MB 에서 그 초판 work 의 part 입니다.

빌드 경고 원문은 `raw/build_issues.json`, 대조 원문은 `raw/wikicheck.json` 에 있습니다.

