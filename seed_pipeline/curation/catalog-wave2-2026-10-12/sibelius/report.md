# 시벨리우스 작품 카탈로그 — 2차 확장 보고

데이터 파일만 만들었다(DB·kubectl·git 손대지 않음). 결과는 `catalog.json`, 원자료·중간 산출물은 `raw/`, 스크립트는 `scripts/`.

- 위키백과: "List of compositions by Jean Sibelius"(`raw/wiki_list.txt`). rowspan 이 많은 정렬 표를 행 단위로 펴서(`scripts/wikiparse.py` → `raw/wiki_rows.json`, 693행) 썼다. 회색 셀(소실·포기)과 "→" 편곡 행, HUL·번호 없는 행, 맨 끝 "Preliminary versions and fragments" 절은 기본으로 뺐다.
- MusicBrainz: 시벨리우스 artist work 를 browse(`inc=aliases+work-rels`, 100개씩)로 1617개 받았다(`raw/browse_works.json`). 낱개 조회는 하지 않았다.
- 순서: `wikiparse.py` → `units.py`(Op./JS 번호 단위로 묶고 뺄 행 가름) → `mbindex.py`·`mbpick.py`(MB 고르기) → `defs_op.py`·`defs_js.py`(손 정의: 제목·이름) → `build.py` → `wikicheck.py` → `report.py`.
- 생성기 시험(`gen_test.sql`): `{"pieces": 297, "parts": 451, "children": 34, "linked": 1, "updated_parts": 0, "existing_pieces": 3}` 오류 없음.

## 1. 개수

| 갈래 | 작품 | part | children |
|---|---:|---:|---:|
| 묶음(collection) | 63 | 295 | 34 |
| 다악장(multi_movement) | 40 | 156 | 0 |
| 낱곡(single) | 197 | 0 | 0 |
| 합계 | 300 | 451 | 34 |

- Op. 번호 작품 116개(Op. 1–116, 107 은 빈 번호; Op. 27 은 부수음악·모음곡 2개), JS 번호 작품 184개.
- 새 작품 297개, 운영 기존 작품에 잇는 것 3개(277·278·280), 운영 낱곡을 묶음 part 로 잇는 것 1개(279).
- authenticity: 모두 authentic(작곡가 자신의 마지막 판 또는 유일하게 남은 판).
- MBID: 작품 296/300, part 442/451, children 32/34. 작품 MBID 없음: Op. 109, JS 63, JS 153, JS 199.
- 갈래(genre): chamber 70, piano 50, choral 42, song 33, orchestral 13, symphonic_poem 11, suite 11, incidental_music 10, symphony 8, melodrama 8, cantata 7, concertante 5, string_quartet 4, piano_trio 4, overture 3, choral_orchestral 3, violin_sonata 3, piano_sonata 2, march 2, organ 2, sacred 2, concerto 1, ballet 1, opera 1, carillon 1, piano_quartet 1, piano_quintet 1, piano_four_hands 1

## 2. 운영 기존 작품 대응

운영 시벨리우스 작품 4개 모두 piece_identifiers 에 MBID 가 없어 카탈로그 번호로 맞췄다. 제목만으로 맞춘 것은 없다. 운영 중복 작품은 없다.

| piece id | 운영 제목 | 운영 opus | 이 목록 | 근거 |
|---:|---|---|---|---|
| 277 | 교향시 <핀란디아> | Op. 26 | `sibelius-op26` | 카탈로그 번호(Op. 26). 운영 작품에 MBID 없음 → 생성기가 MB 809aadce 를 식별자로 더함 |
| 278 | 바이올린 협주곡 D단조 | Op. 47 | `sibelius-op47` | 카탈로그 번호(Op. 47). MB 67843334 를 더함 |
| 279 | 슬픈 왈츠 | Op. 44, No. 1 | `sibelius-op44 의 part 1` | 카탈로그 번호(Op. 44/1). 묶음 <쿠올레마>에서 뽑은 2개의 소품 Op. 44 의 1번 part existingPieceId=279 |
| 280 | 교향곡 2번 D장조 | Op. 43 | `sibelius-op43` | 카탈로그 번호(Op. 43). MB 74d08c2f 를 더함 |

- 279 「슬픈 왈츠」는 운영 type 이 song(낱곡)이고 opus `Op. 44, No. 1` 이다. 새 묶음 `sibelius-op44`(MB 8224c547)의 part 1(MB 176827c6)에 existingPieceId=279 로 이었다. 279 의 제목·설명은 그대로 둔다.
- SPEC 의 '대목 작품'·'여러 작품을 한데 묶은 운영 작품'에 해당하는 시벨리우스 운영 작품은 없다.

## 3. 뺀 것과 까닭

위키백과 표 행 기준 169행을 뺐다(아래 갈래별). 행이 아니라 각주에만 나오는 옛 판은 맨 끝에 따로 적었다.

### 소실·포기 (10)

- JS 190 Symphony No. 8 (1924–c. late 1930s–1945 (abandoned))
- JS 80 Fencing Music (Fäktmusik) (1891 (lost))
- JS 223 Circus March (Zirkusmarsch) (1891 (lost))
- JS 198 Theme and Variations in C minor (1891 (lost))
- Op. 72/1 "Vi ses igen" ("Farewell") (1914 (lost))
- Op. 72/2 "Orions bälte" ("Orion's Girdle") (1914 (lost))
- JS 204 "Tre trallande jäntor" ("Three Warbling Maidens") (1915 (lost))
- JS 151 March of the Pori Regiment (Porilaisten marssi), arrangement [I] of the original (arr. 1892 (lost))
- JS 29 "The American Millers' Song" ([Unknown] (lost))
- JS 175 Snöfallet (The Snowfall) (1927 (lost))

### 일부만 전함 (11)

- JS 105 Cantata for the University Graduation Ceremonies of 1894 (Kantaatti tohtorinja maisterinvihkijäisissä 1894) (1894 (partially survives))
- JS 106 Cantata for the University Graduation Ceremonies of 1897 (Kantaatti tohtorinja maisterinvihkijäisissä 1897) (1897 (partially survives))
- JS 165 Scherzo in E minor (1887 (partially survives))
- JS 195 Theme and Variations in C# minor (1888 (partially survives))
- JS 156 Piano Quartet in C minor (1891 (partially survives))
- JS 186 Suite in A major (1889 (partially survives))
- JS 193 Tempo di valse in G minor (1887 (partially survives))
- JS 79 Fantasy (1889 (partially survives))
- JS 99/1 "Oje Carulì" ("Oh Caroline"), arr. of a song by M.P. Costa (1887–1888 (partially survives))
- JS 99/2 "Trippole trappole", arr. of a Spanish folk song adapted by G.L. Cottrau (1887–1888 (partially survives))
- JS 59 Den lilla sjöjungfrun (The Little Mermaid) (1887–1888 (abandoned, partially survives))

### 일부 소실 (1)

- JS 115 Karelia (1893 (partially destroyed)) — JS 115 <카렐리아> 음악(뒤에 복원판). Op. 10·11 은 넣음

### 단편 (4)

- JS 37 (fragment) Andante molto sostenuto in B minor (1888–1889)
- JS 89 (fragment) [Tempo di valse] in B minor (1886–1887)
- JS 91 (fragment) [Andante] in B minor (1888)
- JS 92 (fragment) [Andantino] in B minor (1888–1889)

### 미완성 (2)

- JS 90 [Sonata Allegro Exposition] in B minor (1887) — JS 90
- JS 26 Allegro [Sonata Exposition] in A minor (1888–1889) — JS 26

### 연습곡 (5)

- JS 179a [Sonata Allegro Exposition] in D minor (1889) — JS 179a
- JS 179b [Sonata Allegro Exposition] in F minor (1889) — JS 179b
- JS 179c [Sonata Allegro Exposition] in C major (1889) — JS 179c
- JS 179d [Sonata Allegro] in E major (1889) — JS 179d — 같은 JS 179 묶음의 다른 4곡이 제시부만이라 함께 뺌
- JS 179e [Sonata Allegro Exposition] in C minor (1889) — JS 179e

