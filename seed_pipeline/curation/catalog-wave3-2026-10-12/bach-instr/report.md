# 바흐 기악 작품 목록 — 묶음·다악장·낱곡 정리와 seed 대응 보고

데이터만 만들었습니다(DB·git·브라우저 안 씀). 결과는 `catalog.json`·`seed_map.json`, 원자료와 중간 산출물은 `raw/`, 스크립트는 `scripts/` 입니다. 성악(BWV 1–524 등)은 cat3-bach-vocal 이 맡고, 이 보고는 기악만 다룹니다.

- 위키백과: `List of compositions by Johann Sebastian Bach` 가 갈래별 문서를 끼워 넣는 꼴이라, 그 문서들(오르간·건반과 류트·실내악·관현악·푸가(카논·음악의 헌정·푸가의 기법)·`Bach-Werke-Verzeichnis`(BWV3 새 번호)·`BWV Anh.`)의 표(`<onlyinclude>`)와 글머리 목록을 풀었습니다. 원문 `raw/wiki/`, 표 `raw/wiki_rows.json`, 글머리 `raw/wiki_bullets.json`.
- MusicBrainz: 바흐 artist(24f1766e…) work 8,418개를 browse(`inc=aliases+work-rels`, 100개씩 85번, 성악 에이전트와 반씩 나눠 받음)로 받았습니다(`raw/browse.json`). 낱개 조회는 browse 에 없던 seed MBID 11개(모두 다른 work 로 병합된 것)만 했습니다(`raw/mb_single_lookups.json`).
- 순서: `wikiparse.py` → `mbindex.py`(BWV 번호별 MB 후보·원곡다움 점수) → `build.py`(넣을 것·묶음·이름, `defs.py` 표) → `seedmap.py`(seed 대응, 손 판정은 `seed_manual.py`) → `finalize.py`(manual 잇기·제목 겹침 풀기) → `check.py`(검사·위키 대조) → `report.py`.
- 리드 3차 생성기 `wave3/gen/gen_catalog.py` 를 seed_pipeline 의 `uv run python` 으로 `--seed-map seed_map.json` 을 붙여 돌려 오류 없이 통과했습니다: `{"pieces": 84, "parts": 573, "children": 384, "linked": 86, "updated_parts": 0, "existing_pieces": 165, "retitled_seed": 246}` (출력 `gen_test.sql`).
- 성악 seed_map 과 합친 `--hide-only` 시험도 통과했습니다: `{"seed_pieces": 1686, "seed_map_entries": 1686}`(두 seed_map 합집합 1,686, 겹침 0, 성악 쪽과 대조 끝). 찬송 번안 7행·Anh. 31 코랄 1행(14320·14335·14791·14853·14961·15131·15543·15637)은 성악 쪽이 빼서 이 seed_map 에만 있습니다. `excerpt_keep` 은 기악에 해당 없음(대목을 가리키는 seed 는 모두 part 로 이었습니다).

## 1. 개수

| 갈래 | 작품 | part | children |
|---|---:|---:|---:|
| 묶음(collection) | 20 | 280 | 384 |
| 다악장(multi_movement) | 84 | 293 | 0 |
| 낱곡(single) | 145 | 0 | 0 |
| 합계 | 249 | 573 | 384 |

갈래별 작품 수: 코랄 전주곡(낱곡·묶음) 87, 건반(전주곡·푸가·토카타 등, 평균율·인벤션·음악의 헌정·푸가의 기법 포함) 76, 오르간 자유곡(전주곡과 푸가 등) 38, 협주곡·행진곡 18, 실내악 13, 카논 9, 건반 모음곡 묶음(영국·프랑스·파르티타) 3, 오르간 트리오 소나타 묶음 1, 무반주 바이올린 1, 무반주 첼로 1, 바이올린 소나타 묶음 1, 관현악 모음곡 묶음 1.

MBID: 작품 240/249(없는 7개는 MB 에 묶음 work 가 없는 <오르겔뷔흘라인>·<라이프치히 코랄>·<클라비어위붕 3권>·인벤션과 신포니아·작은 전주곡 BWV 933–938·바이올린과 하프시코드 소나타 BWV 1014–1019·관현악 모음곡 묶음), part 572/573(없는 1개는 <음악의 헌정> 트리오 소나타 묶음 노드, 그 아래 악장 4개는 MBID 있음), children 384/384. authenticity 는 모두 authentic(진위 의심은 뺌), 진위 물음표가 남은 작품은 `note` 에 적었습니다.

seed 대응: 운영 바흐 seed 작품 1686개 가운데 기악·잡음 941개를 `seed_map.json` 에 적고, 성악 745개는 적지 않았습니다(목록 `raw/vocal_handoff.json`, 성악 에이전트에 공유).

| 대응 | 개수 |
|---|---:|
| work | 161 |
| part | 86 |
| unmatched — arrangement(남의 편곡·다른 편성·현대 복원 판) | 396 |
| unmatched — spurious(위작·진위 의심, Emans 판 등 BWV 밖 코랄 포함) | 106 |
| unmatched — excluded_scope(옛 판·다른 판, 바흐의 남의 작품 편곡) | 79 |
| unmatched — popular(대중음악·게임·패러디) | 43 |
| unmatched — unknown(원곡을 하나로 못 정함) | 37 |
| unmatched — fragment(단편·미완성) | 10 |
| unmatched — hymn_translation(다른 언어 찬송 번안) | 9 |
| unmatched — other_composer(남의 곡) | 7 |
| unmatched — duplicate(운영 중복 행) | 7 |
| 합계 | 941 |

- work/part 근거: MBID 같음 227개(그중 병합된 work 로 맞춘 것 11개), BWV 번호(+악장 제목) 13개, 제목만 7개(근거는 각 행 note).
- arrangement 가 많은 까닭: 국제 seed 가 편곡 음반에서 들어와 MB 편곡 work(리히터 피아노 4손 <오르겔뷔흘라인>, 부소니·리스트·스토코프스키 편곡, MB 'catch-all for arrangements' work, 플루트 앙상블 'Arr. Pour Flutes' 등)를 가리키는 행이 대부분입니다. MB 관계(편곡·관현악 편곡·바탕)와 설명·제목의 편곡 표시로 가렸고, 원곡이 카탈로그에 있으면 note 에 원곡 key·경로를 적었습니다.

## 2. 운영 기존 작품 대응표

### manual 작품

| id | 운영 제목 | → key | 근거 |
|---:|---|---|---|
| 12 | 무반주 첼로 모음곡 | `bach-bwv1007-1012` | MBID 4e4b97df(Six Suites for Unaccompanied Cello) |
| 16 | 토카타와 푸가 D단조 | `bach-bwv565` | 카탈로그 번호(BWV 565). 운영에 MBID 가 없어 생성기가 c4f0bd0a 를 더함 |
| 13 | 무반주 바이올린 소나타와 파르티타 | `bach-bwv1001-1006` | 카탈로그 번호(BWV 1001–1006). 묶음 MBID 4a8c18a0 은 중복 seed 14554 가 쥐고 있어 catalog mbid 를 비움 |
| 14 | 브란덴부르크 협주곡 | `bach-brandenburg` | 카탈로그 번호(BWV 1046–1051). 묶음 MBID 7481c7f5 는 중복 seed 13869 가 쥐고 있어 catalog mbid 를 비움 |
| 10 | 평균율 클라비어곡집 (1권&2권) | — | 잇지 않음: 평균율 1·2권을 한데 묶은 작품: 1권(bach-wtc-1)·2권(bach-wtc-2)을 따로 넣고 잇지 않음 |
| 11 | 골든베르크 변주곡 | — | 잇지 않음: 「골든베르크 변주곡」(오타): MBID 를 가진 seed 461 이 bach-bwv988 에 이어짐, 운영 중복 |
| 15 | 마태 수난곡 | — | 잇지 않음: 마태 수난곡: 성악(성악 에이전트 몫) |
| 431 | 관현악 모음곡 3번 D장조 중 "G선상의 아리아" | — | 잇지 않음: 「관현악 모음곡 3번 D장조 중 "G선상의 아리아"」: 큰 작품의 한 대목을 따로 둔 운영 작품이라 그대로 둠 |
| 432 | 칸타타 BWV 147 "예수, 인류의 소망의 기쁨" | — | 잇지 않음: 칸타타 BWV 147 대목: 성악(성악 에이전트 몫) |

네 manual 작품은 제목을 운영과 똑같이 두었습니다(「무반주 첼로 모음곡」「토카타와 푸가 D단조」「무반주 바이올린 소나타와 파르티타」「브란덴부르크 협주곡」).

### 운영 중복 작품

- 브란덴부르크 협주곡: manual 14(MBID 없음, 설명·링크 있음) ↔ seed 13869 「Six concerts avec plusieurs instruments」(MBID 7481c7f5). 리드 지시로 manual 14 를 `bach-brandenburg` 자리로 쓰고(다른 작곡가의 manual 중복과 같은 처리) 묶음 mbid 는 비웠습니다. seed 13869 는 duplicate.
- 무반주 바이올린 소나타와 파르티타: manual 13(MBID 없음) ↔ seed 14554(MBID 4a8c18a0). 같은 방식으로 manual 13 → `bach-bwv1001-1006`, 묶음 mbid 비움, seed 14554 는 duplicate.
- 골드베르크 변주곡: manual 11 「골든베르크 변주곡」(오타, MBID 없음) ↔ seed 461 「골드베르크 변주곡 BWV 988」(MBID 1d51e560, 비교 구간 2). seed 461 → `bach-bwv988`(제목 「골드베르크 변주곡」, manual 11 과 글자가 달라 겹치지 않음).
- 무반주 첼로 모음곡: manual 12(MBID 있음) ↔ seed 13814 「Six Suites for Unaccompanied Cello」(MBID 없음) → 12 를 잇고 13814 는 duplicate.
- 평균율: manual 10 「평균율 클라비어곡집 (1권&2권)」(1·2권 전체 MBID bd511c33) ↔ seed 13964 「The Well-Tempered Clavier」(MBID 없음). 1·2권을 따로 넣어 둘 다 잇지 않았고 13964 는 duplicate.
- 대목 작품: manual 431 「관현악 모음곡 3번 D장조 중 "G선상의 아리아"」는 명세대로 그대로 두고 `bach-orchestral-suites` 3번 2악장 part 에 잇지 않았습니다.

