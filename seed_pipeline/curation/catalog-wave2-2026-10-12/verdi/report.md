# 베르디 작품 카탈로그 — 2차 확장 보고

(보고서 파일 쓰기가 에이전트 쪽에서 막혀, 에이전트가 메시지로 보낸 본문을 리드가 옮겼습니다.)

- 위키백과 "List of compositions by Giuseppe Verdi" 기준, 우리말 오페라 제목은 한국어판 "주세페 베르디" 참고.
- MusicBrainz browse(inc=aliases+work-rels, 100개씩 24번) 2,339개. 낱개 조회 없음.
- 순서: defs.py → build.py → wikicheck.py → mbcheck.py → mbextra.py.
- 생성기 시험 통과: pieces 51, parts 33, children 12, existing_pieces 4.

## 1. 개수

묶음 3(part 16) / 다악장 3(part 17, children 12) / 낱곡 49 → 작품 55, part 33, children 12.

- 오페라 28, 가곡 8(묶음 2·낱곡 6), 종교곡 9, 그 밖의 성악 2, 피아노 2, 관현악 3, 실내악 2.
- 작품 MBID 50, 없음 5(<Suona la tromba>, 신포니아 B♭·D, <Stramberia>, <Pietà, Signor>). part·children MBID 는 전부 있음.
- 연도 없음 8(위키에 연도 없음). catalogue 는 전부 null.

## 2. 운영 기존 작품 대응

| id | 운영 제목 | key | 근거 |
|---:|---|---|---|
| 148 | 오페라 <라 트라비아타> | verdi-la-traviata | MBID 24df0a9b |
| 149 | 오페라 <리골레토> | verdi-rigoletto | MBID 2dc7fb62 |
| 150 | 오페라 <아이다> | verdi-aida | MBID 6675ed9c |
| 152 | 레퀴엠 | verdi-requiem | MBID 2d73a8a6. 악장 7 + Dies irae 10곡·Offertorio 2곡을 새 part 로 |

- 대목 작품이라 그대로 둠: 151 「오페라 <나부코> 중 "히브리 노예들의 합창"」. <나부코> 전체는 verdi-nabucco(445fc058)로 따로.
- 운영 중복 없음.

## 3. 뺀 것과 까닭

- 개정·번역판 9: Le trouvère, Giovanna de Guzman/I vespri siciliani, Macbeth(1865), Simon Boccanegra(1881), La forza(1869), Don Carlo(1867·1872·1884·1886). 원작 한 줄의 yearText·note 에 적음.
- 미완성 계획 1: Re Lear. 옛 판 1: Libera me(1869, 13명 합작 <로시니를 위한 미사>; 레퀴엠 7곡으로 고쳐 씀). 같은 곡 1: 'Valzer' = Waltz in F(1859). 합작·귀속 불확실 1: Canto di Virginia.
- 위키 목록에 없어 안 넣은 MB work(참고): 가곡 여러 곡, Ave Maria in B minor, Pater Noster in G major, Adagio per tromba, Capriccio per fagotto(진위 논란), Variazioni per pianoforte ed orchestra, 8 romanze per tenore e orchestra(베리오 편곡).

## 4. 애매했던 판단

1. 오페라 28편 = 위키 표 1–26 + 제목이 따로 서는 개작 <예루살렘>·<아롤도>. 원작 <제1차 십자군의 롬바르디아인>·<스티펠리오>도 남김.
2. 판이 여럿인 오페라는 원작 한 줄: <맥베스>·<시몬 보카네그라>·<운명의 힘>은 year=초판, yearText 에 개정 연도. <돈 카를로스>는 프랑스어 원작 MBID 에 이탈리아어 <돈 카를로>를 합침(제목은 한국어판 따라 <돈 카를로스>). <시칠리아인의 저녁 기도>도 프랑스어 원작 MBID.
3. 레퀴엠: 7악장 part, Dies irae(10)·Offertorio(2)만 children.
4. 연도 정정: Pater noster 는 1880년 4월 밀라노 초연이라 1880.
5. MBID 비움: 'Pietà, Signor (Agnus Dei)'(73e7806b)가 1894 가곡인지 확인 안 돼 비움.
6. 미사 E♭장조: MB(디노 리초 교정판) 6곡을 악장으로.

## 5. 직접 옮긴 우리말 이름

- 한국어판 위키 그대로: 하루만의 임금님, 나부코, 에르나니, 두 사람의 포스카리, 알지라, 아틸라, 맥베스, 군도, 예루살렘, 레냐노 전투, 루이자 밀러, 스티펠리오, 일 트로바토레, 시칠리아인의 저녁 기도, 시몬 보카네그라, 아롤도, 운명의 힘, 돈 카를로스, 오텔로, 팔스타프, 가면무도회.
- 직접/다듬음: 오베르토, 제1차 십자군의 롬바르디아인, 조반나 다르코, 해적, 6개의 로망스 (1838)/(1845), 녹턴 <Guarda che bianca luna>, 4개의 종교 소품, 칸타타 <여러 나라의 찬가>, 찬가 <Suona la tromba>, 말 없는 로망스, 파테르 노스테르·탄툼 에르고·라우다테 푸에리·퀴 톨리스·신포니아(음역).
- part: 레퀴엠 악장(레퀴엠과 키리에/디에스 이레/봉헌송/상투스/아뉴스 데이/룩스 에테르나/리베라 메), 종교 소품(아베 마리아/스타바트 마테르/테 데움), 4중주 4악장 '스케르초 푸가. Allegro assai mosso'. 가곡 제목은 전부 원제.

## 6. 위키 대조

- 87줄 전부 넣음/뺌/곡으로 맞음, 못 맞춘 0. 묶음 곡 수 6/6, 6/6, 4/4 일치.
- MB 는 1838·1845 가곡집을 둘 다 'Seste romanze'(오기)로 적음. 위키 'Laudi', MB 'Lauda' → 위키 따름.