### 옛 판·단편 절 (8)

- JS 210 String Trio in G minor (1893–1894)
- JS 56 "Då världar ännu skapade ej voro" ("When Worlds Still Uncreated Were") (1888)
- JS 57 "Den första kyssen" ("The First Kiss") (1891–1892)
- JS 42 [preliminary version of "Säv, säv, susa"] (1900)
- JS 87 [preliminary version of "Soluppgång"] (1902)
- JS 215 [preliminary version of "Vänskapens blomma"] (1909)
- JS 94 "Heitä, koski, kuohuminen" ("Rapids, Cease Your Foaming") (1893)
- JS 122 "Listen to the Water Mill" (1905–1906)

### 옛 판 (1)

- Op. 45/2 Musik zu einer Szene (Music to a Scene) (1904) — Op. 45/2 <무도 간주곡>의 1904년 첫 판(Musik zu einer Szene)

### 같은 곡 다른 판 (3)

- JS 160b Rakastava (The Lover) ([1894], arr. 1894) — JS 160b 바리톤·남성 합창·현악판(JS 160a 무반주 합창판을 넣음)
- JS 34a Andante festivo (1922) — JS 34a 현악 4중주판(1938년 현악 합주판 JS 34b 를 넣음)
- JS 30b Andante cantabile in E♭ major (1887) — JS 30b 피아노·하모늄판(JS 30a 피아노판을 넣음)

### 작곡가 편곡 (13)

- JS 77b A Lonely Ski-Trail (Ett ensamt skidspår) ([1925], arr. 1948) — JS 77b(JS 77a 피아노 멜로드라마를 1948년 현악·하프로 옮김)
- Op. 47 Violin Concerto in D minor ([1903–1904, rev. 1905], trans. 1905) — 바이올린 협주곡 Op. 47 의 바이올린·피아노 편곡
- Op. 77/1 Serious Melody No. 1: Cantique ([1914 (arr. 1916)], trans. 1915 (1916)) — Op. 77/1 의 바이올린(첼로)·피아노 편곡
- Op. 77/2 Serious Melody No. 2: Devotion ([1915 (arr. 1916)], trans. 1915 (1916)) — Op. 77/2 의 바이올린(첼로)·피아노 편곡
- Op. 71 Scène d'amour (Love Scene), from Scaramouche ([1913], trans. 1925) — <스카라무슈> Op. 71 에서 '사랑의 장면' 바이올린·피아노 편곡
- JS 134a(b) Scherzo in E major with Trio in E minor (or with [Trio] in A major) (1885, arr. 1886) — JS 134a(b) 현악 4중주 스케르초(JS 134)의 피아노 편곡
- Op. 65b The Bells of Kallio Church (Kallion kirkon kellosävel) ([1912], trans. 1912) — Op. 65b 피아노판(합창판을 넣음)
- Op. 96a Valse lyrique (1914, rev. 1919 & 1919) — Op. 96a 피아노판(관현악판을 넣음)
- Op. 96c Valse chevaleresque (1921–1922, rev. 1922) — Op. 96c 피아노판(관현악판을 넣음)
- JS 135b Morceau romantique ([1925], trans. 1925) — JS 135b 피아노판(JS 135a 관현악판을 넣음)
- JS 170b "Siltavahti" ("The Guardian of the Bridge") ([1928], arr. 1928) — JS 170b 독창·피아노판(JS 170a 남성 합창판을 넣음)
- Op. 19 Impromptu ([1902, rev. 1910], arr. 1910) — Op. 19 여성 합창·피아노판(관현악판을 넣음)
- JS 58b "Suur' olet Herra" ("The Lofty Heaven") ([1927], arr. 1945) — JS 58b 남성 4중창·오르간판(JS 58a 를 넣음)

### 같은 번호 작품의 편곡·발췌 (59)

- → Op. 27 King Christian II Suite (Kuningas Kristian II) ([1898], arr. 1898)
- → JS 101 The Maiden in the Tower Overture (Jungfrun i tornet) ([1896], arr. 1900 (score markings))
- → Op. 15 The Wood Nymph (Skogsrået) (1894–1895)
- → Op. 17/1 "Se'n har jag ej frågat mera" ("Since Then I Have Questioned No Further") ([1891–1892], arr. 1903)
- → Op. 38/2 "På verandan vid havet" ("On a Balcony by the Sea") ([1903], arr. 1903)
- → Op. 38/3 "I natten" ("In the Night") ([1903], arr. 1903)
- → Op. 38/1 "Höstkväll" ("Autumn Evening") ([1903], arr. 1904)
- → Op. 3 "Arioso" (1911)
- → Op. 57/6 "Hertig Magnus" ("Duke Magnus") ([1909], arr. 1912)
- → Op. 13/4 "Våren flyktar hastigt" ("Spring Is Flying") ([1891], arr. 1913)
- → Op. 37/3 "Soluppgång" ("Sunrise") ([1902], arr. 1913)
- → Op. 36/6 "Demanten på marssnön" ("The Diamond on the March Snow") ([1900], arr. 1917)
- → Op. 7 "Kullervon valitus" ("Kullervo's Lament"), from Kullervo ([1892, arr. 1892–1893, 1917–1918], arr. 1957)
- → Op. 60/1 "Kom nu hit, död" ("Come Away, Death") ([1909], arr. 1957)
- → Op. 4/3 Presto, from the String Quartet in B♭ major ([1890], arr. 1894)
- → Op. 5/5–6 Impromptu, from the Six Impromptus ([1893], arr. 1894)
- → JS 104 Coronation March (Kröningsmarsch), from the Cantata for the Coronation of Nicholas II ([1896], arr. 1896)
- → Op. 91a Jäger March (Jääkärien marssi) ([1917], arr. 1918)
- → Op. 91b Scout March (Partiolaisten marssi) ([1918], arr. 1918)
- → Op. 113/6 Processional, from the Masonic Ritual Music ([1927], arr. 1938)
- → Op. 33 "Koskenlaskijan morsiamet" ("The Rapids-Rider's Brides") ([1897], arr. 1943)
- → Op. 31/3 Song of the Athenians (Athenarnes sång) (1899)
- → Op. 11 Karelia Suite, select numbers ([1893, arr. 1893], trans. c. 1893–1897)
- → Op. 15 The Wood Nymph (Skogsrået), final section only ([1894–1895], trans. 1895)
- → Op. 27 King Christian II (Kuningas Kristian II), select numbers ([1898], trans. 1898)
- → Op. 31/3 Song of the Athenians (Athenarnes sång) ([1899], trans. 1899)
- → Op. 26 Finlandia, from the Press Celebrations Music ([1899, arr. 1900], trans. 1900)
- → Op. 31/2 Have You Courage? (Har du mod?) (1904, rev. 1911, 1912, trans. 1913)
- → Op. 44/1 Valse triste, from Death (Kuolema) ([1903, arr. 1904], trans. 1904)
- → Op. 46 Pelléas et Mélisande Suite (Pelléas och Mélisande) ([1905, arr. 1905], trans. 1905)
- → Op. 45/2 Dance Intermezzo (Tanssi-Intermezzo) ([1904], rev./trans. 1904)
- → Op. 53 Pan and Echo (Pan och Echo) ([1906], trans. 1907)
- → Op. 51 Belshazzar's Feast Suite (Belsazars gästabud) ([1906, arr. 1907], trans. 1907)
- → Op. 45/1 The Dryad (Dryadi) ([1910], trans. 1910)
- → Op. 71 Scaramouche, select numbers ([1912–1913], trans. 1914)
- → Op. 96b Autrefois ([1919, rev. 1920], trans. 1920)
- → Op. 98a Suite mignonne ([1921], trans. 1921)
- → Op. 98b Suite champêtre ([1922], trans. 1922)
- → Op. 100 Suite caractéristique ([1922], trans. 1922)
- → Op. 83 Everyman (Jedermann or Jokamies), select numbers ([1916], trans. 1925)
- → Op. 109 The Tempest Suite Nos. 1 & 2 (Stormen), select numbers ([1925, arr. 1927], trans. 1927)
- → Op. 7 "Kullervon valitus" ("Kullervo's Lament"), from Kullervo ([1892], trans. 1892–1893, rev. 1917–1918)
- → Op. 33 "Koskenlaskijan morsiamet" ("The Rapids-Rider's Brides") ([1897], trans. 1897–1899)
- → Op. 27/4 "Sången om korsspindeln" ("Fool's Song of the Spider"), from King Christian II ([1898], trans. 1898)
- → JS 147/6 "De trenne blinda systrar" ("The Three Blind Sisters"), from Pelléas et Mélisande ([1905], trans. 1905)
- → JS 48/2b "Den judiska flickans sång" ("The Jewish Girl's Song"), from Belshazzar's Feast ([1906], trans. 1907, rev. 1939)
- → Op. 70 Luonnotar ([1913], trans. 1913)
- → Op. 96b "Autrefois" ([1919, rev. 1920], arr. 1920)
- → JS 105 "Juhlamarssi" ("Festive March"), from the Promotional Cantata of 1894 ([1894], arr. c. 1896)
- → Op. 23/6a "Soi kiitokseksi Luojan" ("We Praise Thee, Our Creator"), from the Songs for Mixed Chorus from the 1897 Promotional Cantata ([1897], arr. 1913)
- → JS 104 "Terve ruhtinatar" ("Hail Princess"), from the Cantata for the Coronation of Nicholas II ([1896], arr. c. 1913)
- → Op. 30 "Nejden andas" ("The Landscape Breathes"), from The Breaking of the Ice on the Oulu River ([1899], arr. c. 1913)
- → Op. 1/4 "Giv mig ej glans, ej guld, ej prakt" ("Give Me No Splendor, Gold or Pomp") ([1909], arr. 1935 (arr. 1942))
- → Op. 26 "Finlandia-hymnin" ("Finlandia Hymn"), from Finlandia ([1899], arr. 1938 & 1940 (arr. 1948))
- → Op. 32 The Origin of Fire (Tulen synty) ([1902, rev. 1910], arr. 1910)
- → Op. 31/2 "Har du mod?" ("Have You Courage?") ([1904], arr. 1904, rev. & arr. 1911)
- → Op. 91b "Partiolaisten marssi" ("Scout March") ([1918, arr. 1918], arr. 1921)
- → Op. 91b "Partiolaisten marssi" ("Scout March") [a.k.a. "The World Song of the World Association of Girl Scouts and Girl Guides"] ([1918, arr. 1918], arr. 1952)
- → Op. 1/4 "Giv mig ej glans, ej guld, ej prakt" ("Give Me No Splendor, Gold or Pomp") ([1909], arr. 1954)