### seed 대응(work·part 전부)

| seed id | 운영 제목 | 대응 | 위치 | 근거 |
|---:|---|---|---|---|
| 461 | 골드베르크 변주곡 BWV 988 | work | `bach-bwv988`  골드베르크 변주곡 | MBID |
| 13720 | Helft mit Gotts Güte preisen, BWV 613 | part | `bach-orgelbuchlein` [15] 코랄 전주곡집 <오르겔뷔흘라인> › Helft mir Gotts Güte preisen | MBID |
| 13723 | Präludium d-Moll, BWV 940 | work | `bach-bwv940`  전주곡 D단조 BWV 940 | MBID |
| 13725 | Präludium und Fuge C-Dur, BWV 545.3/545 | work | `bach-bwv545`  전주곡과 푸가 C장조 BWV 545 | MBID |
| 13727 | Choralvorspiele für Orgel in F-Dur, BWV 651 "Fantasia super: Komm heiliger Geist, Herre Gott" | part | `bach-leipzig-chorales` [1] 코랄 전주곡집 <라이프치히 코랄> › Komm, heiliger Geist, Herre Gott (환상곡) | MBID |
| 13732 | Präludium a-Moll, BWV 569 | work | `bach-bwv569`  전주곡 A단조 BWV 569 | MBID |
| 13733 | Vor deinen Thron tret ich hiermit, BWV 668.2 | part | `bach-leipzig-chorales` [18] 코랄 전주곡집 <라이프치히 코랄> › Vor deinen Thron tret ich hiermit | MBID |
| 13738 | Fantasie g-Moll, BWV 917 | work | `bach-bwv917`  환상곡 G단조 | MBID |
| 13739 | Sinfonia Nr. 13 a-Moll, BWV 799 | part | `bach-bwv772-801` [28] 인벤션과 신포니아 › 신포니아 13번 A단조 | MBID |
| 13753 | Chorale Prelude, Jesus Christus, unser Heiland, BWV 626 | part | `bach-orgelbuchlein` [28] 코랄 전주곡집 <오르겔뷔흘라인> › Jesus Christus, unser Heiland, der den Tod überwand | MBID |
| 13754 | 9 kleine Präludien: Präludium F-Dur, BWV 927 | work | `bach-bwv927`  전주곡 F장조 BWV 927 | MBID |
| 13756 | Wie schön leuchtet der Morgenstern, BWV 739 | work | `bach-bwv739`  코랄 전주곡 <Wie schön leuchtet der Morgenstern> | MBID |
| 13761 | Präludium und Fuge g-Moll, BWV 535 | work | `bach-bwv535`  전주곡과 푸가 G단조 | MBID |
| 13762 | Alle Menschen müssen sterben, BWV 1117 | work | `bach-bwv1117`  코랄 전주곡 <Alle Menschen müssen sterben> | MBID |
| 13766 | Fantasie und Fuge a-Moll, BWV 944 | work | `bach-bwv944`  환상곡과 푸가 A단조 BWV 944 | MBID |
| 13767 | Choralbearbeitung, BWV 674 "Kyrie, Gott heiliger Geist" | part | `bach-clavier-ubung-3` [6] 오르간 작품집 <클라비어위붕 3권> › Kyrie, Gott heiliger Geist (manualiter) | MBID |
| 13774 | Präludium a-Moll, BWV 942 | work | `bach-bwv942`  전주곡 A단조 BWV 942 | MBID |
| 13780 | Allein Gott in der Höh sei Ehr, BWV 717 | work | `bach-bwv717`  코랄 전주곡 <Allein Gott in der Höh sei Ehr> BWV 717 | MBID |
| 13781 | Toccata G-Dur, BWV 916 | work | `bach-bwv916`  토카타 G장조 | MBID |
| 13787 | Fantasia super "Jesu, meine Freude", BWV 713 | work | `bach-bwv713`  코랄 전주곡 <Jesu, meine Freude> BWV 713 | MBID |
| 13789 | Sechs Choräle von verschiedener Art | work | `bach-schubler`  코랄 전주곡집 <쉬블러 코랄> | MBID |
| 13792 | Ach Herr, mich armen Sünder, BWV 742 | work | `bach-bwv742`  코랄 전주곡 <Ach Herr, mich armen Sünder> | MBID |
| 13794 | Fuge C-Dur, BWV 952 | work | `bach-bwv952`  푸가 C장조 BWV 952 | MBID |
| 13795 | Fuge c-Moll (über ein Thema von Giovanni Legrenzi), BWV 574 | work | `bach-bwv574`  레그렌치 주제에 의한 푸가 C단조 | MBID |
| 13798 | Werde munster, mein Gemüte, BWV 1118 | work | `bach-bwv1118`  코랄 전주곡 <Werde munter, mein Gemüte> | MBID |
| 13800 | Christ, der du bist der helle Tag, BWV 1120 | work | `bach-bwv1120`  코랄 전주곡 <Christ, der du bist der helle Tag> | MBID |
| 13806 | 6 kleine Präludien: Präludium e-Moll, BWV 938 | part | `bach-bwv933-938` [6] 작은 전주곡 BWV 933–938 › E단조 | MBID |
| 13809 | Quatorze Canons, BWV 1087 | work | `bach-bwv1087`  골드베르크 저음 주제에 의한 14개의 카논 | MBID |
| 13810 | Christum sollen wir loben schon, BWV 696 | work | `bach-bwv696`  코랄 전주곡 <Christum wir sollen loben schon> | MBID |
| 13811 | Valet will ich dir geben (fantasia super), BWV 735.2 | work | `bach-bwv735`  코랄 전주곡 <Valet will ich dir geben> BWV 735 | MBID |
| 13819 | Sonate für Violine und Cembalo G-dur, BWV 1019.3 | part | `bach-bwv1014-1019` [6] 바이올린과 하프시코드를 위한 소나타 BWV 1014–1019 › 소나타 6번 G장조 | MBID |
| 13822 | Choralbearbeitung, BWV 675 "Allein Gott in der Höh sei Ehr" | part | `bach-clavier-ubung-3` [7] 오르간 작품집 <클라비어위붕 3권> › Allein Gott in der Höh sei Ehr | MBID |
| 13824 | Fuge nach Tomaso Albinoni A-Dur, BWV 950 | work | `bach-bwv950`  알비노니 주제에 의한 푸가 A장조 BWV 950 | MBID |
| 13827 | Fuge für Orgel c-Moll, BWV 575 | work | `bach-bwv575`  푸가 C단조 | MBID |
| 13828 | Choralvorspiele für Orgel in g-Moll, BWV 624 “Hilf Gott, daß mir’s gelinge” | part | `bach-orgelbuchlein` [26] 코랄 전주곡집 <오르겔뷔흘라인> › Hilf Gott, dass mir's gelinge | MBID |
| 13830 | Choralvorspiele für Orgel in G-Dur, BWV 667 "Komm, Gott Schöpfer, heiliger Geist" | part | `bach-leipzig-chorales` [17] 코랄 전주곡집 <라이프치히 코랄> › Komm, Gott Schöpfer, heiliger Geist | MBID |
| 13835 | Erschienen ist der herrliche Tag, BWV 629 | part | `bach-orgelbuchlein` [31] 코랄 전주곡집 <오르겔뷔흘라인> › Erschienen ist der herrliche Tag | MBID |
| 13836 | Choralbearbeitung, BWV 682 "Vater unser im Himmelreich" | part | `bach-clavier-ubung-3` [14] 오르간 작품집 <클라비어위붕 3권> › Vater unser im Himmelreich | MBID |
| 13838 | Ach Gott, tu dich erbarmen, BWV 1109 | work | `bach-bwv1109`  코랄 전주곡 <Ach Gott, tu dich erbarmen> | MBID |
| 13844 | Choralvorspiele für Orgel in e-Moll, BWV 666 "Jesus Christus, unser Heiland - Alio modo" | part | `bach-leipzig-chorales` [16] 코랄 전주곡집 <라이프치히 코랄> › Jesus Christus, unser Heiland (alio modo) | MBID |
| 13845 | Mit Fried und Freud ich fahr dahin, BWV 616 | part | `bach-orgelbuchlein` [18] 코랄 전주곡집 <오르겔뷔흘라인> › Mit Fried und Freud ich fahr dahin | MBID |
| 13848 | 6 kleine Präludien: Präludium E-Dur, BWV 937 | part | `bach-bwv933-938` [5] 작은 전주곡 BWV 933–938 › E장조 | MBID |
| 13850 | Gott, durch deine Güte (Gottes Sohn ist kommen), BWV 724 | work | `bach-bwv724`  코랄 전주곡 <Gott durch deine Güte> | MBID |
| 13851 | 6 kleine Präludien: Präludium C-Dur, BWV 933 | part | `bach-bwv933-938` [1] 작은 전주곡 BWV 933–938 › C장조 | MBID |
| 13852 | Was Gott tut, das ist wohlgetan, BWV 1116 | work | `bach-bwv1116`  코랄 전주곡 <Was Gott tut, das ist wohlgetan> | MBID |
| 13853 | Choralbearbeitung, BWV 673 "Christe, aller Welt Trost" | part | `bach-clavier-ubung-3` [5] 오르간 작품집 <클라비어위붕 3권> › Christe, aller Welt Trost (manualiter) | MBID |
| 13854 | Fuge a-Moll, BWV 947 | work | `bach-bwv947`  푸가 A단조 BWV 947 | MBID |
| 13857 | Präludium und Fuge c-Moll, BWV 549 | work | `bach-bwv549`  전주곡과 푸가 C단조 BWV 549 | MBID |
| 13858 | Choräle, BWV 730 "Liebster Jesu, wir sind hier" | work | `bach-bwv730`  코랄 전주곡 <Liebster Jesu, wir sind hier> BWV 730 | MBID |
| 13859 | Ach Gott und Herr, BWV 714 | work | `bach-bwv714`  코랄 전주곡 <Ach Gott und Herr> | MBID |
| 13861 | Der Tag, der ist so freudenreich, BWV 719 | work | `bach-bwv719`  코랄 전주곡 <Der Tag, der ist so freudenreich> | MBID |
| 13863 | Choralvorspiele für Orgel in a-Moll, BWV 625 "Christ lag in Todesbanden" | part | `bach-orgelbuchlein` [27] 코랄 전주곡집 <오르겔뷔흘라인> › Christ lag in Todesbanden | MBID |
| 13866 | Fantasie und Fuge c-Moll, BWV 906 | work | `bach-bwv906`  환상곡과 푸가 C단조 BWV 906 | MBID |
| 13868 | Christ lag in Todes Banden, BWV 718 | work | `bach-bwv718`  코랄 전주곡 <Christ lag in Todesbanden> BWV 718 | MBID |
| 13871 | Wie nach einer Wasserquelle, BWV 1119 | work | `bach-bwv1119`  코랄 전주곡 <Wie nach einer Wasserquelle> | MBID |
| 13875 | Fantasia super: Christ lag in Todesbanden, BWV 695 | work | `bach-bwv695`  코랄 전주곡 <Christ lag in Todesbanden> BWV 695 | MBID |
| 13877 | O Herre Gott, dein göttlich Wort, BWV 1110 | work | `bach-bwv1110`  코랄 전주곡 <O Herre Gott, dein göttlich Wort> | MBID |
| 13879 | In dich hab ich gehoffet, Herr, BWV 640 | part | `bach-orgelbuchlein` [42] 코랄 전주곡집 <오르겔뷔흘라인> › In dich hab ich gehoffet, Herr | MBID |
| 13883 | Dies sind die heil’gen zehn Gebot’, BWV 635 | part | `bach-orgelbuchlein` [37] 코랄 전주곡집 <오르겔뷔흘라인> › Dies sind die heilgen zehn Gebot | MBID |
| 13888 | Konzert für Violine und Orchester E-Dur, BWV 1042 | work | `bach-bwv1042`  바이올린 협주곡 2번 E장조 | MBID |
| 13891 | Christus, der uns selig macht, BWV 747 | work | `bach-bwv747`  코랄 전주곡 <Christus, der uns selig macht> | MBID |
| 13892 | Pastorale F-Dur / Pastorella F-Dur, BWV 590 | work | `bach-bwv590`  파스토렐라 F장조 | MBID |
| 13893 | Sechs Sonaten, BWV 525-530 | work | `bach-bwv525-530`  오르간 트리오 소나타 BWV 525–530 | MBID |
| 13896 | Erstanden ist der heilge Christ, BWV 628 | part | `bach-orgelbuchlein` [30] 코랄 전주곡집 <오르겔뷔흘라인> › Erstanden ist der heilge Christ | MBID |
| 13898 | Choralbearbeitung, BWV 683 "Vater unser im Himmelreich" | part | `bach-clavier-ubung-3` [15] 오르간 작품집 <클라비어위붕 3권> › Vater unser im Himmelreich (manualiter) | MBID |
| 13899 | Choralvorspiel, BWV 605 "Der Tag, der ist so freudenreich" | part | `bach-orgelbuchlein` [7] 코랄 전주곡집 <오르겔뷔흘라인> › Der Tag, der ist so freudenreich | MBID |
| 13901 | Partite diverse sopra "Sei gegrüßet, Jesu gütig", BWV 768.2 | work | `bach-bwv768`  코랄 파르티타 <Sei gegrüßet, Jesu gütig> | MBID |
| 13906 | Choralvorspiele für Orgel in e-Moll, BWV 665 "Jesus Christus, unser Heiland" | part | `bach-leipzig-chorales` [15] 코랄 전주곡집 <라이프치히 코랄> › Jesus Christus, unser Heiland | MBID |
| 13908 | Machs mit mir, Gott, nach deiner Güt, BWV 957 | work | `bach-bwv957`  코랄 전주곡 <Machs mit mir, Gott, nach deiner Güt> | MBID |
| 13910 | Liebster Jesu, wir sind hier, BWV 633 | part | `bach-orgelbuchlein` [36] 코랄 전주곡집 <오르겔뷔흘라인> › Liebster Jesu, wir sind hier (distinctus) | MBID |
| 13911 | Choralvorspiel, BWV 609 "Lobt Gott, ihr Christen allzugleich" | part | `bach-orgelbuchlein` [11] 코랄 전주곡집 <오르겔뷔흘라인> › Lobt Gott, ihr Christen allzugleich | MBID |
| 13912 | Nun komm, der Heiden Heiland, BWV 659.2 | part | `bach-leipzig-chorales` [9] 코랄 전주곡집 <라이프치히 코랄> › Nun komm, der Heiden Heiland | MBID |
| 13913 | Präludium (Toccata) und Fuge für Orgel E-Dur, BWV 566 | work | `bach-bwv566`  전주곡(토카타)과 푸가 E장조 | MBID |
| 13914 | Choralvorspiel, BWV 677: Fughetta super "Allein Gott in der Höh sei Ehr" | part | `bach-clavier-ubung-3` [9] 오르간 작품집 <클라비어위붕 3권> › Allein Gott in der Höh sei Ehr (푸게타, manualiter) | MBID |
| 13919 | Fuge nach Tomaso Albinoni C-Dur, BWV 946 | work | `bach-bwv946`  알비노니 주제에 의한 푸가 C장조 | MBID |
| 13920 | Nun laßt uns den Leib begraben, BWV 1111 | work | `bach-bwv1111`  코랄 전주곡 <Nun lasset uns den Leib begraben> | MBID |
| 13922 | Ach Gott, vom Himmel sieh' darein, BWV 741 | work | `bach-bwv741`  코랄 전주곡 <Ach Gott, vom Himmel sieh darein> | MBID |
| 13923 | Fantasie (Praeludium) und Fuge g-Moll, BWV 542 | work | `bach-bwv542`  환상곡과 푸가 G단조 | MBID |
| 13924 | 9 kleine Präludien: Präludium D-Dur, BWV 925 | work | `bach-bwv925`  전주곡 D장조 | MBID |
| 13928 | Choralbearbeitung, BWV 685 "Christ, unser Herr, zum Jordan kam" | part | `bach-clavier-ubung-3` [17] 오르간 작품집 <클라비어위붕 3권> › Christ unser Herr zum Jordan kam (manualiter) | MBID |
| 13932 | Ich hab mein Sach Gott heimgstellt, BWV 1113 | work | `bach-bwv1113`  코랄 전주곡 <Ich hab mein Sach Gott heimgestellt> BWV 1113 | MBID |
| 13933 | 9 kleine Präludien: Präludium F-Dur, BWV 928 | work | `bach-bwv928`  전주곡 F장조 BWV 928 | MBID |
| 13934 | Christus, der ist mein Leben, BWV 1112 | work | `bach-bwv1112`  코랄 전주곡 <Christus, der ist mein Leben> | MBID |
| 13936 | Gelobet seist du Jesu Christ, BWV 722 | work | `bach-bwv722`  코랄 전주곡 <Gelobet seist du, Jesu Christ> BWV 722 | MBID |
| 13938 | Wo soll ich fliehen hin, BWV 694 | work | `bach-bwv694`  코랄 전주곡 <Wo soll ich fliehen hin> | MBID |
| 13939 | 6 Französische Suiten | work | `bach-french-suites`  프랑스 모음곡 | MBID |
| 13941 | Toccata in E minor, BWV 914 | work | `bach-bwv914`  토카타 E단조 | MBID |
| 13946 | Präludium und Fuge a-Moll, BWV 543.2 | work | `bach-bwv543`  전주곡과 푸가 A단조 BWV 543 | MBID |
| 13947 | Als Jesus Christus in der Nacht, BWV 1108 | work | `bach-bwv1108`  코랄 전주곡 <Als Jesus Christus in der Nacht> | MBID |
| 13950 | Herzlich lieb hab ich dich, o Herr, BWV 1115 | work | `bach-bwv1115`  코랄 전주곡 <Herzlich lieb hab ich dich, o Herr> | MBID |
| 13952 | Choralbearbeitung, BWV 672 "Kyrie, Gott Vater in Ewigkeit" | part | `bach-clavier-ubung-3` [4] 오르간 작품집 <클라비어위붕 3권> › Kyrie, Gott Vater in Ewigkeit (manualiter) | MBID |
| 13953 | Chorale Prelude, Jesu, meine Freude, BWV 1105 | work | `bach-bwv1105`  코랄 전주곡 <Jesu, meine Freude> BWV 1105 | MBID |
| 13960 | Jesu, meines Lebens Leben, BWV 1107 | work | `bach-bwv1107`  코랄 전주곡 <Jesu, meines Lebens Leben> | MBID |
| 13962 | Präludium C-Dur, BWV 943 | work | `bach-bwv943`  전주곡 C장조 BWV 943 | MBID |
| 13963 | Fuge C-Dur, BWV 953 | work | `bach-bwv953`  푸가 C장조 BWV 953 | MBID |
| 13965 | Nun freut euch, lieben Christen g’mein, BWV 734 | work | `bach-bwv734`  코랄 전주곡 <Nun freut euch, lieben Christen g'mein> | MBID |
| 13968 | Herr Gott, dich loben wir, BWV 725 | work | `bach-bwv725`  코랄 전주곡 <Herr Gott, dich loben wir> | MBID |
| 13972 | Christus, der uns selig macht, BWV 620 | part | `bach-orgelbuchlein` [22] 코랄 전주곡집 <오르겔뷔흘라인> › Christus, der uns selig macht | MBID |
| 13973 | 9 kleine Präludien: Präludium g-Moll, BWV 930 | work | `bach-bwv930`  전주곡 G단조 | MBID |
| 13981 | Wir Christenleut, BWV 612 | part | `bach-orgelbuchlein` [14] 코랄 전주곡집 <오르겔뷔흘라인> › Wir Christenleut | MBID |
| 13983 | Choralbearbeitung, BWV 684 "Christ, unser Herr, zum Jordan kam" | part | `bach-clavier-ubung-3` [16] 오르간 작품집 <클라비어위붕 3권> › Christ unser Herr zum Jordan kam | MBID |
| 13984 | Choralvorspiele für Orgel in f-Moll, BWV 658 "Von Gott will ich nicht lassen" | part | `bach-leipzig-chorales` [8] 코랄 전주곡집 <라이프치히 코랄> › Von Gott will ich nicht lassen | MBID |
| 13989 | Präludium und Fuge für Orgel e-Moll, BWV 533 | work | `bach-bwv533`  전주곡과 푸가 E단조 "대성당" | MBID |
| 13990 | Choralbearbeitung, BWV 681 "Wir glauben all' an einen Gott" | part | `bach-clavier-ubung-3` [13] 오르간 작품집 <클라비어위붕 3권> › Wir gläuben all an einen Gott (푸게타, manualiter) | MBID |
| 13992 | Lobt Gott, ihr Christen, allzugleich, BWV 732.2 | work | `bach-bwv732`  코랄 전주곡 <Lobt Gott, ihr Christen, allzugleich> | MBID |
| 13993 | Christ ist erstanden, BWV 627 | part | `bach-orgelbuchlein` [29] 코랄 전주곡집 <오르겔뷔흘라인> › Christ ist erstanden | MBID |
| 13994 | Choralvorspiele für Orgel in G-Dur, BWV 652 "Komm heiliger Geist, Herre Gott" | part | `bach-leipzig-chorales` [2] 코랄 전주곡집 <라이프치히 코랄> › Komm, heiliger Geist, Herre Gott (alio modo) | MBID |
| 13995 | Christe, du Lamm Gottes, BWV 619 | part | `bach-orgelbuchlein` [21] 코랄 전주곡집 <오르겔뷔흘라인> › Christe, du Lamm Gottes | MBID |
| 14001 | Choralvorspiele für Orgel in G-Dur, BWV 663 "Allein Gott in der Höh' sei Ehr" | part | `bach-leipzig-chorales` [13] 코랄 전주곡집 <라이프치히 코랄> › Allein Gott in der Höh sei Ehr | MBID |
| 14002 | Choralbearbeitung, BWV 676 "Allein Gott in der Höh sei Ehr" | part | `bach-clavier-ubung-3` [8] 오르간 작품집 <클라비어위붕 3권> › Allein Gott in der Höh sei Ehr | MBID |
| 14004 | Allabreve in D major, BWV 589 | work | `bach-bwv589`  알라 브레베 D장조 | MBID |
| 14005 | Herr Jesu Christ, du höchstes Gut, BWV 1114 | work | `bach-bwv1114`  코랄 전주곡 <Herr Jesu Christ, du höchstes Gut> | MBID |
| 14010 | Capriccio sopra la lontananza del suo fratello dilettissimo, BWV 992 | work | `bach-bwv992`  카프리치오 B♭장조 "사랑하는 형의 떠남에 부쳐" | MBID |
| 14013 | Choralbearbeitung, BWV 688 "Jesus Christus unser Heiland" | part | `bach-clavier-ubung-3` [20] 오르간 작품집 <클라비어위붕 3권> › Jesus Christus, unser Heiland, der von uns den Zorn Gottes wandt | MBID |
| 14015 | Fuge nach Tomaso Albinoni h-Moll, BWV 951 | work | `bach-bwv951`  알비노니 주제에 의한 푸가 B단조 | MBID |
| 14016 | Choralvorspiele für Orgel in A-Dur, BWV 656 "O Lamm Gottes unschuldig" | part | `bach-leipzig-chorales` [6] 코랄 전주곡집 <라이프치히 코랄> › O Lamm Gottes, unschuldig | MBID |
| 14018 | Präludium und Fuge C-Dur, BWV 531 | work | `bach-bwv531`  전주곡과 푸가 C장조 BWV 531 | MBID |
| 14019 | Gott ist mein Heil, mein Hilf und Trost, BWV 1106 | work | `bach-bwv1106`  코랄 전주곡 <Gott ist mein Heil, mein Hilf und Trost> | MBID |
| 14023 | 6 kleine Präludien: Präludium d-Moll, BWV 935 | part | `bach-bwv933-938` [3] 작은 전주곡 BWV 933–938 › D단조 | MBID |
| 14025 | Choralvorspiele für Orgel in F-Dur, BWV 618 "O Lamm Gottes, unschuldig" | part | `bach-orgelbuchlein` [20] 코랄 전주곡집 <오르겔뷔흘라인> › O Lamm Gottes, unschuldig | MBID |
| 14029 | Choralbearbeitung, BWV 670 "Christe, aller Welt Trost" | part | `bach-clavier-ubung-3` [2] 오르간 작품집 <클라비어위붕 3권> › Christe, aller Welt Trost | MBID |
| 14031 | Partita für Flöte in a-Moll, BWV 1013 | work | `bach-bwv1013`  무반주 플루트 파르티타 A단조 | MBID |
| 14033 | Praeludium und Fuge für Orgel a-Moll, BWV 551 | work | `bach-bwv551`  전주곡과 푸가 A단조 BWV 551 | MBID |
| 14038 | Präludium e-Moll, BWV 941 | work | `bach-bwv941`  전주곡 E단조 | MBID |
| 14039 | Jesus Christus, unser Heiland (Fuga super), BWV 689 | part | `bach-clavier-ubung-3` [21] 오르간 작품집 <클라비어위붕 3권> › Jesus Christus, unser Heiland, der von uns den Zorn Gottes wandt (푸가, manualiter) | MBID |
| 14041 | Fuge d-Moll, BWV 948 | work | `bach-bwv948`  푸가 D단조 | MBID |
| 14063 | Concerto for Keyboard and Orchestra no. 3 in D major, BWV 1054 | work | `bach-bwv1054`  하프시코드 협주곡 3번 D장조 | MBID |
| 14077 | Fuge B-Dur, BWV 955 | work | `bach-bwv955`  푸가 B♭장조 | MBID |
| 14085 | Partita D-moll, BWV 1004 (in D Minor): III. Sarabande | part | `bach-bwv1001-1006` [4, 3] 무반주 바이올린 소나타와 파르티타 › 파르티타 2번 D단조 › 사라방드 | BWV 번호·악장 제목 |
| 14089 | Concerto for Harpsichord, Strings, and Continuo No.5 in F minor, BWV 1056: 3. Presto | part | `bach-bwv1056` [3] 하프시코드 협주곡 5번 F단조 › Presto | MBID(병합된 work) |
| 14101 | Trio Sonata in F major, BWV 1040 | work | `bach-bwv1040`  트리오 소나타 F장조 | MBID |
| 14130 | Sonate für Violine und Klavier E-Dur, BWV 1016 | part | `bach-bwv1014-1019` [3] 바이올린과 하프시코드를 위한 소나타 BWV 1014–1019 › 소나타 3번 E장조 | MBID |
| 14134 | Präludium und Fuge a-Moll, BWV 894 | work | `bach-bwv894`  전주곡과 푸가 A단조 BWV 894 | MBID |
| 14170 | Sonate für Violine und Klavier A-Dur, BWV 1015 | part | `bach-bwv1014-1019` [2] 바이올린과 하프시코드를 위한 소나타 BWV 1014–1019 › 소나타 2번 A장조 | MBID |
| 14175 | Präludium und Fuge a-Moll, BWV 895 | work | `bach-bwv895`  전주곡과 푸가 A단조 BWV 895 | MBID |
| 14177 | Partita D-moll, BWV 1004 (in D Minor): I. Allemande | part | `bach-bwv1001-1006` [4, 1] 무반주 바이올린 소나타와 파르티타 › 파르티타 2번 D단조 › 알르망드 | BWV 번호·악장 제목 |
| 14178 | Fantasia über ein Rondo c-Moll, BWV 918 | work | `bach-bwv918`  론도에 의한 환상곡 C단조 | MBID |
| 14185 | Wer nur den lieben Gott läßt walten, BWV 691 | work | `bach-bwv691`  코랄 전주곡 <Wer nur den lieben Gott lässt walten> BWV 691 | MBID |
| 14215 | Herr Jesu Christ, dich zu uns wend, BWV 632 | part | `bach-orgelbuchlein` [34] 코랄 전주곡집 <오르겔뷔흘라인> › Herr Jesu Christ, dich zu uns wend | MBID |
| 14224 | O Lamm Gottes, unschuldig, BWV 1085 | work | `bach-bwv1085`  코랄 전주곡 <O Lamm Gottes unschuldig> BWV 1085 | MBID |
| 14237 | Das alte Jahr vergangen ist, BWV 1091 | work | `bach-bwv1091`  코랄 전주곡 <Das alte Jahr vergangen ist> | MBID |
| 14242 | Suite f-moll, BWV 823 | work | `bach-bwv823`  건반 모음곡 F단조 | MBID |
| 14252 | Fantasia a-Moll, BWV 922 | work | `bach-bwv922`  전주곡 A단조 BWV 922 | MBID |
| 14258 | Suite Es-Dur, BWV 819 | work | `bach-bwv819`  건반 모음곡 E♭장조 | MBID |
| 14281 | O Lamm Gottes unschuldig, BWV 1095 | work | `bach-bwv1095`  코랄 전주곡 <O Lamm Gottes unschuldig> BWV 1095 | MBID |
| 14283 | Concerto in C major for Two Harpsichords, BWV 1061 | work | `bach-bwv1061`  두 대의 하프시코드를 위한 협주곡 2번 C장조 | MBID |
| 14298 | Ciacona and Fugue in D minor, BWV 1178 | work | `bach-bwv1178`  샤콘과 푸가 D단조 | MBID |
| 14328 | Concerto in D Minor for Two Violins and Strings BWV 1043: Vivace | part | `bach-bwv1043` [1] 두 대의 바이올린을 위한 협주곡 D단조 › Vivace | BWV 번호·악장 제목 |
| 14333 | Wir Christenleut, BWV 1090 | work | `bach-bwv1090`  코랄 전주곡 <Wir Christenleut> | MBID |
| 14344 | O Jesu, wie ist dein Gestalt, BWV 1094 | work | `bach-bwv1094`  코랄 전주곡 <O Jesu, wie ist dein Gestalt> | MBID |
| 14349 | Fantasie c-Moll, BWV 1121 | work | `bach-bwv1121`  환상곡 C단조 | MBID |
| 14352 | Partita D-moll, BWV 1004 (in D Minor): V. Chaconne | part | `bach-bwv1001-1006` [4, 5] 무반주 바이올린 소나타와 파르티타 › 파르티타 2번 D단조 › 샤콘 | BWV 번호·악장 제목 |
| 14359 | Canon super Fa Mi, a 7, post Tempus Musicum, BWV 1078 | work | `bach-bwv1078`  카논 <Fa Mi, et Mi Fa est tota musica> | MBID |
| 14366 | Concerto in D Minor for Two Violins and Strings BWV 1043: Allegro | part | `bach-bwv1043` [3] 두 대의 바이올린을 위한 협주곡 D단조 › Allegro | BWV 번호·악장 제목 |
| 14388 | Wenn dich Unglück tut greifen an, BWV 1104 | work | `bach-bwv1104`  코랄 전주곡 <Wenn dich Unglück tut greifen an> | MBID |
| 14407 | Canon Trias Harmonica a 8, BWV 1072 | work | `bach-bwv1072`  카논 <Trias harmonica> | MBID |
| 14414 | Violin Sonata in E minor, BWV 1023 | work | `bach-bwv1023`  바이올린 소나타 E단조 | MBID |
| 14430 | Fantasia sur « Wo Gott der Herr nicht bei uns halt », BWV 1128 | work | `bach-bwv1128`  코랄 전주곡 <Wo Gott der Herr nicht bei uns hält> | MBID |
| 14452 | Vom Himmel hoch, da komm ich her, BWV 700 | work | `bach-bwv700`  코랄 전주곡 <Vom Himmel hoch da komm ich her> BWV 700 | MBID |
| 14462 | 6 Partitas, BWV 825-830 | work | `bach-partitas-bwv825-830`  파르티타 BWV 825–830 | MBID |
| 14464 | Präludium und Fughetta F-Dur, BWV 901 | work | `bach-bwv901`  전주곡과 푸게타 F장조 | MBID |
| 14478 | Erhalt uns, Herr, bei deinem Wort, BWV 1103 | work | `bach-bwv1103`  코랄 전주곡 <Erhalt uns Herr, bei deinem Wort> | MBID |
| 14503 | Präludium und Fughetta G-Dur, BWV 902 | work | `bach-bwv902`  전주곡과 푸게타 G장조 | MBID |
| 14507 | Suite française n° 3 (Gigue) | part | `bach-french-suites` [3, 7] 프랑스 모음곡 › 프랑스 모음곡 3번 B단조 › 지그 | 제목; 제목 'Suite française n° 3 (Gigue)' = 프랑스 모음곡 3번 지그 |
| 14549 | Ouverture (Suite) F-Dur, BWV 820 | work | `bach-bwv820`  건반 서곡 F장조 | MBID |
| 14550 | English Suite No. 2 in A Minor, BWV 807 | part | `bach-english-suites` [2] 영국 모음곡 › 영국 모음곡 2번 A단조 | BWV 번호 |
| 14562 | Canone doppio sopr' il soggetto, BWV 1077 | work | `bach-bwv1077`  이중 카논 G장조 | MBID |
| 14577 | Nun komm, der Heiden Heiland, BWV 699 | work | `bach-bwv699`  코랄 전주곡 <Nun komm, der Heiden Heiland> | MBID |
| 14579 | Sonata A-moll, BWV 1013 (in A minor): IV. Bourrée Anglaise | part | `bach-bwv1013` [4] 무반주 플루트 파르티타 A단조 › 부레 앙글레즈 | BWV 번호·악장 제목 |
| 14653 | Suite in g-Moll, BWV 822 | work | `bach-bwv822`  건반 모음곡 G단조 | MBID |
| 14675 | Durch Adams Fall ist ganz verderbt, BWV 1101 | work | `bach-bwv1101`  코랄 전주곡 <Durch Adams Fall ist ganz verderbt> | MBID |
| 14689 | Concerto for Keyboard and Orchestra no. 7 in G minor, BWV 1058 | work | `bach-bwv1058`  하프시코드 협주곡 7번 G단조 | MBID |
| 14695 | Präludium und Fugue C-dur, BWV 547 | work | `bach-bwv547`  전주곡과 푸가 C장조 BWV 547 | MBID |
| 14723 | Sonata A-moll, BWV 1013 (in A minor): I. Allemande | part | `bach-bwv1013` [1] 무반주 플루트 파르티타 A단조 › 알르망드 | BWV 번호·악장 제목 |
| 14734 | 9 kleine Präludien: Präludium g-Moll, BWV 929 | work | `bach-bwv929`  미뉴에트 트리오 G단조 | MBID |
| 14746 | Wer nur den lieben Gott läßt walten, BWV 642 | part | `bach-orgelbuchlein` [44] 코랄 전주곡집 <오르겔뷔흘라인> › Wer nur den lieben Gott lässt walten | MBID |
| 14760 | Concerto for Harpsichord, Strings, and Continuo No.1 in D minor, BWV 1052 - piano performance: 3. Allegro | part | `bach-bwv1052` [3] 하프시코드 협주곡 1번 D단조 › Allegro | MBID(병합된 work) |
| 14765 | 9 kleine Präludien: Präludium A-Moll, BWV 931 | work | `bach-bwv931`  전주곡 A단조 BWV 931 | MBID |
| 14773 | Sonata for Flute & Keyboard in B minor, BWV 1030 | work | `bach-bwv1030`  플루트 소나타 B단조 | MBID |
| 14783 | Concerto for Harpsichord, Strings, and Continuo No.1 in D minor, BWV 1052 - piano performance: 2. Adagio | part | `bach-bwv1052` [2] 하프시코드 협주곡 1번 D단조 › Adagio | MBID(병합된 work) |
| 14790 | Ciacona in G minor, BWV 1179 | work | `bach-bwv1179`  샤콘 G단조 | MBID |
| 14798 | Sonate pour violon seul n° 1 (Fugue) | part | `bach-bwv1001-1006` [1, 2] 무반주 바이올린 소나타와 파르티타 › 소나타 1번 G단조 › 푸가 | 제목; 제목 'Sonate pour violon seul n° 1 (Fugue)' = 무반주 바이올린 소나타 1번 푸가 |
| 14806 | Vater unser im Himmelreich, BWV 636 | part | `bach-orgelbuchlein` [38] 코랄 전주곡집 <오르겔뷔흘라인> › Vater unser im Himmelreich | MBID |
| 14810 | Herr Gott, nun schleuß den Himmel auf, BWV 1092 | work | `bach-bwv1092`  코랄 전주곡 <Herr Gott, nun schleuß den Himmel auf> | MBID |
| 14812 | Concerto for 2 Harpsichords, Strings, and Continuo in C minor, BWV 1060: 2. Adagio | part | `bach-bwv1060` [2] 두 대의 하프시코드를 위한 협주곡 1번 C단조 › Largo ovvero Adagio | MBID(병합된 work) |
| 14833 | Wir glauben all' an einen Gott, BWV 1098 | work | `bach-bwv1098`  코랄 전주곡 <Wir glauben all an einen Gott> | MBID |
| 14842 | Concerto for Harpsichord, Strings, and Continuo No.5 in F minor, BWV 1056: 2. Largo | part | `bach-bwv1056` [2] 하프시코드 협주곡 5번 F단조 › Largo | MBID(병합된 work) |
| 14876 | Liebster Jesu, wir sind hier, BWV 634 | part | `bach-orgelbuchlein` [35] 코랄 전주곡집 <오르겔뷔흘라인> › Liebster Jesu, wir sind hier | MBID |
| 14896 | Gottes Sohn ist kommen, BWV 703 | work | `bach-bwv703`  코랄 전주곡 <Gottes Sohn ist kommen> | MBID |
| 14911 | Fuge nach Tomaso Albinoni A-Dur, BWV 949 | work | `bach-bwv949`  알비노니 주제에 의한 푸가 A장조 BWV 949 | MBID |
| 14935 | 大提琴無伴奏組曲 No. 3 in C: Bourrées I & II | part | `bach-bwv1007-1012` [3, 5] 무반주 첼로 모음곡 › 첼로 모음곡 3번 C장조 › 부레 I·II | 제목; 제목 '大提琴無伴奏組曲 No. 3 in C: Bourrées I & II' = 첼로 모음곡 3번 부레 |
| 14941 | Concerto for Harpsichord, Strings, and Continuo No.4 in A, BWV 1055 - piano performance: 2. Larghetto | part | `bach-bwv1055` [2] 하프시코드 협주곡 4번 A장조 › Larghetto | MBID(병합된 work) |
| 14959 | Partita D-moll, BWV 1004 (in D Minor): II. Courante | part | `bach-bwv1001-1006` [4, 2] 무반주 바이올린 소나타와 파르티타 › 파르티타 2번 D단조 › 쿠랑트 | BWV 번호·악장 제목 |
| 14999 | Ehre sei dir, Christe, der du leidest Not, BWV 1097 | work | `bach-bwv1097`  코랄 전주곡 <Ehre sei dir Christe, der du leidest Not> | MBID |
| 15008 | Menuet 3 in G, BWV 843 | work | `bach-bwv843`  미뉴에트 G장조 BWV 843 | MBID |
| 15009 | Christ, du bist der helle Tag, BWV 766 | work | `bach-bwv766`  코랄 파르티타 <Christ, der du bist der helle Tag> | MBID |
| 15012 | Keyboard Concerto no. 4 in A major, BWV 1055 | work | `bach-bwv1055`  하프시코드 협주곡 4번 A장조 | MBID |
| 15021 | Präludium und Fuge h-Moll, BWV 544 | work | `bach-bwv544`  전주곡과 푸가 B단조 | MBID |
| 15068 | Concerto in C minor for Two Harpsichords, BWV 1062 | work | `bach-bwv1062`  두 대의 하프시코드를 위한 협주곡 3번 C단조 | MBID |
| 15076 | Concerto for 3 harpsichords, strings & continuo in D minor, BWV 1063 | work | `bach-bwv1063`  세 대의 하프시코드를 위한 협주곡 1번 D단조 | MBID |
| 15087 | Concerto for 2 Harpsichords, Strings, and Continuo in C minor, BWV 1060: 3. Allegro | part | `bach-bwv1060` [3] 두 대의 하프시코드를 위한 협주곡 1번 C단조 › Allegro | MBID(병합된 work) |
| 15109 | Sonate D-Dur, BWV 963 | work | `bach-bwv963`  건반 소나타 D장조 | MBID |
| 15113 | Concerto for Harpsichord, Strings, and Continuo No.4 in A, BWV 1055 - piano performance: 3. Allegro ma non tanto | part | `bach-bwv1055` [3] 하프시코드 협주곡 4번 A장조 › Allegro ma non tanto | MBID(병합된 work) |
| 15121 | Prelude in E Minor, BWV 548i | part | `bach-bwv548` [1] 전주곡과 푸가 E단조 "쐐기" › 전주곡 | 제목; 제목 'Prelude in E Minor, BWV 548i' = BWV 548 의 전주곡 |
| 15127 | Präludium und Fuge G-Dur, BWV 550 | work | `bach-bwv550`  전주곡과 푸가 G장조 BWV 550 | MBID |
| 15135 | Rondeau Partita #2 | part | `bach-partitas-bwv825-830` [2, 5] 파르티타 BWV 825–830 › 파르티타 2번 C단조 › 롱도 | 제목; 제목 'Rondeau Partita #2' = 파르티타 2번 롱도 |
| 15138 | Concerto for Harpsichord, Strings, and Continuo No.4 in A, BWV 1055 - piano performance: 1. (Allegro) | part | `bach-bwv1055` [1] 하프시코드 협주곡 4번 A장조 › Allegro | MBID(병합된 work) |
| 15150 | Gelobet seist du, Jesu Christ, BWV 697 | work | `bach-bwv697`  코랄 전주곡 <Gelobet seist du, Jesu Christ> BWV 697 | MBID |
| 15169 | Concerto for 2 Harpsichords, Strings, and Continuo in C minor, BWV 1060: 1. Allegro | part | `bach-bwv1060` [1] 두 대의 하프시코드를 위한 협주곡 1번 C단조 › Allegro | MBID(병합된 work) |
| 15172 | Herr Christ, der ein'ge Gottessohn, BWV 601 | part | `bach-orgelbuchlein` [3] 코랄 전주곡집 <오르겔뷔흘라인> › Herr Christ, der ein'ge Gottes Sohn | MBID |
| 15188 | Fantasie und Fuge c-Moll, BWV 562 | work | `bach-bwv562`  환상곡과 푸가 C단조 BWV 562 | MBID |
| 15201 | Canon Concordia discors a 2, BWV 1086 | work | `bach-bwv1086`  카논 <Concordia discors> | MBID |
| 15203 | Chromatic Fantasy | part | `bach-bwv903` [1] 반음계적 환상곡과 푸가 D단조 › 환상곡 | 제목; 제목 'Chromatic Fantasy' = 반음계적 환상곡과 푸가의 환상곡 |
| 15205 | Concerto for Harpsichord, Strings, and Continuo No.5 in F minor, BWV 1056: 1. (Allegro) | part | `bach-bwv1056` [1] 하프시코드 협주곡 5번 F단조 › Allegro | MBID(병합된 work) |
| 15208 | Sonata A-moll, BWV 1013 (in A minor): III. Sarabande | part | `bach-bwv1013` [3] 무반주 플루트 파르티타 A단조 › 사라방드 | BWV 번호·악장 제목 |
| 15257 | Du Friedenfürst, Herr Jesu Christ, BWV 1102 | work | `bach-bwv1102`  코랄 전주곡 <Du Friedefürst, Herr Jesu Christ> | MBID |
| 15262 | Canon a 2 perpetuus, BWV 1075 | work | `bach-bwv1075`  2성 무한 카논 D장조 | MBID |
| 15272 | Sonata A-moll, BWV 1013 (in A minor): II. Corrente | part | `bach-bwv1013` [2] 무반주 플루트 파르티타 A단조 › 코렌테 | BWV 번호·악장 제목 |
| 15278 | Präludium und Fughetta e-Moll, BWV 900 | work | `bach-bwv900`  전주곡과 푸게타 E단조 | MBID |
| 15285 | Suite for Lute in G minor, BWV 995 | work | `bach-bwv995`  류트 모음곡 G단조 | MBID |
| 15310 | Suite A-Dur, BWV 832 | work | `bach-bwv832`  건반 모음곡 A장조 | MBID |
| 15333 | Fuge a-Moll, BWV 959 | work | `bach-bwv959`  푸가 A단조 BWV 959 | MBID |
| 15385 | Keyboard Concerto no. 6 in F major, BWV 1057 | work | `bach-bwv1057`  하프시코드 협주곡 6번 F장조 | MBID |
| 15397 | Application C-Dur, BWV 994 | work | `bach-bwv994`  아플리카티오 C장조 | MBID |
| 15399 | Canon triplex a 6, BWV 1076 | work | `bach-bwv1076`  6성 3중 카논 G장조 | MBID |
| 15410 | Partita D-moll, BWV 1004 (in D Minor): IV. Gigue | part | `bach-bwv1001-1006` [4, 4] 무반주 바이올린 소나타와 파르티타 › 파르티타 2번 D단조 › 지그 | BWV 번호·악장 제목 |
| 15413 | Menuet 2 in G, BWV 842 | work | `bach-bwv842`  미뉴에트 G단조 | MBID |
| 15454 | Lob sei dem allmächtigen Gott, BWV 704 | work | `bach-bwv704`  코랄 전주곡 <Lob sei dem allmächtigen Gott> | MBID |
| 15465 | Liebster Jesu, wir sind hier, BWV 706 | work | `bach-bwv706`  코랄 전주곡 <Liebster Jesu, wir sind hier> BWV 706 | MBID |
| 15471 | English Suites, BWV 806-811 | work | `bach-english-suites`  영국 모음곡 | MBID |
| 15482 | Aus tiefster Not schrei ich zu dir, BWV 1099 | work | `bach-bwv1099`  코랄 전주곡 <Aus tiefer Not schrei ich zu dir> | MBID |
| 15484 | Herr Christ, der einig Gottes Sohn, BWV 698 | work | `bach-bwv698`  코랄 전주곡 <Herr Christ, der ein'ge Gottes Sohn> | MBID |
| 15504 | Concerto for Flute, Violin, Harpsichord, Strings and Continuo in A minor, BWV 1044 "Triple Concerto" | work | `bach-bwv1044`  플루트, 바이올린과 하프시코드를 위한 협주곡 A단조 | MBID |
| 15525 | Partita n° 3 (Preludio) | part | `bach-bwv1001-1006` [6, 1] 무반주 바이올린 소나타와 파르티타 › 파르티타 3번 E장조 › 전주곡 | 제목; 제목 'Partita n° 3 (Preludio)' = 무반주 바이올린 파르티타 3번 전주곡 |
| 15530 | Sonate für Violine und Klavier h-Moll, BWV 1014 | part | `bach-bwv1014-1019` [1] 바이올린과 하프시코드를 위한 소나타 BWV 1014–1019 › 소나타 1번 B단조 | MBID |
| 15551 | Präludium und Fuge A-Dur, BWV 896 | work | `bach-bwv896`  전주곡과 푸가 A장조 BWV 896 | MBID |
| 15558 | Sonate für Viola da Gamba und Cembalo g-Moll, BWV 1029 | work | `bach-bwv1029`  비올라 다 감바 소나타 3번 G단조 | MBID |
| 15580 | O Gott, du frommer Gott, BWV 767 | work | `bach-bwv767`  코랄 파르티타 <O Gott, du frommer Gott> | MBID |
| 15587 | Vom Himmel hoch, da komm ich her, BWV 701 | work | `bach-bwv701`  코랄 전주곡 <Vom Himmel hoch da komm ich her> BWV 701 | MBID |
| 15593 | Präludium und Fuge c-Moll, BWV 546 | work | `bach-bwv546`  전주곡과 푸가 C단조 BWV 546 | MBID |
| 15600 | Das Jesulein soll doch mein Trost, BWV 702 | work | `bach-bwv702`  코랄 전주곡 <Das Jesulein soll doch mein Trost> | MBID |
| 15621 | Suite a-Moll, BWV 818 | work | `bach-bwv818`  건반 모음곡 A단조 | MBID |
| 15648 | Präludium et parita del tuono terzo F-Dur, BWV 833 | work | `bach-bwv833`  전주곡과 파르티타 F장조 | MBID |
| 15685 | Marche in D major, BWV 1177 | work | `bach-bwv1177`  행진곡 D장조 | MBID |
| 15695 | Ich hab mein Sach Gott heimgestellt, BWV 707 | work | `bach-bwv707`  코랄 전주곡 <Ich hab mein Sach Gott heimgestellt> BWV 707 | MBID |
| 15696 | Partita in C minor, BWV 997.2 | work | `bach-bwv997`  류트 모음곡 C단조 | MBID |
| 15711 | Concerto in D Minor for Two Violins and Strings BWV 1043: Largo ma non tanto | part | `bach-bwv1043` [2] 두 대의 바이올린을 위한 협주곡 D단조 › Largo ma non tanto | BWV 번호·악장 제목 |

