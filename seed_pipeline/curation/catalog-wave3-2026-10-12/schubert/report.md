# 슈베르트(composer 26) 작품 카탈로그 3차 보고

## 1. 개수

- 작품 882: 묶음 68 · 다악장 64 · 낱곡 750
- part 824 (그 아래 children 10)
- 기준: 위키백과 「List of compositions by Franz Schubert」(연도별 표 23쪽)와 「… by genre」. D 단위 1,071개 중 넣음 882, 뺌 189.
- seed 1160: work 793 / part 28 / unmatched 339
  - unmatched 까닭: arrangement 177, fragment 74, duplicate 25, hymn_translation 25, popular 13, unknown 12, excluded_scope 8, spurious 3, excerpt_keep 2
- 생성기(wave3/gen/gen_catalog.py --seed-map) 시험: 새 작품 81, part 796, children 10, 기존 작품 801(seed+manual), 기존 part 고쳐 쓰기 28, part 에 이은 운영 작품 29, seed 제목 바꾸기 822. 숨김 시험(--hide-only) 337개.

## 2. 운영 기존 작품 대응

### manual

| id | 운영 제목 | key | 근거 |
|---|---|---|---|
| 116 | 연가곡집 <겨울나그네> | schubert-d911 | MBID 16a894eb(D 911), part 24개 MBID 같음 → existingPartId |
| 117 | 가곡 <마왕> | schubert-d328 | MBID d783dab0(D 328) |
| 118 | 피아노 5중주 A장조 "송어" | schubert-d667 | MBID ed002d99(D 667) |
| 119 | 교향곡 8번 B단조 "미완성" | schubert-d759 | MBID b1e3d631(D 759) |
| 120 | 현악 4중주 14번 D단조 "죽음과 소녀" | schubert-d810 | 카탈로그 D 810 (운영 MBID 는 말러 편곡 work — 4절 참고) |
| 121 | 즉흥곡 Op. 90 | schubert-d899 | MBID 9d1fcbf9(D 899), part 4개 MBID 같음 → existingPartId |
| 443 | 가곡 "아베 마리아" (엘렌의 노래 3번) | schubert-d839 | MBID b2be878e(D 839) |
| 444 | 악흥의 순간 3번 F단조 | schubert-d780 [3] | MBID 07bd01cc = D 780 3번 part → part existingPieceId |
| 26033 | 네 손을 위한 환상곡 F단조 | schubert-d940 | MBID 5ace0f06(D 940) |

### seed

