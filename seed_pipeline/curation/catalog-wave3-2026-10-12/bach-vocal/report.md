# 바흐 성악 작품 카탈로그 — 3차 보고

- 범위: BWV 1–524(칸타타·모테트·미사·수난곡·오라토리오·마니피카트·4성부 코랄·가곡·아리아)와 성악 추가분(BWV 1084·1089·1122–1127). 기악은 cat3-bach-instr 몫.
- 기준: 위키백과 "List of compositions by Johann Sebastian Bach"(성악 장은 전재 문서 Bach cantata·List of motets·List of masses, passions and oratorios·Chorale harmonisations BWV 253–438·List of songs and arias)와 "List of Bach cantatas".
- MusicBrainz: 바흐 artist work 8,418개를 browse(inc=aliases+work-rels, 100개씩 85번)로만 받았다(`mb_works.json`). 낱개 조회 없음.
- 순서: `fetch_browse.py` → `parse_wiki.py`·`wiki_cantatas.py` → `build_catalog.py`(works.py·defs.py·mbpick.py·parts.py·names.py) → `match_seeds.py` → `finalize.py` → `check.py` → `report.py`.
- 생성기 시험(wave3/gen/gen_catalog.py --seed-map) 통과: 새 작품 13, 기존 작품 243, part 2,015, children 84, 기존 작품 연결 part 336, 제목 바뀌는 seed 575(잠긴 seed 14951·15339 는 생성기가 건너뜀). 기악 seed_map 과 함께 --hide-only 시험도 통과(seed 1,686개 모두 어느 한쪽 seed_map 에 있음).

## 1. 개수

| 갈래 | 작품 | part | children |
|---|---:|---:|---:|
| collection | 2 | 258 | 0 |
| multi_movement | 227 | 1757 | 84 |
| single | 27 | 0 | 0 |
| 합계 | 256 | 2015 | 84 |

- 갈래별 작품 수: cantata 213, choral 9, motet 7, sacred 7, song 6, mass 5, oratorio 5, aria 3, songs 1
- 칸타타 213개(교회·세속, BWV2a 글자 번호 작품 30a·36b·36c·69a·134a·173a·207a 포함), 모테트 7, 미사 5(B단조 + 루터 미사 4), 미사 단장 5(233a·237·238·240·242), 마니피카트 2, 수난곡 2, 오라토리오 3, 4성부 코랄 묶음 1(189곡), 쉬멜리 묶음 1(69곡), 낱곡 코랄 8, 낱곡 가곡·아리아 9.
- MBID: 작품 251/256(두 묶음은 MB 에 묶음 work 없음, BWV 244 는 아래 2절 까닭으로 비움, 500a·1084 는 MB 에 없음), part 2015/2015, children 84/84.

seed 대응(바흐 seed 1686개 중 성악 쪽으로 판정한 745개):

| 대응 | 개수 |
|---|---:|
| work | 242 |
| part | 335 |
| unmatched · duplicate | 59 |
| unmatched · hymn_translation | 30 |
| unmatched · arrangement | 20 |
| unmatched · popular | 15 |
| unmatched · excluded_scope | 11 |
| unmatched · spurious | 10 |
| unmatched · other_composer | 9 |
| unmatched · fragment | 9 |
| unmatched · unknown | 5 |
| 합계 | 745 |

- seed_map 에 넣지 않은 941개: 제목의 BWV 가 기악 번호(525 이상, 성악 추가분 빼고)인 665개는 기악 쪽, 나머지 276개는 BWV 표기도 MB 관계도 성악으로 확실하지 않은 것(오르간 코랄 전주곡과 이름이 같은 찬송 제목, 대중음악, 기악 편곡 등). 리드가 두 에이전트 결과를 합칠 때 남는 몫. 기악 에이전트와 둘 다 unmatched 로 잡았던 14개(기악 편곡·메들리 6, 찬송 번안 7, Anh. 31 코랄 1)는 같은 까닭으로 기악 seed_map 에 있어 내 쪽에서 뺐다 — 두 seed_map 합집합 1,686, 겹침 0. 기악 쪽이 성악 몫으로 넘긴 745개는 모두 받았다(14213 협주곡 재구성·15455 BWV 131a 오르간 푸가는 arrangement).

## 2. 운영 기존 작품 대응

manual 작품(제목 그대로):

| id | 운영 제목 | key | 자리 | 근거 |
|---:|---|---|---|---|
| 15 | 마태 수난곡 | bach-bwv244 | 작품 | 운영 opus_number BWV 244(카탈로그 번호). MBID 없음 |
| 432 | 칸타타 BWV 147 "예수, 인류의 소망의 기쁨" | bach-bwv147 | part 10 (코랄 «Jesus bleibet meine Freude») | MBID bb71e7f6 = MB 의 BWV 147 X 하위 work 와 같음 |

- 운영 중복: BWV 244 는 manual 15 와 seed 13801 «Matthäus-Passion, BWV 244»(MBID 45afb3b2, seed part 104개), seed 14887 «St. Matthew Passion»이 같은 작품. manual 15 를 자리로 쓰고 두 seed 는 duplicate. 작품 MBID 45afb3b2 는 13801 이 쓰고 있어 catalog 에서는 비웠다(13801 을 숨긴 뒤 15 로 옮기면 됨).
- 나머지 manual 바흐 작품 10·11·12·13·14·16·431 은 기악이라 손대지 않음.

seed 작품(work 242, part 335). 근거 칸이 빈 것은 seed MBID 가 catalog 의 작품·part MBID 와 같음:

| seed id | 운영 제목 | key | path | 자리 이름 | 근거 |
|---:|---|---|---|---|---|
| 14193 | Kantate, BWV 1 “Wie schön leuchtet der Morgenstern” | bach-bwv1 |  | 칸타타 <Wie schön leuchtet der Morgenstern> BWV 1 | MBID |
| 14907 | Kantate, BWV 1 "Wie schön leuchtet der Morgenstern": I. Coro "Wie schö | bach-bwv1 | [1] | 합창 "Wie schön leuchtet der Morgenstern" | BWV 1 악장 번호 1 |
| 15546 | Kantate, BWV 10 "Meine Seel erhebt den Herren" | bach-bwv10 |  | 칸타타 <Meine Seel erhebt den Herren> BWV 10 | MBID |
| 14632 | Kantate, BWV 100 "Was Gott tut, das ist wohlgetan" | bach-bwv100 |  | 칸타타 <Was Gott tut, das ist wohlgetan> BWV 100 | MBID |
| 15458 | Kantate, BWV 101 "Nimm von uns, Herr, du treuer Gott" | bach-bwv101 |  | 칸타타 <Nimm von uns, Herr, du treuer Gott> BWV 101 | MBID |
| 15652 | Kantate, BWV 102 "Herr, deine Augen sehen nach dem Glauben" | bach-bwv102 |  | 칸타타 <Herr, deine Augen sehen nach dem Glauben> BWV | MBID |
| 14981 | Kantate, BWV 103 "Ihr werdet weinen und heulen" | bach-bwv103 |  | 칸타타 <Ihr werdet weinen und heulen> BWV 103 | MBID |
| 14718 | Kantate, BWV 103 "Ihr werdet weinen und heulen" (Appendix): I. Coro "I | bach-bwv103 | [1] | 합창 "Ihr werdet weinen und heulen" | BWV 103 악장 번호 1 |
| 15140 | Kantate, BWV 103 "Ihr werdet weinen und heulen" (Appendix): II. Recita | bach-bwv103 | [2] | 레치타티보 "Wer sollte nicht in Klagen untergehn" | BWV 103 악장 번호 2 |
| 15663 | Kantate, BWV 103 "Ihr werdet weinen und heulen" (Appendix): III. Aria  | bach-bwv103 | [3] | 아리아 "Kein Arzt ist außer dir zu finden" | BWV 103 악장 번호 3 |
| 15693 | Kantate, BWV 104 "Du Hirte Israel, höre" | bach-bwv104 |  | 칸타타 <Du Hirte Israel, höre> BWV 104 | MBID |
| 15497 | Kantate, BWV 105 „Herr, gehe nicht ins Gericht mit deinem Knecht“ | bach-bwv105 |  | 칸타타 <Herr, gehe nicht ins Gericht mit deinem Knech | MBID |
| 14951 | 칸타타 <하나님의 시간이 가장 좋은 때> | bach-bwv106 |  | 칸타타 <Gottes Zeit ist die allerbeste Zeit> "Actus t | MBID |
| 14952 | Cantata, BWV 106 "Gottes Zeit ist die allerbeste Zeit" (Actus tragicus | bach-bwv106 | [1] | 소나티나 | BWV 106 악장 가사 일치 |
| 14139 | Kantate, BWV 107 "Was willst du dich betrüben" | bach-bwv107 |  | 칸타타 <Was willst du dich betrüben> BWV 107 | MBID |
| 15605 | Kantate, BWV 108 "Es ist euch gut, daß ich hingehe" | bach-bwv108 |  | 칸타타 <Es ist euch gut, daß ich hingehe> BWV 108 | MBID |
| 14481 | Choralsatz, BWV 1089 "Da Jesus an dem Kreuze stund" | bach-bwv1089 |  | 코랄 <Da Jesus an dem Kreuze stund> BWV 1089 | MBID |
| 15052 | Kantate, BWV 109 "Ich glaube, lieber Herr, hilf meinem Unglauben" | bach-bwv109 |  | 칸타타 <Ich glaube, lieber Herr, hilf meinem Unglaube | MBID |
| 14541 | Himmelfahrts-Oratorium, BWV 11 | bach-bwv11 |  | 승천절 오라토리오 <Lobet Gott in seinen Reichen> BWV 11 | MBID |
| 14351 | Kantate, BWV 110 "Unser Mund sei voll Lachens" | bach-bwv110 |  | 칸타타 <Unser Mund sei voll Lachens> BWV 110 | MBID |
| 15602 | Kantate, BWV 110 "Unser Mund sei voll Lachens": II. Aria "Ihr Gedanken | bach-bwv110 | [2] | 아리아 "Ihr Gedanken und ihr Sinnen" | BWV 110 악장 번호 2 |
| 14915 | Kantate, BWV 111 "Was mein Gott will, das gscheh allzeit" | bach-bwv111 |  | 칸타타 <Was mein Gott will, das g'scheh allzeit> BWV  | MBID |
| 14933 | Kantate, BWV 112 "Der Herr ist mein getreuer Hirt" | bach-bwv112 |  | 칸타타 <Der Herr ist mein getreuer Hirt> BWV 112 | MBID |
| 14590 | Choralsatz, BWV 1122 "Denket doch, ihr Menschenkinder" | bach-bwv1122 |  | 코랄 <Denket doch, ihr Menschenkinder> BWV 1122 | MBID |
| 14786 | Choralsatz, BWV 1123 "Wo Gott zum Haus nicht gibt sein Gunst" | bach-bwv1123 |  | 코랄 <Wo Gott zum Haus nicht gibt sein Gunst> BWV 11 | MBID |
| 15209 | Choralsatz, BWV 1124 "Ich ruf zu dir, Herr Jesu Christ" | bach-bwv1124 |  | 코랄 <Ich ruf zu dir, Herr Jesu Christ> BWV 1124 | MBID |
| 15079 | Choralsatz, BWV 1125 "O Gott, du frommer Gott" | bach-bwv1125 |  | 코랄 <O Gott, du frommer Gott> BWV 1125 | MBID |
| 15026 | Choralsatz, BWV 1126 "Lobet Gott, unsern Herren" | bach-bwv1126 |  | 코랄 <Lobet Gott, unsern Herren> BWV 1126 | MBID |
| 15287 | Aria, BWV 1127 "Alles mit Gott und nichts ohn' ihn" | bach-bwv1127 |  | 아리아 <Alles mit Gott und nichts ohn' ihn> BWV 1127 | MBID |
| 15289 | Kantate, BWV 113 "Herr Jesu Christ, du höchstes Gut" | bach-bwv113 |  | 칸타타 <Herr Jesu Christ, du höchstes Gut> BWV 113 | MBID |
| 15213 | Kantate, BWV 113 "Herr Jesu Christ, du höchstes Gut": II. Aria "Erbarm | bach-bwv113 | [2] | 아리아 "Erbarm dich mein in solcher Last" | BWV 113 악장 번호 2 |
| 15643 | Kantate, BWV 114 "Ach lieben Christen, seid getrost" | bach-bwv114 |  | 칸타타 <Ach, lieben Christen, seid getrost> BWV 114 | MBID |
| 14487 | Kantate, BWV 115 "Mache dich, mein Geist, bereit" | bach-bwv115 |  | 칸타타 <Mache dich, mein Geist, bereit> BWV 115 | MBID |
| 14795 | Kantate, BWV 115 "Mache dich, mein Geist, bereit": IV. Aria "Bete aber | bach-bwv115 | [4] | 아리아 "Bete aber auch dabei" | BWV 115 악장 번호 4 |
| 15651 | Kantate, BWV 116 "Du Friedefürst, Herr Jesu Christ" | bach-bwv116 |  | 칸타타 <Du Friedefürst, Herr Jesu Christ> BWV 116 | MBID |
| 15325 | Kantate, BWV 117 "Sei Lob und Ehr dem höchsten Gut" | bach-bwv117 |  | 칸타타 <Sei Lob und Ehr dem höchsten Gut> BWV 117 | MBID |
| 14888 | Motet "O Jesu Christ, meins Lebens Licht", BWV 118b | bach-bwv118 |  | 모테트 <O Jesu Christ, meins Lebens Licht> BWV 118 | BWV 118 작품 |
| 14781 | Kantate, BWV 119 "Preise, Jerusalem, den Herrn" | bach-bwv119 |  | 칸타타 <Preise, Jerusalem, den Herrn> BWV 119 | MBID |
| 15139 | Kantate, BWV 12 "Weinen, Klagen, Sorgen, Zagen" | bach-bwv12 |  | 칸타타 <Weinen, Klagen, Sorgen, Zagen> BWV 12 | MBID |
| 15348 | Kantate, BWV 12 "Weinen, Klagen, Sorgen, Zagen": I. Sinfonia | bach-bwv12 | [1] | 신포니아 | BWV 12 악장 번호 1 |
| 15048 | Kantate, BWV 12 "Weinen, Klagen, Sorgen, Zagen": II. Coro "Weinen, Kla | bach-bwv12 | [2] | 합창 "Weinen, Klagen, Sorgen, Zagen" | BWV 12 악장 번호 2 |
| 14075 | Kantate, BWV 12 "Weinen, Klagen, Sorgen, Zagen": IV. Aria "Kreuz und K | bach-bwv12 | [4] | 아리아 "Kreuz und Krone sind verbunden" | BWV 12 악장 번호 4 |
| 13759 | Kantate, BWV 120.1 "Gott, man lobet dich in der Stille" | bach-bwv120 |  | 칸타타 <Gott, man lobet dich in der Stille> BWV 120 | MBID |
| 14172 | Kantate, BWV 122 "Das neugeborne Kindelein" | bach-bwv122 |  | 칸타타 <Das neugeborne Kindelein> BWV 122 | MBID |
| 15510 | Kantate, BWV 123 "Liebster Immanuel, Herzog der Frommen" | bach-bwv123 |  | 칸타타 <Liebster Immanuel, Herzog der Frommen> BWV 12 | MBID |
| 14565 | Kantate, BWV 124 "Meinen Jesum laß ich nicht" | bach-bwv124 |  | 칸타타 <Meinen Jesum laß ich nicht> BWV 124 | MBID |
| 15337 | Kantate, BWV 125 "Mit Fried und Freud ich fahr dahin" | bach-bwv125 |  | 칸타타 <Mit Fried und Freud ich fahr dahin> BWV 125 | MBID |
| 14586 | Kantate, BWV 126 "Erhalt uns Herr bei deinem Wort" | bach-bwv126 |  | 칸타타 <Erhalt uns, Herr, bei deinem Wort> BWV 126 | MBID |
| 15057 | Kantate, BWV 127 "Herr Jesu Christ, wahr’ Mensch und Gott" | bach-bwv127 |  | 칸타타 <Herr Jesu Christ, wahr' Mensch und Gott> BWV  | MBID |
| 14111 | Kantate, BWV 127 "Herr Jesu Christ, wahr' Mensch und Gott": III. Aria  | bach-bwv127 | [3] | 아리아 "Die Seelen ruht in Jesu Händen" | BWV 127 악장 번호 3 |
| 15119 | Kantate, BWV 128 "Auf Christi Himmelfahrt allein" | bach-bwv128 |  | 칸타타 <Auf Christi Himmelfahrt allein> BWV 128 | MBID |
| 14300 | Kantate, BWV 129 "Gelobet sei der Herr" | bach-bwv129 |  | 칸타타 <Gelobet sei der Herr, mein Gott> BWV 129 | MBID |
| 14477 | Kantate, BWV 129 "Gelobet sei der Herr": II. Aria "Gelobet sei der Her | bach-bwv129 | [2] | 아리아 "Gelobet sei der Herr" | BWV 129 악장 번호 2 |
| 14601 | Awake, Thou Wintry Earth | bach-bwv129 | [5] | 코랄 "Dem wir das Heilig itzt" | 번안·다른 언어 제목(원어 seed 없음). 관계(arrangement) → MBID 일치 |
| 14737 | Kantate, BWV 13 "Meine Seufzer, meine Tränen" | bach-bwv13 |  | 칸타타 <Meine Seufzer, meine Tränen> BWV 13 | MBID |
| 15642 | Cantata BWV13 'Meine Seufzer, meine Tränen': No. 1, Meine Seufzer, mei | bach-bwv13 | [1] | 아리아 "Meine Seufzer, meine Tränen" | BWV 13 악장 번호 1 |
| 14165 | Cantata BWV13 'Meine Seufzer, meine Tränen': No. 3, Der Gott, der mir  | bach-bwv13 | [3] | 코랄 "Der Gott, der mir hat versprochen" | BWV 13 악장 번호 3 |
| 14124 | Kantate, BWV 130 "Herr Gott, dich loben alle wir" | bach-bwv130 |  | 칸타타 <Herr Gott, dich loben alle wir> BWV 130 | MBID |
| 14939 | Kantate, BWV 131 „Aus der Tiefen rufe ich, Herr, zu dir“ | bach-bwv131 |  | 칸타타 <Aus der Tiefen rufe ich, Herr, zu dir> BWV 13 | MBID |
| 14512 | Kantate, BWV 131 "Aus der Tiefen rufe ich, Herr, zu dir": IV. Aria "Me | bach-bwv131 | [4] | 아리아와 코랄 "Meine Seele wartet auf den Herrn" | BWV 131 악장 번호 4 |
| 14094 | Kantate, BWV 132 "Bereitet die Wege, bereitet die Bahn" | bach-bwv132 |  | 칸타타 <Bereitet die Wege, bereitet die Bahn> BWV 132 | MBID |
| 14725 | Kantate, BWV 133 "Ich freue mich in dir" | bach-bwv133 |  | 칸타타 <Ich freue mich in dir> BWV 133 | MBID |
| 14604 | Kantate, BWV 134 "Ein Herz, das seinen Jesum lebend weiß" | bach-bwv134 |  | 칸타타 <Ein Herz, das seinen Jesum lebend weiß> BWV 1 | MBID |
| 14958 | Kantate, BWV 134a "Die Zeit, die Tag und Jahre macht" | bach-bwv134a |  | 칸타타 <Die Zeit, die Tag und Jahre macht> BWV 134a | MBID |
| 15469 | Kantate, BWV 135 "Ach Herr, mich armen Sünder" | bach-bwv135 |  | 칸타타 <Ach Herr, mich armen Sünder> BWV 135 | MBID |
| 15042 | Kantate, BWV 136 "Erforsche mich, Gott, und erfahre mein Herz" | bach-bwv136 |  | 칸타타 <Erforsche mich, Gott, und erfahre mein Herz>  | MBID |
| 14972 | Kantate, BWV 137 "Lobe den Herren, den mächtigen König der Ehren" | bach-bwv137 |  | 칸타타 <Lobe den Herren, den mächtigen König der Ehre | MBID |
| 15019 | Lobe den Herren | bach-bwv137 | [5] | 코랄 "Lobe den Herren, den mächtigen König der Ehren | 관계(arrangement) → MBID 일치 |
| 15025 | Kantate, BWV 138 "Warum betrübst du dich, mein Herz" | bach-bwv138 |  | 칸타타 <Warum betrübst du dich, mein Herz> BWV 138 | MBID |
| 15679 | Kantate, BWV 139 "Wohl dem, der sich auf seinen Gott" | bach-bwv139 |  | 칸타타 <Wohl dem, der sich auf seinen Gott> BWV 139 | MBID |
| 14948 | Kantate, BWV 14 "Wär Gott nicht mit uns diese Zeit" | bach-bwv14 |  | 칸타타 <Wär Gott nicht mit uns diese Zeit> BWV 14 | MBID |
| 14062 | Kantate, BWV 140 “Wachet auf, ruft uns die Stimme” | bach-bwv140 |  | 칸타타 <Wachet auf, ruft uns die Stimme> BWV 140 | MBID |
| 13978 | Wachet auf, ruft uns die Stimme, BWV 140: I. Coro "Wachet auf, ruft un | bach-bwv140 | [1] | 합창 "Wachet auf, ruft uns die Stimme" | BWV 140 악장 번호 1 |
| 14201 | Kantate, BWV 140 "Wachet auf, ruft uns die Stimme": IV. Choral (Tenor) | bach-bwv140 | [4] | 코랄 "Zion hört die Wächter singen" | BWV 140 악장 번호 4 |
| 14855 | Wachet auf, ruft uns die Stimme, BWV 140: VII. Choral "Gloria sei dir  | bach-bwv140 | [7] | 코랄 "Gloria sei dir gesungen" | BWV 140 악장 번호 7 |
| 15581 | Kantate, BWV 143 "Lobe den Herrn, meine Seele" | bach-bwv143 |  | 칸타타 <Lobe den Herrn, meine Seele> BWV 143 | MBID |
| 14216 | Kantate, BWV 144 "Nimm, was dein ist, und gehe hin" | bach-bwv144 |  | 칸타타 <Nimm, was dein ist, und gehe hin> BWV 144 | MBID |
| 15095 | Kantate, BWV 145 "Ich lebe, mein Herze, zu deinem Ergötzen" | bach-bwv145 |  | 칸타타 <Ich lebe, mein Herze, zu deinem Ergötzen> BWV | MBID |
| 14716 | Kantate, BWV 146 "Wir müssen durch viel Trübsal" | bach-bwv146 |  | 칸타타 <Wir müssen durch viel Trübsal> BWV 146 | MBID |
| 14788 | Wir müssen durch viel Trübsal, BWV 146: Sinfonia | bach-bwv146 | [1] | 신포니아 | BWV 146 악장 가사 일치 |
| 13865 | Kantate, BWV 146 "Wir müssen durch viel Trübsal": VII. "Wie will ich m | bach-bwv146 | [7] | 2중창 "Wie will ich mich freuen" | BWV 146 악장 번호 7 |
| 14295 | Kantate, BWV 147 "Herz und Mund und Tat und Leben": Teil I, VI. Choral | bach-bwv147 | [6] | 코랄 "Wohl mir, dass ich Jesum habe" | BWV 147 악장 번호 6 |
| 14434 | Kantate, BWV 148 "Bringet dem Herrn Ehre seines Namens" | bach-bwv148 |  | 칸타타 <Bringet dem Herrn Ehre seines Namens> BWV 148 | MBID |
| 14813 | Kantate, BWV 149 "Man singet mit Freuden vom Sieg" | bach-bwv149 |  | 칸타타 <Man singet mit Freuden vom Sieg> BWV 149 | MBID |
| 15700 | Kantate, BWV 150 "Nach dir, Herr, verlanget mich" | bach-bwv150 |  | 칸타타 <Nach dir, Herr, verlanget mich> BWV 150 | MBID |
| 15059 | Kantate, BWV 151 "Süßer Trost, mein Jesus kömmt" | bach-bwv151 |  | 칸타타 <Süßer Trost, mein Jesus kömmt> BWV 151 | MBID |
| 14071 | Kantate, BWV 152 "Tritt auf die Glaubensbahn" | bach-bwv152 |  | 칸타타 <Tritt auf die Glaubensbahn> BWV 152 | MBID |
| 14232 | Kantate, BWV 153 "Schau lieber Gott, wie meine Feind" | bach-bwv153 |  | 칸타타 <Schau, lieber Gott, wie meine Feind> BWV 153 | MBID |
| 15152 | Kantate, BWV 154 "Mein liebster Jesus ist verloren" | bach-bwv154 |  | 칸타타 <Mein liebster Jesus ist verloren> BWV 154 | MBID |
| 15089 | Kantate, BWV 155 "Mein Gott, wie lang, ach lange" | bach-bwv155 |  | 칸타타 <Mein Gott, wie lang, ach lange?> BWV 155 | MBID |
| 15212 | Be Contented, O My Soul, from BWV 155 | bach-bwv155 | [1] | 레치타티보 "Mein Gott, wie lang, ach lange" | 번안·다른 언어 제목(원어 seed 없음). 관계(arrangement) → MBID 일치 |
| 14687 | Kantate, BWV 156 "Ich steh mit einem Fuß im Grabe" | bach-bwv156 |  | 칸타타 <Ich steh mit einem Fuß im Grabe> BWV 156 | MBID |
| 13821 | Kantate, BWV 156 "Ich steh mit einem Fuß im Grabe": I. Sinfonia | bach-bwv156 | [1] | 신포니아 | BWV 156 악장 번호 1 |
| 15364 | Kantate, BWV 157 "Ich lasse dich nicht, du segnest mich denn!" | bach-bwv157 |  | 칸타타 <Ich lasse dich nicht, du segnest mich denn> B | MBID |
| 14486 | Kantate, BWV 158 "Der Friede sei mit dir" | bach-bwv158 |  | 칸타타 <Der Friede sei mit dir> BWV 158 | MBID |
| 14113 | Kantate, BWV 159 "Sehet, wir gehn hinauf gen Jerusalem" | bach-bwv159 |  | 칸타타 <Sehet, wir gehn hinauf gen Jerusalem> BWV 159 | MBID |
| 14610 | Cantata, BWV 159: Es ist vollbracht | bach-bwv159 | [4] | 아리아 "Es ist vollbracht" | BWV 159 악장 가사 일치 |
| 15056 | Kantate, BWV 16 "Herr Gott, dich loben wir" | bach-bwv16 |  | 칸타타 <Herr Gott, dich loben wir> BWV 16 | MBID |
| 15405 | Kantate, BWV 16 appendix "Herr Gott, dich loben wir": V. Aria (Tenore) | bach-bwv16 | [5] | 아리아 "Geliebter Jesu, du allein sollst meiner Seele | BWV 16 악장 번호 5 |
| 14152 | Kantate, BWV 161 "Komm, du süße Todesstunde" | bach-bwv161 |  | 칸타타 <Komm, du süße Todesstunde> BWV 161 | MBID |
| 15233 | Kantate, BWV 162 "Ach! ich sehe, itzt, da ich zur Hochzeit gehe" | bach-bwv162 |  | 칸타타 <Ach! ich sehe, itzt, da ich zur Hochzeit gehe | MBID |
| 15058 | Kantate, BWV 163 "Nur jedem das Seine" | bach-bwv163 |  | 칸타타 <Nur jedem das Seine> BWV 163 | MBID |
| 14472 | Kantate, BWV 164 "Ihr, die ihr euch von Christo nennet" | bach-bwv164 |  | 칸타타 <Ihr, die ihr euch von Christo nennet> BWV 164 | MBID |
| 14278 | Kantate, BWV 165 "O heilges Geist- und Wasserbad" | bach-bwv165 |  | 칸타타 <O heilges Geist- und Wasserbad> BWV 165 | MBID |
| 14162 | Kantate, BWV 166 "Wo gehest du hin" | bach-bwv166 |  | 칸타타 <Wo gehest du hin?> BWV 166 | MBID |
| 15256 | Kantate, BWV 167 "Ihr Menschen, rühmet Gottes Liebe" | bach-bwv167 |  | 칸타타 <Ihr Menschen, rühmet Gottes Liebe> BWV 167 | MBID |
| 14543 | Kantate, BWV 168 "Tue Rechnung! Donnerwort" | bach-bwv168 |  | 칸타타 <Tue Rechnung! Donnerwort> BWV 168 | MBID |
| 14802 | Kantate, BWV 169 "Gott soll allein mein Herze haben" | bach-bwv169 |  | 칸타타 <Gott soll allein mein Herze haben> BWV 169 | MBID |
| 15402 | Cantata, BWV 169 "Gott soll allein mein Herz haben": Alto aria "Stirb  | bach-bwv169 | [5] | 아리아 "Stirb in mir, Welt" | BWV 169 악장 가사 일치 |
| 14547 | Kantate, BWV 17 "Wer Dank opfert, der preiset mich" | bach-bwv17 |  | 칸타타 <Wer Dank opfert, der preiset mich> BWV 17 | MBID |
| 14502 | Kantate, BWV 171 "Gott, wie dein Name, so ist auch dein Ruhm" | bach-bwv171 |  | 칸타타 <Gott, wie dein Name, so ist auch dein Ruhm> B | MBID |
| 14375 | Kantate, BWV 172 "Erschallet, ihr Lieder, erklinget, ihr Saiten" | bach-bwv172 |  | 칸타타 <Erschallet, ihr Lieder, erklinget, ihr Saiten | MBID |
| 15634 | Kantate, BWV 173 "Erhöhtes Fleisch und Blut" | bach-bwv173 |  | 칸타타 <Erhöhtes Fleisch und Blut> BWV 173 | MBID |
| 14886 | Kantate, BWV 173a "Durchlauchtster Leopold" | bach-bwv173a |  | 칸타타 <Durchlauchtster Leopold> BWV 173a | MBID |
| 14506 | Kantate, BWV 174 "Ich liebe den Höchsten von ganzem Gemüte" | bach-bwv174 |  | 칸타타 <Ich liebe den Höchsten von ganzem Gemüte> BWV | MBID |
| 15167 | Kantate, BWV 175 “Er rufet seinen Schafen mit Namen” | bach-bwv175 |  | 칸타타 <Er rufet seinen Schafen mit Namen> BWV 175 | MBID |
| 14248 | Kantate, BWV 175 "Er rufet seinen Schafen mit Namen": IV. Aria "Es dün | bach-bwv175 | [4] | 아리아 "Es dünket mich, ich seh dich kommen" | BWV 175 악장 번호 4 |
| 14230 | Kantate, BWV 176 "Es ist ein trotzig und verzagt Ding" | bach-bwv176 |  | 칸타타 <Es ist ein trotzig und verzagt Ding> BWV 176 | MBID |
| 15165 | Kantate, BWV 177 "Ich ruf zu dir, Herr Jesu Christ" | bach-bwv177 |  | 칸타타 <Ich ruf zu dir, Herr Jesu Christ> BWV 177 | MBID |
| 14712 | Kantate, BWV 178 "Wo Gott der Herr nicht bei uns hält" | bach-bwv178 |  | 칸타타 <Wo Gott der Herr nicht bei uns hält> BWV 178 | MBID |
| 14079 | Kantate, BWV 179 "Siehe zu, daß deine Gottesfurcht nicht Heuchelei sei | bach-bwv179 |  | 칸타타 <Siehe zu, daß deine Gottesfurcht nicht Heuche | MBID |
| 14173 | Kantate, BWV 179 "Siehe zu, daß deine Gottesfurcht nicht Heuchelei sei | bach-bwv179 | [5] | 아리아 "Liebster Gott, erbarme dich" | BWV 179 악장 번호 5 |
| 14378 | Kantate, BWV 18 "Gleichwie der Regen und Schnee vom Himmel fällt" | bach-bwv18 |  | 칸타타 <Gleichwie der Regen und Schnee vom Himmel fäl | MBID |
| 14357 | Kantate, BWV 18 "Gleichwie der Regen und Schnee vom Himmel fällt": App | bach-bwv18 | [1] | 신포니아 | 관계(other version) → MBID 일치 |
| 15090 | Cantata BWV18 'Gleichwie der Regen und Schnee vom Himmel fällt': No. 4 | bach-bwv18 | [4] | 아리아 "Mein Seelenschatz ist Gottes Wort" | BWV 18 악장 번호 4 |
| 14081 | Kantate, BWV 18 "Gleichwie der Regen und Schnee vom Himmel fällt": V.  | bach-bwv18 | [5] | 코랄 "Ich bitt, o Gott, aus Herzensgrund" | BWV 18 악장 번호 5 |
| 14525 | Kantate, BWV 180 "Schmücke dich, o liebe Seele" | bach-bwv180 |  | 칸타타 <Schmücke dich, o liebe Seele> BWV 180 | MBID |
| 15523 | Kantate, BWV 181 "Leichtgesinnte Flattergeister" | bach-bwv181 |  | 칸타타 <Leichtgesinnte Flattergeister> BWV 181 | MBID |
| 14889 | Kantate, BWV 181 "Leichtgesinnte Flattergeister": I. Aria (Basso) "Lei | bach-bwv181 | [1] | 아리아 "Leichtgesinnte Flattergeister" | BWV 181 악장 번호 1 |
| 15657 | Kantate, BWV 181 "Leichtgesinnte Flattergeister": V. Coro "Laß, Höchst | bach-bwv181 | [5] | 합창 "Laß, Höchster, uns zu allen Zeiten" | BWV 181 악장 번호 5 |
| 15222 | Kantate, BWV 182 „Himmelskönig, sei willkommen“ | bach-bwv182 |  | 칸타타 <Himmelskönig, sei willkommen> BWV 182 | MBID |
| 14420 | Kantate, BWV 182 "Himmelskönig, sei willkommen" Appendix: I. Sonata | bach-bwv182 | [1] | 소나타 | BWV 182 악장 번호 1 |
| 15499 | Kantate, BWV 182 "Himmelskönig, sei willkommen" Appendix: VII. Choral  | bach-bwv182 | [7] | 코랄 "Jesu, deine Passion" | BWV 182 악장 번호 7 |
| 15481 | Kantate, BWV 183 "Sie werden euch in den Bann tun" | bach-bwv183 |  | 칸타타 <Sie werden euch in den Bann tun> BWV 183 | MBID |
| 15533 | Kantate, BWV 183 "Sie werden euch in den Bann tun": II. Aria "Ich fürc | bach-bwv183 | [2] | 아리아 "Ich fürchte nicht des Todes Schrecken" | BWV 183 악장 번호 2 |
| 14271 | Kantate, BWV 184 "Erwünschtes Freudenlicht" | bach-bwv184 |  | 칸타타 <Erwünschtes Freudenlicht> BWV 184 | MBID |
| 14519 | Kantate, BWV 185 "Barmherziges Herze der ewigen Liebe" | bach-bwv185 |  | 칸타타 <Barmherziges Herze der ewigen Liebe> BWV 185 | MBID |
| 14875 | Kantate, BWV 186 "Ärgre dich, o Seele, nicht" | bach-bwv186 |  | 칸타타 <Ärgre dich, o Seele, nicht> BWV 186 | MBID |
| 15623 | Kantate, BWV 187 "Es wartet alles auf dich" | bach-bwv187 |  | 칸타타 <Es wartet alles auf dich> BWV 187 | MBID |
| 15678 | Kantate, BWV 188 "Ich habe meine Zuversicht" | bach-bwv188 |  | 칸타타 <Ich habe meine Zuversicht> BWV 188 | MBID |
| 14435 | Kantate, BWV 19 "Es erhub sich ein Streit" | bach-bwv19 |  | 칸타타 <Es erhub sich ein Streit> BWV 19 | MBID |
| 14365 | Kantate, BWV 190 "Singet dem Herrn ein neues Lied" | bach-bwv190 |  | 칸타타 <Singet dem Herrn ein neues Lied> BWV 190 | MBID |
| 14996 | Kantate, BWV 191 "Gloria in excelsis Deo" | bach-bwv191 |  | 칸타타 <Gloria in excelsis Deo> BWV 191 | MBID |
| 15094 | Kantate, BWV 192 "Nun danket alle Gott" | bach-bwv192 |  | 칸타타 <Nun danket alle Gott> BWV 192 | MBID |
| 14661 | Kantate, BWV 193 "Ihr Tore zu Zion" | bach-bwv193 |  | 칸타타 <Ihr Tore zu Zion> BWV 193 | MBID |
| 15394 | Kantate, BWV 194 "Höchsterwünschtes Freudenfest" | bach-bwv194 |  | 칸타타 <Höchsterwünschtes Freudenfest> BWV 194 | MBID |
| 14334 | Kantate, BWV 195 "Dem Gerechten muß das Licht" | bach-bwv195 |  | 칸타타 <Dem Gerechten muß das Licht> BWV 195 | MBID |
| 15350 | Kantate, BWV 196 "Der Herr denket an uns" | bach-bwv196 |  | 칸타타 <Der Herr denket an uns> BWV 196 | MBID |
| 14264 | Kantate, BWV 197 "Gott ist unsre Zuversicht" | bach-bwv197 |  | 칸타타 <Gott ist unsre Zuversicht> BWV 197 | MBID |
| 14633 | Kantate, BWV 198 "Laß, Fürstin, laß noch einen Strahl" | bach-bwv198 |  | 칸타타 <Laß, Fürstin, laß noch einen Strahl> "Trauer- | MBID |
| 14327 | Kantate, BWV 199 "Mein Herze schwimmt im Blut" | bach-bwv199 |  | 칸타타 <Mein Herze schwimmt im Blut> BWV 199 | MBID |
| 15670 | Kantate, BWV 2 "Ach Gott, vom Himmel sieh darein" | bach-bwv2 |  | 칸타타 <Ach Gott, vom Himmel sieh darein> BWV 2 | MBID |
| 14575 | Kantate, BWV 20 "O Ewigkeit, du Donnerwort" | bach-bwv20 |  | 칸타타 <O Ewigkeit, du Donnerwort> BWV 20 | MBID |
| 15668 | Kantate, BWV 201 "Geschwinde, ihr wirbelnden Winde" | bach-bwv201 |  | 칸타타 <Geschwinde, ihr wirbelnden Winde> BWV 201 | MBID |
| 14273 | Cantata, BWV 202 "Weichet nur betrübte Schatten": Soprano aria "Wenn d | bach-bwv202 | [5] | 아리아 "Wenn die Frühlingslüfte streichen" | BWV 202 악장 가사 일치 |
| 14143 | Kantate, BWV 203 "Amore traditore" | bach-bwv203 |  | 칸타타 <Amore traditore> BWV 203 | MBID |
| 15498 | Kantate, BWV 204 "Ich bin in mir vergnügt" | bach-bwv204 |  | 칸타타 <Ich bin in mir vergnügt> BWV 204 | MBID |
| 14037 | Kantate, BWV 205 "Zerreißet, zersprenget, zertrümmert die Gruft" | bach-bwv205 |  | 칸타타 <Zerreißet, zersprenget, zertrümmert die Gruft | MBID |
| 14500 | Kantate, BWV 206 "Schleicht, spielende Wellen, und murmelt gelinde!" | bach-bwv206 |  | 칸타타 <Schleicht, spielende Wellen> BWV 206 | MBID |
| 15331 | Kantate, BWV 207 "Vereinigte Zwietracht der wechselnden Saiten" | bach-bwv207 |  | 칸타타 <Vereinigte Zwietracht der wechselnden Saiten> | MBID |
| 14103 | Vereinigte Zwietracht der wechselnden Saiten, BWV 207: I. Chorus "Vere | bach-bwv207 | [1] | 합창 "Vereinigte Zwietracht der wechselnden Saiten" | BWV 207 악장 번호 1 |
| 14526 | Kantate, BWV 207a "Auf, schmetternde Töne der muntern Trompeten" | bach-bwv207a |  | 칸타타 <Auf, schmetternde Töne der muntern Trompeten> | MBID |
| 13791 | Kantate, BWV 208 “Was mir behagt, ist nur die muntre Jagd!” | bach-bwv208 |  | 칸타타 <Was mir behagt, ist nur die muntre Jagd> "사냥  | MBID |
| 13907 | Kantate, BWV 208 “Was mir behagt, ist nur die muntre Jagd!”: IX. “Scha | bach-bwv208 | [9] | 아리아 "Schafe können sicher weiden" | BWV 208 악장 번호 9 |
| 15104 | Kantate, BWV 208 “Was mir behagt, ist nur die muntre Jagd!”: XIII. Ari | bach-bwv208 | [13] | 아리아 "Weil die wollenreichen Herden" | BWV 208 악장 번호 13 |
| 14513 | Kantate, BWV 209 "Non sa che sia dolore" | bach-bwv209 |  | 칸타타 <Non sa che sia dolore> BWV 209 | MBID |
| 14190 | Kantate, BWV 21 "Ich hatte viel Bekümmernis" | bach-bwv21 |  | 칸타타 <Ich hatte viel Bekümmernis> BWV 21 | MBID |
| 14681 | Seufzer, Tränen, Kummer, Not | bach-bwv21 | [3] | 아리아 "Seufzer, Tränen, Kummer, Not" | 관계(arrangement) → MBID 일치 |
| 14153 | Kantate, BWV 210 "O holder Tag, erwünschte Zeit" | bach-bwv210 |  | 칸타타 <O holder Tag, erwünschte Zeit> BWV 210 | MBID |
| 13929 | Kantate, BWV 211 "Schweigt stille, plaudert nicht" | bach-bwv211 |  | 칸타타 <Schweigt stille, plaudert nicht> "커피 칸타타" BWV | MBID |
| 13755 | Kantate, BWV 212 "Mer hahn en neue Oberkeet" | bach-bwv212 |  | 칸타타 <Mer hahn en neue Oberkeet> "농민 칸타타" BWV 212 | MBID |
| 14169 | Good Fellows Be Merry | bach-bwv212 | [20] | 아리아 "Dein Wachstum sei feste und lache vor Lust" | 번안·다른 언어 제목(원어 seed 없음). 관계(other version) → MBID 일치 |
| 14609 | Kantate, BWV 213 "Laßt uns sorgen, laßt uns wachen" | bach-bwv213 |  | 칸타타 <Laßt uns sorgen, laßt uns wachen> BWV 213 | MBID |
| 14354 | Kantate, BWV 214 "Tönet, ihr Pauken! Erschallet, Trompeten!" | bach-bwv214 |  | 칸타타 <Tönet, ihr Pauken! Erschallet, Trompeten!> BW | MBID |
| 15214 | Kantate, BWV 215 "Preise dein Glücke, gesegnetes Sachsen" | bach-bwv215 |  | 칸타타 <Preise dein Glücke, gesegnetes Sachsen> BWV 2 | MBID |
| 14879 | Kantate, BWV 22 "Jesus nahm zu sich die Zwölfe" | bach-bwv22 |  | 칸타타 <Jesus nahm zu sich die Zwölfe> BWV 22 | MBID |
| 15283 | Cantata BWV22 'Jesus nahm zu sich die Zwölfe': No. 5, Ertöt uns durch  | bach-bwv22 | [5] | 코랄 "Ertöt uns durch dein Güte" | BWV 22 악장 번호 5 |
| 13889 | Der Geist hilft unsrer Schwachheit auf, BWV 226 | bach-bwv226 |  | 모테트 <Der Geist hilft unser Schwachheit auf> BWV 22 | MBID |
| 13894 | Fürchte dich nicht, ich bin bei dir, BWV 228 | bach-bwv228 |  | 모테트 <Fürchte dich nicht> BWV 228 | MBID |
| 13752 | Komm, Jesu, komm, BWV 229 | bach-bwv229 |  | 모테트 <Komm, Jesu, komm> BWV 229 | MBID |
| 14205 | Kantate, BWV 23 "Du wahrer Gott und Davids Sohn" | bach-bwv23 |  | 칸타타 <Du wahrer Gott und Davids Sohn> BWV 23 | MBID |
| 14020 | h-Moll-Messe, BWV 232 | bach-bwv232 |  | 미사 B단조 BWV 232 | MBID |
| 14246 | Mass in B minor BWV 232, Missa: Kyrie eleison (chorus) | bach-bwv232 | [1] | 키리에 | 제목 'Missa: Kyrie eleison (chorus)' — 첫 키리에(1번)로 봄 |
| 15570 | Benedictus from Mass in B minor, BWV 232 | bach-bwv232 | [24] | 베네딕투스 | 관계(arrangement) → MBID 일치 |
| 14990 | Agnus Dei from Mass in B minor, BWV 232 | bach-bwv232 | [26] | 아뉴스 데이 | 관계(arrangement) → MBID 일치 |
| 14249 | Messe F-Dur, BWV 233 | bach-bwv233 |  | 미사 F장조 BWV 233 | MBID |
| 14739 | Missa in F major, BWV 233: Quoniam tu solus sanctus | bach-bwv233 | [5] | 아리아 "Quoniam tu solus sanctus" | BWV 233 악장 가사 일치 |
| 15432 | Kyrie eleison F-Dur, BWV 233a "Christe, du Lamm Gottes" | bach-bwv233a |  | 키리에 F장조 <Christe, du Lamm Gottes> BWV 233a | MBID |
| 15299 | Messe A-Dur, BWV 234 | bach-bwv234 |  | 미사 A장조 BWV 234 | MBID |
| 15522 | Messe g-Moll, BWV 235 | bach-bwv235 |  | 미사 G단조 BWV 235 | MBID |
| 14504 | Messe G-Dur, BWV 236 | bach-bwv236 |  | 미사 G장조 BWV 236 | MBID |
| 15470 | Sanctus C-Dur, BWV 237 | bach-bwv237 |  | 상투스 C장조 BWV 237 | MBID |
| 15142 | Sanctus D-Dur, BWV 238 | bach-bwv238 |  | 상투스 D장조 BWV 238 | MBID |
| 14299 | Kantate, BWV 24 "Ein ungefärbt Gemüte" | bach-bwv24 |  | 칸타타 <Ein ungefärbt Gemüte> BWV 24 | MBID |
| 14520 | Sanctus G-Dur, BWV 240 | bach-bwv240 |  | 상투스 G장조 BWV 240 | MBID |
| 15211 | Christe eleison g-Moll, BWV 242 | bach-bwv242 |  | 크리스테 엘레이손 G단조 BWV 242 | MBID |
| 15653 | Magnificat D-Dur, BWV 243 | bach-bwv243 |  | 마니피카트 D장조 BWV 243 | MBID |
| 15227 | Magnificat D-Dur, BWV 243: IX. Aria "Esurientes implevit bonis" | bach-bwv243 | [9] | 아리아 "Esurientes implevit bonis" | BWV 243 악장 번호 9 |
| 14753 | Magnificat D-Dur, BWV 243: X. Aria "Suscepit Israel" | bach-bwv243 | [10] | 아리아 "Suscepit Israel" | BWV 243 악장 번호 10 |
| 13731 | Magnificat Es-Dur, BWV 243a | bach-bwv243a |  | 마니피카트 E♭장조 BWV 243a | MBID |
| 14978 | Ich bin's, ich sollte büßen | bach-bwv244 | [10] | 코랄 "Ich bin's, ich sollte büßen" | 제목 가사 «Ich bin's, ich sollte büßen» 로만 맞춤(BWV 표기 없음) |
| 14338 | Matthäus-Passion, BWV 244: Teil II, XXXIV. Accompagnato-Rezitativ "Mei | bach-bwv244 | [34] | 레치타티보 "Mein Jesus schweigt zu falschen Lügen still | BWV 244 악장 번호 34 |
| 15145 | St. Matthew Passion, BWV 244: Part II, XLVI. Recit. (Evangelist) "Then | bach-bwv244 | [38, 3] | 레치타티보 "Petrus aber saß draussen im Palast" › 레치타티보 | 관계(other version) → MBID 일치 |
| 14680 | Matthäus-Passion, BWV 244: Teil II, XXXIX. Aria "Erbarme dich, mein Go | bach-bwv244 | [39] | 아리아 "Erbarme dich, mein Gott" | BWV 244 악장 번호 39 |
| 15480 | St. Matthew Passion, BWV 244: Part II, XLVIII. Choral "Lamb of God, I  | bach-bwv244 | [40] | 코랄 "Bin ich gleich von dir gewichen" | 관계(other version) → MBID 일치 |
| 14284 | Matthäus-Passion, BWV 244: Teil II, XLIX. Aria "Aus Liebe will mein He | bach-bwv244 | [49] | 아리아 "Aus Liebe will mein Heiland sterben" | BWV 244 악장 번호 49 |
| 14715 | Matthäus-Passion, BWV 244: Teil II, LII. Aria "Können Tränen meiner Wa | bach-bwv244 | [52] | 아리아 "Können Tränen meiner Wangen" | BWV 244 악장 번호 52 |
| 13839 | Matthäus-Passion, BWV 244: O Haupt voll Blut und Wunden | bach-bwv244 | [54] | 코랄 "O Haupt voll Blut und Wunden" | BWV 244 악장 가사 일치 |
| 15160 | St. Matthew Passion, BWV 244: No. 62, Wenn ich einmal soll scheiden | bach-bwv244 | [62] | 코랄 "Wenn ich einmal soll scheiden" | BWV 244 악장 번호 62 |
| 15614 | Matthäus-Passion, BWV 244: Teil II, LXV. Aria "Mache dich, mein Herze, | bach-bwv244 | [65] | 아리아 "Mache dich, mein Herze, rein" | BWV 244 악장 번호 65 |
| 14209 | Me kyynelin sua muistelemme | bach-bwv244 | [68] | 합창 "Wir setzen uns mit Tränen nieder" | 번안·다른 언어 제목(원어 seed 없음). 관계(other version) → MBID 일치 |
| 14529 | Johannes-Passion, BWV 245, 1728 - 1732 revision | bach-bwv245 |  | 요한 수난곡 BWV 245 | BWV 245.3 작품 |
| 14214 | Johannes-Passion, BWV 245: Teil II. No. 19 Arioso "Betrachte, meine Se | bach-bwv245 | [19] | 아리오소 "Betrachte, meine Seel" | BWV 245 악장 번호 19 |
| 14883 | Wir haben ein Gesetz | bach-bwv245 | [21, 6] | 레치타티보 "Und die Kriegsknechte flochten" › 합창 "Wir h | 제목 가사 «Wir haben ein Gesetz» 로만 맞춤(BWV 표기 없음) |
| 15134 | St. John Passion, BWV 245: Es ist vollbracht! | bach-bwv245 | [30] | 아리아 "Es ist vollbracht!" | BWV 245 악장 가사 일치 |
| 14247 | Mein teurer Heiland | bach-bwv245 | [32] | 아리아 "Mein teurer Heiland, laß dich fragen" | 제목 가사 «Mein teurer Heiland» 로만 맞춤(BWV 표기 없음) |
| 15630 | Choralsatz "Herzlich lieb hab' ich dich, o Herr" | bach-bwv245 | [40] | 코랄 "Ach Herr, laß dein lieb Engelein" | 다른 가사의 같은 코랄 화성(MB other version). 관계(other version) → MBID 일치 |
| 13770 | Weihnachts-Oratorium, BWV 248 | bach-bwv248 |  | 크리스마스 오라토리오 BWV 248 | MBID |
| 14923 | Weihnachts-Oratorium, BWV 248: Teil I, I. "Jauchzet, frohlocket" | bach-bwv248 | [1] | 합창 "Jauchzet, frohlocket" | BWV 248 악장 번호 1 |
| 14944 | Symphonie pastorale (Hirtenmusik aus dem Weihnachtsoratorium, BWV 248) | bach-bwv248 | [10] | 신포니아 | 번안·다른 언어 제목(원어 seed 없음). 관계(arrangement) → MBID 일치 |
| 15684 | Christmas Oratorio, BWV 248: “And there were shepherds in the same cou | bach-bwv248 | [11] | 레치타티보 "Und es waren Hirten in derselben Gegend" | 번안·다른 언어 제목(원어 seed 없음). 관계(other version) → MBID 일치 |
| 14611 | Weihnachts-Oratorium, BWV 248: Teil VI, LIV. Coro "Herr, wenn die stol | bach-bwv248 | [54] | 합창 "Herr, wenn die stolzen Feinde schnauben" | BWV 248 악장 번호 54 |
| 15173 | Weihnachts-Oratorium, BWV 248: Teil VI, LXIV. Choral "Nun seid ihr woh | bach-bwv248 | [64] | 코랄 "Nun seid ihr wohl gerochen" | BWV 248 악장 번호 64 |
| 13942 | Oster-Oratorium, BWV 249 | bach-bwv249 |  | 부활절 오라토리오 <Kommt, eilet und laufet> BWV 249 | MBID |
| 15682 | Oster-Oratorium, BWV 249: IX. Aria "Saget, saget mir geschwinde" | bach-bwv249 | [9] | 아리아 "Saget, saget mir geschwinde" | BWV 249 악장 번호 9 |
| 15322 | Kantate, BWV 25 "Es ist nichts Gesundes an meinem Leibe" | bach-bwv25 |  | 칸타타 <Es ist nichts Gesundes an meinem Leibe> BWV 2 | MBID |
| 14150 | Choralsatz, BWV 250 "Was Gott tut, das ist wohlgetan" | bach-bwv250-438 | [1] | Was Gott tut, das ist wohlgetan | MBID |
| 15457 | Choralsatz, BWV 251 "Sei Lob und Ehr dem höchsten Gut" | bach-bwv250-438 | [2] | Sei Lob und Ehr dem höchsten Gut | MBID |
| 15513 | Choralsatz, BWV 252 "Nun danket alle Gott" | bach-bwv250-438 | [3] | Nun danket alle Gott | MBID |
| 14646 | Chorale: In dieser lett'n betrübten Zeit, BWV 253 | bach-bwv250-438 | [4] | Ach bleib bei uns, Herr Jesu Christ | MBID |
| 14297 | Choralsatz, BWV 254 "Ach Gott, erhör mein Seufzen" | bach-bwv250-438 | [5] | Ach Gott, erhör mein Seufzen | MBID |
| 14878 | Choralsatz, BWV 255 "Ach Gott und Herr" | bach-bwv250-438 | [6] | Ach Gott und Herr | MBID |
| 14515 | Choralsatz, BWV 256 "Ach, lieben Christen, seidgetrost" | bach-bwv250-438 | [7] | Ach lieben Christen, seid getrost | MBID |
| 15016 | Choralsatz, BWV 257 "Wär Gott nicht mit uns diese Zeit" | bach-bwv250-438 | [8] | Wär Gott nicht mit uns diese Zeit | MBID |
| 15204 | Choralsatz, BWV 258 "Wo Gott der Herr nicht bei uns hält" | bach-bwv250-438 | [9] | Wo Gott der Herr nicht bei uns hält | MBID |
| 15307 | Choralsatz, BWV 259 "Ach was soll ich Sünder machen" | bach-bwv250-438 | [10] | Ach, was soll ich Sünder machen | MBID |
| 14684 | Chorale: O heil'ger Geist, du hochstes Gut, BWV 260 | bach-bwv250-438 | [11] | Allein Gott in der Höh sei Ehr | MBID |
| 15319 | Chorale Harmonization, BWV 261 “Allein zu dir, Herr Jesu Christ” | bach-bwv250-438 | [12] | Allein zu dir, Herr Jesu Christ | MBID |
| 15003 | Choralsatz, BWV 262 "Alle Menschen müssen sterben" | bach-bwv250-438 | [13] | Alle Menschen müssen sterben | MBID |
| 14174 | Choralsatz, BWV 263 "Alles ist an Gottes Segen" | bach-bwv250-438 | [14] | Alles ist an Gottes Segen | MBID |
| 15527 | Choralsatz, BWV 264 "Als der gütige Gott" | bach-bwv250-438 | [15] | Als der gütige Gott | MBID |
| 14639 | Choralsatz, BWV 267 "An Wasserflüssen Babylon" | bach-bwv250-438 | [18] | An Wasserflüssen Babylon | MBID |
| 14979 | Choralsatz, BWV 268 "Auf, auf, mein Herz, und du mein ganzer Sinn" | bach-bwv250-438 | [19] | Auf, auf, mein Herz | MBID |
| 14164 | Choralsatz, BWV 269 "Aus meines Herzens Grunde" | bach-bwv250-438 | [20] | Aus meines Herzens Grunde | MBID |
| 15123 | Choralsatz, BWV 270 "Befiehl du deine Wege" | bach-bwv250-438 | [21] | Befiehl du deine Wege (B단조) | MBID |
| 14428 | Choralsatz, BWV 271 "Befiehl du deine Wege" | bach-bwv250-438 | [22] | Befiehl du deine Wege (BWV 271) | MBID |
| 15594 | Choralsatz, BWV 272 "Befiehl du deine Wege" | bach-bwv250-438 | [23] | Befiehl du deine Wege (D단조) | MBID |
| 14784 | Choralsatz, BWV 273 "Christ, der du bist der helle Tag" | bach-bwv250-438 | [24] | Christ, der du bist der helle Tag | MBID |
| 15438 | Choralsatz, BWV 274 "Christe, der du bist Tag und Licht" | bach-bwv250-438 | [25] | Christe, der du bist Tag und Licht | MBID |
| 15380 | Choralsatz, BWV 275 "Christe, du Beistand deiner Kreuzgemeine" | bach-bwv250-438 | [26] | Christe, du Beistand | MBID |
| 14659 | Choralsatz, BWV 277 "Christ lag in Todesbanden" | bach-bwv250-438 | [28] | Christ lag in Todesbanden | MBID |
| 14722 | Choralsatz, BWV 278 "Christ lag in Todesbanden" | bach-bwv250-438 | [29] | Christ lag in Todesbanden (E단조) | MBID |
| 13748 | Choral, BWV 280 "Christ, unser Herr, zum Jordan kam" | bach-bwv250-438 | [31] | Christ unser Herr zum Jordan kam | MBID |
| 15641 | Choralsatz, BWV 281 "Christus, der ist mein Leben" | bach-bwv250-438 | [32] | Christus, der ist mein Leben (F장조) | MBID |
| 15263 | Choralsatz, BWV 282 "Christus, der ist mein Leben" | bach-bwv250-438 | [33] | Christus, der ist mein Leben (G장조) | MBID |
| 15433 | Choralsatz, BWV 283 "Christus, der uns selig macht" | bach-bwv250-438 | [34] | Christus, der uns selig macht | MBID |
| 15396 | Choralsatz, BWV 284 "Christus ist erstanden" | bach-bwv250-438 | [35] | Christus ist erstanden, hat überwunden | MBID |
| 15667 | Choralsatz, BWV 285 "Da der Herr Christ zu Tische saß" | bach-bwv250-438 | [36] | Da der Herr Christ zu Tische saß | MBID |
| 14635 | Choralsatz, BWV 288 "Das alte Jahr vergangen ist" | bach-bwv250-438 | [39] | Das alte Jahr vergangen ist | MBID |
| 15225 | Choralsatz, BWV 290 "Das walt Gott Vater und Gott Sohn" | bach-bwv250-438 | [41] | Das walt Gott Vater und Gott Sohn | MBID |
| 14912 | Choralsatz, BWV 291 "Das walt mein Gott" | bach-bwv250-438 | [42] | Das walt mein Gott | MBID |
| 15644 | Choralsatz, BWV 292 "Den Vater dort oben" | bach-bwv250-438 | [43] | Den Vater dort oben | MBID |
| 14804 | Choralsatz, BWV 293 "Der du bist drei in Einigkeit" | bach-bwv250-438 | [44] | Der du bist drei in Einigkeit | MBID |
| 14133 | Choralsatz, BWV 295 "Des Heilgen Geistes reiche Gnad" | bach-bwv250-438 | [46] | Des Heilgen Geistes reiche Gnad | MBID |
| 14419 | Choralsatz, BWV 296 "Die Nacht ist kommen" | bach-bwv250-438 | [47] | Die Nacht ist kommen | MBID |
| 14466 | Choralsatz, BWV 297 "Die Sonn hat sich mit ihrem Geianz gewendet" | bach-bwv250-438 | [48] | Die Sonn hat sich mit ihrem Glanz gewendet | MBID |
| 13997 | Choral, BWV 298 "Dies sind die heil'gen zehn Gebot'" | bach-bwv250-438 | [49] | Dies sind die heilgen zehn Gebot | MBID |
| 14522 | Choralsatz, BWV 299 [1] "Dir, dir, Jehova, will ich singen" | bach-bwv250-438 | [50] | Dir, dir, Jehova, will ich singen | MBID |
| 15568 | Choralsatz, BWV 301 "Du, o schönes Weltgebäude" | bach-bwv250-438 | [52] | Du, o schönes Weltgebäude | MBID |
| 15408 | Choralsatz, BWV 302 "Ein' feste Burg ist unser Gott" | bach-bwv250-438 | [53] | Ein feste Burg ist unser Gott (D장조) | MBID |
| 14836 | Choralsatz, BWV 303 "Ein feste Burg ist unser Gott" | bach-bwv250-438 | [54] | Ein feste Burg ist unser Gott (BWV 303) | MBID |
| 15701 | Choralsatz, BWV 304 "Eins ist not! ach Herr, dies Eine" | bach-bwv250-438 | [55] | Eins ist not, ach Herr, dies Eine | MBID |
| 14259 | Choralsatz, BWV 306 "Erstanden ist der heilge Christ" | bach-bwv250-438 | [57] | Erstanden ist der heilig Christ | MBID |
| 14374 | Choralsatz, BWV 307 "Es ist gewißlich an der Zeit" | bach-bwv250-438 | [58] | Es ist gewisslich an der Zeit | MBID |
| 14108 | Choralsatz, BWV 308 "Es spricht der Unweisen Mund wohl" | bach-bwv250-438 | [59] | Es spricht der Unweisen Mund wohl | MBID |
| 14991 | Choralsatz, BWV 309 "Es stehn vor Gottes Throne" | bach-bwv250-438 | [60] | Es stehn vor Gottes Throne | MBID |
| 15629 | Choralsatz, BWV 310 "Es wird schier der letzte Tag herkommen" | bach-bwv250-438 | [61] | Es wird schier der letzte Tag herkommen | MBID |
| 15258 | Choralsatz, BWV 311 "Es woll uns Gott genädig sein" | bach-bwv250-438 | [62] | Es woll uns Gott gnädig sein (B단조) | MBID |
| 14110 | Choralsatz, BWV 313 "Für Freuden laßt uns springen" | bach-bwv250-438 | [64] | Für Freuden lasst uns springen | MBID |
| 14960 | Choralsatz, BWV 314 "Gelobet seist du, Jesu Christ" | bach-bwv250-438 | [65] | Gelobt seist du, Jesu Christ | MBID |
| 15453 | Choralsatz, BWV 315 "Gib dich zufrieden und sei stille" | bach-bwv250-438 | [66] | Gib dich zufrieden und sei stille | MBID |
| 14796 | Choralsatz, BWV 316 "Gott, der du selber bist das Licht" | bach-bwv250-438 | [67] | Gott, der du selber bist das Licht | MBID |
| 14184 | Choralsatz, BWV 317 "Gott, der Vater, wohn uns bei" | bach-bwv250-438 | [68] | Gott der Vater wohn uns bei | MBID |
| 15047 | Choralsatz, BWV 319 "Gott hat das Evangelium" | bach-bwv250-438 | [70] | Gott hat das Evangelium | MBID |
| 14099 | Choralsatz, BWV 321 "Gottlob, es geht nunmehr zum Ende" | bach-bwv250-438 | [72] | Gottlob, es geht nunmehr zum Ende | MBID |
| 15120 | Choralsatz, BWV 322 "Gott sei gelobet und gebenedeiet" | bach-bwv250-438 | [73] | Gott sei gelobet und gebenedeiet | MBID |
| 15294 | Choralsatz, BWV 323 "Gott sei uns gnädig und barmherzig" | bach-bwv250-438 | [74] | Gott sei uns gnädig und barmherzig | MBID |
| 14752 | Chorale: Lob und Preis sei Gott, dem Vater, BWV 324 | bach-bwv250-438 | [75] | Meine Seele erhebet den Herren | MBID |
| 14310 | Choralsatz, BWV 325 "Heilig, heilig, heilig" | bach-bwv250-438 | [76] | Heilig, heilig, heilig | MBID |
| 14132 | Choralsatz, BWV 326 "Herr Gott, dich loben alle wir" | bach-bwv250-438 | [77] | Herr Gott, dich loben alle wir | MBID |
| 15367 | Choralsatz, BWV 327 "Für deinen Thron tret ich hiermit" | bach-bwv250-438 | [78] | Vor deinen Thron tret ich hiermit | MBID |
| 15535 | Choralsatz, BWV 328 "Herr Gott, dich loben wir" | bach-bwv250-438 | [79] | Herr Gott, dich loben wir | MBID |
| 15615 | Choralsatz, BWV 329 "Herr, ich denk an jene Zeit" | bach-bwv250-438 | [80] | Herr, ich denk an jene Zeit | MBID |
| 14877 | Choralsatz, BWV 331 "Herr, ich habe mißgehandelt" | bach-bwv250-438 | [82] | Herr, ich habe missgehandelt (BWV 331) | MBID |
| 13956 | Choralsatz, BWV 332 "Herr Jesu Christ, dich zu uns wend" | bach-bwv250-438 | [83] | Herr Jesu Christ, dich zu uns wend | MBID |
| 14987 | Choralsatz BWV 333 "Herr Jesu Christ, du hast bereit" | bach-bwv250-438 | [84] | Herr Jesu Christ, du hast bereit' | MBID |
| 14078 | Choralsatz, BWV 334 "Herr Jesu Christ, du höchstes Gut" | bach-bwv250-438 | [85] | Herr Jesu Christ, ich schrei zu dir | MBID |
| 14032 | Choralsatz, BWV 335 "Herr Jesu Christ, mein's Lebens Licht" | bach-bwv250-438 | [86] | Herr Jesu Christ, meins Lebens Licht | MBID |
| 14568 | Choralsatz, BWV 336 "Herr Jesu Christ, wahr' Mensch und Gott" | bach-bwv250-438 | [87] | Herr Jesu Christ, wahr' Mensch und Gott | MBID |
| 15672 | Choralsatz, BWV 337 "Herr, nun laß in Friede" | bach-bwv250-438 | [88] | Herr, nun lass in Friede | MBID |
| 15489 | Choralsatz, BWV 338 "Herr, straf mich nicht in deinem Zorn" | bach-bwv250-438 | [89] | Herr, straf mich nicht in deinem Zorn, das bitt | MBID |
| 14473 | Choralsatz, BWV 339 "Herr, wie du willst, so shicks mit mir" | bach-bwv250-438 | [90] | Wer in dem Schutz des Höchsten ist | MBID |
| 15020 | Choralsatz, BWV 340 "Herzlich lieb hab ich dich, o Herr" | bach-bwv250-438 | [91] | Herzlich lieb hab ich dich, o Herr | MBID |
| 14677 | Choralsatz, BWV 341 "Heut' ist, o Mensch, ein großer Trauertag" | bach-bwv250-438 | [92] | Heut ist, o Mensch, ein großer Trauertag | MBID |
| 15346 | Choralsatz, BWV 342 "Heut triumphieret Gottes Sohn" | bach-bwv250-438 | [93] | Heut triumphieret Gottes Sohn | MBID |
| 15379 | Choralsatz, BWV 343 "Hilf Gott, daß mirs gelinge" | bach-bwv250-438 | [94] | Hilf, Gott, dass mirs gelinge | MBID |
| 14392 | Choralsatz, BWV 344 "Hilf, Herr, Jesu laß gelingen" | bach-bwv250-438 | [95] | Hilf, Herr Jesu, lass gelingen | MBID |
| 14304 | Choralsatz, BWV 345 "Ich bin ja, Herr, in deiner Macht" | bach-bwv250-438 | [96] | Ich bin ja, Herr, in deiner Macht | MBID |
| 15301 | Choralsatz, BWV 346 "Ich dank dir, Gott, für deine Wohltat" | bach-bwv250-438 | [97] | Ich dank dir, Gott, für deine Wohltat | MBID |
| 15451 | Choralsatz, BWV 348 "Ich dank dir, lieber Herre" | bach-bwv250-438 | [99] | Ich dank dir, lieber Herre (B♭장조) | MBID |
| 15452 | Choralsatz, BWV 349 "Ich dank dir schon durch deinen Sohn" | bach-bwv250-438 | [100] | Ich dank dir schon durch deinen Sohn | MBID |
| 14491 | Choralsatz, BWV 350 "Ich danke dir, o Gott, in deinem Throne" | bach-bwv250-438 | [101] | Ich danke dir, Herr Gott, in deinem Throne | MBID |
| 14838 | Choralsatz, BWV 352 "Jesu, der du meine Seele" | bach-bwv250-438 | [103] | Jesu, der du meine Seele (A단조) | MBID |
| 14822 | Choralsatz, BWV 353 "Jesu, der du meine Seele" | bach-bwv250-438 | [104] | Jesu, der du meine Seele (G단조) | MBID |
| 14567 | Choralsatz, BWV 354 "Jesu, der du meine Seele" | bach-bwv250-438 | [105] | Jesu, der du meine Seele | MBID |
| 14557 | Choralsatz, BWV 355 "Jesu, der du selbsten wohl" | bach-bwv250-438 | [106] | Jesu, der du selbsten wohl | MBID |
| 14501 | Choralsatz, BWV 356 "Jesu, du mein liebstes leben" | bach-bwv250-438 | [107] | Jesu, du mein liebstes Leben | MBID |
| 14266 | Choralsatz, BWV 357 "Jesu, Jesu, du bist mein" | bach-bwv250-438 | [108] | Jesu, Jesu, du bist mein | MBID |
| 14764 | Choralsatz, BWV 358 "Jesu, meine Freude" | bach-bwv250-438 | [109] | Jesu, meine Freude | MBID |
| 14474 | Choralsatz, BWV 359 "Jesu, meiner Seelen Wonne" | bach-bwv250-438 | [110] | Jesu, meiner Seelen Wonne (A장조) | MBID |
| 15358 | Choralsatz, BWV 360 "Jesu, meiner Seelen Wonne" | bach-bwv250-438 | [111] | Jesu, meiner Seelen Wonne (B♭장조) | MBID |
| 13744 | Choralsatz, BWV 361 "Jesu, meines Herzens Freud" | bach-bwv250-438 | [112] | Jesu, meines Herzens Freud | MBID |
| 14394 | Choralsatz, BWV 362 "Jesu, nun sei gepreiset" | bach-bwv250-438 | [113] | Jesu, nun sei gepreiset | MBID |
| 14475 | Chorale: Wer sich will zu dem Tisch machen, BWV 363 | bach-bwv250-438 | [114] | Jesus Christus, unser Heiland, der von uns den Got | MBID |
| 14846 | Choralsatz, BWV 364 "Jesus Christus, unser Heiland" | bach-bwv250-438 | [115] | Jesus Christus, unser Heiland, der den Tod überwan | MBID |
| 14203 | Choralsatz, BWV 365 "Jesus, meine Zuversicht" | bach-bwv250-438 | [116] | Jesus, meine Zuversicht | MBID |
| 14688 | Choralsatz, BWV 366: "Ihr Gestirn, ihr hohlen Lüfte" | bach-bwv250-438 | [117] | Ihr Gestirn, ihr hohlen Lüfte | MBID |
| 15219 | Choralsatz, BWV 367 "In allen meinen Taten" | bach-bwv250-438 | [118] | In allen meinen Taten | MBID |
| 14458 | Choralstaz, BWV 369 "Keinen hat Gott verlassen" | bach-bwv250-438 | [120] | Keinen hat Gott verlassen | MBID |
| 15247 | Choralsatz, BWV 370 "Komm, Gott Schöpfer, Heiliger Geist" | bach-bwv250-438 | [121] | Komm, Gott Schöpfer, Heiliger Geist | MBID |
| 14926 | Choralsatz, BWV 371 "Kyrie! Gott Vater in Ewigkeit" | bach-bwv250-438 | [122] | Kyrie, Gott Vater in Ewigkeit | MBID |
| 15372 | Choralsatz, BWV 372 "Laß, o Herr, dein Ohr sich neigen" | bach-bwv250-438 | [123] | Lass, o Herr, dein Ohr sich neigen | MBID |
| 15323 | Choralsatz, BWV 374 "Lobet den Herren, denn er ist sehr freundlich" | bach-bwv250-438 | [125] | Lobet den Herren, denn er ist sehr | MBID |
| 14433 | Choralsatz, BWV 375 "Lobt Gott, ihr Christen allzugleich" | bach-bwv250-438 | [126] | Lobt Gott, ihr Christen, allzugleich | MBID |
| 15234 | Choralsatz, BWV 376 "Lobt Gott, ihr Christen allzugleich" | bach-bwv250-438 | [127] | Lobt Gott, ihr Christen allzugleich | MBID |
| 14852 | Choralsatz, BWV 377 "Mach's mit mir, Gott, nach deiner Güt'" | bach-bwv250-438 | [128] | Machs mit mir, Gott, nach deiner Güt | MBID |
| 14560 | Choralsatz, BWV 378 "Mein Augen schließ ich jetzt" | bach-bwv250-438 | [129] | Mein Augen schließ ich jetzt | MBID |
| 14511 | Choralsatz, BWV 379 "Meinen Jesum laß ich nicht, Jesus " | bach-bwv250-438 | [130] | Meinen Jesum lass ich nicht, Jesus | MBID |
| 13867 | Choralsatz, BWV 380 „Meinen Jesum laß ich nicht, weil“ | bach-bwv250-438 | [131] | Meinen Jesum lass ich nicht, weil | MBID |
| 15239 | Choralsatz, BWV 381 "Meines Lebens letzte Zeit" | bach-bwv250-438 | [132] | Meines Lebens letzte Zeit | MBID |
| 14167 | Choralsatz, BWV 382 "Mit Fried und Freud ich fahr dahin" | bach-bwv250-438 | [133] | Mit Fried und Freud ich fahr dahin | MBID |
| 15354 | Choralsatz, BWV 383 "Mitten wir im Leben sind" | bach-bwv250-438 | [134] | Mitten wir im Leben sind | MBID |
| 15415 | Choralsatz, BWV 384 "Nicht so traurig, nicht so sehr" | bach-bwv250-438 | [135] | Nicht so traurig, nicht so sehr | MBID |
| 14241 | Choralsatz, BWV 385 "Nun bitten wir den heiligen Geist" | bach-bwv250-438 | [136] | Nun bitten wir den Heiligen Geist | MBID |
| 14769 | Choralsatz, BWV 386 "Nun danket alle Gott" | bach-bwv250-438 | [137] | Nun danket alle Gott (A장조) | MBID |
| 14348 | Choralsatz, BWV 387 "Nun freut euch, Gottes Kinder all" | bach-bwv250-438 | [138] | Nun freut euch, Gottes Kinder all | MBID |
| 14847 | Choralsatz, BWV 389 "Nun lob, mein Seel, den Herren" | bach-bwv250-438 | [140] | Nun lob, mein Seel, den Herren (C장조) | MBID |
| 14801 | Choralsatz, BWV 390 "Nun lob, mein Seel, den Herren" | bach-bwv250-438 | [141] | Nun lob, mein Seel, den Herren (BWV 390) | MBID |
| 14368 | Choralsatz, BWV 391 "Nun preiset alle Gottes Barmherzigkeit" | bach-bwv250-438 | [142] | Nun preiset alle Gottes Barmherzigkeit | MBID |
| 13823 | Choralsatz, BWV 392 "Nun ruhen alle Wälder" | bach-bwv250-438 | [143] | Nun ruhen alle Wälder | MBID |
| 14980 | Choralsatz, BWV 393 "O Welt, sieh hier dein Leben" | bach-bwv250-438 | [144] | O Welt, sieh hier dein Leben (A장조) | MBID |
| 15384 | Choralsatz, BWV 394 "O Welt, sieh hier dein Leben" | bach-bwv250-438 | [145] | O Welt, sieh hier dein Leben (BWV 394) | MBID |
| 14691 | Choralsatz, BWV 395 "O Welt, ich muß dich lassen" | bach-bwv250-438 | [146] | O Welt, sieh hier dein Leben (BWV 395) | MBID |
| 15250 | Choralsatz, BWV 396 "Nun sich der Tag geendet hat" | bach-bwv250-438 | [147] | Nun sich der Tag geendet hat | MBID |
| 14585 | Choralsatz, BWV 397 "O Ewigkeit, du Donnerwort" | bach-bwv250-438 | [148] | O Ewigkeit, du Donnerwort | MBID |
| 14924 | Choralsatz, BWV 398 "O Gott, du frommer Gott" | bach-bwv250-438 | [149] | O Gott, du frommer Gott (D장조) | MBID |
| 15608 | Choralsatz, BWV 399 "O Gott, du frommer Gott" | bach-bwv250-438 | [150] | O Gott, du frommer Gott (G장조) | MBID |
| 14531 | Choralsatz, BWV 400 "O Herzensangst, o Bangigkeit und Zagen" | bach-bwv250-438 | [151] | O Herzensangst | MBID |
| 14905 | Choralsatz, BWV 403 "O Mensch, schau Jesum Christum an" | bach-bwv250-438 | [154] | O Mensch, schau Jesum Christum an | MBID |
| 14270 | Choralsatz, BWV 404 "O Traurigkeit, O Herzeleid" | bach-bwv250-438 | [155] | O Traurigkeit, o Herzeleid | MBID |
| 14814 | Choralsatz, BWV 405 "O wie selig seid ihr doch, ihr Frommen" | bach-bwv250-438 | [156] | O wie selig seid ihr doch, ihr Frommen (D단조) | MBID |
| 15559 | Choralsatz, BWV 406 "O wie selig seid ihr doch, ihr Frommen" | bach-bwv250-438 | [157] | O wie selig seid ihr doch, ihr Frommen (BWV 406) | MBID |
| 15192 | Choralsatz BWV 407: "O wir armen Sünder" | bach-bwv250-438 | [158] | O wir armen Sünder | MBID |
| 14693 | Choralsatz, BWV 409 "Seelenbräutigam" | bach-bwv250-438 | [160] | Seelenbräutigam | MBID |
| 15575 | Choralsatz, BWV 410 "Sei gegrüßet, Jesu gütig" | bach-bwv250-438 | [161] | Sei gegrüßet, Jesu gütig | MBID |
| 15303 | Choralsatz, BWV 411 "Singt dem Herrn ein neues Lied" | bach-bwv250-438 | [162] | Singt dem Herrn ein neues Lied | MBID |
| 15277 | Choralsatz, BWV 412 "So giebst du nun, mein Jesu, gute Nacht" | bach-bwv250-438 | [163] | So gibst du nun, mein Jesu, gute Nacht | MBID |
| 14142 | Choralsatz, BWV 413 "Sollt' ich meinem Gott nicht singen" | bach-bwv250-438 | [164] | Sollt ich meinem Gott nicht singen | MBID |
| 14305 | Choralsatz, BWV 416 "Vater unser im Himmelreich" | bach-bwv250-438 | [167] | Vater unser im Himmelreich | MBID |
| 14756 | Choralsatz, BWV 418 "Von Gott will ich nicht lassen" | bach-bwv250-438 | [169] | Von Gott will ich nicht lassen (A단조) | MBID |
| 15689 | Choralsatz, BWV 419 "Von Gott will ich nicht lassen" | bach-bwv250-438 | [170] | Helft mir Gotts Güte preisen | MBID |
| 15462 | Choralsatz, BWV 420 "Warum betrübst du dich, mein Herz" | bach-bwv250-438 | [171] | Warum betrübst du dich, mein Herz (A단조) | MBID |
| 14780 | Choralsatz, BWV 421 "Warum betrübst du dich, mein Herz" | bach-bwv250-438 | [172] | Warum betrübst du dich, mein Herz (BWV 421) | MBID |
| 15226 | Choralsatz, BWV 422 "Warum sollt ich mich denn grämen" | bach-bwv250-438 | [173] | Warum sollt ich mich denn grämen | MBID |
| 15483 | Choralsatz, BWV 423 "Was betrübst du dich, mein Herze" | bach-bwv250-438 | [174] | Was betrübst du dich, mein Herze | MBID |
| 14199 | Choralsatz, BWV 424 "Was bist du doch, o Seele, so betrübet" | bach-bwv250-438 | [175] | Was bist du doch, o Seele, so betrübet | MBID |
| 14945 | Choralsatz, BWV 425 "Was willt du dich, o meine Seele, kränken" | bach-bwv250-438 | [176] | Was willst du dich, o meine Seele, kränken | MBID |
| 15116 | Choralsatz, BWV 427 "Wenn ich in Angst und Not" | bach-bwv250-438 | [178] | Wenn ich in Angst und Not | MBID |
| 14331 | Choralsatz, BWV 428 "Wenn mein Stündlein vorhanden ist" | bach-bwv250-438 | [179] | Wenn mein Stündlein verhanden ist (G장조) | MBID |
| 15488 | Choralsatz, BWV 429 "Wenn mein Stündlein vorhanden ist" | bach-bwv250-438 | [180] | Wenn mein Stündlein verhanden ist (A장조) | MBID |
| 14558 | Choralsatz, BWV 430 "Wenn mein Stündlein vorhanden ist" | bach-bwv250-438 | [181] | Wenn mein Stündlein verhanden ist (BWV 430) | MBID |
| 14872 | Choralsatz, BWV 431 "Wenn wir in höchsten Nöten sein" | bach-bwv250-438 | [182] | Wenn wir in höchsten Nöten sein (F장조) | MBID |
| 14431 | Choralsatz, BWV 432 "Wenn wir in höchsten Nöten sein" | bach-bwv250-438 | [183] | Wenn wir in höchsten Nöten sein (G장조) | MBID |
| 14391 | Choralsatz, BWV 433 "Wer Gott vertraut, hat wohl gebaut" | bach-bwv250-438 | [184] | Wer Gott vertraut, hat wohl gebaut | MBID |
| 14217 | Choralsatz, BWV 434 "Wer nur den lieben Gott läßt walten" | bach-bwv250-438 | [185] | Wer weiß, wie nahe mir mein Ende | MBID |
| 14494 | Choralsatz, BWV 435 "Wie bist du, Seele, in mir so gar betrübt" | bach-bwv250-438 | [186] | Wie bist du, Seele, in mir so gar betrübt | MBID |
| 14701 | Choralsatz, BWV 436 "Wie schön leuchtet der Morgenstern" | bach-bwv250-438 | [187] | Wie schön leuchtet der Morgenstern | MBID |
| 15282 | Choralsatz, BWV 438 "Wo Gott zum Haus nicht gibt sein Gunst" | bach-bwv250-438 | [189] | Wo Gott zum Haus nicht gibt sein Gunst | MBID |
| 15006 | Kantate, BWV 26 "Ach wie flüchtig, ach wie nichtig" | bach-bwv26 |  | 칸타타 <Ach wie flüchtig, ach wie nichtig> BWV 26 | MBID |
| 15238 | Kantate, BWV 27 "Wer weiß, wie nahe mir mein Ende?" | bach-bwv27 |  | 칸타타 <Wer weiß, wie nahe mir mein Ende?> BWV 27 | MBID |
| 14696 | Kantate, BWV 28 "Gottlob! nun geht das Jahr zu Ende" | bach-bwv28 |  | 칸타타 <Gottlob! nun geht das Jahr zu Ende> BWV 28 | MBID |
| 14545 | Kantate, BWV 28 "Gottlob! nun geht das Jahr zu Ende": I. Aria "Gottlob | bach-bwv28 | [1] | 아리아 "Gottlob! nun geht das Jahr zu Ende" | BWV 28 악장 번호 1 |
| 14220 | Kantate, BWV 29 "Wir danken dir, Gott, wir danken dir" | bach-bwv29 |  | 칸타타 <Wir danken dir, Gott, wir danken dir> BWV 29 | MBID |
| 15101 | Cantata, BWV 29 "Wir danken Dir, Gott": Sinfonia in D major | bach-bwv29 | [1] | 신포니아 | 관계(arrangement) → MBID 일치 |
| 14476 | Kantate, BWV 3 "Ach Gott, wie manches Herzeleid" | bach-bwv3 |  | 칸타타 <Ach Gott, wie manches Herzeleid> BWV 3 | MBID |
| 13870 | Kantate, BWV 30.2 "Freue dich, erlöste Schar" | bach-bwv30 |  | 칸타타 <Freue dich, erlöste Schar> BWV 30 | MBID |
| 14036 | Kantate, BWV 30.1 "Angenehmes Wiederau" | bach-bwv30a |  | 칸타타 <Angenehmes Wiederau> BWV 30a | MBID |
| 15583 | Kantate, BWV 31 "Der Himmel lacht! die Erde jubilieret" | bach-bwv31 |  | 칸타타 <Der Himmel lacht! Die Erde jubilieret> BWV 31 | MBID |
| 14749 | Kantate, BWV 32 "Liebster Jesu, mein Verlangen" | bach-bwv32 |  | 칸타타 <Liebster Jesu, mein Verlangen> BWV 32 | MBID |
| 15514 | Kantate, BWV 33 "Allein zu dir, Herr Jesu Christ" | bach-bwv33 |  | 칸타타 <Allein zu dir, Herr Jesu Christ> BWV 33 | MBID |
| 15078 | Kantate, BWV 33 "Allein zu dir, Herr Jesu Christ": III. Aria "Wie furc | bach-bwv33 | [3] | 아리아 "Wie furchtsam wankten meine Schritte" | BWV 33 악장 번호 3 |
| 13847 | Kantate, BWV 34.2 "O ewiges Feuer, o Ursprung der Liebe" | bach-bwv34 |  | 칸타타 <O ewiges Feuer, o Ursprung der Liebe> BWV 34 | MBID |
| 14222 | Cantata BWV35 'Geist und Seele wird verwirret': No. 4, Gott hat alles  | bach-bwv35 | [4] | 아리아 "Gott hat alles wohlgemacht" | BWV 35 악장 번호 4 |
| 14900 | Kantate, BWV 36 “Schwingt freudig euch empor” | bach-bwv36 |  | 칸타타 <Schwingt freudig euch empor> BWV 36 | MBID |
| 15316 | Kantate, BWV 36 "Schwingt freudig euch empor": II. Choral "Nun komm, d | bach-bwv36 | [2] | 코랄 "Nun komm, der Heiden Heiland" | BWV 36 악장 번호 2 |
| 14313 | Kantate, BWV 36 "Schwingt freudig euch empor": IV. Choral "Zwingt die  | bach-bwv36 | [4] | 코랄 "Zwingt die Saiten in Cythara" | BWV 36 악장 번호 4 |
| 15506 | Kantate, BWV 36 "Schwingt freudig euch empor": VI. Choral "Der du bist | bach-bwv36 | [6] | 코랄 "Der du bist dem Vater gleich" | BWV 36 악장 번호 6 |
| 14303 | Kantate, BWV 36 "Schwingt freudig euch empor": VIII. Choral "Lob sei G | bach-bwv36 | [8] | 코랄 "Lob sei Gott, dem Vater g’ton" | BWV 36 악장 번호 8 |
| 14008 | Kantate, BWV 36.3 "Die Freude reget sich" | bach-bwv36b |  | 칸타타 <Die Freude reget sich> BWV 36b | MBID |
| 13881 | Kantate, BWV 36.1 "Schwingt freudig euch empor" | bach-bwv36c |  | 칸타타 <Schwingt freudig euch empor> BWV 36c | MBID |
| 14848 | Kantate, BWV 37 "Wer da gläubet und getauft wird" | bach-bwv37 |  | 칸타타 <Wer da gläubet und getauft wird> BWV 37 | MBID |
| 14706 | Choralsatz "Ich dank' dir, lieber Herre" | bach-bwv37 | [6] | 코랄 "Den Glauben mir verleihe" | 다른 가사의 같은 코랄 화성(MB other version). 관계(other version) → MBID 일치 |
| 14376 | Kantate, BWV 38 "Aus tiefer Not schrei ich zu dir" | bach-bwv38 |  | 칸타타 <Aus tiefer Not schrei ich zu dir> BWV 38 | MBID |
| 15224 | Kantate, BWV 39 "Brich dem Hungrigen dein Brot" | bach-bwv39 |  | 칸타타 <Brich dem Hungrigen dein Brot> BWV 39 | MBID |
| 13915 | Kantate, BWV 4 „Christ lag in Todesbanden“ | bach-bwv4 |  | 칸타타 <Christ lag in Todes Banden> BWV 4 | MBID |
| 14087 | Cantata, BWV 4 "Christ lag in Todesbänden": Tenor aria "Jesus Christus | bach-bwv4 | [4] | 아리아 Versus III "Jesus Christus, Gottes Sohn" | BWV 4 악장 가사 일치 |
| 15341 | Kantate, BWV 4 "Christ lag in Todesbanden": VIII. Choral Versus VII "W | bach-bwv4 | [8] | 코랄 Versus VII "Wir essen und leben wohl" | BWV 4 악장 번호 8 |
| 14276 | Kantate, BWV 40 "Darzu ist erschienen der Sohn Gottes" | bach-bwv40 |  | 칸타타 <Darzu ist erschienen der Sohn Gottes> BWV 40 | MBID |
| 14837 | Kantate, BWV 41 "Jesu, nun sei gepreiset" | bach-bwv41 |  | 칸타타 <Jesu, nun sei gepreiset> BWV 41 | MBID |
| 14149 | Kantate, BWV 42 "Am Abend aber desselbigen Sabbats" | bach-bwv42 |  | 칸타타 <Am Abend aber desselbigen Sabbats> BWV 42 | MBID |
| 15268 | Kantate, BWV 42 "Am Abend aber desselbigen Sabbats" (Appendix): IV. Ch | bach-bwv42 | [4] | 코랄 "Verzage nicht, o Häuflein klein" | BWV 42 악장 번호 4 |
| 15296 | Kantate, BWV 43 "Gott fähret auf mit Jauchzen" | bach-bwv43 |  | 칸타타 <Gott fähret auf mit Jauchzen> BWV 43 | MBID |
| 15032 | Kantate, BWV 43 appendix "Gott fähret auf mit Jauchzen": Teil II, VII. | bach-bwv43 | [7] | 아리아 "Er ists, der ganz allein die Kelter hat getre | BWV 43 악장 번호 7 |
| 15392 | Choralsatz "Ermuntre dich, mein schwacher Geist" | bach-bwv43 | [11] | 코랄 "Du Lebensfürst, Herr Jesu Christ" | 다른 가사의 같은 코랄 화성(MB other version). 관계(other version) → MBID 일치 |
| 14441 | Geistliches Lied, BWV 439 "Ach, daß nicht die letzte Stunde" | bach-bwv439-507 | [1] | Ach, dass nicht die letzte Stunde | MBID |
| 14731 | Geistliches Lied, BWV 440 "Auf, auf! die rechte Zeit ist hier" | bach-bwv439-507 | [2] | Auf, auf! die rechte Zeit ist hier | MBID |
| 14438 | Geistliches Lied, BWV 441 "Auf, auf! mein Herz, mit Freuden" | bach-bwv439-507 | [3] | Auf, auf, mein Herz, mit Freuden | MBID |
| 14828 | Geistliches Lied, BWV 442 "Beglückter Stand getreuer Seelen" | bach-bwv439-507 | [4] | Beglückter Stand getreuer Seelen | MBID |
| 14285 | Geistliches Lied, BWV 443 "Beschränkt, ihr Weisen dieser Welt" | bach-bwv439-507 | [5] | Beschränkt, ihr Weisen dieser Welt | MBID |
| 14129 | Geistliche Lied, BWV 444 "Brich entzwei, mein armes Herze" | bach-bwv439-507 | [6] | Brich entzwei, mein armes Herze | MBID |
| 14535 | Geistliches Lied, BWV 446 "Der lieben Sonne Licht und Pracht" | bach-bwv439-507 | [8] | Der lieben Sonnen Licht und Pracht | MBID |
| 14867 | Geistliches Lied, BWV 447 "Der Tag ist hin" | bach-bwv439-507 | [9] | Der Tag ist hin, die Sonne gehet nieder | MBID |
| 14854 | Geistliches Lied, BWV 448 "Der Tag mit seinem Lichte" | bach-bwv439-507 | [10] | Der Tag mit seinem Lichte | MBID |
| 14072 | Geistliches Lied, BWV 449 "Dich bet ich an, mein höchster Gott" | bach-bwv439-507 | [11] | Dich bet ich an, mein höchster Gott | MBID |
| 15158 | Geistliches Lied, BWV 451 "Die güldne Sonne" | bach-bwv439-507 | [13] | Die güldne Sonne | MBID |
| 14244 | Geistliches Lied, BWV 452 "Dir, dir, Jehova, will ich singen" | bach-bwv439-507 | [14] | Dir, dir, Jehova, will ich singen | MBID |
| 15609 | Geistliches Lied, BWV 453 "Eins ist not! ach Herr, dies Eine" | bach-bwv439-507 | [15] | Eins ist not! ach Herr, dies Eine | MBID |
| 15110 | Geistliches Lied, BWV 454: „Ermuntre dich, mein schwacher Geist“ | bach-bwv439-507 | [16] | Ermuntre dich, mein schwacher Geist | MBID |
| 14623 | Geistliches Lied, BWV 455 "Erwürgtes Lamm, das die verwahrten Siegel" | bach-bwv439-507 | [17] | Erwürgtes Lamm, das die verwahrten Siegel | MBID |
| 15524 | Geistliches Lied, BWV 456 "Es glänzet der Christen inwendiges Leben" | bach-bwv439-507 | [18] | Es glänzet der Christen inwendiges Leben | MBID |
| 14254 | Geistliches Lied, BWV 457 "Es ist nun aus mit meinem Leben" | bach-bwv439-507 | [19] | Es ist nun aus mit meinem Leben | MBID |
| 14832 | Geistliches Lied, BWV 459 "Es kostet viel, ein Christ zu sein" | bach-bwv439-507 | [21] | Es kostet viel, ein Christ zu sein | MBID |
| 14140 | Geistliches Lied, BWV 460 "Gib dich zufrieden und sei stille" | bach-bwv439-507 | [22] | Gib dich zufrieden und sei stille | MBID |
| 15001 | Geistliches Lied, BWV 462 "Gott, wie groß ist deine Güte" | bach-bwv439-507 | [24] | Gott wie groß ist deine Güte | MBID |
| 15435 | Geistliches Lied, BWV 464 "Ich bin ja, Herr, in deiner Macht" | bach-bwv439-507 | [26] | Ich bin ja, Herr, in deiner Macht | MBID |
| 14582 | Geistliches Lied, BWV 465 "Ich freue mich in dir" | bach-bwv439-507 | [27] | Ich freue mich in dir | MBID |
| 15184 | Geistliches Lied, BWV 466 "Ich halte treulich still" | bach-bwv439-507 | [28] | Ich halte treulich still | MBID |
| 13977 | Geistliches Lied, BWV 467 "Ich laß dich nicht" | bach-bwv439-507 | [29] | Ich lass dich nicht | MBID |
| 14724 | Geistliches Lied, BWV 468 "Ich liebe Jesum alle Stund" | bach-bwv439-507 | [30] | Ich liebe Jesum alle Stund | MBID |
| 15576 | Ich steh an deiner Krippen hier | bach-bwv439-507 | [31] | Ich steh an deiner Krippen hier | 관계(other version) → MBID 일치 |
| 15669 | Geistliches Lied, BWV 470 "Jesu, Jesu, du bist mein" | bach-bwv439-507 | [32] | Jesu, Jesu, du bist mein | MBID |
| 14546 | Geistliches Lied, BWV 471 "Jesu, deine Liebeswunden" | bach-bwv439-507 | [33] | Jesu, deine Liebeswunden | MBID |
| 15519 | Geistliches Lied, BWV 472 "Jesu, meines Glaubens Zier" | bach-bwv439-507 | [34] | Jesu, meines Glaubens Zier | MBID |
| 15039 | Geistliches Lied, BWV 473 "Jesu, meines Herzens Freud" | bach-bwv439-507 | [35] | Jesu, meines Herzens Freud | MBID |
| 14275 | Geistliches Lied, BWV 475 "Jesus, unser Trost und Leben" | bach-bwv439-507 | [37] | Jesus, unser Trost und Leben | MBID |
| 15619 | Geistliches Lied, BWV 476 "Ihr Gestirn, ihr hohen Lüfte" | bach-bwv439-507 | [38] | Ihr Gestirn, ihr hohlen Lüfte | MBID |
| 14534 | Geistliches Lied, BWV 477 "Kein Stündlein geht dahin" | bach-bwv439-507 | [39] | Kein Stündlein geht dahin | MBID |
| 15434 | Geistliches Lied, BWV 479 "Kommt, Seelen dieser Tag" | bach-bwv439-507 | [41] | Kommt, Seelen, dieser Tag | MBID |
| 15215 | Geistliches Lied, BWV 480 "Kommt wieder aus der finstren Gruft" | bach-bwv439-507 | [42] | Kommt wieder aus der finstern Gruft | MBID |
| 14916 | Geistliches Lied, BWV 481 "Lasset uns mit Jesu ziehen" | bach-bwv439-507 | [43] | Lasset uns mit Jesu ziehen | MBID |
| 14835 | Geistliches Lied, BWV 482 "Liebes Herz, bedenke doch" | bach-bwv439-507 | [44] | Liebes Herz, bedenke doch | MBID |
| 15511 | Geistliches Lied, BWV 483 "Liebster Gott, wann werd ich sterben" | bach-bwv439-507 | [45] | Liebster Gott, wann werd ich sterben | MBID |
| 14840 | Geistliches Lied, BWV 484 "Liebster Herr Jesu, wo bleibst du so lange" | bach-bwv439-507 | [46] | Liebster Herr Jesu, wo bleibst du so lange | MBID |
| 15179 | Geistliches Lied, BWV 485 "Liebster Immanuel, Herzog der Frommen" | bach-bwv439-507 | [47] | Liebster Immanuel, Herzog der Frommen | MBID |
| 15541 | Geistliches Lied, BWV 486 "Mein Jesu, dem die Seraphinen" | bach-bwv439-507 | [48] | Mein Jesu, dem die Seraphinen | MBID |
| 15210 | Mein Jesu, was für Seelenweh, BWV 487 | bach-bwv439-507 | [49] | Mein Jesu! was vor Seelenweh | BWV 487 묶음 안 곡 |
| 14301 | Geistliches Lied, BWV 488 "Meines Lebens letzte Zeit" | bach-bwv439-507 | [50] | Meines Lebens letzte Zeit | MBID |
| 15599 | Geistliches Lied, BWV 489 "Nicht so traurig, nicht so sehr" | bach-bwv439-507 | [51] | Nicht so traurig, nicht so sehr | MBID |
| 15585 | Geistliches Lied, BWV 490 "Nur mein Jesus ist mein leben" | bach-bwv439-507 | [52] | Nur mein Jesus ist mein Leben | MBID |
| 14219 | Geistliches Lied, BWV 491 "O du Liebe meiner Liebe" | bach-bwv439-507 | [53] | O du Liebe meiner Liebe | MBID |
| 14102 | Geistliches Lied, BWV 492 "O finstre Nacht, wann wirst du doch vergehe | bach-bwv439-507 | [54] | O finstre Nacht, wenn wirst du doch vergehen | MBID |
| 14767 | Oi Jeesus, lapsi armainen | bach-bwv439-507 | [55] | O Jesulein süß, o Jesulein mild | 번안·다른 언어 제목(원어 seed 없음). 관계(other version) → MBID 일치 |
| 14137 | Geistliches Lied, BWV 494 "O liebe Seele, zieh die Sinnen" | bach-bwv439-507 | [56] | O liebe Seele, zieh die Sinnen | MBID |
| 15660 | Geistliches Lied, BWV 495 "O wie selig seid ihr doch, ihr Frommen" | bach-bwv439-507 | [57] | O wie selig seid ihr doch, ihr Frommen | MBID |
| 13925 | Geistliches Lied, BWV 496 "Seelenbräutigam, Jesu, Gottes Lamm" | bach-bwv439-507 | [58] | Seelenbräutigam | MBID |
| 14509 | Geistliches Lied, BWV 497 "Seelenweide" | bach-bwv439-507 | [59] | Seelenweide | MBID |
| 14119 | Geidtliche Lied, BWV 498 "Selig, wer an Jesum denkt" | bach-bwv439-507 | [60] | Selig, wer an Jesum denkt | MBID |
| 15463 | Geistliches Lied, BWV 499 "Sei gegrüßet, Jesu gütig" | bach-bwv439-507 | [61] | Sei gegrüßet, Jesu gütig | MBID |
| 14211 | Geistliche Lied, BWV 500 "So gehst du nun, mein Jesu, hin" | bach-bwv439-507 | [62] | So gehst du nun, mein Jesu hin | MBID |
| 15526 | Geistliche Lied, BWV 501 "So gibst do nun, mein Jesu gute Nacht" | bach-bwv439-507 | [63] | So gibst du nun, mein Jesu, gute Nacht | MBID |
| 14483 | Geistliches Lied, BWV 502 "So wünsch ich mir zu guter Letzt" | bach-bwv439-507 | [64] | So wünsch ich mir zu guter Letzt | MBID |
| 15320 | Geistliches Lied, BWV 503 "Steh ich bei meinem Gott" | bach-bwv439-507 | [65] | Steh ich bei meinem Gott | MBID |
| 15223 | Geistliches Lied, BWV 504 "Vergiß mein nicht, daß ich dein nicht verge | bach-bwv439-507 | [66] | Vergiss mein nicht, dass ich dein nicht vergesse | MBID |
| 15624 | Geistliches Lied, BWV 505 "Vergiß mein nicht, mein allerliebster Gott" | bach-bwv439-507 | [67] | Vergiss mein nicht, ..., Mein allerliebster Gott | MBID |
| 14207 | Geistliches Lied, BWV 506 "Was bist du doch, o Seele, so betrübet" | bach-bwv439-507 | [68] | Was bist du doch, o Seele, so betrübt | MBID |
| 15423 | Geistliches Lied, BWV 507 "Wo ist mein Schäflein, das ich liebe" | bach-bwv439-507 | [69] | Wo ist mein Schäflein, das ich liebe | MBID |
| 14831 | Kantate, BWV 44 "Sie werden euch in den Bann tun" | bach-bwv44 |  | 칸타타 <Sie werden euch in den Bann tun> BWV 44 | MBID |
| 14800 | Kantate, BWV 45 "Es ist dir gesagt, Mensch, was gut ist" | bach-bwv45 |  | 칸타타 <Es ist dir gesagt, Mensch, was gut ist> BWV 4 | MBID |
| 14367 | Kantate, BWV 46 "Schauet doch und sehet, ob irgendein Schmerz sei" | bach-bwv46 |  | 칸타타 <Schauet doch und sehet, ob irgend ein Schmerz | MBID |
| 15071 | Kantate, BWV 47 "Wer sich selbst erhöhet, der soll erniedriget werden" | bach-bwv47 |  | 칸타타 <Wer sich selbst erhöhet, der soll erniedriget | MBID |
| 15149 | Cantata "Wer Sich Selbst Erhöhet, Der Soll Erniedriget Werden" BWV 47  | bach-bwv47 | [2] | 아리아 "Wer ein wahrer Christ will heißen" | BWV 47 악장 번호 2 |
| 15658 | Choralsatz "Warum betrübst du dich, mein Herz" | bach-bwv47 | [5] | 코랄 "Der zeitlichen Ehrn will ich gern entbehrn" | 다른 가사의 같은 코랄 화성(MB other version). 관계(other version) → MBID 일치 |
| 14195 | Kantate, BWV 48 "Ich elender Mensch, wer wird mich erlösen" | bach-bwv48 |  | 칸타타 <Ich elender Mensch, wer wird mich erlösen> BW | MBID |
| 15532 | Kantate, BWV 49 “Ich geh und suche mit Verlangen” | bach-bwv49 |  | 칸타타 <Ich geh und suche mit Verlangen> BWV 49 | MBID |
| 14088 | Kantate, BWV 5 "Wo soll ich fliehen hin" | bach-bwv5 |  | 칸타타 <Wo soll ich fliehen hin> BWV 5 | MBID |
| 14197 | Die Lieder aus dem Notenbuch der Anna Magdalena Bach: VI , Gedenke doc | bach-bwv509 |  | 아리아 <Gedenke doch, mein Geist, zurücke> BWV 509 | MBID |
| 14436 | Kantate, BWV 51 "Jauchzet Gott in allen Landen" | bach-bwv51 |  | 칸타타 <Jauchzet Gott in allen Landen> BWV 51 | MBID |
| 15565 | Cantata BWV51 'Jauchzet Gott in allen Landen': No. 4, Sei Lob und Prei | bach-bwv51 | [4] | 코랄 "Sei Lob und Preis mit Ehren" | BWV 51 악장 번호 4 |
| 14308 | Choralsatz F-Dur, BWV 510 “Gib dich zufrieden und sei stille” | bach-bwv510 |  | 가곡 <Gib dich zufrieden und sei stille> F장조 BWV 510 | MBID |
| 15612 | Choralsatz, BWV 511 “Gib dich zufrieden und sei stille” | bach-bwv511 |  | 가곡 <Gib dich zufrieden und sei stille> G단조 BWV 511 | MBID |
| 15352 | Choralsatz, BWV 512 “Gib dich zufrieden und sei stille” | bach-bwv512 |  | 가곡 <Gib dich zufrieden und sei stille> E단조 BWV 512 | MBID |
| 15007 | O Ewigkeit, du Donnerwort, BWV 513 | bach-bwv513 |  | 가곡 <O Ewigkeit, du Donnerwort> BWV 513 | MBID |
| 15228 | Choral “Schaffs mit mir, Gott”, BWV 514 | bach-bwv514 |  | 가곡 <Schaffs mit mir, Gott, nach deinem Willen> BWV | MBID |
| 14917 | Aria “Warum betrübst du dich”, BWV 516 | bach-bwv516 |  | 아리아 <Warum betrübst du dich> BWV 516 | MBID |
| 15163 | Die Lieder aus dem Notenbuch der Anna Magdalena Bach: “Wie wohl ist mi | bach-bwv517 |  | 가곡 <Wie wohl ist mir, o Freund der Seelen> BWV 517 | MBID |
| 15125 | Kantate, BWV 52 "Falsche Welt, dir trau ich nicht" | bach-bwv52 |  | 칸타타 <Falsche Welt, dir trau ich nicht> BWV 52 | MBID |
| 15440 | Kantate, BWV 52 "Falsche Welt, dir trau ich nicht": III. Aria "Immerhi | bach-bwv52 | [3] | 아리아 "Immerhin, immerhin, wenn ich gleich verstoßen | BWV 52 악장 번호 3 |
| 14648 | Kantate, BWV 54 "Widerstehe doch der Sünde" | bach-bwv54 |  | 칸타타 <Widerstehe doch der Sünde> BWV 54 | MBID |
| 15046 | Kantate, BWV 55 "Ich armer Mensch, ich Sündenknecht" | bach-bwv55 |  | 칸타타 <Ich armer Mensch, ich Sündenknecht> BWV 55 | MBID |
| 15273 | Kantate, BWV 55 "Ich armer Mensch, ich Sündenknecht": III. Aria "Erbar | bach-bwv55 | [3] | 아리아 "Erbarme dich!" | BWV 55 악장 번호 3 |
| 14986 | Kantate, BWV 56 "Ich will den Kreuzstab gerne tragen" | bach-bwv56 |  | 칸타타 <Ich will den Kreuzstab gerne tragen> BWV 56 | MBID |
| 14608 | Kantate, BWV 57 "Selig ist der Mann" | bach-bwv57 |  | 칸타타 <Selig ist der Mann> BWV 57 | MBID |
| 14713 | Chorale: Kommst du nun, Jesu, vom Himmel herunter, BWV 57 | bach-bwv57 | [8] | 코랄 "Richte dich, Liebste, nach meinem Gefallen und | 다른 가사의 같은 코랄 화성(MB other version). 관계(other version) → MBID 일치 |
| 14135 | Kantate, BWV 58 "Ach Gott, wie manches Herzeleid" | bach-bwv58 |  | 칸타타 <Ach Gott, wie manches Herzeleid> BWV 58 | MBID |
| 15351 | Kantate, BWV 59 "Wer mich liebet, der wird mein Wort halten" | bach-bwv59 |  | 칸타타 <Wer mich liebet, der wird mein Wort halten> B | MBID |
| 14919 | Kantate, BWV 6 "Bleib bei uns, denn es will Abend werden" | bach-bwv6 |  | 칸타타 <Bleib bei uns, denn es will Abend werden> BWV | MBID |
| 14602 | Kantate, BWV 60 "O Ewigkeit, du Donnerwort" | bach-bwv60 |  | 칸타타 <O Ewigkeit, du Donnerwort> BWV 60 | MBID |
| 14539 | Kantate, BWV 60: V. Choral "Es ist genug; Herr, wenn es dir gefällt" | bach-bwv60 | [5] | 코랄 "Es ist genug; Herr, wenn es dir gefällt" | BWV 60 악장 번호 5 |
| 14091 | Kantate, BWV 61 “Nun komm, der Heiden Heiland” | bach-bwv61 |  | 칸타타 <Nun komm, der Heiden Heiland> BWV 61 | MBID |
| 14155 | Kantate, BWV 61 "Nun komm, der Heiden Heiland": VI. Choral "Amen, Amen | bach-bwv61 | [6] | 코랄 "Amen, Amen" | BWV 61 악장 번호 6 |
| 15236 | Kantate, BWV 62 "Nun komm, der Heiden Heiland" | bach-bwv62 |  | 칸타타 <Nun komm, der Heiden Heiland> BWV 62 | MBID |
| 15437 | Kantate, BWV 62 appendix "Nun komm, der Heiden Heiland": IV. Aria (Bas | bach-bwv62 | [4] | 아리아 "Streite, siege, starker Held!" | BWV 62 악장 번호 4 |
| 14670 | Kantate, BWV 63 "Christen, ätzet diesen Tag" | bach-bwv63 |  | 칸타타 <Christen, ätzet diesen Tag> BWV 63 | MBID |
| 15292 | Kantate, BWV 64 "Sehet, welch eine Liebe hat uns der Vater erzeiget" | bach-bwv64 |  | 칸타타 <Sehet, welch eine Liebe hat uns der Vater erz | MBID |
| 14862 | Kantate, BWV 65 "Sie werden aus Saba alle kommen" | bach-bwv65 |  | 칸타타 <Sie werden aus Saba alle kommen> BWV 65 | MBID |
| 14922 | Kantate, BWV 66.2/66 "Erfreut euch, ihr Herzen" | bach-bwv66 |  | 칸타타 <Erfreut euch, ihr Herzen> BWV 66 | MBID |
| 15355 | Kantate, BWV 67 "Halt im Gedächtnis Jesum Christ" | bach-bwv67 |  | 칸타타 <Halt im Gedächtnis Jesum Christ> BWV 67 | MBID |
| 14651 | Kantate, BWV 68 "Also hat Gott die Welt geliebt" | bach-bwv68 |  | 칸타타 <Also hat Gott die Welt geliebt> BWV 68 | MBID |
| 14136 | Kantate, BWV 68 "Also hat Gott die Welt geliebt": II. Aria + Ritornell | bach-bwv68 | [2] | 아리아와 리토르넬로 "Mein gläubiges Herze" | BWV 68 악장 번호 2 |
| 14743 | Kantate, BWV 69 "Lobe den Herrn, meine Seele" | bach-bwv69 |  | 칸타타 <Lobe den Herrn, meine Seele> BWV 69 | MBID |
| 15261 | Kantate, BWV 69a "Lobe den Herrn, meine Seele" | bach-bwv69a |  | 칸타타 <Lobe den Herrn, meine Seele> BWV 69a | MBID |
| 14768 | Kantate, BWV 7 "Christ unser Herr zum Jordan kam" | bach-bwv7 |  | 칸타타 <Christ unser Herr zum Jordan kam> BWV 7 | MBID |
| 15062 | Kantate, BWV 7 "Christ unser Herr zum Jordan kam": IV. Aria "Des Vater | bach-bwv7 | [4] | 아리아 "Des Vaters Stimme ließ sich hören" | BWV 7 악장 번호 4 |
| 13719 | Kantate, BWV 70.2 "Wachet! betet! betet! wachet!" | bach-bwv70 |  | 칸타타 <Wachet! Betet! Betet! Wachet!> BWV 70 | MBID |
| 15186 | Cantata, BWV 70 “Watch Ye, Pray Ye”: “Though reviling tongues assail u | bach-bwv70 | [5] | 아리아 "Laßt der Spötter Zungen schmähen" | 번안·다른 언어 제목(원어 seed 없음). 관계(arrangement) → MBID 일치 |
| 14603 | Kantate, BWV 71 "Gott ist mein König" | bach-bwv71 |  | 칸타타 <Gott ist mein König> BWV 71 | MBID |
| 14233 | Kantate, BWV 72 "Alles nur nach Gottes Willen" | bach-bwv72 |  | 칸타타 <Alles nur nach Gottes Willen> BWV 72 | MBID |
| 15061 | Kantate, BWV 73 "Herr, wie du willt, so schicks mit mir" | bach-bwv73 |  | 칸타타 <Herr, wie du willt, so schicks mit mir> BWV 7 | MBID |
| 15044 | Kantate, BWV 74 "Wer mich liebet, der wird mein Wort halten" | bach-bwv74 |  | 칸타타 <Wer mich liebet, der wird mein Wort halten> B | MBID |
| 14373 | Kantate, BWV 75 "Die Elenden sollen essen" | bach-bwv75 |  | 칸타타 <Die Elenden sollen essen> BWV 75 | MBID |
| 14625 | Kantate, BWV 76 "Die Himmel erzählen die Ehre Gottes" | bach-bwv76 |  | 칸타타 <Die Himmel erzählen die Ehre Gottes> BWV 76 | MBID |
| 15421 | Kantate, BWV 77 "Du sollt Gott, deinen Herren, lieben" | bach-bwv77 |  | 칸타타 <Du sollt Gott, deinen Herren, lieben> BWV 77 | MBID |
| 15072 | Kantate, BWV 78 "Jesu, der du meine Seele" | bach-bwv78 |  | 칸타타 <Jesu, der du meine Seele> BWV 78 | MBID |
| 14821 | Kantate, BWV 78 "Jesu, der du meine Seele": II. "Wir eilen mit schwach | bach-bwv78 | [2] | 2중창 "Wir eilen mit schwachen, doch emsigen Schritt | BWV 78 악장 번호 2 |
| 15336 | Kantate, BWV 79 "Gott der Herr ist Sonn und Schild" | bach-bwv79 |  | 칸타타 <Gott der Herr ist Sonn und Schild> BWV 79 | MBID |
| 14450 | Kantate, BWV 8.2 "Liebster Gott, wenn werd ich sterben?" | bach-bwv8 |  | 칸타타 <Liebster Gott, wenn werd ich sterben?> BWV 8 | MBID |
| 15375 | Kantate, BWV 8 appendix "Liebster Gott, wenn werd ich sterben?": IV. A | bach-bwv8 | [4] | 아리아 "Doch weichet, ihr tollen, vergeblichen Sorgen | BWV 8 악장 번호 4 |
| 15626 | Kantate, BWV 80 "Ein feste Burg ist unser Gott" | bach-bwv80 |  | 칸타타 <Ein feste Burg ist unser Gott> BWV 80 | MBID |
| 15447 | Kantate, BWV 80 "Ein feste Burg ist unser Gott": VII. Duetto "Wie seli | bach-bwv80 | [7] | 2중창 "Wie selig sind doch die, die Gott im Munde tr | BWV 80 악장 번호 7 |
| 14227 | Kantate, BWV 81 "Jesus schläft, was soll ich hoffen" | bach-bwv81 |  | 칸타타 <Jesus schläft, was soll ich hoffen?> BWV 81 | MBID |
| 15339 | 칸타타 <나는 만족하나이다> | bach-bwv82 |  | 칸타타 <Ich habe genug> BWV 82 | MBID |
| 14315 | Kantate, BWV 82 appendix "Ich habe genung": III. Aria (Bass) "Schlumme | bach-bwv82 | [3] | 아리아 "Schlummert ein, ihr matten Augen" | BWV 82 악장 번호 3 |
| 15407 | Kantate, BWV 82 "Ich habe genung": V. Aria "Ich freue mich auf meinen  | bach-bwv82 | [5] | 아리아 "Ich freue mich auf meinen Tod" | BWV 82 악장 번호 5 |
| 14580 | Kantate, BWV 83 "Erfreute Zeit im neuen Bunde" | bach-bwv83 |  | 칸타타 <Erfreute Zeit im neuen Bunde> BWV 83 | MBID |
| 14704 | Kantate, BWV 84 "Ich bin vergnügt mit meinem Glücke" | bach-bwv84 |  | 칸타타 <Ich bin vergnügt mit meinem Glücke> BWV 84 | MBID |
| 14626 | Kantate, BWV 85 "Ich bin ein guter Hirt" | bach-bwv85 |  | 칸타타 <Ich bin ein guter Hirt> BWV 85 | MBID |
| 14644 | See What His Love Can Do, from BWV 85 | bach-bwv85 | [5] | 아리아 "Seht, was die Liebe tut" | 번안·다른 언어 제목(원어 seed 없음). 관계(arrangement) → MBID 일치 |
| 14658 | Kantate, BWV 86 "Wahrlich, wahrlich, ich sage euch" | bach-bwv86 |  | 칸타타 <Wahrlich, wahrlich, ich sage euch> BWV 86 | MBID |
| 15098 | Kantate, BWV 87 "Bisher habt ihr nichts gebeten in meinem Namen" | bach-bwv87 |  | 칸타타 <Bisher habt ihr nichts gebeten in meinem Name | MBID |
| 14116 | Kantate, BWV 88 "Siehe, ich will viel Fischer aussenden" | bach-bwv88 |  | 칸타타 <Siehe, ich will viel Fischer aussenden> BWV 8 | MBID |
| 14528 | Kantate, BWV 89 "Was soll ich aus dir machen, Ephraim?" | bach-bwv89 |  | 칸타타 <Was soll ich aus dir machen, Ephraim?> BWV 89 | MBID |
| 14109 | Kantate, BWV 89 "Was soll ich aus dir machen, Ephraim?" (Appendix): I. | bach-bwv89 | [1] | 아리아 "Was soll ich aus dir machen, Ephraim?" | BWV 89 악장 번호 1 |
| 14395 | Kantate, BWV 9 "Es ist das Heil uns kommen her" | bach-bwv9 |  | 칸타타 <Es ist das Heil uns kommen her> BWV 9 | MBID |
| 14890 | Kantate, BWV 90 "Es reißet euch ein schrecklich Ende" | bach-bwv90 |  | 칸타타 <Es reißet euch ein schrecklich Ende> BWV 90 | MBID |
| 14782 | Leit uns mit deiner rechten Hand | bach-bwv90 | [5] | 코랄 "Leit uns mit deiner rechten Hand" | 관계(arrangement) → MBID 일치 |
| 14325 | Kantate, BWV 91 "Gelobet seist du, Jesu Christ" | bach-bwv91 |  | 칸타타 <Gelobet seist du, Jesu Christ> BWV 91 | MBID |
| 15038 | Kantate, BWV 92 "Ich hab in Gottes Herz und Sinn" | bach-bwv92 |  | 칸타타 <Ich hab in Gottes Herz und Sinn> BWV 92 | MBID |
| 15419 | Kantate, BWV 93 "Wer nur den lieben Gott läßt walten" | bach-bwv93 |  | 칸타타 <Wer nur den lieben Gott läßt walten> BWV 93 | MBID |
| 14279 | Sing, Pray, and Walk | bach-bwv93 | [7] | 코랄 "Sing, bet und geh auf Gottes Wegen" | 번안·다른 언어 제목(원어 seed 없음). 관계(arrangement) → MBID 일치 |
| 15185 | Kantate, BWV 94 "Was frag ich nach der Welt" | bach-bwv94 |  | 칸타타 <Was frag ich nach der Welt> BWV 94 | MBID |
| 15313 | Kantate, BWV 95 "Christus, der ist mein Leben" | bach-bwv95 |  | 칸타타 <Christus, der ist mein Leben> BWV 95 | MBID |
| 14898 | Kantate, BWV 96 "Herr Christ, der einge Gottessohn" | bach-bwv96 |  | 칸타타 <Herr Christ, der einge Gottessohn> BWV 96 | MBID |
| 14584 | Choralsatz "Herr Christ, der einig' Gott's Sohn" | bach-bwv96 | [6] | 코랄 "Ertöt uns durch dein Güte" | 다른 가사의 같은 코랄 화성(MB other version). 관계(other version) → MBID 일치 |
| 14775 | Kantate, BWV 97 "In allen meinen Taten" | bach-bwv97 |  | 칸타타 <In allen meinen Taten> BWV 97 | MBID |
| 14824 | Kantate, BWV 98 "Was Gott tut, das ist wohlgetan" | bach-bwv98 |  | 칸타타 <Was Gott tut, das ist wohlgetan> BWV 98 | MBID |
| 13862 | Kantate, BWV 99 "Was Gott tut, das ist wohlgetan" | bach-bwv99 |  | 칸타타 <Was Gott tut, das ist wohlgetan> BWV 99 | MBID |
| 15124 | Kantate, BWV 99 "Was Gott tut, das ist wohl getan": I. Coro "Was Gott  | bach-bwv99 | [1] | 합창 "Was Gott tut, das ist wohlgetan" | BWV 99 악장 번호 1 |

unmatched 가운데 duplicate·hymn_translation(같은 자리를 다른 seed 가 차지)은 `seed_map.json` 의 note 에 자리 seed 를 적었다.

기존 seed part 가운데 catalog part 와 MBID 가 안 맞아 남는 것(자리 seed 기준):

| key | seed id | 안 맞는 seed part / 전체 | 까닭 |
|---|---:|---|---|
| bach-bwv1127 | 15287 | 12 / 12 | 12절 유절 아리아라 part 없이 낱곡으로 둠 |
| bach-bwv127 | 15057 | 1 / 5 | MB 부록(App.) 합창 뺌 |
| bach-bwv162 | 15233 | 2 / 8 | MB 부록(alt) 악장 2개 뺌 |
| bach-bwv207 | 15331 | 1 / 10 | MB 부록(Anhang) 행진곡 뺌 |
| bach-bwv243 | 15653 | 3 / 13 | MB 가 BWV 243 에 붙인 성탄 삽입곡 3개(실제로는 243a 의 곡) 뺌 |
| bach-bwv248 | 13770 | 1 / 58 | MB 의 24번 다 카포 반복 항목 뺌 |
| bach-bwv36b | 14008 | 4 / 4 | MB 악장 자료가 짝수 번 레치타티보 4개뿐이라 낱곡으로 둠 |
| bach-bwv63 | 14670 | 1 / 8 | MB 부록(alt) 2중창 뺌 |

## 3. 뺀 것과 까닭

칸타타 장(BWV2a 1장) 행 가운데 뺀 것(위키 행 단위):

| BWV(위키 표기) | 까닭 | 설명 |
|---|---|---|
| 4.1 | lost | BWV 4 의 첫 판(1707), 악보 소실 |
| 34.2 | fragment | BWV 34a 혼례 칸타타, 일부만 전함 |
| 36.2 | lost | BWV 36a <Steigt freudig in die Luft>, 음악 소실 |
| 66.1 | lost | BWV 66a <Der Himmel dacht auf Anhalts Ruhm und Glück>, 음악 소실(BWV 66 으로 복원) |
| 70.1 | lost | BWV 70a(대림절 판), 음악 일부만 BWV 70 에 남음 |
| 80.1 | lost | BWV 80a <Alles, was von Gott geboren>, 음악 소실 |
| 82.3 | version | BWV 82 의 3번째 판(악보 출처 없음) |
| 120.2 | fragment | BWV 120a <Herr Gott, Beherrscher aller Dinge>, 일부 소실 |
| 120.3 | lost | BWV 120b, 음악 소실 |
| 147.1 | lost | BWV 147a(대림절 판), 음악 일부만 BWV 147 에 남음 |
| 184.1 | fragment | BWV 184a 세속 칸타타, 일부만 전함 |
| 186.1 | fragment | BWV 186a(대림절 판), 일부만 전함 |
| 190.2 | fragment | BWV 190a(아우크스부르크 신앙고백 200주년), 음악 일부만 전함 |
| 193.1 | fragment | BWV 193a <Ihr Häuser des Himmels>, 일부만 전함 |
| 194.1 | fragment | BWV 194a 세속 칸타타 원형, 일부만 전함 |
| 195.1 | lost | BWV 195 의 첫 판, 소실 |
| 197.1 | fragment | BWV 197a <Ehre sei Gott in der Höhe>, 일부만 전함 |
| 200 | arrangement | BWV 200 아리아, 슈퇴르첼 수난 오라토리오의 아리아를 바흐가 옮겨 적은 것 |
| 205.2 | lost | BWV 205a <Blast Lärmen, ihr Feinde>, 음악 소실 |
| 210.1 | fragment | BWV 210a <O angenehme Melodei>, 일부만 전함 |
| 216.1 | fragment | BWV 216 <Vergnügte Pleißenstadt>, 일부만 전함 |
| 216.2 | fragment | BWV 216a <Erwählte Pleißenstadt>, 일부만 전함 |

그 밖의 성악 작품:

- 위작·진위 의심(부록 II·III 포함): 칸타타 BWV 15·53·141·142·160·189·217–224, 누가 수난곡 BWV 246, 모테트 BWV 1164(Anh. 159), 수난 파스티치오 아리오소 BWV 1088, 가곡 BWV 515·515a(G. H. 바흐)·519–523(크렙스?), 부록 미사·코랄·가곡(Anh. 24·31·40·41 등).
- 남의 작품을 옮기거나 편곡한 것: BWV 200(슈퇴르첼), 239(칼다라), 241(케를), 508 «Bist du bei mir»(슈퇴르첼), 518(조반니니), 1081(바사니 미사의 크레도 첫머리), 1082(칼다라), 1083 «Tilge, Höchster»(페르골레시 <스타바트 마테르>), 1166 수난 파스티치오.
- 소실: 마가 수난곡 BWV 247, 쾨텐 추도 음악 BWV 244a(=1143), 목자 칸타타 BWV 249a·249b, 그 밖의 소실 칸타타(BWV 1135–1163, 부록 I).
- 단편: BWV 80b, 224, 524 쿼들리벳(앞뒤 없음).
- 다른 번호로 옮겨진 것: BWV 231(→ BWV 28/2a). BWV 11 은 칸타타 장이 아니라 오라토리오로 넣음. BWV 1040(트리오)은 칸타타 장에 있지만 기악이라 기악 쪽 몫.
- 같은 곡의 다른 판은 한 작품으로 합침(BWV3 소수점 판 번호). 합친 판:

  - BWV 8: 8.1, 8.2
  - BWV 18: 18.1, 18.2
  - BWV 21: 21.1, 21.2, 21.3
  - BWV 23: 23.1, 23.2, 23.3
  - BWV 31: 31.1, 31.2
  - BWV 36: 36.4, 36.5
  - BWV 58: 58.1, 58.2
  - BWV 80: 80.2, 80.3
  - BWV 82: 82.1, 82.2, 82.4
  - BWV 91: 91.1, 91.2
  - BWV 130: 130.1, 130.2
  - BWV 134: 134.2, 134.3
  - BWV 157: 157.1, 157.2
  - BWV 161: 161, 161, v2
  - BWV 162: 162.1, 162.2
  - BWV 172: 172.1, 172.2, 172.3
  - BWV 185: 185.1, 185.2
  - BWV 194: 194.2, 194.3, 194.4
  - BWV 195: 195.2, 195.3
  - BWV 199: 199.1, 199.2, 199.3
  - BWV 206: 206.1, 206.2
  - BWV 208: 208.1, 208.2, 208.3
  - BWV 118: 118.1, 118.2
  - BWV 244: 244.1, 244.2
  - BWV 245: 245.1, 245.2, 245.3, 245.4, 245.5
  - BWV 249: 249.3, 249.4, 249.5

- BWV 82a(소프라노 판, BWV3 82.2)는 위키 "List of Bach cantatas" 처럼 BWV 82 에 합침. BWV2a 에서 따로 번호를 받은 30a·36b·36c·69a·134a·173a·207a·243a 는 가사(또는 조·편성·곡 구성)가 달라 따로 넣음.
- MB 자료 때문에 part 없이 둔 것: BWV 36b: MB 악장 자료가 이어지지 않아(번호 [2, 4, 6, 8]) part 없이 낱곡으로 둠

## 4. 애매했던 판단

1. **제목 꼴(리드 지시 반영)**: `칸타타 <Wachet auf, ruft uns die Stimme> BWV 140` — 독일어 원제를 꺾쇠, 끝에 catalogue 와 같은 BWV(생성기가 opus_number 대신 catalogue 칼럼으로 옮김). 별명은 원제와 BWV 사이에 확실한 것만(`칸타타 <Schweigt stille, plaudert nicht> "커피 칸타타" BWV 211`; 커피·농민·사냥·결혼 칸타타, Actus tragicus, Trauer-Ode). 모테트·미사·수난곡·오라토리오·마니피카트·상투스·낱곡 코랄·가곡도 같은 갈래가 여럿이라 끝에 BWV. 운영 seed 14951(BWV 106)·15339(BWV 82)는 편집자가 우리말 제목으로 잠가 둬서 생성기가 제목을 바꾸지 않음.
2. **manual 15 와 seed 13801(마태 수난곡)**: SPEC 은 MBID 가진 쪽을 쓰라고 하지만, seed 를 쓰면 이름이 «마태 수난곡»으로 바뀌어 manual 15 와 같은 제목이 둘이 된다. 설명·링크가 있는 manual 15 에 part 를 붙이고 seed 둘은 duplicate 로 둠. 반대로 하려면 existingPieceId 를 13801 로, MBID 를 다시 넣으면 됨.
3. **manual 432 를 part 에 이음**: «칸타타 BWV 147 중 예수, 인류의 소망의 기쁨»은 SPEC 의 '큰 작품의 대목'이지만 이번에 BWV 147 에 part 가 생기고 MBID 가 X 번 part 와 똑같아 그 part 의 existingPieceId 로 이음(비교 구간이 있는 작품이라 part 에서 바로 들어가게). 같은 대목 seed 20개(독일어 원제·영어 «Jesu, Joy of Man's Desiring» 등)는 duplicate·hymn_translation.
4. **판과 미완성**: BWV3 소수점 판은 한 작품으로 합치고 BWV2a 글자 번호는 따로 둠(82a 만 합침). 미완성이지만 전곡 녹음에서 보충해 연주하는 BWV 190·192·193 과 한 악장짜리 BWV 50 은 넣음(위키 칸타타 목록은 '단편' 색). 반대로 위키 칸타타 목록이 현존으로 세는 BWV 120a(일부 소실)·249a(음악 소실, 부활절 오라토리오로 복원)·1083(페르골레시 편곡)은 뺌.
5. **번안·영어 제목 seed**: seed MB work 는 모두 parts 관계 없는 낱 work 라 MBID 가 part 와 직접 같지 않다. MB 관계(arrangement·other version 등)를 따라가 원곡 악장에 닿으면 part 로 잇되, 한 자리에 하나만: 원어(독일어) seed 가 먼저, 없을 때만 번안 제목 seed. 밀린 번안은 hymn_translation, 원어는 duplicate. 기악 편곡(협주곡·피아노·오르간·리스트 S. 번호)은 arrangement, MB 'based on'·메들리는 popular.
6. **MB 와 위키가 어긋난 곳**: MB 의 'BWV 34.1'·'34.2' 라벨이 위키 BWV3 번호와 반대(34.2 = 성령강림절 칸타타 5악장, 34.1 = 혼례 칸타타 단편). MB work 66148fbd 를 BWV 34 로 직접 지정. BWV 138 은 MB 순서 키가 어긋나 악장 번호 순으로 정렬. 마태 수난곡은 MB 의 Teil I·II 를 펴서 1–68번을 part 로, a–e 하위 번호는 children 으로(두 겹). 요한 수난곡 40번·크리스마스 오라토리오 64번·미사 B단조 27번도 번호 part(movementNumber 없음, 화면에 '1.' 꼴). 칸타타·루터 미사·마니피카트·모테트·승천절·부활절 오라토리오는 악장(로마 숫자).
7. **4성부 코랄 묶음 이름**: 같은 찬송 첫머리가 여러 번 나와(19개) 그 곡들만 이름 뒤에 조성을 붙임(예: `Befiehl du deine Wege (A단조)`). part 마다 catalogueAlt 에 BWV 번호. BWV 299 는 위키에 [1]·[2] 두 행이라 한 part 로.

## 5. 직접 옮긴 우리말 이름(검수용)

- 작품 제목: 4성부 코랄 BWV 250–438, 쉬멜리 찬송가집 BWV 439–507, 크리스마스 오라토리오, 부활절 오라토리오, 승천절 오라토리오, 요한 수난곡, 미사 B단조, 미사 F장조·A장조·G단조·G장조, 마니피카트 D장조·E♭장조, 상투스 C장조·D장조·G장조, 키리에 F장조, 크리스테 엘레이손 G단조, 모테트·코랄·가곡·아리아 <원제>.
- 별명: 커피 칸타타(BWV 211), 농민 칸타타(212), 사냥 칸타타(208), 결혼 칸타타(202).
- 악장 갈래어: 합창(Coro·Chor·Chorus), 코랄(Choral·Chorale·Corale), 아리아(Aria·Arie), 레치타티보(Recitativo·Rezitativ·Accompagnato), 아리오소, 2중창(Duetto·Duett·Aria duetto), 3중창(Terzetto), 4중창, 신포니아, 소나타, 소나티나, 리토르넬로, 푸가, 행진곡(Marche), 서곡(Ouvertüre), 가보트, 독창(Basso solo). 두 갈래가 함께면 `코랄과 레치타티보`처럼 이음. 갈래어 없이 배역만 있는 수난곡 번호는 복음사가 → 레치타티보, Chori → 합창으로 채움.
- 미사 악장: 키리에, 크리스테, 글로리아, 크레도, 상투스, 호산나, 호산나(반복), 베네딕투스, 아뉴스 데이. 나머지 라틴어 가사는 원문 그대로.

## 6. 위키백과 대조

- "List of Bach cantatas" 254행과 대조: 현존 칸타타(교회 190·세속 23) 가운데 카탈로그에 없는 것 3개 — BWV 120a, BWV 249a, BWV 1083(4절 4번).
- 그 목록에서 칸타타가 아니거나 단편 색인데 카탈로그에 있는 것: BWV 11(칸타타 아님), BWV 50(단편), BWV 118(칸타타 아님), BWV 190(단편), BWV 192(단편), BWV 193(단편). 11 은 오라토리오, 118 은 모테트로 넣음.
- 4성부 코랄: 위키 표 BWV 250–438 의 번호 189개 모두 part(위키 행은 210개 — 한 번호에 판·가사가 둘인 행 포함). 189개 모두 MB work 연결.
- 쉬멜리: BWV 439–507 69곡 모두 part, MB 연결 69/69.
- 모테트 225–230·118, 미사 232–236, 미사 단장 233a·237·238·240·242, 마니피카트 243·243a, 수난곡 244·245, 오라토리오 248·249·11: 위키 표와 번호 일치.
- 악장 수·이름은 위키 표에 없어서 MB parts 로만 만들었다. MB 순서 키·번호 이상은 build_notes.json 에 남김: BWV 63: MB 하위 work 뺌(부록·이본·반복) — Kantate, BWV 63 (appendix) "Christen, ätzet diesen Tag": III(alt). Duet (Soprano & Bass) "Gott, du hast es wohl gefüget"; BWV 127: MB 하위 work 뺌(부록·이본·반복) — Kantate, BWV 127 "Herr Jesu Christ, wahr' Mensch und Gott": App. Coro "Herr Jesu Christ, wahr' Mensch und Gott"; BWV 138: MB 순서 키 대신 악장 번호 순으로 정렬; BWV 162: MB 하위 work 뺌(부록·이본·반복) — Kantate, BWV 162 (appendix) "Ach! ich sehe, itzt, da ich zur Hochzeit gehe": I(alt). Aria (Bass) "Ach! ich sehe, itzt, da ich zur Hochzeit gehe"; BWV 162: MB 하위 work 뺌(부록·이본·반복) — Kantate, BWV 162 (appendix) "Ach! ich sehe, itzt, da ich zur Hochzeit gehe": VI(alt). Choral "Ach, ich habe schon erblicket"; BWV 207: MB 하위 work 뺌(부록·이본·반복) — Kantate, BWV 207 "Vereinigte Zwietracht der wechselnden Saiten": Anhang: Marche; BWV 243: MB 하위 work 뺌(부록·이본·반복) — Magnificat in D major, BWV 243: III. Choral Interpolation "Vom Himmel hoch"; BWV 243: MB 하위 work 뺌(부록·이본·반복) — Magnificat in D major, BWV 243: VII. Choral Interpolation "Freut euch und jubiliert"; BWV 243: MB 하위 work 뺌(부록·이본·반복) — Magnificat in D major, BWV 243: X. Choral Interpolation "Gloria in excelsis Deo"; BWV 244: 번호 없는 MB 하위 work 뺌 — Matthäus-Passion, BWV 244: Second Part. No. 67 Recitative: “Und da wurden zween Mörder” (Evangelist, chorus); BWV 248: MB 하위 work 뺌(부록·이본·반복) — Weihnachts-Oratorium, BWV 248: Teil III, XXIV (da capo). Coro da capo „Herrscher des Himmels, erhöre das Lallen“