### 기존 seed part 가 카탈로그 노드와 안 맞는 것(`raw/orphan_seed_parts.json`)

work/part 로 이은 seed 작품에 이미 붙은 seed part(IDENTIFIERS_MATCHED) 가운데 카탈로그에 같은 MBID 노드가 없는 것입니다. 생성기가 이름을 고쳐 쓸 대상이 없습니다.

- seed 13901 「Partite diverse sopra "Sei gegrüßet, Jesu gütig", BWV 768.2」(work → `bach-bwv768`): seed part 12개 — 변주곡 낱곡 규칙으로 part 없이 둔 작품
- seed 14224 「O Lamm Gottes, unschuldig, BWV 1085」(work → `bach-bwv1085`): seed part 2개 — MB 가 전주곡·4성 코랄로 나눈 것을 코랄 전주곡 낱곡으로 둔 작품
- seed 14550 「English Suite No. 2 in A Minor, BWV 807」(part → `bach-english-suites`): seed part 6개 — MB 의 다른(비정식) work 트리 아래 악장이라 정식 work 의 악장과 MBID 가 다름
- seed 15009 「Christ, du bist der helle Tag, BWV 766」(work → `bach-bwv766`): seed part 7개 — 변주곡 낱곡 규칙으로 part 없이 둔 작품
- seed 15109 「Sonate D-Dur, BWV 963」(work → `bach-bwv963`): seed part 5개 — MB 악장 이름이 '(Ohne Bezeichnung)'뿐이라 낱곡으로 둔 작품
- seed 15580 「O Gott, du frommer Gott, BWV 767」(work → `bach-bwv767`): seed part 9개 — 변주곡 낱곡 규칙으로 part 없이 둔 작품