- work 793·part 28 의 대응 전체는 seed_map.json. work 는 모두 seed 의 MBID 가 그 D 번호의 원곡 work 인 것으로 맞춤(같은 D 에 seed 가 둘 이상이면 하나는 duplicate).
- MBID 만으로 안 되어 손으로 맞춘 것:
  - 605 「Harfenspieler I aus "Wilhelm Meister", D. 478 "Wer sich der Einsamkeit ergibt"」 → schubert-d478 [1]: Harfenspieler I = D 478 1번(1816년 1판)
  - 625 「Harfenspieler III, D. 480 "Wer nie sein Brot mit Tränen aß"」 → schubert-d478 [2]: 옛 D 480 = D 478 2번(1816년 1판)
  - 12027 「Harfenspieler II, D. 479: "An die Türen will ich schleichen"」 → schubert-d478 [3]: 옛 D 479 = D 478 3번(1816년 1판)
  - 12181 「Hymnus an den heiligen Geist, D. 964」 → schubert-d948: 옛 D 964 = D 948 2판(관악 반주)
  - 12270 「Gott! Höre meine Stimme, D. 190 Nr. 5」 → schubert-d190 [6]: 5번 「Gott! höre meine Stimme」(성악·피아노판은 슈베르트 자신의 판)
  - 12441 「Sehnsucht (Nur wer die Sehnsucht kennt) (Mignon's Song), D. 310b」 → schubert-d310: D 310 2판
  - 12458 「Selma und Selmar, D. 286b」 → schubert-d286: D 286 다른 판
  - 12474 「Die schöne Müllerin (Tränenregen)」 → schubert-d795 [10]: 제목으로 맞춤: 「Die schöne Müllerin (Tränenregen)」 = D 795 10번
  - 12634 「Gütigster, Bester, Weisester, D. 441」 → schubert-d407 [1]: 옛 D 441 = D 407 1번의 3성부·피아노 판
  - 12745 「Symphonie n° 5 (Allegro)」 → schubert-d485 [1]: 제목으로 맞춤: 「Symphonie n° 5 (Allegro)」 = 교향곡 5번 1악장 Allegro
  - 12895 「Winterreise D911: Der Lindenbaum: Am Brunnen vor dem Tore」 → schubert-d911 [5]: MB 「Winterreise D911: Der Lindenbaum」 = D 911 5번
  - 13684 「5 Minuets, D.89」 → schubert-d89 [1]: MB 「5 Minuets, D.89」(parts 는 10곡 전부로 잘못 묶임) — 미뉴에트 다섯 곡 묶음에 이음

### 운영 중복(같은 작품을 가리키는 운영 작품 둘 이상)

- 663 「Im Frühling, D. 882」 — seed 13257 와 같은 작품(다른 MB work: Im Frühling, D. 882)
- 667 「Auf dem Wasser zu singen, D. 774」 — seed 13575 와 같은 작품(다른 MB work: Auf dem Wasser zu singen, D. 774)
- 2438 「Der Hirt auf dem Felsen, D. 965」 — seed 12611 와 같은 작품(다른 MB work: Der Hirt auf dem Felsen, D. 965)
- 11928 「String Quartet no. 14 in D minor, D. 810 “Death and the Maiden”」 — manual 120 과 같은 작품(MBID 없음)
- 12210 「Der Leidende „Klage“, D. 432b」 — seed 12157 와 같은 작품(다른 MB work: Der Leidende „Klage“, D. 432b); D 432 다른 판
- 12259 「Das Dörfchen, D. 641」 — seed 12821 와 같은 작품(다른 MB work: Das Dörfchen, D. 641); 옛 D 641 = D 598 2판(Op. 11 No. 1)
- 12271 「Winterreise, op. 89, D. 911」 — manual 116 과 같은 작품(MBID 없음)
- 12305 「3 Sonatas for Violin and Piano, op. 137」 — Op. 137 세 곡 묶음 — 카탈로그는 D. 384·385·408 낱개(schubert-d384/d385/d408)
- 12332 「Wiegenlied: "Schlafe, holder süßer Knabe"」 — 제목으로 맞춤: 자장가 D 498 과 같은 곡(다른 MB work)
- 12339 「Widerschein, D. 949」 — seed 13168 와 같은 작품(다른 MB work: Widerschein, D. 949); 옛 D 949 = D 639 2판
- 12643 「An den Frühling, D. 245: "Willkommen, schöner Jüngling"」 — seed 12477 와 같은 작품(다른 MB work: An den Frühling, D. 245: "Willkommen, schöner Jüngling"); 옛 D 245 = D 587 2판
- 12700 「4 Gesänge, D. 983」 — Op. 17 네 곡 묶음 — 카탈로그는 D 983·983A·983B·983C 낱개(schubert-d983 등)
- 12702 「Romanze: Der Vollmond strahlt, D. 797 Nr. 3b」 — 로망스 성악·피아노판(Op. 26) — schubert-d797 [4] 와 겹침
- 12802 「Deux Marches Caractéristiques, D. 886」 — seed 13531 와 같은 작품(다른 MB work: Deux Marches Caractéristiques, D. 886); 옛 D 886 = D 968B
- 12813 「Nacht und Träume」 — 제목으로 맞춤: D 827 과 같은 곡(다른 MB work)
- 12883 「Menuette und Deutsche, D. 90」 — D 89 와 같은 작품(옛 D 90 표기) — work schubert-d89
- 13100 「4 Impromptus, op. 90, D. 899」 — manual 121 과 같은 작품(MBID 없음)
- 13197 「Moments musicaux for the Pianoforte, op. 94」 — Buonamici 판 악보 — schubert-d780 과 같은 작품
- 13233 「Lieder, Franz Schubert: Heidenröslein」 — 제목으로 맞춤: D 257 과 같은 곡(다른 MB work)
- 13262 「Sonata for Piano no. 2 in C major, D. 279」 — seed 12944 와 같은 작품(다른 MB work: Sonata for Piano no. 2 in C major, D. 279)
- 13320 「Der Taucher, D. 111」 — seed 12238 와 같은 작품(다른 MB work: Der Taucher, D. 111); 옛 D 111 = D 77 2판
- 13355 「Ständchen, D. 920」 — seed 13661 와 같은 작품(다른 MB work: Ständchen, D. 920)
- 13572 「5 Deutsche Tänze, D. 90」 — D 89 독일 무곡 다섯 곡(옛 D 90) — schubert-d89 [2] 와 겹침
- 13605 「Szene aus Goethes Faust, D.126」 — seed 13161 와 같은 작품(다른 MB work: Szene aus Goethes Faust, D.126)
- 13690 「Sehnsucht (Nur wer die Sehnsucht kennt) (Mignon's Song), D. 310a」 — seed 12441 와 같은 작품(다른 MB work: Sehnsucht (Nur wer die Sehnsucht kennt) (Mignon's Song), D. ); D 310 1판