### 민요 편곡 (8)

- JS 81/1 My Beloved Is Beautiful, Her Mouth Like a Corn-cockle (Minun kultani kaunis on, sen suu kuin auran kukka) (1902–1903) — JS 81/1 <6개의 핀란드 민요> 피아노 편곡
- JS 81/2 I Love You with All My Heart (Sydämestäni rakastan) (1902–1903) — JS 81/2 <6개의 핀란드 민요> 피아노 편곡
- JS 81/3 Evening Is Coming (Ilta tulee, ehtoo joutuu) (1902–1903) — JS 81/3 <6개의 핀란드 민요> 피아노 편곡
- JS 81/4 That Beautiful Girl (Tuopa tyttö, kaunis tyttö) (1902–1903) — JS 81/4 <6개의 핀란드 민요> 피아노 편곡
- JS 81/5 The Fratricide (Velisuurmaaja) (1902–1903) — JS 81/5 <6개의 핀란드 민요> 피아노 편곡
- JS 81/6 Wedding Memory (Häämuistelma) (1902–1903) — JS 81/6 <6개의 핀란드 민요> 피아노 편곡
- JS 211 "Tule, tule kultani" ("Come, Come, My Sweetheart") (1892) — JS 211 <Tule, tule kultani>
- JS 10 "Ack, hör du fröken Gyllenborg" ("Ah, Do You Hear, Miss Gyllenborg"), folk ballad from Pernå (1888–1889) — JS 10 페르노 민요 발라드

### 전래 선율 편곡 (2)

- JS 51a Carminalia, a setting of three school songs (1898) — <카르미날리아> JS 51a (피에 칸티오네스 라틴 학교 노래 3곡 편곡)
- JS 51b(c) Carminalia, a setting of three school songs ([1898], arr. 1898) — <카르미날리아> JS 51b(c) 반주판

### 남의 곡 편곡 (2)

- JS 152 March of the Pori Regiment (Porilaisten marssi), arrangement [II] of the original (arr. 1900) — JS 152 <포리 연대 행진곡> 편곡
- JS 118 "Laulun mahti" ("The Power of Song"), arr. of J. Vītols's song (1895) — JS 118 비톨스 노래 편곡

### 스케치 묶음 (1)

- JS 148 Pianokompositioner för barn (Piano Works for Children), 21 sketches (1899) — JS 148 <어린이를 위한 피아노곡> 21개 스케치

### 철회 (1)

- Op. 75/6 The Lilac (Syringa) (1914 (withdrawn 1919, rev. as Op. 96/1)) — Op. 75/6

### 카탈로그 번호 없음 (38)

- – Kuutar (The Moon Goddess) (1919–early 1920s (abandoned))
- – The Building of the Boat (Veneen luominen) (1893–1894 (abandoned))
- – Marjatta (1905 (abandoned))
- – "Der Rabe" ("The Raven") (1910 (abandoned))
- HUL 1260 Lord, You are a Rock (Herr du bist ein Fels) (1889–1890, rev. 1889–1890)
- HUL 1263 Lord, Show Us Your Mercy (Herr erzeige uns deine Gnade) (1889–1890, rev. 1889–1890)
- HUL 0542–46 Ljunga Wirginia (1885 (partially survives))
- HUL 0517 [Vivace] (1890)
- HUL 0796/2 [Four Themes] (1887)
- HUL 0618 [Thirty-three Small Pieces] (1888–1889)
- HUL 0620 [Allegro] in G minor (1888–1889)
- HUL 0621 Allegretto in B♭ major (1889)
- HUL 0538 [Menuetto] in D minor (c. 1882–1885)
- HUL 0539 [Andante] – Adagio – Allegro maestoso (c. 1883–1885)
- HUL 0547 [Allegretto] in A♭ major (c. 1887–1888)
- HUL 1351 Moderato in F major (1885–1889)
- – [Mazurka] in G minor (1887–1889)
- – Theme for Improvisation (1933)
- HUL 1088/2 [Allegretto] in A major (1891–1894)
- HUL 0768/3 Allegro in F minor (1888)
- HUL 0797 [Five Short Pieces] (1888)
- HUL 1183 "Jag kysser dig ej" ("I Kiss You and Weary Not") (1889–1891)
- HUL 1286/2 "Löjet var utan hem" ("Wit Was without a Home") (1890–1891)
- – [Chorales written for Martin Wegelius] (student exercises) (1887–1888)
- – [Chorales written for Albert Becker] (student exercises) (1888–1889)
- HUL 0163 [Luonnotar], predecessor to Pohjola's Daughter (1903–1905)
- – [Suite for Orchestra], predecessor to The Oceanides (1913–1914)
- HUL 0504 [March], preliminary version of Scout March (Partiolaisten marssi) (1897–1899)
- HUL 0536a/2 [Mazurka] in C major (1883)
- HUL 0525/3 Impromptu in G minor (1884)
- HUL 1283 "Medan nordanvinden gnyr" ("While the North Wind Roars") (1888)
- HUL 1179 "Solen slog himlen röd" ("The Sun Reddened the Sky") (1888)
- HUL 1180 "Höstkväll" ("Autumn Evening") (1888–1889)
- HUL 1186 "Flickan gick en vintermorgan" ("The Maiden Went Out One Winter Morning") (1890–1892)
- – "Frihet" ("Freedom") (1891–1892)
- – "Drick, De förflyga de susande pärlorna" ("Drink, the Fizzling Pearls are Flying Away") (1891–1892)
- – "Romans" ("Romance") (1905)
- – "Och skull ditt hjärta jag fångat" ("And If I had Captured Your Heart") (1908–1910)