## 3. 뺀 것과 까닭

| 까닭 | 개수 |
|---|---:|
| 진위 의심(BWV 본 목록에 있으나 위키백과가 위작·의심으로 적은 것) | 7 |
| 단편·미완성 | 8 |
| 남의 작품을 바흐가 편곡·전사한 것 | 29 |
| 같은 곡의 옛 판(번호가 따로 있는 것) | 1 |
| BWV3 새 번호 가운데 소실·단편·진위 불확실 | 10 |

- **진위 의심(BWV 본 목록에 있으나 위키백과가 위작·의심으로 적은 것)**: BWV 539 전주곡과 푸가 D단조 '바이올린 푸가': 위키백과 오르간 목록에 진위 'uncertain'(푸가는 BWV 1001/2 편곡); BWV 563 환상곡과 모방 B단조: 위키백과 오르간·푸가 목록에 'spurious'; BWV 583 오르간 트리오 D단조: 위키백과 오르간 목록에 'spurious'(남의 실내 트리오 편곡일 수 있음); BWV 733 코랄 푸가 <Meine Seele erhebt den Herren>: 위키백과에 제자 크렙스(J. L. Krebs) 작품일 수 있다고 적힘; BWV 836 알르망드 G단조: 위키백과 건반 목록에 'spurious'(산도니 작품일 수 있음); BWV 899 전주곡과 푸게타 D단조: 위키백과 푸가 목록에 'doubtful'; BWV 923 전주곡 B단조: 위키백과에 W. H. 파헬벨 작품일 수 있다고 적힘
- **단편·미완성**: BWV 573 환상곡 C장조: 안나 막달레나 노트 속 미완성 단편; BWV 753 코랄 전주곡 <Jesu, meine Freude>: 미완성; BWV 764 코랄 전주곡 <Wie schön leuchtet der Morgenstern>: 미완성 단편; BWV 837 알르망드 G단조: 미완성; BWV 932 전주곡 E단조(빌헬름 프리데만 노트): 미완성; BWV 991 변주 아리아 C단조: 미완성; BWV 1045 신포니아 D장조: 칸타타 첫머리로 쓰려던 단편; BWV 1059 하프시코드 협주곡 D단조: 1악장 9마디만 남은 단편
- **남의 작품을 바흐가 편곡·전사한 것**: BWV 585 트리오 C단조: 파슈(J. F. Fasch) 트리오 소나타 편곡; BWV 586 트리오 G장조: 텔레만 작품 편곡으로 추정; BWV 587 아리아 F장조: 쿠프랭 <Les Nations> 편곡; BWV 592 오르간 협주곡 G장조: 요한 에른스트 공자 협주곡 편곡; BWV 593 오르간 협주곡 A단조: 비발디 Op. 3-8 (RV 522) 편곡; BWV 594 오르간 협주곡 C장조: 비발디 RV 208 편곡; BWV 595 오르간 협주곡 C장조: 요한 에른스트 공자 협주곡 편곡(BWV 984 와 같은 곡); BWV 596 오르간 협주곡 D단조: 비발디 Op. 3-11 (RV 565) 편곡; BWV 965 건반 소나타 A단조: 라인켄 <Hortus musicus> 편곡; BWV 966 건반 소나타 C장조: 라인켄 <Hortus musicus> 편곡; BWV 967 건반 소나타 A단조 1악장: 모르는 원곡의 편곡; BWV 972 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 973 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 974 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 975 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 976 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 977 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 978 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 979 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 980 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 981 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 982 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 983 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 984 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 985 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 986 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 987 <16개의 협주곡> 가운데: 비발디·마르첼로·텔레만·요한 에른스트 공자 등의 협주곡 건반 편곡; BWV 1025 바이올린과 건반을 위한 모음곡 A장조: 바이스(S. L. Weiss) 류트 소나타 편곡; BWV 1065 네 대의 하프시코드를 위한 협주곡 A단조: 비발디 Op. 3-10 (RV 580) 편곡
- **같은 곡의 옛 판(번호가 따로 있는 것)**: BWV 1071 신포니아 F장조(BWV 1046a·1046.1): 브란덴부르크 협주곡 1번의 옛 판
- **BWV3 새 번호**: BWV 1167 텔레만 협주곡을 오르간용으로 옮긴 것(악보 소실); BWV 1168 코랄 전주곡 <O Traurigkeit, o Herzeleid>: <오르겔뷔흘라인>에 넣으려던 단편(옛 Anh. 200); BWV 1169 코랄 전주곡: 옛 Anh. II(진위 의심)에서 BWV3 로 옮긴 번호, 출처마다 번호가 다름; BWV 1170 코랄 전주곡: 옛 Anh. II(진위 의심)에서 BWV3 로 옮긴 번호, 출처마다 번호가 다름; BWV 1171 코랄 전주곡(Emans 판): BWV3 에 새로 들어갔지만 진위가 굳지 않음; BWV 1172 코랄 전주곡(Emans 판): BWV3 에 새로 들어갔지만 진위가 굳지 않음; BWV 1173 코랄 전주곡(Emans 판): BWV3 에 새로 들어갔지만 진위가 굳지 않음; BWV 1174 코랄 전주곡(Emans 판): BWV3 에 새로 들어갔지만 진위가 굳지 않음; BWV 1175 코랄 전주곡: BWV3 에 새로 들어갔지만 진위가 굳지 않음; BWV 1176 코랄 전주곡: 옛 Anh. II(진위 의심)에서 BWV3 로 옮긴 번호
- **부록(Anh. II·III)으로 옮겨진 본 번호**(위키백과 BWV Anh. 표, 진위 의심·위작): 86개 — 534, 553, 554, 555, 556, 557, 558, 559, 560, 561, 567, 568, 571, 576, 577, 580, 581, 584, 591, 597, 598, 692, 693, 705, 708, 716, 723, 726, 740, 743, 744, 745, 746, 748, 749, 750, 751, 752, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 765, 771, 821, 824, 834, 835, 838, 839, 840, 844, 845, 897, 898, 905, 907, 908, 909, 919, 920, 945, 956, 958, 960, 962, 964, 968, 969, 970, 990, 1020, 1022, 1024, 1031, 1033, 1036, 1037, 1038, 1070. 여기에는 <8개의 작은 전주곡과 푸가> BWV 553–560(크렙스 작품 추정), 코랄 전주곡 BWV 692·693·705·708·716·723·726·740·743–752·754–763·765·771, BWV 821·834·838–840·844·845·897·898·905·907–909·919·920·945·956·958·960·962·964·968–970·990·1020·1022·1024·1031·1033·1036–1038·1070 이 들어 있습니다.
- **같은 곡의 다른 판(a·b 번호, .1/.2 판, var.)**: 위키백과 본 목록 표에서 104행. 마지막 판(또는 BWV 기본 번호) 하나만 넣었습니다. <라이프치히 코랄>의 바이마르 판(651a–668a), 평균율 1권 초기형(846a–869a), 533a·535a·545a·549a 등, BWV 1006.2(류트 판), 997.1(류트 하프시코드 판), 1046.1(=1071), 1050.1, 1052.1, 1061.1, 1080.1(자필 판)이 여기에 들어갑니다. 예외: BWV 818·819 는 위키백과 글머리 목록이 818a·819a 를 'alternative version'으로 적어 기본 번호를 넣었습니다.
- **부록(Anh.) 번호 기악**: Anh. 113–132(안나 막달레나 노트의 남의 곡), Anh. 42–79(진위 의심 코랄 전주곡), Anh. 153(바이올린 소나타) 등은 모두 넣지 않았습니다(진위가 굳은 기악 Anh. 은 BWV 1121·1128 로 번호를 받은 두 곡뿐이고 둘 다 넣음).
- **변주곡 낱곡 규칙**: 코랄 파르티타 BWV 766·767·768·770, 카논 변주곡 BWV 769, 아리아 바리아타 BWV 989 는 part 없이 낱곡입니다(골드베르크만 예외).

