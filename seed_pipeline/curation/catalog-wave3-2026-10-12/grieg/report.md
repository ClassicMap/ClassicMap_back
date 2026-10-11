# 그리그 작품 카탈로그 3차 보고 (composer_id 117)

## 1. 개수

- 작품 149개: 묶음 63, 다악장 21, 낱곡 65
- part 512개, children 0개 (두 겹 묶음 없음)
- 새 작품 22개, 운영 seed 를 work 로 이은 작품 127개
- seed 작품 310개 전부 대응: work 127, part 8, unmatched 175
  - arrangement(편곡·다른 편성 판) 72
  - excluded_scope(범위 밖) 60
  - hymn_translation(가사 번안·다른 언어 제목) 20
  - duplicate(같은 작품 다른 seed 행) 7
  - popular(대중음악) 6
  - fragment(단편·스케치) 5
  - unknown(판단 불가) 4
  - spurious(위작 의심) 1
- 운영 manual 작품 없음(0개).
- 생성기 시험(wave3/gen/gen_catalog.py, `--seed-map` 포함, `gen_test.sql`): `{"pieces": 22, "parts": 512, "children": 0, "linked": 8, "updated_parts": 0, "existing_pieces": 127, "retitled_seed": 134}` 오류 없음(잠긴 14198 은 제목 그대로).

## 2. 운영 기존 작품 대응표

work 대응 127개는 모두 **MBID 로** 맞췄어요(seed 의 musicbrainz_work = catalog work mbid).