### 각주에만 나오는 옛 판(넣지 않음)

- 교향곡 5번 Op. 82 1915년 첫 판(4악장; 1916년 판은 소실)
- 교향곡 1번 Op. 39 첫 판(소실)
- 바이올린 협주곡 Op. 47 1904년 첫 판
- <엔 사가> Op. 9 1892년 첫 판
- <봄의 노래> Op. 16 1894년 <즉흥곡> 판
- <대양의 요정> Op. 73 1914년 '예일' 판·전신 모음곡
- <레민카이넨 모음곡> Op. 22 1896년 판
- 카사치오네 Op. 6 1904년 판
- <인 메모리암> Op. 59 1909년 판
- <불의 기원> Op. 32 1902년 판
- <찬가> Op. 21 1896년 판
- <산델스> Op. 28 1898년 판
- <즉흥곡> Op. 19 1902년 판
- 유머레스크 1번 Op. 87/1 1917년 판
- <무도 간주곡> Op. 45/2 의 1904년 판(Musik zu einer Szene)
- 에필로그 Op. 2/2 1891년 판(Perpetuum mobile)
- 가곡 Op. 13/2·3·5, Op. 35/2, Op. 61/6, Op. 72/6 의 예비 판
- 현악 4중주 Op. 56 피날레 예비 판
- <템페스트> 모음곡 1번 「카논」 1927년 예비 판

## 4. 애매했던 판단

1. **<크리스티안 2세> Op. 27 을 두 작품으로 둠.** 위키백과는 1898년 연극 부수음악에 Op. 27 을 주고, 작곡가가 같은 해 뽑은 연주회용 모음곡(녹턴·엘레지·뮈제트·세레나데·발라드)을 "→ Op. 27" 편곡 행으로 둔다. 모음곡이 실제 연주·녹음의 중심이라 `sibelius-op27`(부수음악, 낱곡)과 `sibelius-op27-suite`(모음곡, 다악장 5악장, MB d679c86c)로 나눴다. 둘 다 catalogue 가 `Op. 27` 이다. 모음곡을 빼려면 `sibelius-op27-suite` 한 줄만 지우면 된다.
2. **부수음악 원곡과 모음곡을 함께 넣음.** <쿠올레마> JS 113 / Op. 44·62, <펠레아스와 멜리장드> JS 147 / Op. 46, <벨사살의 향연> JS 48 / Op. 51, <백조 공주> JS 189 / Op. 54, <템페스트> JS 182 / Op. 109, <신문의 날 축제 음악> JS 137 / Op. 25·26. 원곡은 SPEC 대로 part 없는 낱곡이다. <카렐리아> 음악 JS 115 는 악보 일부가 사라져 뺐고(뒤에 복원판 있음) Op. 10·11 만 넣었다.
3. **하위 번호는 Op. 하나로 묶음.** Op. 44/62/65/69/77/87/89/91/96/98/111/109 처럼 a·b 나 /1·/2 로 나뉜 번호는 Op. 번호 하나의 묶음으로 두고, 문자 번호는 part 의 catalogueAlt 에 `Op. 69a` 꼴로 적었다. 위키백과가 "6개의 유머레스크"로 한데 보는 Op. 87(2곡)·Op. 89(4곡)는 번호대로 두 묶음으로 뒀다.
4. **Op. 72 는 1·2번이 소실이라 3–6번만 넣었다.** SPEC 대로 seq 는 1–4 로 매기고, 출판 번호는 nameEn 앞에 `No. 3`–`No. 6` 으로 남겼다. Op. 75 는 6번 「라일락」이 1919년 철회되어 Op. 96a 로 다시 쓰였으므로 5곡만 둠.
5. **<템페스트> 모음곡 2번(Op. 109/3)은 위키백과대로 9곡.** MB 는 「노래 1 – 노래 2」를 한 악장으로 묶어 8개다. 그래서 노래 1·2 children 은 MBID 가 없다. 출판 악보 기준 8악장이 맞다면 두 줄을 합치면 된다.
6. **<펠레아스와 멜리장드> 모음곡 Op. 46 은 9악장.** 위키백과는 「멜리장드」 아래 (a) 「바닷가에서」를 한 줄로 적고(8줄), 출판 번호는 1, 2, 2a, 3–8 이다. MB 와 같이 9개로 나눠 I–IX 로 매겼다.
7. **<레민카이넨 모음곡> Op. 22 악장 순서는 Op. 22/1–4(위키백과·MB) 순.** 작곡가가 1947년 2·3곡(백조·투오넬라) 순서를 바꾼 판이 오늘날 흔히 쓰인다. 바꿀지는 리드 판단.
8. **옛 판·여러 판 중 하나만.** 한 JS 번호 아래 a·b·c 판이 있으면 하나만 넣었다: JS 34b(<안단테 페스티보> 1938년 현악 합주판; 1922년 현악 4중주 원판 34a 는 뺌), JS 30a, JS 58a, JS 77a, JS 135a, JS 160a, JS 170a, JS 9a, JS 214a. JS 98(<Isänmaalle>)은 a·b·c 가 한 곡의 판들이라 catalogue 를 `JS 98` 로 뒀다. JS 60·61, JS 219·220 은 위키백과가 "주제가 다른 별개의 곡"으로 보아 둘 다 넣고 제목 끝에 (첫 작곡)/(두 번째 작곡), (1920)/(1929)를 붙였다.
9. **어린 시절 실내악·피아노 소품(1880년대 JS 번호)은 완성·현존이면 모두 넣음.** 제시부만 남은 소나타 악장(JS 26·90·179a–e), 단편(JS 37·89·91·92), 일부만 전하는 곡(JS 59·79·156·165·186·193·195 등)은 뺐다. JS 179d 는 완성 악장이지만 같은 JS 179 연습 묶음(베커 문하 소나타 형식 연습)의 나머지가 제시부뿐이라 함께 뺐다. 이 갈래 제목은 빠르기말을 소리대로 옮기고 편성을 괄호로 붙였다(예: `알레그레토 C장조 (바이올린과 피아노)`). 같은 제목이 겹치면 연도를 붙였다(JS 24/225, JS 30a/74).
10. **편곡으로 본 것.** JS 51 <카르미날리아>(피에 칸티오네스 라틴 노래 3곡 화성 붙임), JS 81 핀란드 민요 6곡 피아노 편곡, JS 10·211 민요, JS 118(비톨스)·JS 152(포리 연대 행진곡)는 뺐다. JS 148 <어린이를 위한 피아노곡>은 21개 스케치 묶음이라 뺐다. JS 116 <아시스의 장엄한 행진곡>은 원래 현악 4중주판이 사라지고 작곡가의 피아노 3중주판만 남아 그것을 넣었다.
11. **Op. 67/3 조성.** 위키백과 표는 "B♭ major", MB·출판 악보는 B♭ minor 다. B♭단조로 적었다(위키 대조에서 1건 다름으로 남김).
12. **Op. 96 의 MB 묶음 work(4854ef46)는 피아노판 묶음**이다. 위키백과는 Op. 96 을 관현악곡으로 세므로 part 이름은 관현악판(96a 서정적 왈츠, 96b 두 소프라노와 관현악 <옛날에>, 96c 기사의 왈츠) 기준이지만 part MBID 는 그 묶음의 자식(피아노판 쪽)이다. 관현악판 MB work(2066bbef·4a81f889·4acdba9e)로 바꿀지 리드 판단.
13. **JS 160a <라카스타바> 남성 합창판**은 위키백과 3곡, MB 4곡(마지막 곡을 둘로 나눔)이라 part MBID 를 비웠다. JS 182 <템페스트> 부수음악은 MB 에 `Stormen, JS 182`(7116829c)와 36곡짜리 `Myrsky, op. 109`(9295b0b9)가 함께 있어 제목이 JS 182 인 앞의 것을 썼다.
14. **Op. 23** 은 위키백과 9곡 중 6번이 (a)·(b) 두 곡이라 6번 part 아래 children 2개로 뒀다(6번 part MBID 없음, children 은 MB 6a·6b).