## 4. 애매했던 판단

- **남의 작품 편곡은 뺐습니다**: 비발디 등 협주곡의 오르간 편곡 BWV 592–596, 건반 편곡 <16개의 협주곡> BWV 972–987(마르첼로 오보에 협주곡 BWV 974 포함), <네 대의 하프시코드를 위한 협주곡> BWV 1065(비발디 Op. 3-10), 라인켄 편곡 BWV 965·966, 파슈·텔레만·쿠프랭 편곡 BWV 585–587, 바이스 편곡 BWV 1025. 이들 seed 는 excluded_scope 로 적었습니다. 하프시코드 협주곡 1052–1064 는 바흐 자신의 작품을 옮긴 것이라 넣었습니다.
- **운영 중복은 manual 을 자리로**: 브란덴부르크(manual 14 ↔ seed 13869), 무반주 바이올린(manual 13 ↔ seed 14554)은 처음에 명세대로 MBID 를 가진 seed 를 이었다가, 리드 지시로 manual 을 existingPieceId 로 바꾸고(제목 운영 그대로) 묶음 mbid 를 비웠습니다(그 MBID 는 seed 가 쥐고 있음). 두 seed 는 duplicate 입니다. 골드베르크는 비교 구간이 있는 seed 461 자리를 그대로 두고 manual 11 은 리드가 따로 처리합니다.
- **옛 판·다른 판 seed 79개를 excluded_scope 로 적음**: <라이프치히 코랄> 바이마르 판(651a 등), BWV 1006.2 류트 판, 997.1, 1019.1·1019.2, 1080.1 자필 판, 평균율 초기형 등 바흐 자신의 다른 판 녹음입니다. 명세의 '마지막 판만' 규칙을 따랐지만 숨기면 정식 바흐 녹음이 빠집니다.
- **진위 판단**: BWV 본 목록에 있어도 위키백과 갈래 목록이 위작·의심으로 적은 7곡(539·563·583·733·836·899·923)은 뺐고, 표의 저자 칸에만 물음표가 있는 곡(720·939–942·947·959, 빌헬름 프리데만과 공동 의심 841·842)은 넣고 note 에 적었습니다. BWV3 새 번호 1169–1176(옛 Anh.·Emans 판 코랄 전주곡)은 진위가 굳지 않았고 MB 와 위키백과의 번호 매김도 달라 뺐고, 1177(행진곡)·1178·1179(2025년 확인된 샤콘)는 넣었습니다.
- **묶음 구성**: <클라비어위붕 3권>은 BWV 669–689 + 듀엣 802–805 25곡으로 묶고, 인쇄본 앞뒤의 BWV 552(전주곡과 푸가 "성 안나")는 BWV·녹음 관례대로 따로 다악장 작품으로 두었습니다. 리드 예시 밖에서 바이올린과 하프시코드 소나타 BWV 1014–1019(바흐가 6곡 세트로 정리), 작은 전주곡 BWV 933–938 도 묶음으로 했습니다. <음악의 헌정>·<푸가의 기법>·BWV 1087 은 곡 모음이라 collection(악장 번호 없음)으로, 골드베르크는 리드 지시대로 다악장(아리아·30변주·아리아 다 카포 32 part, 악장 번호는 비움)으로 두었습니다.
- **<음악의 헌정> part**: MB 는 트리오 소나타 4악장을 VIII a–d 로 펴 놓았지만 트리오 소나타를 part 하나(MBID 없음)로 두고 4악장을 children 으로 넣었습니다. 5개의 Canones diversi 는 MB 대로 따로 part 입니다.
- **MB 정식 work 고르기**: 같은 BWV 에 work 가 여럿이면(편곡 catch-all, 판본, 복원 판) 원곡다움 점수(편곡 표시·설명, 다른 판 접미, 편곡 관계 수, seed MBID 일치)로 고르고, 틀린 것은 손으로 지정했습니다: BWV 677·732(732.2)·997(997.2)·1019(1019.3)·1026·1056·1067·1080(인쇄본 22 part). BWV 818 의 MB part 가운데 'III, IV. Sarabandes I & II'(묶음 중복)는 뺐습니다.
- **빠르기말 없는 악장 이름**: MB 에 이름이 없거나 '[no tempo indication]'인 첫 악장(브란덴부르크 1·2·6번, BWV 1063)은 관례대로 'Allegro', BWV 1018 1악장은 'Largo', BWV 914 첫 부분은 '토카타'로 채웠습니다. BWV 963 은 MB 악장 이름이 '(Ohne Bezeichnung)'뿐이라 낱곡으로 두었습니다.
- **제목으로 맞춘 seed 8개**: 'Suite française n° 3 (Gigue)'(14507), 'Sonate pour violon seul n° 1 (Fugue)'(14798), '大提琴無伴奏組曲 No. 3 … Bourrées'(14935), 'Rondeau Partita #2'(15135), 'Chromatic Fantasy'(15203), 'Partita n° 3 (Preludio)'(15525), 'Prelude in E Minor, BWV 548i'(15121), 'Harpsichord Concerto in F minor: Largo'(14630, 이미 다른 seed 가 있어 duplicate). MB 에 편곡 표시가 없는 work 라 원곡 녹음으로 보고 part 로 이었습니다.
- **성악 경계**: 성악 원곡이 분명한 편곡·번안(Jesu Joy 편곡, Sheep may safely graze, 마태 수난곡 번안, 'Oi Jeesus, lapsi armainen' = BWV 493 노래 번안 등)은 리드 예시와 달리 성악 몫으로 넘겼습니다('성악 원곡의 번안·편곡이 분명하면 성악 에이전트 몫' 규칙). 원곡을 정하지 못한 'unspecified version' 코랄·catch-all 44행은 unknown/hymn_translation 으로 내가 적었고 id 목록을 성악 에이전트에 보냈습니다.
- **조성이 다른 같은 번호 seed**: 'Konzert g-Moll für 3 Violinen, BWV 1056'(14622·15051·15485), 'Ouverture no. 2 in A minor, BWV 1067[a]'(15216)는 현대 복원·다른 조성 판이라 arrangement 로 적었습니다.