| seed id | 운영 제목 | → catalog key | 새 제목 |
|---|---|---|---|
| 13721 | Seks sanger med orkester | grieg-eg177 | 6개의 관현악 반주 가곡 |
| 13730 | Fem digte, op. 69 | grieg-op69 | 5개의 가곡 Op. 69 |
| 13736 | An Old Norwegian Folksong with Variations, op. 51 | grieg-op51 | 옛 노르웨이 선율과 변주곡 |
| 13740 | Julens vuggesang, EG 155 | grieg-eg155 | 가곡 <Julens vuggesang> |
| 13742 | Fuge i f-moll, EG 114 | grieg-eg114 | 현악 4중주를 위한 푸가 F단조 |
| 13747 | Folkelivsbilder, op. 19 | grieg-op19 | 피아노 모음곡 <민중 생활의 정경> |
| 13750 | Two Melodies, op. 53 | grieg-op53 | 현악 합주를 위한 2개의 선율 |
| 13757 | Hjertets melodier, op. 5 | grieg-op5 | 가곡집 <마음의 멜로디> |
| 13758 | Fædrelandssang, EG 151 | grieg-eg151 | 가곡 <Fædrelandssang> |
| 13763 | Foran sydens kloster, op. 20 | grieg-op20 | 합창과 관현악을 위한 <수도원 문 앞에서> |
| 13776 | Lyric Suite, op. 54 | grieg-op54-suite | 서정 모음곡 |
| 13778 | Sonata for Violin and Piano no. 1 in F major, op. 8 | grieg-op8 | 바이올린 소나타 1번 F장조 |
| 13783 | 25 Norske Folkeviser og Danser, op. 17 | grieg-op17 | 25개의 노르웨이 민요와 춤곡 Op. 17 |
| 13784 | Fire sanger, op. 2 | grieg-op2 | 4개의 가곡 Op. 2 |
| 13785 | Slåtter (Norwegian Peasant Dances) op. 72 | grieg-op72 | 노르웨이 농민 무곡 <슬로테르> |
| 13788 | Til en hunndjevel, EG 154 | grieg-eg154 | 가곡 <Til en hunndjevel> |
| 13790 | Barnlige Sange | grieg-op61 | 가곡집 <어린이의 노래> |
| 13796 | Påskesang, EG 146 | grieg-eg146 | 가곡 <Påskesang> |
| 13803 | Sechs Lieder, op. 48 | grieg-op48 | 6개의 가곡 Op. 48 |
| 13805 | Tåren, EG 128 | grieg-eg128 | 가곡 <Tåren> |
| 13807 | Seks Norske fjellmelodier | grieg-eg108 | 6개의 노르웨이 산의 선율 |
| 13812 | I Høst (In Autumn) – Concert Overture for Orchestra, op. 11 | grieg-op11 | 연주회용 서곡 <가을에> |
| 13815 | Romancer og Sange, op. 18 | grieg-op18 | 9개의 로망스와 노래 Op. 18 |
| 13818 | Suk, EG 134 | grieg-eg134 | 가곡 <Suk> |
| 13820 | Humoresker, op. 6 | grieg-op6 | 4개의 유모레스크 Op. 6 |
| 13825 | 4 Salmer fritt efter gamle norske Kirkemelodier, op. 74 | grieg-op74 | 4개의 시편 |
| 13831 | Simpel sang, EG 147 | grieg-eg147 | 가곡 <Simpel sang> |
| 13834 | Romanser og ballader af A. Munch, op. 9 | grieg-op9 | 4개의 로망스와 발라드 Op. 9 |
| 13837 | Holberg-kantate EG 171 | grieg-eg171 | 홀베르그 칸타타 |
| 13842 | Den bergtekne, op. 32 | grieg-op32 | 독창과 관현악을 위한 <산에 홀린 사람> |
| 13849 | Sonata for Violin and Piano no. 3 in C minor, op. 45 | grieg-op45 | 바이올린 소나타 3번 C단조 |
| 13855 | Fire pianostykker, op. 1 | grieg-op1 | 4개의 피아노 소품 Op. 1 |
| 13860 | Romancer | grieg-op15 | 4개의 로망스 Op. 15 |
| 13872 | Andante con moto i c-moll, EG 116 | grieg-eg116 | 피아노 3중주를 위한 Andante con moto C단조 |
| 13873 | Sonate for Piano i e-moll, op. 7 | grieg-op7 | 피아노 소나타 E단조 |
| 13874 | Gentlemen-menige, EG 156 | grieg-eg156 | 가곡 <Gentlemen-menige> |
| 13880 | Til L. M. Lindemans Sølvbryllup, EG 135 | grieg-eg135 | 가곡 <Til L. M. Lindemans Sølvbryllup> |
| 13884 | Til Generalkonsul Chr. Tønsberg, EG 136 | grieg-eg136 | 가곡 <Til Generalkonsul Chr. Tønsberg> |
| 13887 | Symphonic Dances, op. 64 | grieg-op64 | 교향적 무곡 |
| 13897 | Album for Mandssang, op. 30 | grieg-op30 | 남성 합창곡집 Op. 30 |
| 13905 | På Hamars ruiner, EG 140 | grieg-eg140 | 가곡 <På Hamars ruiner> |
| 13909 | To symfoniske stykker, op. 14 | grieg-op14 | 2개의 교향적 소품 Op. 14 |
| 13917 | Klaverstykker etter egne sanger, hefte I, op. 41 | grieg-op41 | 자작 가곡에 의한 피아노 소품 1권 Op. 41 |
| 13921 | Jeg elsker, EG 153 | grieg-eg153 | 가곡 <Jeg elsker> |
| 13931 | Odalisken synger, EG 131 | grieg-eg131 | 가곡 <Odalisken synger> |
| 13935 | Poetiske Tonebilder, op. 3 | grieg-op3 | 피아노 모음곡 <시적 음화> |
| 13937 | Under Juletraeet, EG 144 | grieg-eg144 | 가곡 <Under Juletræet> |
| 13940 | Sonata for Cello and Piano in A minor, op. 36 | grieg-op36 | 첼로 소나타 A단조 |
| 13943 | Jenta, EG 141 | grieg-eg141 | 가곡 <Jenta> |
| 13944 | Fire albumblad, op. 28 | grieg-op28 | 4개의 앨범의 잎 Op. 28 |
| 13945 | Jaegeren (Der Jäger), EG 157 | grieg-eg157 | 가곡 <Jægeren> |
| 13955 | Attegløyma, EG 142 | grieg-eg142 | 가곡 <Attegløyma> |
| 13959 | Concerto in A minor for Piano and Orchestra, op. 16 | grieg-op16 | 피아노 협주곡 A단조 |
| 13966 | Vesle gut, EG 129 | grieg-eg129 | 가곡 <Vesle gut> |
| 13967 | 19 norske folkeviser, op. 66 | grieg-op66 | 19개의 노르웨이 민요 Op. 66 |
| 13969 | Siehst du das Meer, EG 121 | grieg-eg121 | 가곡 <Siehst du das Meer> |
| 13974 | Two Lyric Pieces from op. 68 | grieg-op68-orch | 현악 합주를 위한 2개의 서정 소곡 |
| 13975 | Blåbæret, EG 145 | grieg-eg145 | 가곡 <Blåbæret> |
| 13976 | Fem digte op. 70 | grieg-op70 | 5개의 가곡 Op. 70 |
| 13985 | Prinsessen, EG 133 | grieg-eg133 | 가곡 <Prinsessen> |
| 13996 | Den blonde Pige (I), EG 130 | grieg-eg130 | 가곡 <Den blonde Pige> I |
| 13998 | Stemninger, op. 73 | grieg-op73 | 피아노 모음곡 <분위기> |
| 14003 | Den blonde Pige (II), EG 138 | grieg-eg138 | 가곡 <Den blonde Pige> II |
| 14007 | Sonata for Violin and Piano no. 2 in G major, op. 13 | grieg-op13 | 바이올린 소나타 2번 G장조 |
| 14011 | Ni barnestykker, EG 103 | grieg-eg103 | 9개의 어린이 소품 EG 103 |
| 14012 | Valgsang, EG 149 | grieg-eg149 | 가곡 <Valgsang> |
| 14017 | 23 småstykker for klaver, EG 104 | grieg-eg104 | 23개의 작은 소품 EG 104 |
| 14021 | Morgenbønn på skolen, EG 139 | grieg-eg139 | 가곡 <Morgenbønn på skolen> |
| 14028 | Den hvite, røde rose, EG 137 | grieg-eg137 | 가곡 <Den hvite, røde rose> |
| 14034 | Dig elsker jeg! EG 127 | grieg-eg127 | 가곡 <Dig elsker jeg> |
| 14035 | Min lille fugl, EG 126 | grieg-eg126 | 가곡 <Min lille fugl> |
| 14040 | Soldaten, EG 125 | grieg-eg125 | 가곡 <Soldaten> |
| 14148 | String Quartet in F major, EG 117 | grieg-eg117 | 현악 4중주 2번 F장조 |
| 14182 | Vier Romancen | grieg-op10 | 4개의 로망스 Op. 10 |
| 14186 | Dansen går, EG 112 | grieg-eg112 | 피아노곡 <춤은 계속된다> |
| 14191 | Danmark | grieg-eg161 | 합창곡 <Danmark> |
| 14198 | 극음악 <페르 귄트> | grieg-op23 | 극음악 <페르 귄트> |
| 14269 | Sjømannssang | grieg-eg163 | 합창곡 <Sjømannssang> |
| 14292 | Claras sang, EG 124 | grieg-eg124 | 가곡 <Claras sang> |
| 14294 | Flaggvise | grieg-eg172 | 합창곡 <Flaggvise> |
| 14332 | Romancer (ældre og nyere), op. 39 | grieg-op39 | 6개의 로망스 Op. 39 |
| 14382 | Tre klaverstykker, EG 105 | grieg-eg105 | 3개의 피아노 소품 EG 105 |
| 14399 | Ved J. S. Welhavens Båre | grieg-eg165 | 합창곡 <Ved J. S. Welhavens Båre> |
| 14405 | Canon à 4 voci, EG 179 | grieg-eg179 | 4성부 카논 |
| 14443 | Improvista over to norske folkeviser, op. 29 | grieg-op29 | 노르웨이 민요에 의한 2개의 즉흥곡 |
| 14463 | Fire digte fra Fiskerjenten, op. 21 | grieg-op21 | <어부의 딸>에 의한 4개의 가곡 |
| 14542 | Ved Halfdan Kjerulfs minnestøtte, EG 167 | grieg-eg167 | 합창곡 <Ved Halfdan Kjerulfs minnestøtte> |
| 14574 | Sangerhilsen, EG 170 | grieg-eg170 | 합창곡 <Sangerhilsen> |
| 14578 | Inga Litamor | grieg-eg168 | 합창곡 <Inga Litamor> |
| 14583 | Sanger fra Haugtussa som ikke er med i opus 67, EG 152 | grieg-eg152 | <하우그투사> 미수록 가곡 EG 152 |
| 14614 | Intermezzo in A minor, EG 115 | grieg-eg115 | 첼로와 피아노를 위한 간주곡 A단조 |
| 14672 | Valse-kapriser | grieg-op37 | 2개의 왈츠 카프리스 |
| 14698 | Landkjenning, op. 31 | grieg-op31 | 남성 합창곡 <육지가 보인다> |
| 14711 | Symphony in C minor, EG 119 | grieg-eg119 | 교향곡 C단조 |
| 14745 | Elegiske digte, op. 59 | grieg-op59 | 가곡집 <비가풍의 시> |
| 14747 | Den syngende Menighet, EG 122 | grieg-eg122 | 가곡 <Den syngende Menighet> |
| 14787 | Kantate til Karl Hals | grieg-eg164 | 칼 할스를 위한 칸타타 |
| 14816 | Sigurd Jorsalfar, op. 22 | grieg-op22 | 부수음악 <시구르드 요르살파르> |
| 14850 | Fire sanger for mannsstemmer, EG 160 | grieg-eg160 | 4개의 남성 합창곡 EG 160 |
| 14899 | Tusseslåt, EG 111 | grieg-eg111 | 피아노곡 <요정의 곡> |
| 14903 | Haugtussa, op. 67 | grieg-op67 | 연가곡집 <하우그투사> |
| 14934 | Klaverstykker etter egne sanger, op. 52 | grieg-op52 | 자작 가곡에 의한 피아노 소품 2권 Op. 52 |
| 14984 | To sanger av Jørgen Moe, EG 162 | grieg-eg162 | 요르겐 모에 시에 의한 2개의 남성 합창곡 |
| 14993 | Sex digte (Ibsensangene), op. 25 | grieg-op25 | 입센 시에 의한 6개의 가곡 |
| 15037 | 5 Songs of Norway, op. 58 | grieg-op58 | 가곡집 <노르웨이> |
| 15040 | Tolv melodier il digte af Aasmund Olavsson Vinje, op. 33 | grieg-op33 | 비녜 시에 의한 12개의 가곡 |
| 15043 | Tre klaverstykker, EG 102 | grieg-eg102 | 3개의 피아노 소품 EG 102 |
| 15074 | Kantate ved avsløringen av Christie-stauen | grieg-eg158 | 크리스티 동상 제막 칸타타 |
| 15161 | Fem Digte, op. 26 | grieg-op26 | 욘 파울센 시에 의한 5개의 가곡 |
| 15166 | Bergmanden | grieg-eg132 | 가곡 <Bergmanden> |
| 15177 | To Mannskorsanger, EG 169 | grieg-eg169 | 2개의 남성 합창곡 EG 169 |
| 15202 | Reiseminder fra Fjeld og Fjord, op. 44 | grieg-op44 | 가곡집 <산과 피오르의 추억> |
| 15245 | Seks Dikte, op. 49 | grieg-op49 | 드라크만 시에 의한 6개의 가곡 |
| 15253 | Oppsang for frihetsfolket i Norden | grieg-eg166 | 합창곡 <Oppsang for frihetsfolket i Norden> |
| 15265 | Hvide skyer, EG 110 | grieg-eg110 | 피아노곡 <흰 구름> |
| 15297 | Albumblad, EG 109 | grieg-eg109 | 앨범의 잎 |
| 15376 | Bergliot, op. 42 | grieg-op42 | 멜로드라마 <베르글리오트> |
| 15426 | Jædervise | grieg-eg174 | 합창곡 <Jædervise> |
| 15476 | Kristianiensernes Sangerhilsen | grieg-eg173 | 합창곡 <Kristianiensernes Sangerhilsen> |
| 15539 | Dona nobis pacem, EG 159 | grieg-eg159 | 합창곡 <Dona nobis pacem> |
| 15547 | Impromptu til Griegs Mandskor i Fort Dodge, Iowa | grieg-eg175 | 합창곡 <Impromptu til Griegs Mandskor i Fort Dodge, Iowa> |
| 15584 | Agitato, EG 106 | grieg-eg106 | 피아노곡 <Agitato> |
| 15627 | Olav Trygvason, op. 50 | grieg-op50 | <올라브 트뤼그바손>의 장면 |
| 15639 | 5 Digte, op. 60 | grieg-op60 | 5개의 가곡 Op. 60 |
| 15646 | Til kirken hun vandrer, EG 123 | grieg-eg123 | 가곡 <Til kirken hun vandrer> |
| 15680 | Du retter tidt dit øjepar, EG 148 | grieg-eg148 | 가곡 <Du retter tidt dit øjepar> |
| 15686 | To Ole Bull, EG 176 | grieg-eg176 | 합창곡 <Til Ole Bull> |