## 5. 직접 옮긴 우리말 이름(검수용)

가곡·합창곡 제목은 SPEC 대로 원제 그대로 두고, 국내에서 널리 쓰는 우리말이 있는 4곡만 `우리말 (원제)`로 했다(검은 장미, 그것은 꿈이었나, 첫 키스, 밀회에서 돌아온 소녀). 빠르기말·갈래어로 된 어린 시절 소품 제목(알레그레토, 안단티노, 미뉴에트, 아침의 노래(Aubade) 등)은 소리대로 옮기거나 갈래어만 옮겼다. 아래는 그 밖에 직접 옮긴 이름이다.

| 구분 | 번호 | 우리말 | 원어·영어 |
|---|---|---|---|
| 작품 | Op. 7 | 교향곡 <쿨레르보> | Kullervo |
| 곡·악장 | Op. 7 | 도입부 (Johdanto). Allegro moderato | I. Introduction (Johdanto). Allegro moderato |
| 곡·악장 | Op. 7 | 쿨레르보의 젊은 시절 (Kullervon nuoruus). Grave | II. Kullervo's Youth (Kullervon nuoruus). Grave |
| 곡·악장 | Op. 7 | 쿨레르보와 누이 (Kullervo ja hänen sisarensa). Allegro vivace | III. Kullervo and His Sister (Kullervo ja hänen sisarensa). Allegro vivace |
| 곡·악장 | Op. 7 | 쿨레르보 싸움터로 가다 (Kullervon sotaanlähtö). Alla marcia | IV. Kullervo Goes to War (Kullervon sotaanlähtö). Alla marcia |
| 곡·악장 | Op. 7 | 쿨레르보의 죽음 (Kullervon kuolema). Andante | V. Kullervo's Death (Kullervon kuolema). Andante |
| 작품 | Op. 8 | 부수음악 <도마뱀> | Ödlan (The Lizard), Incidental Music |
| 작품 | Op. 9 | 교향시 <엔 사가> | En saga |
| 작품 | Op. 10 | <카렐리아> 서곡 | Karelia Overture |
| 작품 | Op. 11 | <카렐리아> 모음곡 | Karelia Suite |
| 작품 | Op. 14 | 현악 모음곡 <라카스타바> | Rakastava (The Lover), Suite for Strings |
| 곡·악장 | Op. 14 | 연인 (Rakastava) | I. The Lover (Rakastava) |
| 곡·악장 | Op. 14 | 연인의 길 (Rakastetun tie) | II. The Path of the Beloved (Rakastetun tie) |
| 곡·악장 | Op. 14 | 잘 자요… 안녕히 (Hyvää iltaa ... Jää hyvästi) | III. Good Evening ... Farewell! (Hyvää iltaa ... Jää hyvästi) |
| 작품 | Op. 15 | 교향시 <숲의 요정> | The Wood Nymph (Skogsrået) |
| 작품 | Op. 16 | 교향시 <봄의 노래> | Spring Song (Vårsång) |
| 작품 | Op. 19 | 여성 합창과 관현악을 위한 <즉흥곡> | Impromptu for Female Chorus and Orchestra |
| 작품 | Op. 20 | 첼로와 피아노를 위한 <말린코니아> | Malinconia for Cello and Piano |
| 작품 | Op. 21 | 남성 합창곡 <찬가> | Hymn (Natus in curas) |
| 작품 | Op. 22 | <레민카이넨 모음곡> (네 개의 전설) | Lemminkäinen Suite (Four Legends from the Kalevala) |
| 곡·악장 | Op. 22 | 레민카이넨과 섬의 처녀들 (Lemminkäinen ja saaren neidot) | I. Lemminkäinen and the Maidens of the Island |
| 곡·악장 | Op. 22 | 투오넬라의 백조 (Tuonelan joutsen) | II. The Swan of Tuonela |
| 곡·악장 | Op. 22 | 투오넬라의 레민카이넨 (Lemminkäinen Tuonelassa) | III. Lemminkäinen in Tuonela |
| 곡·악장 | Op. 22 | 레민카이넨의 귀향 (Lemminkäinen palaa kotitienoille) | IV. Lemminkäinen's Return |
| 작품 | Op. 25 | <역사적 장면> 1번 | Scènes historiques I |
| 곡·악장 | Op. 25 | 서곡풍으로 (All'Overtura) | I. All'Overtura |
| 곡·악장 | Op. 25 | 장면 (Scena) | II. Scena |
| 곡·악장 | Op. 25 | 축제 (Festivo) | III. Festivo |
| 작품 | Op. 27 | 부수음악 <크리스티안 2세> | King Christian II, Incidental Music |
| 작품 | Op. 27 | <크리스티안 2세> 모음곡 | King Christian II Suite |
| 곡·악장 | Op. 27 | 세레나데. Moderato assai (Quasi menuetto) | IV. Serenade. Moderato assai (Quasi menuetto) |
| 작품 | Op. 28 | 남성 합창과 관현악을 위한 <산델스> | Sandels |
| 작품 | Op. 29 | 멜로드라마 <스뇌프리드> | Snöfrid |
| 작품 | Op. 30 | 멜로드라마 <울루강의 얼음 깨짐> | The Breaking of the Ice on the Oulu River (Islossningen i Uleå älv) |
| 곡·악장 | Op. 31 | 레민카이넨을 위한 노래 (Laulu Lemminkäiselle) | No. 1 A Song for Lemminkäinen (Laulu Lemminkäiselle) |
| 곡·악장 | Op. 31 | 아테네인의 노래 (Athenarnes sång) | No. 3 Song of the Athenians (Athenarnes sång) |
| 작품 | Op. 32 | 칸타타 <불의 기원> | The Origin of Fire (Tulen synty) |
| 곡·악장 | Op. 34 | 춤의 아리아 (Air de danse) E장조 | No. 2 Air de danse in E major |
| 곡·악장 | Op. 34 | 몽상 (Rêverie) E단조 | No. 6 Rêverie in E minor |
| 곡·악장 | Op. 34 | 전원 무곡 (Danse pastorale) A장조 | No. 7 Danse pastorale in A major |
| 곡·악장 | Op. 34 | 하프 타는 사람 (Joueur de harpe) B♭단조 | No. 8 Joueur de harpe in B♭ minor |
| 곡·악장 | Op. 34 | 감사 (Reconnaissance) D장조 | No. 9 Reconnaissance in D major |
| 곡·악장 | Op. 34 | 추억 (Souvenir) A단조 | No. 10 Souvenir in A minor |
| 곡·악장 | Op. 36 | 검은 장미 (Svarta rosor) | Svarta rosor |
| 곡·악장 | Op. 37 | 첫 키스 (Den första kyssen) | Den första kyssen |
| 곡·악장 | Op. 37 | 그것은 꿈이었나 (Var det en dröm?) | Var det en dröm? |
| 곡·악장 | Op. 37 | 밀회에서 돌아온 소녀 (Flickan kom ifrån sin älsklings möte) | Flickan kom ifrån sin älsklings möte |
| 곡·악장 | Op. 39 | 피날레 (Quasi una fantasia). Andante – Allegro molto | IV. Finale (Quasi una fantasia). Andante – Allegro molto |
| 곡·악장 | Op. 40 | 작은 왈츠 (Valsette) E단조 | No. 1 Valsette in E minor |
| 곡·악장 | Op. 40 | 무언가 (Chant sans paroles) E단조 | No. 2 Chant sans paroles in E minor |
| 곡·악장 | Op. 40 | 선율적 상념 (Pensée mélodique) C장조 | No. 6 Pensée mélodique in C major |
| 곡·악장 | Op. 40 | 작은 세레나데 (Petite sérénade) B♭장조 | No. 9 Petite sérénade in B♭ major |
| 작품 | Op. 41 | 피아노 모음곡 <퀼리키> | Kyllikki |
| 작품 | Op. 44 | <쿠올레마>에서 뽑은 2개의 소품 Op. 44 | 2 Pieces from Kuolema, Op. 44 |
| 곡·악장 | Op. 44 | 슬픈 왈츠 (Valse triste) | No. 1 Valse triste |
| 곡·악장 | Op. 44 | 학이 있는 정경 (Kurkikohtaus) | No. 2 Scene with Cranes (Kurkikohtaus) |
| 곡·악장 | Op. 45 | 드리아드 (Dryadi) | No. 1 The Dryad |
| 곡·악장 | Op. 45 | 무도 간주곡 (Tanssi-Intermezzo) | No. 2 Dance Intermezzo (Tanssi-Intermezzo) |
| 작품 | Op. 46 | <펠레아스와 멜리장드> 모음곡 | Pelléas et Mélisande Suite |
| 곡·악장 | Op. 46 | 성문에서 (Vid slottsporten) | I. At the Castle Gate |
| 곡·악장 | Op. 46 | 멜리장드 (Mélisande) | II. Mélisande |
| 곡·악장 | Op. 46 | 바닷가에서 (På stranden vid havet) | III. At the Seashore |
| 곡·악장 | Op. 46 | 공원의 샘 (En källa i parken) | IV. By a Spring in the Park |
| 곡·악장 | Op. 46 | 세 눈먼 자매 (De trenne blinda systrar) | V. The Three Blind Sisters |
| 곡·악장 | Op. 46 | 물레 앞의 멜리장드 (Mélisande vid sländan) | VII. Mélisande at the Spinning Wheel |
| 곡·악장 | Op. 46 | 간주곡 (Mellanaktsmusik) | VIII. Entr'acte |
| 곡·악장 | Op. 46 | 멜리장드의 죽음 (Mélisandes död) | IX. The Death of Mélisande |
| 작품 | Op. 48 | 칸타타 <해방된 여왕> | The Captive Queen (Vapautettu kuningatar) |
| 작품 | Op. 49 | 교향시 <포욜라의 딸> | Pohjola's Daughter (Pohjolan tytär) |
| 작품 | Op. 51 | <벨사살의 향연> 모음곡 | Belshazzar's Feast Suite |
| 곡·악장 | Op. 51 | 동방의 행렬 (Orientalisk marsch) | I. Oriental Procession |
| 곡·악장 | Op. 51 | 고독 (Solitude) | II. Solitude |
| 곡·악장 | Op. 51 | 카드라의 춤 (Khadras dans) | IV. Khadra's Dance |
| 작품 | Op. 53 | 관현악을 위한 <판과 에코> | Pan and Echo (Pan och Echo) |
| 작품 | Op. 54 | <백조 공주> 모음곡 | Swanwhite Suite (Svanevit) |
| 곡·악장 | Op. 54 | 공작 (Påfågeln) | I. The Peacock |
| 곡·악장 | Op. 54 | 하프 (Harpan) | II. The Harp |
| 곡·악장 | Op. 54 | 장미를 든 처녀들 (Tärnorna med rosor) | III. The Maiden with the Roses |
| 곡·악장 | Op. 54 | 들어 봐, 울새가 노래한다 (Hör rödhaken slå) | IV. Listen! The Robin Sings |
| 곡·악장 | Op. 54 | 홀로 있는 왕자 (Prinsen allena) | V. The Prince Alone |
| 곡·악장 | Op. 54 | 백조 공주와 왕자 (Svanevit och prinsen) | VI. Swanwhite and the Prince |
| 곡·악장 | Op. 54 | 찬가 (Lovsång) | VII. Song of Praise |
| 작품 | Op. 55 | 교향시 <밤의 질주와 해돋이> | Nightride and Sunrise |
| 작품 | Op. 56 | 현악 4중주 D단조 "친밀한 목소리" | String Quartet in D minor "Voces intimae" |
| 곡·악장 | Op. 58 | 몽상 (Rêverie) | No. 1 Rêverie |
| 곡·악장 | Op. 58 | 변주가 붙은 아리아 (Air varié) | No. 3 Air varié |
| 곡·악장 | Op. 58 | 목동 (Der Hirt) | No. 4 Der Hirt |
| 곡·악장 | Op. 58 | 저녁에 (Des Abends) | No. 5 Des Abends |
| 곡·악장 | Op. 58 | 대화 (Dialogue) | No. 6 Dialogue |
| 곡·악장 | Op. 58 | 어부의 노래 (Fischerlied) | No. 8 Fischerlied |
| 곡·악장 | Op. 58 | 세레나데 (Ständchen) | No. 9 Ständchen |
| 곡·악장 | Op. 58 | 여름 노래 (Sommerlied) | No. 10 Sommerlied |
| 작품 | Op. 59 | 관현악을 위한 장송 행진곡 <인 메모리암> | In memoriam, Funeral March for Orchestra |
| 작품 | Op. 60 | <십이야>에 의한 2개의 노래 | 2 Songs from Twelfth Night, Op. 60 |
| 작품 | Op. 62 | <쿠올레마>를 위한 2개의 소품 Op. 62 | 2 Pieces for Kuolema, Op. 62 |
| 곡·악장 | Op. 62 | 낭만적 왈츠 (Valse romantique) | No. 2 Valse romantique |
| 작품 | Op. 64 | 교향시 <음유시인> | The Bard (Barden) |
| 작품 | Op. 66 | <역사적 장면> 2번 | Scènes historiques II |
| 곡·악장 | Op. 66 | 사냥 (Metsästys) | I. The Hunt (Metsästys) |
| 곡·악장 | Op. 66 | 사랑의 노래 (Minnelaulu) | II. Love Song (Minnelaulu) |
| 곡·악장 | Op. 66 | 도개교에서 (Nostosillalla) | III. At the Draw-Bridge (Nostosillalla) |
| 작품 | Op. 70 | 소프라노와 관현악을 위한 교향시 <루온노타르> | Luonnotar |
| 작품 | Op. 71 | 발레 판토마임 <스카라무슈> | Scaramouche |
| 작품 | Op. 73 | 교향시 <대양의 요정> | The Oceanides (Aallottaret) |
| 곡·악장 | Op. 74 | 목가 (Ekloge) | No. 1 Ekloge |
| 곡·악장 | Op. 74 | 부드러운 서풍 (Sanfter Westwind) | No. 2 Sanfter Westwind |
| 곡·악장 | Op. 74 | 무도회에서 (Auf dem Tanzvergnügen) | No. 3 Auf dem Tanzvergnügen |
| 곡·악장 | Op. 74 | 옛집에서 (Im alten Heim) | No. 4 Im alten Heim |
| 작품 | Op. 75 | 피아노 모음곡 <나무> | 5 Pieces "The Trees", Op. 75 |
| 곡·악장 | Op. 75 | 마가목이 꽃필 때 (När rönnan blommar) | No. 1 När rönnan blommar |
| 곡·악장 | Op. 75 | 외로운 소나무 (Den ensamma furan) | No. 2 Den ensamma furan |
| 곡·악장 | Op. 75 | 사시나무 (Aspen) | No. 3 Aspen |
| 곡·악장 | Op. 75 | 자작나무 (Björken) | No. 4 Björken |
| 곡·악장 | Op. 75 | 가문비나무 (Granen) | No. 5 Granen |
| 곡·악장 | Op. 76 | 스케치 (Esquisse) | No. 1 Esquisse |
| 곡·악장 | Op. 76 | 위안 (Consolation) C#단조 | No. 5 Consolation in C# minor |
| 곡·악장 | Op. 76 | 어린이 소품 (Pièce enfantine) | No. 8 Pièce enfantine |
| 곡·악장 | Op. 76 | 린네풀 (Linnaea) | No. 11 Linnaea |
| 곡·악장 | Op. 76 | 할리퀸 춤 (Harlequinade) | No. 13 Harlequinade |
| 곡·악장 | Op. 77 | 칸티크 (Laetare anima mea) | No. 1 Cantique (Laetare anima mea) |
| 곡·악장 | Op. 77 | 헌신 (Ab imo pectore) | No. 2 Devotion (Ab imo pectore) |
| 곡·악장 | Op. 79 | 추억 (Souvenir) D장조 | No. 1 Souvenir in D major |
| 곡·악장 | Op. 79 | 성격적 무곡 (Danse caractéristique) | No. 3 Danse caractéristique |
| 곡·악장 | Op. 79 | 무도 목가 (Tanz-Idylle) E단조 | No. 5 Tanz-Idylle in E minor |
| 곡·악장 | Op. 81 | 아침의 노래 (Aubade) D장조 | No. 4 Aubade in D major |
| 작품 | Op. 83 | 부수음악 <예더만> | Everyman (Jokamies), Incidental Music |
| 작품 | Op. 85 | 피아노 모음곡 <꽃> | 5 Pieces "The Flowers", Op. 85 |
| 곡·악장 | Op. 85 | 데이지 (Bellis) | No. 1 Bellis |
| 곡·악장 | Op. 85 | 카네이션 (Oeillet) | No. 2 Oeillet |
| 곡·악장 | Op. 85 | 붓꽃 (Iris) | No. 3 Iris |
| 곡·악장 | Op. 85 | 매발톱꽃 (Aquileja) | No. 4 Aquileja |
| 곡·악장 | Op. 85 | 초롱꽃 (Campanula) | No. 5 Campanula |
| 곡·악장 | Op. 91 | 예거 행진곡 (Jääkärien marssi) | Op. 91a Jäger March (Jääkärien marssi) |
| 곡·악장 | Op. 91 | 보이스카우트 행진곡 (Partiolaisten marssi) | Op. 91b Scout March (Partiolaisten marssi) |
| 작품 | Op. 92 | 칸타타 <나의 조국> | My Own Land (Oma maa) |
| 작품 | Op. 93 | 칸타타 <대지의 노래> | Song of the Earth (Jordens sång) |
| 곡·악장 | Op. 94 | 목동과 목동 아가씨 (Berger et bergerette) | No. 4 Berger et bergerette |
| 곡·악장 | Op. 94 | 선율 (Mélodie) B장조 | No. 5 Mélodie in B major |
| 작품 | Op. 95 | 칸타타 <대지의 찬가> | Hymn of the Earth (Maan virsi) |
| 곡·악장 | Op. 96 | 서정적 왈츠 (Valse lyrique) | Op. 96a Valse lyrique |
| 곡·악장 | Op. 96 | 옛날에 (Autrefois) | Op. 96b Autrefois |
| 곡·악장 | Op. 96 | 기사의 왈츠 (Valse chevaleresque) | Op. 96c Valse chevaleresque |
| 곡·악장 | Op. 97 | 노래 (Lied) | No. 2 Lied |
| 곡·악장 | Op. 97 | 작은 왈츠 (Kleiner Walzer) | No. 3 Kleiner Walzer |
| 곡·악장 | Op. 97 | 익살스러운 행진곡 (Humoristischer Marsch) | No. 4 Humoristischer Marsch |
| 곡·악장 | Op. 98 | 작은 모음곡 (Suite mignonne) | Op. 98a Suite mignonne |
| 곡·악장 | Op. 98 | 작은 장면 (Petite scène) | I. Petite scène |
| 곡·악장 | Op. 98 | 전원 모음곡 (Suite champêtre) | Op. 98b Suite champêtre |
| 곡·악장 | Op. 98 | 성격적 소품 (Pièce caractéristique) | I. Pièce caractéristique |
| 곡·악장 | Op. 98 | 엘레지풍 선율 (Mélodie élégiaque) | II. Mélodie élégiaque |
| 곡·악장 | Op. 99 | 익살스러운 소품 (Pièce humoristique) | No. 1 Pièce humoristique |
| 곡·악장 | Op. 99 | 스케치 (Esquisse) | No. 2 Esquisse |
| 곡·악장 | Op. 99 | 추억 (Souvenir) | No. 3 Souvenir |
| 곡·악장 | Op. 99 | 왈츠의 순간 (Moment de valse) | No. 7 Moment de valse |
| 곡·악장 | Op. 99 | 작은 행진곡 (Petite marche) | No. 8 Petite marche |
| 작품 | Op. 100 | 현악과 하프를 위한 <성격적 모음곡> | Suite caractéristique |
| 곡·악장 | Op. 101 | 저녁 노래 (Chant du soir) | No. 2 Chant du soir |
| 곡·악장 | Op. 101 | 서정적 장면 (Scène lyrique) | No. 3 Scène lyrique |
| 곡·악장 | Op. 101 | 낭만적 장면 (Scène romantique) | No. 5 Scène romantique |
| 곡·악장 | Op. 103 | 마을 교회 (The Village Church) | No. 1 The Village Church |
| 곡·악장 | Op. 103 | 바이올린 타는 사람 (The Fiddler) | No. 2 The Fiddler |
| 곡·악장 | Op. 103 | 노 젓는 사람 (The Oarsman) | No. 3 The Oarsman |
| 곡·악장 | Op. 103 | 폭풍 (The Storm) | No. 4 The Storm |
| 곡·악장 | Op. 103 | 슬픈 기분으로 (In Mournful Mood) | No. 5 In Mournful Mood |
| 작품 | Op. 109 | <템페스트> 전주곡과 모음곡 Op. 109 | The Tempest: Prelude and Suites, Op. 109 |
| 곡·악장 | Op. 109 | 떡갈나무 (Der Eichbaum) | I. The Oak Tree |
| 곡·악장 | Op. 109 | 칼리반의 노래 (Calibans Lied) | III. Caliban's Song |
| 곡·악장 | Op. 109 | 추수하는 사람들 (Die Herbstmänner) | IV. The Harvesters |
| 곡·악장 | Op. 109 | 장면 (Scène) | VI. Scène |
| 곡·악장 | Op. 109 | 간주곡 – 아리엘의 노래 (Zwischenspiel – Ariels Lied) | VIII. Entr'acte – Ariel's Song |
| 곡·악장 | Op. 109 | 폭풍 (Der Sturm) | IX. The Storm |
| 곡·악장 | Op. 109 | 바람의 합창 (Chor der Winde) | I. Chorus of the Winds |
| 곡·악장 | Op. 109 | 님프의 춤 (Tanz der Nymphen) | III. Dance of the Nymphs |
| 곡·악장 | Op. 109 | 노래 1 (Lied I) | V. Song I |
| 곡·악장 | Op. 109 | 노래 2 (Lied II) | VI. Song II |
| 곡·악장 | Op. 109 | 물의 요정들 (Die Najaden) | VIII. The Naiads |
| 곡·악장 | Op. 109 | 춤의 에피소드 (Tanz-Episode) | IX. Dance Episode |
| 작품 | Op. 110 | 칸타타 <바이내뫼이넨의 노래> | Väinämöinen's Song (Väinön virsi) |
| 곡·악장 | Op. 111 | 장송 음악 (Surusoitto) | Op. 111b Surusoitto |
| 작품 | Op. 112 | 교향시 <타피올라> | Tapiola |
| 작품 | Op. 113 | <프리메이슨 의식 음악> | Masonic Ritual Music (Musique religieuse) |
| 작품 | Op. 114 | <5개의 스케치> Op. 114 | 5 Sketches, Op. 114 |
| 곡·악장 | Op. 114 | 풍경 (Maisema) | No. 1 Maisema |
| 곡·악장 | Op. 114 | 겨울 풍경 (Talvikuva) | No. 2 Talvikuva |
| 곡·악장 | Op. 114 | 숲속 호수 (Metsälampi) | No. 3 Metsälampi |
| 곡·악장 | Op. 114 | 숲의 노래 (Metsälaulu) | No. 4 Metsälaulu |
| 곡·악장 | Op. 114 | 봄의 환영 (Kevätnäky) | No. 5 Kevätnäky |
| 곡·악장 | Op. 115 | 황야에서 (Auf der Heide) | No. 1 Auf der Heide |
| 곡·악장 | Op. 115 | 종 (Die Glocken) | No. 4 Die Glocken |
| 곡·악장 | Op. 116 | 무도 장면 (Scène de danse) | No. 1 Scène de danse |
| 곡·악장 | Op. 116 | 성격적 무곡 (Danse caractéristique) | No. 2 Danse caractéristique |
| 곡·악장 | Op. 116 | 낭만적 론도 (Rondeau romantique) | No. 3 Rondeau romantique |
| 작품 | JS 1 | 왈츠 A♭장조 "베치 레르셰에게" | Valse in A♭ major "À Betzy Lerche" |
| 작품 | JS 48 | 부수음악 <벨사살의 향연> | Belshazzar's Feast (Belsazars gästabud), Incidental Music |
| 작품 | JS 54 | 관현악을 위한 <행렬> | Cortège |
| 작품 | JS 62 | 부수음악 <새들의 언어> 중 결혼 행진곡 | The Language of the Birds (Die Sprache der Vögel): Wedding March |
| 작품 | JS 65 | <공중누각> (바이올린 2대) | Luftslott (Castles in the Air) for two violins |
| 작품 | JS 70 | <즐거운 악사> (바이올린 독주) | En glad musikant (A Happy Musician) for solo violin |
| 작품 | JS 77a | 멜로드라마 <외로운 스키 자국> | Ett ensamt skidspår (A Lonely Ski-Trail) |
| 작품 | JS 82 | 피아노 모음곡 <플로레스탄> | Florestan |
| 작품 | JS 88 | 멜로드라마 <백작 부인의 초상> | Grevinnans konterfej (The Countess's Portrait) |
| 작품 | JS 97 | 가곡 <잊을 수 없는 타이스 찬가> | Hymn to Thaïs, the Unforgettable |
| 작품 | JS 101 | 오페라 <탑 속의 처녀> | The Maiden in the Tower (Jungfrun i tornet) |
| 작품 | JS 102 | 카리용을 위한 <칼리오 교회의 종> | Kallion kirkon kellosävel (The Bells of Kallio Church) |
| 작품 | JS 109 | 피아노곡 <기사> | Kavaljeren (The Cavalier) |
| 작품 | JS 113 | 부수음악 <쿠올레마> | Kuolema (Death), Incidental Music |
| 작품 | JS 116 | <아시스의 장엄한 행진곡> (피아노 3중주) | La pompeuse Marche d'Asis for piano trio |
| 작품 | JS 125 | 멜로드라마 <질투의 밤> | Svartsjukans nätter (Nights of Jealousy) |
| 작품 | JS 135a | 관현악을 위한 <낭만적 소품> | Morceau romantique sur un motif de M. Jacob de Julin |
| 작품 | JS 137 | <신문의 날 축제 음악> | Press Celebrations Music (Sanomalehdistön päivien musiikki) |
| 작품 | JS 138 | 멜로드라마 <물의 요정> A♭장조 | Näcken (The Watersprite) in A♭ major |
| 작품 | JS 147 | 부수음악 <펠레아스와 멜리장드> | Pelléas et Mélisande, Incidental Music |
| 곡·악장 | JS 153 | 전주곡 (Preludium) | No. 1 Preludium |
| 곡·악장 | JS 153 | 후주곡 (Postludium) | No. 2 Postludium |
| 작품 | JS 160a | 남성 합창곡 <라카스타바> | Rakastava (The Lover) for male chorus |
| 작품 | JS 161 | <사랑하는 아이노에게> (피아노 연탄) | Rakkaalle Ainolle (To My Beloved Aino) for piano four hands |
| 작품 | JS 163 | 관현악을 위한 <발레 장면> | Scène de ballet |
| 작품 | JS 182 | 부수음악 <템페스트> | The Tempest (Stormen), Incidental Music |
| 곡·악장 | JS 185 | 전원 풍경 (Country Scenery) | I. Country Scenery |
| 곡·악장 | JS 185 | 세레나데: 봄 저녁 (Serenade: Evening in Spring) | II. Serenade: Evening in Spring |
| 곡·악장 | JS 185 | 여름에 (In the Summer) | III. In the Summer |
| 작품 | JS 189 | 부수음악 <백조 공주> | Svanevit (Swanwhite), Incidental Music |
| 작품 | JS 194 | 템포 디 발스 F#단조 "룰루 왈츠" (첼로와 피아노) | Tempo di valse in F# minor "Lulu Waltz" for cello and piano |
| 작품 | JS 200 | <티에라> (금관 7중주와 타악기) | Tiera for brass septet and percussion |
| 작품 | JS 207 | 피아노 3중주 A단조 "하프트레스크" | Piano Trio in A minor "Hafträsk" |
| 작품 | JS 208 | 피아노 3중주 C장조 "로비사" | Piano Trio in C major "Lovisa" |
| 작품 | JS 209 | 피아노 3중주 D장조 "코르포" | Piano Trio in D major "Korpo" |
| 작품 | JS 216 | <물방울> (바이올린과 첼로) | Vattendroppar (Water Droplets) for violin and cello |

## 6. 위키백과 대조 결과

`scripts/wikicheck.py` → `raw/wikicheck.json`.

- Op. 1–116 빠짐: [107] (107 은 위키백과도 빈 번호).
- JS 1–225: 넣은 번호 184개, 넣지 않고 까닭을 적은 번호 41개, 까닭 없이 빠진 번호 없음.
- 묶음 곡 수가 위키백과 행 수와 다른 것: Op. 72(위키 6, 우리 4); Op. 75(위키 6, 우리 5) — Op. 72 는 1·2번 소실, Op. 75 는 6번 철회.
- 묶음 곡 조성 대조(양쪽에 조성이 있는 곡): 맞음 71건, 다름 1건(Op. 67/3 위키 'Piano Sonatina No. 3 in B♭ major' ↔ 우리 'No. 3 in B♭ minor').
- 다악장 악장 수가 위키백과 하위 목록과 다른 것: Op. 46(위키 8, 우리 9) — Op. 46 은 4절 6번 참고.
- MB parts 와 위키백과가 다른 곳: Op. 109/3(MB 8곡, 위키 9곡 → 위키대로 9곡, 노래 1·2 MBID 없음), JS 160a(MB 4곡, 위키 3곡 → 위키대로, part MBID 비움), Op. 23(MB 10곡, 위키 9곡 중 6번이 a·b → 6번 아래 children 2개). 나머지 묶음·다악장은 곡 수가 같고 MB 제목의 번호·악장 번호와 우리 순서가 맞는지 기계로 확인했다(`raw/part_map_check.txt`).
- 위키 표 오탈자를 바로잡은 곳: Op. 37/5 "sun"→"sin", Op. 38/4 "Hans"→"hans", Op. 36/4·57/7 따옴표 빠짐, JS 63 "Dolicissimo"→Dolcissimo, JS 203/1 "styta"→"styra".