## 5. 직접 옮긴 우리말 이름 목록(검수용)

- 작품 제목: 「오르간 트리오 소나타 BWV 525–530」, 「코랄 전주곡집 <오르겔뷔흘라인>」, 「코랄 전주곡집 <쉬블러 코랄>」, 「코랄 전주곡집 <라이프치히 코랄>」, 「오르간 작품집 <클라비어위붕 3권>」, 「작은 전주곡 BWV 933–938」, 「바이올린과 하프시코드를 위한 소나타 BWV 1014–1019」, 「관현악 모음곡 BWV 1066–1069」, 「골드베르크 저음 주제에 의한 14개의 카논」
- 별명: 전주곡과 푸가 E단조 "대성당"(BWV 533 Cathedral), 토카타와 푸가 D단조 "도리아"(538 Dorian), 전주곡과 푸가 E단조 "쐐기"(548 Wedge), 전주곡과 푸가 E♭장조 "성 안나"(552 St Anne), 환상곡 G장조 "피에스 도르그"(572 Pièce d'orgue), 푸가 G단조 "작은 푸가"(578 Little), 카프리치오 B♭장조 "사랑하는 형의 떠남에 부쳐"(992)
- 갈래·꼴 이름: 레그렌치·코렐리·알비노니·라인켄 주제에 의한 푸가(574·579·946·949–951·954), 칸초나(588), 알라 브레베(589), 파스토렐라(590), 전주곡(토카타)과 푸가(566), 건반 모음곡·건반 서곡(818–823·832), 프랑스 서곡(831), 전주곡과 파르티타(833), 론도에 의한 환상곡(918), 미뉴에트 트리오(929), 건반 소나타(963), 이탈리아 협주곡(971), 아리아 바리아타(989), 아플리카티오(994), 류트 모음곡·류트 전주곡·류트 푸가(995–1000), 무반주 플루트 파르티타(1013), 바이올린과 통주저음을 위한 푸가(1026), 비올라 다 감바 소나타 1–3번(1027–1029, 번호는 관례), 두 대의 플루트를 위한 트리오 소나타(1039), 하프시코드 협주곡 1–7번·두 대/세 대의 하프시코드를 위한 협주곡(1052–1064, 위키 번호), 행진곡(1177), 샤콘과 푸가·샤콘(1178·1179), 코랄 파르티타(766–770), 카논 변주곡(769)
- 카논: 카논 <Trias harmonica>(1072), 4성 무한 카논(1073), 4성 카논(1074), 2성 무한 카논(1075), 6성 3중 카논(1076), 이중 카논(1077), 카논 <Fa Mi, et Mi Fa est tota musica>(1078), 카논 <Concordia discors>(1086)
- part 이름: 3성·6성 리체르카레, 트리오 소나타(음악의 헌정), 듀엣 1–4번(802–805), 인벤션·신포니아 n번, 소나타·파르티타 n번(무반주 바이올린), 첼로 모음곡 n번, Fuga a 3 Soggetti (미완성), n변주(골드베르크), 아리아 다 카포
- 코랄 이름 뒤 꾸밈말: (환상곡)·(트리오)·(푸게타)·(푸가) 는 Fantasia·Trio·Fughetta·Fugue 를 옮긴 것, alio modo·manualiter·distinctus 는 원어 그대로
- 춤곡·악장 갈래어: 전주곡, 알르망드, 쿠랑트, 코렌테, 사라방드, 지그, 미뉴에트, 가보트, 부레, 부레 앙글레즈, 파스피에, 폴로네즈, 바디네리, 롱도(Rondeau), 서곡, 신포니아, 샤콘, 루르, 두블, 시칠리아노, 카프리치오, 스케르초, 부를레스카, 포를란, 레주이상스, 뮈제트, 앙트레, 아리아(Air·Aria), 에코, 트리오, 푸가, 푸게타, 환상곡, 토카타, 파사칼리아. 꾸밈: '(두블 2개)'(avec deux Doubles), '(롱도)'(en rondeau), '(뮈제트)'(ou la Musette). 'Tempo di …'·'Alla …'·'al tempo di Giga' 는 빠르기말로 보고 원어 그대로 두었습니다.

## 6. 위키백과 대조 결과

- 본 목록 번호(BWV 525–1080, 1085–1087, 1090–1121, 1128, 1177–1179) 가운데 표에 있는 번호 507개: 넣음 462개, 까닭 적고 뺌 45개, 빠진 번호 0개.
- 위키 표에 없는 번호 BWV 1040(카논 트리오 소나타 F장조)은 글머리 목록·MB 로 넣었습니다. BWV 833 은 위키 표의 정렬값이 832 로 잘못 들어가 있어 칸 값으로 바로잡아 읽었습니다.
- 묶음 곡 수: 번호 범위로 된 묶음 16개 모두 위키 표 행 수와 같습니다(검사 오류 0). <클라비어위붕 3권>은 669–689 21곡 + 802–805 4곡 = 25곡, <음악의 헌정> 13 part(트리오 소나타 4악장 포함), <푸가의 기법> 22 part, BWV 1087 14 part 는 MB parts 와 같습니다.
- 조성: 위키 표와 다른 곳 BWV 873(위키 C#장조, 카탈로그 C#단조) — 평균율 2권 4번은 C#단조가 맞아(MB·악보) MB 를 따랐습니다. 그 밖에 위키 표 조성이 MB 와 다른 BWV 625·667 은 코랄 이름에 조성을 쓰지 않아 영향이 없습니다.
- <오르겔뷔흘라인> 순서는 위키백과의 'Orgelbüchlein No.' 를 따랐습니다(BWV 634 가 35번, 633 이 36번).
- <쉬블러 코랄> 묶음 MB(4161a5d1)·평균율 1·2권(dce85d48·a9fabb1b)·영국·프랑스 모음곡·파르티타·트리오 소나타·브란덴부르크·무반주 바이올린·첼로·골드베르크·음악의 헌정·푸가의 기법·BWV 1087 은 MB parts 관계를 그대로 썼습니다. MB parts 가 위키백과와 어긋난 곳은 없었고, 위 4절의 손 지정만 있습니다.
- MB 의 BWV3 번호 1169–1176 은 위키백과와 하나씩 어긋납니다(MB 1169 = 옛 Anh. 200 단편, 위키 1168 = Anh. 200). 둘 다 넣지 않아 영향은 없고 seed 는 spurious·fragment 로 적었습니다.
- MB 'Fantasia con imitazione h-Moll, BWV 563' 과 위키 표 'C maj.' 가 다르지만 위작 의심으로 빼서 영향이 없습니다.