part 대응 8개(근거는 4절 9번):

| seed id | 운영 제목 | → key [path] | part 이름 | 근거 |
|---|---|---|---|---|
| 14306 | Peer Gynt, op. 23: No. 24. Night Scene | grieg-op23 [26] | 밤 장면 (Nattscene) | MB 제목 Op. 23 + 그리그 판 번호 |
| 14371 | Dans av dovergubbens datter, op. 23 no. 9 | grieg-op23 [10] | 마왕의 딸의 춤 (Dans av Dovregubbens datter) | MB 제목 Op. 23 no. 9 |
| 14421 | Peer Gynt, op. 23: VI. Peer Gynt og den grønnkledte | grieg-op23 [7] | 페르 귄트와 초록 옷의 여인 (Peer Gynt og den grønkledte) | MB 제목 Op. 23 |
| 14845 | Romancer, op. 39 nr. 5: I. Blegnet, segnet (Withered, Fallen) | grieg-op39 [5] | Ved en ung Hustrus Båre | 작품번호 Op. 39 nr. 5 + 시 첫 구절 |
| 14870 | Pièces lyriques (Notturno) | grieg-op54 [4] | 녹턴 (Notturno) | 제목(Notturno) |
| 15281 | Barnlige Sange (Children's Songs), op. 61 nr. 5: Kveldssang for Blakken (Goodnight Song for Dobbin) | grieg-op61 [5] | Kveldsang for Blakken | 작품번호 Op. 61 nr. 5 |
| 15417 | Sex digte, op. 25: No. 2. En svane | grieg-eg177 [4] | 백조 (En Svane) | MB 'based on' 관계 |
| 15474 | Peer Gynt, op. 23: Overture | grieg-op23 [1] | 제1막 전주곡: 결혼식장에서 (I Bryllupsgården) | MB 제목 Op. 23 'Overture' |

운영 중복·묶음 작품:

- 462 '서정 소품집' = 서정 소곡집 10권 전체(묶음 운영 작품, 비교 구간 1) → 그대로 두고 unmatched(excluded_scope).
- 같은 작품의 seed 가 둘 이상인 것은 MBID 를 가진 원작 행을 work 로, 나머지를 duplicate 로:
  - 14098 'Fola, fola blakken' — grieg-op61 5번 'Kveldsang for Blakken' 첫 구절 제목(15281 을 그 part 에 이음)
  - 14158 'Three Piano Pieces: Gnome's Tune' — grieg-eg111 과 같음(영어 제목)
  - 14403 'a-Moll Konzert' — grieg-op16 피아노 협주곡과 같음(독일어 제목)
  - 14559 'Three Piano Pieces: The Dance Goes On, EG 112' — grieg-eg112 와 같음(영어 제목)
  - 15197 'Scentter fra "Olav Trygvason", op. 50' — grieg-op50 <올라브 트뤼그바손>의 장면과 같은 작품의 다른 MB 행
  - 15270 'Andante con moto, EG 137' — grieg-eg116 Andante con moto 와 같음(MB 제목의 'EG 137' 은 잘못된 번호)
  - 15564 'To lyriske stykker' — grieg-op68-orch 와 같음(13974 를 work 로)
- 큰 작품의 한 대목을 따로 둔 manual 작품은 없음(그리그는 manual 0).

## 3. 뺀 것과 까닭

### 위키백과 목록에서 뺀 작품

- 위작 의심 1: EG 101 Larvikspolka
- 단편·스케치 7: EG 118 피아노 5중주 단편, EG 120 피아노 협주곡 B단조 단편, EG 143 Dyre Vaa, EG 178 Halling(하르딩 피들 기보), EG 180 Andante(스케치), 위키 번호 없는 바이올린 협주곡·교향곡 2번 스케치
- 남의 작품 편곡 1: EG 113 모차르트 소나타 4곡의 제2 피아노 파트
- 민요·애창곡 편곡집 1: EG 108 <노르웨이 선율집>(4절 1번)
- 옛 판·다른 판 4: EG 181 Ragnhild(Op. 44-3 옛 판), 번호 없는 'Dulgt kjærlighet'(Op. 39-2 옛 판), 'Møte'(Op. 67-4 옛 판), '루이스 호른베크에게 바친 5개의 가곡'(Op. 9·15, EG 124·125 의 옛 판)
- 그리그 자신의 편곡 행 2: 번호 없는 'Det første møte'(Op. 21-1 성악·관현악), 'Klokkeklang'(Op. 54-6 관현악)
- 소실 3: 'Frieriet paa Helgoland', 현악 4중주 D단조, 'Å Ola, Ola min egen onge'(일부 소실)
- 같은 Op. 의 다른 편성(따로 행이 있어도 작품 하나로): Op. 11 피아노 연탄, Op. 34·63 피아노판, Op. 35 관현악(지트 편곡), Op. 39-5 리드오르간판, Op. 40 피아노판, Op. 51 2대 피아노판, EG 107 관현악판

### seed 만 있고 뺀 것(unmatched) — 까닭별

**excluded_scope(범위 밖) 60**

- 462 '서정 소품집' — 서정 소곡집 10권 전체를 묶은 운영 작품(MB 'Lyriske stykker'). 권별 묶음 grieg-op12…op71 로 나눔. 비교 구간 1, 숨기지 않음
- 13797 'Norges melodier, EG 108' — EG 108 <노르웨이 선율집> 152곡: 민요·애국가·남의 노래를 쉬운 피아노로 옮긴 편곡집이라 뺌
- 13999 '7 fugues, EG 184' — EG 184 7개의 푸가: 라이프치히 학습 습작, 위키 목록(EG 101–181) 밖
- 14121 'Ragnhild' — EG 181 Ragnhild: Op. 44-3 의 옛 판
- 14125 'Resignation, EG 182' — EG 182 Resignation: 위키 목록 밖
- 14468 'Møde' — Møde: Op. 67-4 의 옛 판(위키 'alternate version' 행)
- 15240 '17 Chorales and Fugues' — 17개의 코랄과 푸가: 학습 습작, 위키 목록 밖
- <노르웨이 선율집> 안 곡 53개: 14067, 14118, 14200, 14240, 14324, 14336, 14380, 14402, 14404, 14432, 14447, 14459, 14587, 14612, 14645, 14654, 14678, 14733, 14799, 14820, 14866, 14869, 14893, 14968, 15018, 15077, 15082, 15103, 15108, 15171, 15180, 15200, 15217, 15235, 15246, 15284, 15286, 15298, 15306, 15317, 15363, 15374, 15449, 15478, 15491, 15493, 15503, 15545, 15553, 15591, 15617, 15654, 15674

**arrangement(편곡·다른 편성 판) 72**

- 13734 'Lyriske stykker, op. 65 no. 6: Bryllupsdag på Troldhaugen' — Op. 65-6 관현악 편곡
- 13743 'Peer Gynt Suite no. 1, op. 46: IV. I Dovregubbens hall (In the Hall of the Mountain King)' — Op. 46-4 편곡 모음(catch-all)
- 13793 'Lyric Pieces, op. 54: Bell-Ringing. Andante' — Op. 54-6 자이들 관현악 편곡
- 13799 'Piano II til fire sonater av Mozart, EG 113' — EG 113 모차르트 소나타 4곡에 붙인 제2 피아노 파트(남의 작품 편곡)
- 13882 'Лесная песня' — Op. 10-2 편곡(러시아어 제목)
- 13895 'Norske danser, op. 35' — Op. 35 발현악기 편곡(Tewes)
- 13927 'Danse norvégienne' — Op. 35-2 편곡 'Danse norvégienne'
- 14006 'Symfoniske Danser, op. 64' — Op. 64 피아노 연탄판(그리그 자신의 다른 편성 판)
- 14014 'Fire Norske danser, op. 35' — Op. 35 피아노 독주판(원판은 연탄)
- 14068 '25 Norske Folkeviser og Danser, op. 17 no. 13: Reiselåt' — Op. 17-13 편곡 모음(catch-all)
- 14096 '25 Norske Folkeviser og Danser, op. 17 no. 3: Springdans' — Op. 17-3 편곡 모음(catch-all)
- 14107 'Four Norwegian Dances, op. 35: No. 3' — Op. 35-3 편곡 모음(catch-all)
- 14122 '25 Norske Folkeviser og Danser, op. 17 no. 12: Solfager og ormekongen' — Op. 17-12 편곡 모음(catch-all)
- 14147 'I Høst' — Op. 11 피아노 연탄 원판(그리그 자신의 다른 편성 판). catalog 는 1887 관현악판
- 14163 'Der var engang, op. 71 nr. 1' — Op. 71-1 편곡 모음(catch-all)
- 14236 'Ases Tod' — Op. 23 '오세의 죽음' 독일어 편곡
- 14239 '19 norske folkeviser, op. 66: No. 7. Bådnlåt' — Op. 66-7 편곡 모음(catch-all)
- 14296 'I Love Thee (op. 5, no. 3)' — Op. 5-3 성악·관현악 편곡
- 14319 'Ved en ung hustrus båre' — Op. 39-5 성악·리드오르간판(위키 따로 행, 그리그 자신의 다른 편성)
- 14322 'Ballade op. 65/5' — Op. 65-5 현악 합주 편곡
- 14360 'Til én I, op. 59 no. 3' — Op. 59-3 관현악 편곡(Valdar)
- 14362 'Slåtter - Suite for orkester, op. 72 no. 2: John Væstafæs Springdans' — Op. 72-2 관현악 편곡
- 14397 'Norwegian Bridal Procession' — Op. 19-2 관현악 편곡(델리어스)
- 14427 'Violin Sonata no. 2 in G major, op. 13: III. Allegro animato' — Op. 13 3악장 편곡 모음(catch-all)
- 14492 'Solvejg's Song (op. 23, no. 1)' — Op. 23 '솔베이그의 노래' 영어 가사 관현악 편곡
- 14521 'Ave maris stella' — EG 150 오르간 편곡(Gerhardt)
- 14540 'Lyriske stykker, hefte III, op. 43 no. 2: Ensom vandrer' — Op. 43-2 바이올린·피아노 편곡
- 14551 'Fire digte, op. 21: Det første møte' — Op. 21-1 성악·관현악판(위키 '편곡' 행)
- 14552 'Four Norwegian Dances, op. 35: No. 2' — Op. 35-2 편곡 모음(catch-all)
- 14566 '19 norske folkeviser, op. 66 no. 15: Bådnlåt' — Op. 66-15 편곡 모음(catch-all)
- 14605 'Gavotte et Musette (Holberg Suite)' — Op. 40 가보트 오르간 편곡(Jongen)
- 14616 'Stemninger, op. 73: No. 2. Scherzo-Impromtu' — Op. 73-2 바이올린·피아노 편곡(Achron)
- 14652 'Og jeg vil ha mig en silkevest, op. 60 no. 5' — Op. 60-5 편곡(Valdar)
- 14660 'Lyriske stykker, hefte X, op. 71 no. 3: Smaatrold' — Op. 71-3 바이올린·피아노 편곡(Achron)
- 14674 'Cello Concerto after Cello Sonata, op. 36' — Op. 36 첼로 소나타를 협주곡으로 만든 남의 편곡
- 14748 'Hail Star of Heaven' — EG 150 오르간 편곡(Asper), 영어 제목
- 14761 'Sigurd Jorsalfar, op. 22: I. Borghilds drøm' — Op. 22/56 '보르힐드의 꿈' 피아노판
- 14770 'Three Songs from “Peer Gynt”, op. 23' — Op. 23 노래 3곡 성악·피아노판
- 14789 'Allegretto in E major' — Op. 45 2악장 첼로·피아노 편곡
- 14839 'On St. John's Eve (op. 60, no. 5)' — Op. 60-5 관현악 편곡(영어 제목)
- 14927 'Eros (op 70, no. 1)' — Op. 70-1 관현악 편곡(영어 제목)
- 14928 'Sørgesrsj over Rikard Nordraak, EG 107' — EG 107 금관 편곡
- 14949 'Four Norwegian Dances, op. 35: No. 4' — Op. 35-4 편곡 모음(catch-all)
- 14955 'I Love Thee' — Op. 5-3 피아노 편곡
- 14957 'Sarabande (Holberg Suite)' — Op. 40 사라방드 오르간 편곡(Jongen)
- 14969 'Den bergtekne' — Op. 32 피아노 편곡(Stevenson)
- 15091 'Four Norwegian Dances, op. 35: No. 1' — Op. 35-1 편곡 모음(catch-all)
- 15118 '19 norske folkeviser, op. 66: No. 1. Kulokk' — Op. 66-1 편곡 모음(catch-all)
- 15136 'Peer Gynt, op. 23: Anitras dans' — Op. 23 '아니트라의 춤' 첼로·피아노 편곡(Goltermann)
- 15248 'Ein Traum' — Op. 48-6 두 고음 성부·피아노 편곡
- 15308 '25 Norske Folkeviser og Danser, op. 17 no. 18: Stabbelpten' — Op. 17-18 편곡 모음(catch-all)
- 15318 'Lyriske stykker, hefte III, op. 43 no. 5: Erotikk' — Op. 43-5 편곡 모음(catch-all)
- 15390 'A Dream (op. 48, no. 6)' — Op. 48-6 관현악 편곡(영어 제목)
- 15395 'Sigurd Jorsalfar, op. 22: III. Hyldningsmarsj' — Op. 22/56 '충성 행진곡' 피아노판
- 15401 'Funeral March (In Memory of Richard Nordraak)' — EG 107 관현악 편곡(Wood)
- 15427 'Lyriske stykker, hefte III, op. 43 no. 3: I hjemmet' — Op. 43-3 바이올린·피아노 편곡
- 15431 'Peer Gynt: Death of Åse' — Op. 23/46 '오세의 죽음' 오르간 편곡(Jongen)
- 15439 'Le Djinn' — Op. 71-3 관현악 편곡 'Le Djinn'
- 15494 'Slåtter - Suite for orkester, op. 72 no. 4: Haugelåt - Halling' — Op. 72-4 관현악 편곡
- 15509 'A Swan, op. 25 no. 2' — Op. 25-2 관현악 편곡(영어 제목)
- 15538 'Gammel norsk melodi med variasjoner, op. 51' — Op. 51 2대 피아노 원판(그리그 자신의 다른 편성 판). catalog 는 관현악판
- 15549 '25 Norske Folkeviser og Danser, op. 17 no. 22: Kulokk' — Op. 17-22 편곡 모음(catch-all)
- 15567 'Anitra’s Dance' — Op. 46-3 편곡 모음(catch-all)
- 15569 'Thanks for Thy Advice (op. 21, no.4)' — Op. 21-4 관현악 편곡(영어 제목)
- 15604 'Sigurd Jorsalfar, op. 22: II. Ved mannjevningen. Marsj' — Op. 22/56 '겨루기에서' 피아노판
- 15611 'Folkelivsbilder, op. 19 no. 2: Brudefølget drager forbi' — Op. 19-2 관현악 편곡(할보르센)
- 15631 'Peer Gynt, op. 23: Morgenstemning' — Op. 23 '아침 기분' 첼로·피아노 편곡(Goltermann)
- 15649 '25 Norske Folkeviser og Danser, op. 17 no. 1: Springdans' — Op. 17-1 편곡 모음(catch-all)
- 15655 'Lyriske stykker, hefte II, op. 38 no. 1: Vuggevise' — Op. 38-1 바이올린·피아노 편곡(Sitt)
- 15659 'Slåtter - Suite for orkester, op. 72 no. 8: Bruremarsj (etter Myllarguten)' — Op. 72-8 관현악 편곡
- 15661 'Nordic Folksongs and Dances, op. 17 no. 5: Dance from Jölster' — Op. 17-5 바이올린·피아노 편곡
- 15687 'Til én II, op. 59 no. 4' — Op. 59-4 관현악 편곡(Valdar)

**hymn_translation(가사 번안·다른 언어 제목) 20**

- 13864 'Return to Rundarne' — Op. 33-9 'Ved Rundarne' 영어·프랑스어 제목
- 14022 'ソルヴェイグの歌' — '솔베이그의 노래' 일본어 제목
- 14043 'Väike lind' — 에스토니아어 제목('작은 새')
- 14055 'みずうみ' — 일본어 가사곡('みずうみ')
- 14180 'Fem Digte, op. 26 no. 4. With a Primrose' — Op. 26-4 영어 가사
- 14312 'Lost Song' — Op. 55-4 '솔베이그의 노래' 다른 가사판
- 14396 'Våren, op. 33, no. 2' — Op. 33-2 'Våren' 스웨덴어 가사판(MB 언어 swe)
- 14461 'Der Fichtenbaum, op. 59 no. 2' — Op. 59-2 독일어 번역
- 14516 'T‘estimo' — Op. 5-3 카탈루냐어 번역
- 14527 'Ich liebe dich, op. 5 no. 3' — Op. 5-3 독일어 번역
- 14556 '6 songs, op. 48' — Op. 48 노르웨이어 번역판(원작은 독일어)
- 14589 'Peer Gynt, op. 23: Act V: Solveig's Cradle Song' — Op. 23 '솔베이그의 자장가' 영어 가사
- 14682 'Six Songs, op. 48: No. 1. Greeting' — Op. 48-1 영어 가사
- 14729 'Letzter Frühling' — Op. 33-2 독일어 번역
- 14826 'Fire digte fra Fiskerjenten, op. 21: No. 2. Good Morning' — Op. 21-2 영어 가사
- 15422 'Tides of Spring, op. 33 no. 2' — Op. 33-2 영어 번역
- 15424 'How Fair Is Thy Face' — Op. 74-1 영어 번역
- 15448 'Im Kahne, op. 60 no. 3' — Op. 60-3 독일어 번역
- 15635 '5 Digte, op. 60, no. 2: The Mother Sings' — Op. 60-2 영어 가사
- 15673 'Peer Gynt, op. 23: Acte IV. Solveigs sang' — Op. 23 '솔베이그의 노래' 프랑스어 가사

**popular(대중음악) 6**

- 14057 'Was bin ich ohne dich' — '솔베이그의 노래'를 바탕으로 한 독일어 대중가요
- 14059 'Grieg’s Piano Concerto' — 모어캠·와이즈 코미디 촌극
- 14631 'Hall of the Mambo King' — '산속 마왕의 궁전에서' 맘보 편곡
- 14742 'One More Night With You' — 그리그 선율을 바탕으로 한 대중가요
- 15069 'Ase's Death' — 듀크 엘링턴 재즈판(MB 녹음 3개 모두 엘링턴 악단)
- 15450 'Petey’s King of France (“In the Hall of the Mountain King”)' — '산속 마왕의 궁전에서' 대중 편곡

**duplicate(같은 작품 다른 seed 행) 7**

- 14098 'Fola, fola blakken' — grieg-op61 5번 'Kveldsang for Blakken' 첫 구절 제목(15281 을 그 part 에 이음)
- 14158 'Three Piano Pieces: Gnome's Tune' — grieg-eg111 과 같음(영어 제목)
- 14403 'a-Moll Konzert' — grieg-op16 피아노 협주곡과 같음(독일어 제목)
- 14559 'Three Piano Pieces: The Dance Goes On, EG 112' — grieg-eg112 와 같음(영어 제목)
- 15197 'Scentter fra "Olav Trygvason", op. 50' — grieg-op50 <올라브 트뤼그바손>의 장면과 같은 작품의 다른 MB 행
- 15270 'Andante con moto, EG 137' — grieg-eg116 Andante con moto 와 같음(MB 제목의 'EG 137' 은 잘못된 번호)
- 15564 'To lyriske stykker' — grieg-op68-orch 와 같음(13974 를 work 로)

**fragment(단편·스케치) 5**

- 14358 'Klaverkontsert h moll, EG 120 (fragmenter)' — EG 120 피아노 협주곡 B단조 단편
- 14882 'Andante' — EG 180 스케치
- 14947 'Halling' — EG 178 하르딩 피들 곡 기보 단편
- 15182 'Fragmenter av en pianokvintett EG 118' — EG 118 피아노 5중주 단편
- 15198 'Dyre Vaa' — EG 143 단편

**spurious(위작 의심) 1**

- 15031 'Larvikspolka, EG 101' — EG 101 위작 의심(위키 'Possibly spurious')

**unknown(판단 불가) 4**

- 14429 'Der Wind wird zum Sturm (Nordische Weisen)' — 'Der Wind wird zum Sturm (Nordische Weisen)' 원곡 확인 안 됨
- 15293 'Danse paysanne' — 'Danse paysanne' 원곡 확인 안 됨
- 15356 'Lyric Pieces: Melody' — 'Lyric Pieces: Melody' Op. 38-3 인지 Op. 47-3 인지 MB 도 모름
- 15556 'Bønn fra "Sigurd Jorsalfar", op. 56 no. 1' — 'Bønn fra Sigurd Jorsalfar, op. 56 no. 1': Op. 56-1 은 전주곡이라 제목이 안 맞음

## 4. 애매했던 판단

1. **<노르웨이 선율집> EG 108(152곡)을 뺐어요.** 민요뿐 아니라 애국가·학생가·남의 노래(노르드라크, 셸룹 등)를 쉬운
   피아노(가사 붙음)로 옮긴 편곡집이라 SPEC 의 민요·남의 작품 편곡 규칙에 걸려요. MB 도 152곡 중 119개만 parts 로 있어 곡목을
   끝까지 맞출 수 없어요. 그래서 seed 13797(seed part 117개)과 그 안 곡을 가리키는 seed 53개(MB 제목이 'Norges melodier, EG 133 No. n'
   으로 잘못 붙은 행 52 + 'EG 108: No. 146' 1)를 모두 excluded_scope 로 뒀어요. 넣기로 하면 seed 54개를 숨기지 않고 묶음 하나로 모을 수 있지만
   152곡 목록을 따로 구해야 해요.
   반면 Op. 17·66·72(작품번호 받은 민요·하르딩 피들 곡 피아노 편곡), Op. 30(남성 합창 민요 편곡), EG 168, 그리고 EG 108 에서 뽑아 1886년에
   따로 낸 <6개의 노르웨이 산의 선율>(seed 13807)은 그리그의 창작 편곡으로 보고 넣었어요.
2. **무대 작품에 part 를 둔 것.** Op. 23 <페르 귄트>는 seed 4개(15474 '서곡'=1막 전주곡, 14421, 14371, 14306)가 안의 번호를 가리켜서
   SPEC 대로 MB parts 로 part 28개를 만들었어요(kind=multi_movement, movementNumber 없음). 순서는 위키백과 막 구성(1막 4·2막 8·3막 2·4막 8·5막 6)을
   따랐고, 위키 목록의 'Day Scene'(MB 없음)과 3막 'Solveig's Song'(4막과 겹침)은 넣지 않았어요. 할보르센 편곡 '신부 행렬'과 3막 전주곡은 위키·MB
   둘 다 있어 넣었어요.
   Op. 22 <시구르드 요르살파르>(9곡), Op. 50 <올라브 트뤼그바손>의 장면(3장), EG 171 홀베르그 칸타타(4악장), EG 167(2부분)도 seed 작품에 이미
   seed part 가 붙어 있어 이름을 고쳐 주려고 part 를 뒀어요. 낱곡으로 되돌리려면 이 다섯 작품의 kind 를 single 로, parts 를 비우면 돼요.
3. **Op. 23 제목은 운영 제목 '극음악 <페르 귄트>'를 그대로 썼어요.** seed 14198 은 editor_locked=1(설명·링크·비교 구간 있음)이라 3차 생성기가
   제목을 바꾸지 않아요. part 에 이은 seed 의 새 제목('극음악 <페르 귄트> 중 "…"')과 맞추려고 catalog 제목도 같게 뒀어요. Op. 22 는 2차 관례대로 '부수음악'.
4. **seed 462 '서정 소품집'(MB 'Lyriske stykker', 10권 전체, 비교 구간 1)** 은 비발디 '사계' 꼴의 묶음 운영 작품이라 그대로 두고 unmatched
   (excluded_scope)로 적었어요. 비교 구간이 있어 숨기지 않아요. 권별 묶음(Op. 12…71)이 새로 생겨 작곡가 화면에 '서정 소품집'과 '서정 소곡집 n권'이
   함께 보여요. 462 의 seed part 53개(권 MBID·곡 MBID)는 손대지 않았어요. 새 권 묶음은 그 권 MBID 를 work MBID 로 써요(all_mbids_taken 에는 없음).
5. **같은 Op. 의 다른 편성.** 마지막 판·대표 판 하나만 넣었어요: Op. 11 관현악(1887, 피아노 연탄 원판 seed 14147 은 arrangement), Op. 40·34·63 현악 합주판,
   Op. 51 관현악판(2대 피아노 원판 seed 15538 은 arrangement), Op. 64 관현악판(연탄 seed 14006 은 arrangement), Op. 35 피아노 연탄 원판.
   곡 구성이 다른 관현악 모음은 따로 넣었어요: <서정 모음곡>(Op. 54 중 4곡, seed 13776), 현악 합주를 위한 2개의 서정 소곡(Op. 68 중 2곡, seed 13974).
6. **EG 110·111·112** 는 위키에서 '3개의 피아노 소품' 한 행이지만 EG 번호가 셋이라 낱곡 셋으로 뒀어요(운영 seed 도 셋). 영어 제목 seed 14158·14559 는 duplicate.
7. **EG 117 현악 4중주 2번**은 두 악장만 완성됐지만 그 꼴로 연주·녹음돼 넣었어요(미완성 연주 관례). **EG 152 <하우그투사> 미수록 가곡**은 위키 12곡대로
   넣었는데 MB 에는 6곡만 있어 나머지 6곡 part 는 mbid 가 없어요. **Op. 44** 도 MB parts 가 없어 6곡 모두 mbid 없음.
8. **EG 182·184·'17 Chorales and Fugues'** 는 위키 목록(EG 101–181) 밖 학습 습작·소품이라 excluded_scope 로 뒀어요. **EG 181 Ragnhild**, 'Møde'(14468)는
   위키가 Op. 44-3·Op. 67-4 의 옛 판으로 적어 뺐어요. **EG 113**(모차르트 소나타에 붙인 제2 피아노)은 남의 작품 편곡으로 뺐어요.
9. **제목만으로 part 에 이은 seed** (근거):
   - 14845 'Romancer, op. 39 nr. 5: I. Blegnet, segnet' → Op. 39-5 'Ved en ung Hustrus Båre'(작품번호 + 시 첫 구절 'Blegnet, segnet').
   - 14870 'Pièces lyriques (Notturno)' → Op. 54-4 Notturno(서정 소곡 중 Notturno 는 이것 하나).
   - 15281 'Barnlige Sange … op. 61 nr. 5: Kveldssang for Blakken' → Op. 61-5(작품번호). 같은 노래 첫 구절 제목 'Fola, fola blakken'(14098)은 duplicate.
   - 15417 'Sex digte, op. 25: No. 2. En svane (for orchestra)' → EG 177-4(MB 'based on' 관계가 EG 177 no. 4 를 가리킴).
   - 15474 'Peer Gynt, op. 23: Overture' → Op. 23 1막 전주곡. 14306 'No. 24. Night Scene' → 밤 장면(그리그 판 번호 24).
10. **seed part 중 catalog 에 없는 것**(생성기가 손대지 않음): 14198 의 44897823 'Solveigs sang, op. 23 no. 1'(성악·피아노판, 무대 번호 아님),
    13790 의 ba99f07a 'Barnlige Sange op. 61 nr. 5: III. Lok'(MB 의 엉뚱한 중복 part).
11. **unknown 4개**: 14429 'Der Wind wird zum Sturm (Nordische Weisen)', 15293 'Danse paysanne', 15356 'Lyric Pieces: Melody'(Op. 38-3/47-3 중 어느 것인지 MB 도 모름),
    15556 'Bønn fra Sigurd Jorsalfar, op. 56 no. 1'(Op. 56-1 은 전주곡이라 안 맞음).
12. **excerpt_keep 은 0개.** 큰 작품 대목을 가리키는 seed 는 모두 Op. 23 part 로 이었고(4개), 남은 것은 남의 편곡·번역·대중판이에요.
    15069 'Ase's Death' 는 MB 'other version' 만 있어 녹음을 한 번 조회해 보니 3개 모두 듀크 엘링턴 악단 재즈판이라 popular 로 뒀어요.
13. 노래 편곡 중 '(orchestrated version)' 영어 제목 행(14492·14839·14927·15390·15509·15569)은 한 음반의 남의 관현악 편곡으로 보고 arrangement.
    다만 15417 만은 MB 가 EG 177(그리그 자신의 관현악 가곡)과 이어 part 로 이었어요.

## 5. 직접 옮긴 우리말 이름(검수용)

국내에서 널리 쓰는 것으로 본 이름: 서정 소곡집, 페르 귄트, 아침 기분, 오세의 죽음, 아니트라의 춤, 산속 마왕의 궁전에서, 솔베이그의 노래, 솔베이그의 자장가, 아라비아의 춤, 페르 귄트의 귀향, 신부의 약탈·잉그리드의 탄식, 홀베르그 모음곡, 서정 모음곡, 교향적 무곡, 그대를 사랑해(Jeg elsker dig), 백조(En svane), 봄(Våren), 꿈(Ein Traum), 가슴의 상처·지난 봄(Op. 34), 트롤드하우겐의 결혼식 날, 나비, 난쟁이의 행진, 작은 새, 고향에서, 아리에타, 요정의 춤, 파수꾼의 노래, 양치기 소년, 종소리, 꼬마 요정.

작품별 우리말 곡 이름 전체(처음 나온 곳 기준, 위 목록 포함):

- 가곡집 <마음의 멜로디>: 그대를 사랑해 (Jeg elsker dig)
- 서정 소곡집 1권 Op. 12: 아리에타 (Arietta); 왈츠 (Vals); 파수꾼의 노래 (Vægtersang); 요정의 춤 (Elverdans); 민요 (Folkevise); 노르웨이 선율 (Norsk); 앨범의 잎 (Stambogsblad); 조국의 노래 (Fædrelandssang)
- 피아노 모음곡 <민중 생활의 정경>: 산의 춤 (Fjeldslåt); 신부 행렬이 지나간다 (Brudefølget drar forbi); 사육제에서 (Fra Karnevalet)
- <어부의 딸>에 의한 4개의 가곡: 첫 만남 (Det første Møde)
- 부수음악 <시구르드 요르살파르>: 제1막 전주곡 (Innledning til Akt I); 보르힐드의 꿈 (Borghilds Drøm); 겨루기에서 (Ved Mandjevningen); 노래: 북방 민족 (Kvad: Norrønafolket); 충성 행진곡 (Hyldningsmarsch); 간주곡 I (Mellomspill I); 간주곡 II (Mellomspill II); 왕의 노래 (Kongekvadet); 호른 신호 (Hornsignaler)
- 극음악 <페르 귄트>: 제1막 전주곡: 결혼식장에서 (I Bryllupsgården); 할링 (Halling); 스프링가르 (Springar); 제2막 전주곡: 신부의 약탈, 잉그리드의 탄식 (Bruderovet. Ingrids klage); 페르 귄트와 목장 처녀들 (Peer Gynt og sæterjentene); 페르 귄트와 초록 옷의 여인 (Peer Gynt og den grønkledte); 말 탄 모습으로 귀인을 알아본다 (På ridestellet skal storfolk kjendes); 산속 마왕의 궁전에서 (I Dovregubbens hall); 마왕의 딸의 춤 (Dans av Dovregubbens datter); 트롤에게 쫓기는 페르 귄트 (Peer Gynt jages av troll); 페르 귄트와 뵈위그 (Peer Gynt og Bøygen); 제3막 전주곡: 깊은 숲속에서 (Dypt inne i barskogen); 오세의 죽음 (Åses død); 제4막 전주곡: 아침 기분 (Morgenstemning); 도둑과 장물아비 (Tyven og heleren); 아라비아의 춤 (Arabisk dans); 아니트라의 춤 (Anitras dans); 페르 귄트의 세레나데 (Peer Gynts serenade); 페르 귄트와 아니트라 (Peer Gynt og Anitra); 솔베이그의 노래 (Solveigs sang); 멤논 석상 앞의 페르 귄트 (Peer Gynt ved Memnonstøtten); 제5막 전주곡: 페르 귄트의 귀향 (Peer Gynts hjemfart); 난파 (Skipsforliset); 오두막에서 노래하는 솔베이그 (Solveig synger i hytten); 밤 장면 (Nattscene); 성령강림절 찬송 (Pinsesalme); 솔베이그의 자장가 (Solveigs vuggevise)
- 입센 시에 의한 6개의 가곡: 백조 (En Svane)
- 비녜 시에 의한 12개의 가곡: 봄 (Våren)
- 2개의 비가적 선율: 가슴의 상처 (Hjertesår); 지난 봄 (Våren)
- 서정 소곡집 2권 Op. 38: 자장가 (Vuggevise); 선율 (Melodie); 스프링당스 (Springdans); 엘레지 (Elegie); 카논 (Kanon)
- 6개의 로망스 Op. 39: 몬테 핀치오에서 (Fra Monte Pincio)
- 서정 소곡집 3권 Op. 43: 나비 (Sommerfugl); 외로운 나그네 (Ensom vandrer); 고향에서 (I Hjemmet); 작은 새 (Liden Fugl); 에로티크 (Erotik); 봄에게 (Til Foråret)
- <페르 귄트> 모음곡 1번: 아침 기분 (Morgenstemning)
- 서정 소곡집 4권 Op. 47: 왈츠 즉흥곡 (Valse-Impromptu); 앨범의 잎 (Albumblad); 멜랑콜리 (Melankoli)
- 6개의 가곡 Op. 48: 장미의 계절에 (Zur Rosenzeit); 꿈 (Ein Traum)
- 자작 가곡에 의한 피아노 소품 2권 Op. 52: 첫 만남 (Det første møte)
- 서정 소곡집 5권 Op. 54: 양치기 소년 (Gjætergut); 노르웨이 행진곡 (Gangar); 난쟁이의 행진 (Troldtog); 녹턴 (Notturno); 스케르초 (Scherzo); 종소리 (Klokkeklang)
- <페르 귄트> 모음곡 2번: 신부의 약탈, 잉그리드의 탄식 (Bruderovet. Ingrids klage); 페르 귄트의 귀향 (Peer Gynts hjemfart)
- <시구르드 요르살파르> 모음곡: 전주곡: 겨루기에서 (Ved Mannjevningen); 간주곡: 보르힐드의 꿈 (Borghilds Drøm)
- 서정 소곡집 6권 Op. 57: 지나간 날들 (Svundne Dage); 가데 (Gade); 환상 (Illusion); 비밀 (Hemmelighed); 그녀는 춤춘다 (Hun danser); 향수 (Hjemve)
- 서정 소곡집 7권 Op. 62: 실프 (Sylphe); 감사 (Takk); 프랑스 세레나데 (Fransk Serenade); 시냇물 (Bækken); 환영 (Drømmesyn); 집으로 (Hjemad)
- 2개의 북유럽 선율: 민요풍으로 (I folketonestil)
- 서정 소곡집 8권 Op. 65: 젊은 날에서 (Fra Ungdomsdagene); 농부의 노래 (Bondens Sang); 우울 (Tungsind); 살롱 (Salon); 발라드풍으로 (I Balladetone); 트롤드하우겐의 결혼식 날 (Bryllupsdag på Troldhaugen)
- 서정 소곡집 9권 Op. 68: 뱃사람의 노래 (Matrosernes Opsang); 할머니의 미뉴에트 (Bedstemors Menuet); 그대 발밑에 (For dine Føtter); 산 위의 저녁 (Aften på Højfjeldet); 요람에서 (Bådnlåt); 우울한 왈츠 (Valse mélancolique)
- 서정 소곡집 10권 Op. 71: 옛날 옛적에 (Der var engang); 여름 저녁 (Sommeraften); 꼬마 요정 (Småtrold); 숲의 고요 (Skovstilhed); 지나간 날 (Forbi); 회상 (Efterklang)
- 23개의 작은 소품 EG 104: 전주곡 (Preludium); 2성부 전주곡 (To-stemmig Preludium)

작품 제목 중 직접 옮긴 고유 제목: <시적 음화>(Op. 3), <마음의 멜로디>(Op. 5), <가을에>(Op. 11), <민중 생활의 정경>(Op. 19), <수도원 문 앞에서>(Op. 20), <어부의 딸>(Op. 21), <시구르드 요르살파르>(Op. 22·56), <육지가 보인다>(Op. 31), <산에 홀린 사람>(Op. 32), 2개의 비가적 선율(Op. 34), <베르글리오트>(Op. 42), <산과 피오르의 추억>(Op. 44), <올라브 트뤼그바손>(Op. 50), 옛 노르웨이 선율과 변주곡(Op. 51), <노르웨이>(Op. 58), <비가풍의 시>(Op. 59), <어린이의 노래>(Op. 61), 2개의 북유럽 선율(Op. 63), <하우그투사>(Op. 67), <슬로테르>(Op. 72), <분위기>(Op. 73), 4개의 시편(Op. 74), 리카르드 노르드라크 추모 장송 행진곡(EG 107), 6개의 노르웨이 산의 선율(EG 108), <흰 구름>·<요정의 곡>·<춤은 계속된다>(EG 110–112), 크리스티 동상 제막 칸타타(EG 158), 칼 할스를 위한 칸타타(EG 164), 홀베르그 칸타타(EG 171).
가곡·합창곡 낱곡(EG 121–176)과 민요 편곡 곡 이름은 원제 그대로 뒀어요.

## 6. 위키백과 대조 결과

`scripts/wikicheck.py` → `raw/wikicheck.txt`. 위키 표 행마다 catalog 작품을 찾아 곡 수·조성을 맞췄어요.

- Op. 1–74 빠짐 없음. 위키 EG 번호(101–181) 중 뺀 것(EG 101·113·118·120·143·178·180·181, 3절) 말고는 빠짐 없음. 위키에 없는 catalog 번호 없음.
- 곡목이 있는 위키 행은 곡 수가 모두 맞음(서정 소곡집 10권, Op. 17 25곡, Op. 66 19곡, Op. 72 17곡, EG 104 23곡 등).
- 위키에 곡목이 없는 작품(소나타·협주곡·현악 4중주·교향곡·Op. 23·Op. 50·Op. 51·EG 167·EG 171)은 MB parts 를 따랐어요.
- 조성: 위키 영어 제목·곡목에 적힌 조성은 모두 catalog 제목·곡 이름에 들어가 있어요(EG 107 은 대조에서 걸려 'A단조'를 넣음).
- MB 와 위키가 다른 곳(위키를 따름):
  - Op. 17 10·11번: MB 'Friervise', 'Kjempevise' / 위키 'Aa Ole engang i sinde', 'På Dovrefjeld i Norge'(같은 곡, 다른 이름).
  - EG 104 3·12·22번: MB 'Molto allegro vivace', 'Largo con estro poetica', 'Rolig, ikke for hurtig' / 위키 'Allegro desiderio', 'Preludium', 'Nicht zu schnell, ruhig'.
  - Op. 22: MB 순서 키가 9번 'Hornsignaler'를 맨 앞에 둠 → 위키 순서로.
  - Op. 56 1번: MB 'Prelude: I kongens hall' / 위키 'Prelude: Ved Mannjevningen'.
  - Op. 23: MB parts 에 무대 번호가 아닌 성악·피아노 '솔베이그의 노래'와 작곡가가 다른 'Ut av Dovregubbens hall'이 섞여 있어 뺐고, 위키의 'Day Scene'은 MB 에 없어 뺐어요.
  - Op. 61: MB parts 에 5번 자리 엉뚱한 'III. Lok' 중복 part → 뺌.
  - EG 152: 위키 12곡, MB 6곡.
- 위키가 한 행에 둔 EG 110·111·112 는 낱곡 셋(6번 판단).

## 파일

- `catalog.json`, `seed_map.json`, `gen_test.sql`(생성기 시험 결과)
- `scripts/`: browse.py(MB 받기), wiki_fetch.py·wikiparse.py(위키 표), overview.py(MB 나무 `raw/mb_tree.txt`), defs_op.py·defs_eg.py(작품 손 정의), defs_seed.py(unmatched seed), build.py(catalog·seed_map 만들고 검사), wikicheck.py, report.py