### 큰 작품의 대목(excerpt_keep, 숨기지 않음)

- 12566 「Rosamunde D 797 : Musique de scène : Ouverture (Die Zauberharfe)」 → <로자문데> 서곡 / Rosamunde Overture (Die Zauberharfe, D. 644)
- 13261 「Ouvertüre zur Oper Fierabras D796」 → <피에라브라스> 서곡 / Fierrabras Overture

## 3. 뺀 것과 까닭

- 독창 가곡 · 단편 28: D 15 Der Geistertanz, D 15; D 15A Der Geistertanz, D 15A; D 144 Romanze, D 144; D 164 Liebesrausch, D 164; D 172 Der Morgenstern, D 172; D 201 Auf den Tod einer Nachtigall, D 201; D 327 Lorma, D 327; D 329 Die drei Sänger; D 363 An Chloen, D 363; D 376 Lorma, D 376; D 396 Gruppe aus dem Tartarus, D 396; D 416 Lied in der Abwesenheit; D 467 Pflicht und Liebe; D 469 Mignon, D 469; D 484 Gesang der Geister über den Wassern, D 484; D 532 Das Lied vom Reifen; D 549 Mahomets Gesang, D 549; D 564 Gretchen im Zwinger a.k.a. Gretchens Bitte; D 577 Entzückung an Laura, D 577; D 596 Lied eines Kindes; D 645 Abend, D 645; D 663 Psalm 13 (12); D 682 Über allen Zauber Liebe; D 721 Mahomets Gesang, D 721; D 728 Johanna Sebus; D 937 Lebensmut, D 937; D 990E L'incanto degli occhi; D 990F Ombre amene a.k.a. La serenata
- 피아노 독주 · 단편 18: D 24D Fugue, D 24D; D 41A Fugue, D 41A; D 71B Fugue, D 71B; D 154 Piano Sonata, D 154; D 309A Rondo, D 309A; D 346 Allegretto, D 346; D 347 Allegro moderato, D 347; D 348 Andantino, D 348; D 349 Adagio, D 349; D 570 Scherzo and Allegro; D 571 Piano Sonata, D 571; D 605 Fantasy, D 605; D 613 Piano Sonata, D 613; D 625 Piano Sonata, D 625; D 655 Piano Sonata, D 655; D 769A Piano Sonata, D 769a; D 900 Allegretto, D 900; D 980C Two Ländler, D 980C
- 분류 없음(소실·부록) · 소실 13: D 14 Overture, D 14; D 19 String Quartet, D 19; D 19A String Quartet, D 19A; D 19B Waltzes and a March, D 19B; D 20 Overture, D 20; D 21 Six Variations, D 21; D 22 Twelve Minuets with Trios, D 22; D 24 Seven Variations, D 24; D 425 Lebensbild; D 451 Prometheus, D 451; D 597A Variations; D 944A German Dance, D 944A; D 981 Der Minnesänger
- 분류 없음(소실·부록) · 남의 곡 전사(Anh. III) 13: D Anh. III/1 Schubert's copy of nine canons by Michael Hay; D Anh. III/2 Schubert's copy of Franz Roser's Die Teilung ; D Anh. III/3 Schubert's copy of part of Mozart's Symphony ; D Anh. III/4 Schubert's copy of a canon from Zumsteeg's El; D Anh. III/5 Schubert's copy of Zumsteeg's Chor der Derwis; D Anh. III/6 Schubert's copy of Joseph Preindl's Offertory; D Anh. III/7 Schubert's copy of Reichardt's Monolog aus Go; D Anh. III/8 Schubert's copy of part of Beethoven's Sympho; D Anh. III/9 Schubert's copy of the organ part of M. Haydn; D Anh. III/10 Schubert's copy of Joseph Preindl's Mass in C; D Anh. III/11 Schubert's copy of a canon by Mozart, K. 440d; D Anh. III/12 Schubert's copy of a canon by Mozart, K. 230/; D Anh. III/13 Schubert's copy of Beethoven's Abendlied unte
- 독창 가곡 · 스케치 10: D 1A Song, D 1A; D 39 Lebenstraum; D 311 An den Mond, D 311; D 513A Nur wer die Liebe kennt; D 555 Liedentwurf, D 555; D 874 O Quell, was strömst du rasch und wild; D 896 Fröhliches Scheiden; D 896A Sie in jedem Liede; D 896B Wolke und Quelle; D 916A Liedentwurf, D 916A
- 보유(연습·기타) · 작곡 연습 10: D 16 Counterpoint exercises, D 16; D 17 Composition exercises, D 17; D 25 Counterpoint exercises, D 25; D 25A Counterpoint exercises, D 25A; D 25B Counterpoint exercises, D 25B; D 25C Fugue, D 25C; D 33 Composition exercises, D 33; D 34 Composition exercises, D 34; D 35 Composition exercises, D 35; D 965B Fugal exercises, D 965B
- 중창·합창 · 스케치 9: D 65 Schmerz verzerret ihr Gesicht; D 249 Die Schlacht, D 249; D 329A Das Grab, D 329A; D 387 Die Schlacht, D 387; D 705 Gesang der Geister über den Wassern, D 705; D 873 Canon, D 873; D 873A Nachklänge; D 875A Die Allmacht, D 875A; D 916 Das stille Lied
- 분류 없음(소실·부록) · 위작·의심작(Anh. I 등) 9: D Anh. I/1 String Quartet, D Anh. I/1; D Anh. I/2 String Quartet, D Anh. I/2; D Anh. I/8 Piano Sonata, D Anh. I/8; D Anh. I/9 Piano Sonata, D Anh. I/9; D Anh. I/10 Fantasy, D Anh. I/10; D Anh. I/12 Seven Easy Variations; D Anh. I/13 Six German Dances, D Anh. I/13; D Anh. I/16 Écossaise de Vienne; D Anh. I/24 Kantate auf den Vater (Cantata to his father)
- 보유(연습·기타) · 위작·의심작(Anh. I 등) 9: D Anh. I/3 Fugue, D Anh. I/3; D Anh. I/14 Waltz, D Anh. I/4, a.k.a. Kupelwieser-Walzer; D Anh. I/15 Minuet with Trio, D Anh. I/15; D Anh. I/17 Tantum ergo, D Anh. I/17; D Anh. I/25 Drum Schwester und Brüder; D Anh. I/26 Sturmbeschwörung; D Anh. I/28 Klage, D Anh. I/28; D Anh. I/29 Kaiser Ferdinand II.; D Anh. I/32 Themes for thoroughbass exercises
- 관현악 · 단편 6: D 2A Overture, D 2A; D 2B Symphony, D 2B; D 2G Overture, D 2G; D 71C Orchestral piece, D 71C; D 74A Orchestral piece, D 74A; D 470 Overture, D 470
- 실내악 · 단편 6: D 2C String Quartet, D 2C; D 3 String Quartet, D 3; D 72 Wind Octet; D 87A Andante, D 87A; D 103 Quartettsatz, D 103; D 111A String Trio, D 111A
- 중창·합창 · 단편 6: D 47 Dithyrambe, D 47; D 70 Sprüche des Confucius, D 70; D 356 Trinklied, D 356; D 725 Duet, D 725; D 984 Der Wintertag a.k.a. Geburtstaglied; D 988A Accompaniment part
- 중창·합창 · 위작·의심작(Anh. I 등) 6: D Anh. I/18 Lied beim Rundetanz; D Anh. I/19 Lied im Freien, D Anh. I/19; D Anh. I/20 Amors Macht; D Anh. I/21 Badelied; D Anh. I/22 Sylphen; D Anh. I/23 Lebenslied, D Anh. I/23
- 피아노 독주 · 스케치 5: D 37A Fugue sketches, D 37A; D 916B Piano piece, D 916B; D 916C Piano piece, D 916C; D 980A Two Dances, D 980A; D 980E Two Dances, D 980E
- 독창 가곡 · 소실 5: D 204A Das Traumbild; D 863 An Gott; D 864 Das Totenhemdchen; D 990B Augenblicke im Elysium; D 990D Die Schiffende
- 관현악 · 스케치 5: D 615 Symphony, D 615; D 708A Symphony, D 708A; D 729 Symphony No. 7; D 936A Symphony No. 10; D 966B Orchestral piece, D 966B
- 무대 음악 · 단편 4: D 11 Der Spiegelritter; D 94A Orchestral piece, D 94A; D 137 Adrast; D 435 Die Bürgschaft, D 435
- 무대 음악 · 스케치 4: D 701 Sakuntala (also spelled Sacontala or Sakontal; D 791 Rüdiger; D 918 Der Graf von Gleichen; D 982 Sketches for an opera a.k.a. Sophie
- 보유(연습·기타) · 남의 곡 편곡(Anh. II) 4: D Anh. II/1 Arrangement of Gluck's overture to Iphigénie ; D Anh. II/2 Arrangement of Matiegka's Notturno (Trio), Op; D Anh. II/3 Arrangement of two arias from Gluck's Echo et; D Anh. II/4 Arrangement of M. Stadler's 8th Psalm (Zwölf 
- 실내악 · 소실 3: D 2F Trio, D 2F; D 39A Three Minuets with Trios, D 39A; D 94B Five Minuets and Six German Dances, D 94B
- 교회 음악 · 단편 3: D 24E Mass, D 24E; D 453 Requiem; D 607 Evangelium Johannis 6, Vers 55–58
- 피아노 네 손 · 단편 2: D 1B Fantasy, D 1B; D 1C Sonata, D 1C
- 실내악 · 스케치 1: D 2D Six Minuets, D 2D
- 피아노 독주 · 위작·의심작(Anh. I 등) 1: D 13 Fugue, D 13
- 독창 가곡 · D 번호 없음 1: D deest:Das war ich, D deest Das war ich, D deest
- 보유(연습·기타) · 소실 1: D 177A Am ersten Mai
- 무대 음악 · 소실 1: D 239 Claudine von Villa Bella
- 중창·합창 · 소실 1: D 426 Trinklied, D 426
- 피아노 네 손 · 스케치 1: D 618A Polonaise, D 618A
- 중창·합창 · 작곡 연습 1: D 619 Sing-Übungen (vocal exercises)
- 교회 음악 · 스케치 1: D 755 Kyrie, D 755
- 보유(연습·기타) · 스케치 1: D 778B Ich hab' in mich gesogen
- 피아노 네 손 · 위작·의심작(Anh. I 등) 1: D Anh. I/7 March, D Anh. I/7

같은 곡의 옛 판은 D 번호를 따로 받지 않아 단위에 안 들어감(예: D 328 마왕 1~3판, D 550 송어 1~4판). 옛 판을 가리키는 seed 는 그 D 의 duplicate 나 part 로 적음(옛 D 479·480·641·949·964·111·245 등).

## 4. 애매했던 판단

1. **미완성인데 넣은 것** — D 759 미완성 교향곡(완성된 두 악장만 part, 단편 스케르초 뺌), D 840 피아노 소나타 15번 "Reliquie"(완성된 앞 두 악장만 part, 단편 3·4악장 뺌 — MB·seed 는 4악장), D 703 4중주 악장(완성된 1악장만, 낱곡), D 471 현악 3중주 1번(완성된 1악장만, 낱곡), D 68 현악 4중주 5번(가운데 악장 소실, 두 악장), D 157·279·566 피아노 소나타 1·2·6번(앞 세 악장만 전함, 번호 붙은 소나타로 연주됨), D 689 <라자루스>(1막·2막 일부만 전하는 미완성 오라토리오, 녹음·연주 있음 — 넣음), D 93 <Don Gayseros>(위키: 2·3번 미완성 — AGA·전집 녹음에 있어서 넣음), D 41(30곡 중 20곡 전함), D 681(12곡 중 8곡 전함), D 380(3곡 중 완성된 2곡만). 뺀 미완성: D 729 교향곡 7번·D 936A 10번·D 615·708A 등 스케치 교향곡, D 571·613·625·655·769A 피아노 소나타 단편, D 72 관악 8중주, D 239 <Claudine von Villa Bella>(1막만 전함), D 11·137·435·701·791·918 미완성 무대 작품.
2. **피에라브라스 D 796** — MB parts 50개가 순서 없이 두 벌로 겹쳐 있어 part 를 만들지 않음(낱곡). 서곡 seed 13261 과 로자문데 서곡 seed 12566(D 644 서곡)은 `excerpt_keep`(제목 `<피에라브라스> 서곡`, `<로자문데> 서곡`). 2막 아리아 seed 4개(12544·13105·13371·13535)는 `unknown` 으로 둠(숨겨짐) — part 로 살리려면 번호표가 필요함.
3. **로자문데 D 797·D 190** — 무대 작품이지만 seed 가 대목을 가리켜 part 를 만듦. D 797 은 위키 번호표 10곡(서곡은 D 644·732 것이라 뺌, MB 는 서곡 포함 11), D 190 은 MB 순서 9곡(서곡+8번호). D 787(로망스 성악·피아노판)·D 647 은 seed 가 편곡뿐이라 part 없이 둠.
4. **운영 manual 120 「죽음과 소녀」의 MBID 가 말러 현악 합주 편곡(db422156 "orch. Mahler")** — 그 MBID 로 붙은 manual part 4개(38323~38326)도 말러판 악장. catalog 는 원곡 work(c6e6e640)와 원곡 악장 MBID 로 part 4개를 새로 넣게 되어 있어서, 옛 part 4개를 지우거나 MBID 를 바꾸는 처리가 마이그레이션에 필요함.
5. **D 단위로 짠 것** — 가곡은 D 번호 낱곡, 한 D 번호 아래 여러 곡이면 묶음(D 93·478·688·795·857·866·877·902·911·957, D 407). 그래서 작품번호로 묶인 seed(「3 Sonatas op. 137」 12305, 「4 Gesänge D. 983」=Op. 17 12700)는 `duplicate`. 미사는 위키가 「Sanctus & Benedictus」를 한 줄로 적지만 MB·관례대로 6악장(D 105·167·324·452·950, D 678 은 MB 13조각을 6악장으로 합침). D 459 소나타 3번은 위키대로 D 459(2악장)와 D 459A(3곡 묶음)로 나눔(MB·seed 는 5악장 「Fünf Klavierstücke」). D 957 은 위키대로 13곡(비둘기 우편은 D 965A 낱곡, MBID 는 MB 의 D 957 14번 part 를 씀). D 89 는 두 겹(5개의 미뉴에트 / 5개의 독일 무곡, 그 아래 곡).
6. **슈베르트 자신의 다른 편성판** — D 592·597·773·798(서곡 네 손판), D 759A(알폰소 서곡 피아노판), D 8A(서곡 현악 4중주판)은 자기 D 번호가 있어 낱곡으로 넣음.

## 5. 직접 옮긴 우리말 이름(검수용)

- 가곡 제목(「우리말 (원제)」): D 118 물레 잣는 그레트헨, D 257 들장미, D 328 마왕, D 550 송어, D 531 죽음과 소녀, D 547 음악에 부쳐, D 498 자장가, D 776 그대는 나의 안식, D 827 밤과 꿈, D 774 물 위에서 노래함, D 764 뮤즈의 아들, D 891 실비아에게, D 544 가니메드, D 965 바위 위의 목동, D 943 강 위에서, D 686 봄의 신앙, D 138 쉼 없는 사랑, D 367 툴레의 왕, D 674 프로메테우스, D 882 봄에, D 828 젊은 수녀, D 771 난쟁이, D 489 방랑자, D 905 류트에게, D 799 저녁노을 속에서, D 583 타르타로스의 무리, D 216 바다의 고요, D 965A 비둘기 우편, D 714 물 위의 정령의 노래, D 706 시편 23편, D 953 시편 92편
- 연가곡 곡 이름: D 795: 방랑, 어디로?, 멈춰라!, 시냇물에 대한 감사, 일을 마치고, 궁금한 사람, 조바심, 아침 인사, 물방앗간 사람의 꽃, 눈물의 비, 나의 것!, 휴식, 초록색 리본을 달고, 사냥꾼, 질투와 자존심, 좋아하는 색, 싫어하는 색, 시든 꽃, 물방앗간 사람과 시냇물, 시냇물의 자장가; D 911: 밤 인사, 풍향계, 얼어붙은 눈물, 동결, 보리수, 넘쳐흐르는 눈물, 강 위에서, 회상, 도깨비불, 휴식, 봄의 꿈, 고독, 우편 마차, 백발, 까마귀, 마지막 희망, 마을에서, 폭풍의 아침, 환영, 이정표, 여인숙, 용기, 환일, 거리의 악사; D 957: 사랑의 소식, 전사의 예감, 봄의 동경, 세레나데, 머무를 곳, 먼 곳에서, 이별, 아틀라스, 그녀의 초상, 어부의 딸, 도시, 바닷가에서, 도플갱어
- 별명·고유 제목: 비극적(D 417), 작은 C장조(D 589), 그레이트(D 944), 4중주 악장(D 703), 소나타 악장(D 28), 노투르노(D 897), 작은 장송 음악(D 79), 듀오(D 574), 그라츠 환상곡(D 605A), 방랑자(D 760), 마지막 왈츠(D 146), 첫 왈츠(D 365), 빈 귀부인 렌틀러(D 734), 유물(D 840 Reliquie), 가슈타인(D 850), 환상(D 894), 감상적인 왈츠(D 779), 고귀한 왈츠(D 969), 크레빙클 춤(D 980D), 그랑 소나타(D 48), 우리의 우정은 변치 않으리(D 608), 그랑 듀오(D 812), 어린이 행진곡(D 928), 인생의 폭풍(D 947), 그랑 론도(D 951), 화려한 론도(D 895), 군대 행진곡(D 733), 영웅 행진곡(D 602), 대행진곡(D 819), 성격적 행진곡(D 968B), 익살스러운 렌틀러(D 354), 독일 미사(D 872), 독일 레퀴엠(D 621), 독일어 슈타바트 마테르(D 383), 성령 찬가(D 948), 종려 주일을 위한 6개의 안티폰(D 696), 살리에리 50주년 기념 축하곡(D 407), 하프 타는 사람의 노래(D 478), 빌헬름 마이스터의 노래(D 877), 4개의 후렴 가곡(D 866), 3개의 노래(D 902), 4개의 칸초네(D 688), 라자루스(D 689), 알폰소와 에스트렐라(D 732), 피에라브라스(D 796), 로자문데(D 797·D 804), 헝가리 선율(D 817), 헝가리풍·프랑스풍 디베르티스망(D 818·823).
- 로자문데 part: 간주곡 1·2·3번, 발레 음악 1·2번, 로망스, 정령의 합창, 목동의 선율, 목동의 합창, 사냥꾼의 합창.
- 중창 갈래어: 위키 갈래별 목록의 Trio/Quartet/Quintet/Octet → 「남성·여성·혼성 N중창」, Chorus·Hymn·(관현악 없는) Cantata → 「…합창곡」, 관현악 칸타타·이름에 Kantate → 「칸타타」, Canon → 「카논」, Duet → 「2중창」.
- 같은 제목이 겹치는 120곡(낱곡)은 제목 끝에 D 번호(`가곡 <Sehnsucht> D. 310`). 제목이 그냥 「Lied」인 곡은 첫 구절을 괄호로(`가곡 <Lied (In's stille Land)>`).

## 6. 위키백과 대조

```
제목 겹침(카탈로그 안): []
운영 잠긴 제목과 겹침: []
번호로 시작하는 nameKo: []
빈 nameKo: []
seed 수 1160 / seed_map 1160 / 빠짐 [] / 남는 것 []
catalog 에서 두 번 쓴 운영 id: []
seed_map work/part 와 catalog 불일치: [] / catalog 에만: [] / seed_map 에만: []

== 위키 대조
넣기로 한 D 882 / catalog 882 / 빠진 D []
묶음 곡 수 다름:
  D. 41 위키 이름 30곡 / part 20 (Thirty Minuets with Trios, D 41)
  D. 89 위키 이름 10곡 / part 2 (Five Minuets and Five German Dances)
  D. 380 위키 이름 3곡 / part 2 (Three Minuets, each with Two Trios)
  D. 681 위키 이름 12곡 / part 8 (Twelve Ländler, D 681)
  D. 735 위키 이름 8곡 / part 9 (Galop and Eight Écossaises)
  D. 790 위키 이름 24곡 / part 12 (Twelve German Dances, D 790, a.k.a. Twelve Ländler)
조성 다름:
악장 수 다름:
  D. 759 위키 3악장(Allegro moderato – Andante con moto – Scherzo (Fragment)) / part 2
  D. 840 위키 4악장(Moderato – Andante (publ. 1839) – Minuet (fragment) – Rondo (fragment)) / part 2
연도 없음: ['D. 968A', 'D. 970', 'D. 973', 'D. 974', 'D. 975', 'D. 977', 'D. 980B', 'D. 980F', 'D. 985', 'D. 986', 'D. 988', 'D. 990C']
```

MB parts 와 위키가 다른 곳(위키를 따름): D 957(MB 14곡, 위키 13곡+D 965A), D 797(MB 서곡 포함 11, 위키 10), D 279(MB 4악장에 D 346 포함, 위키 3), D 459(MB 5곡 한 work, 위키 D 459·459A 둘), D 407(MB 4곡에 옛 D 441 판 포함, 위키 3), D 735(MB 에 Polka 하나 더, 위키 갤롭+8곡), D 781(MB 11, 위키 12 — 12번 MBID 없음), D 970(MB 5, 위키 6 — 6번 MBID 없음), D 299(MB 8번만, 위키 12). 미사는 위키 5줄(Sanctus & Benedictus)·MB 6악장 → 6악장으로 둠.

