# 카드가 적은 작곡가 채우기 (2026-11-11)

「처음 듣는다면」 카드가 2장 이하였던 작곡가 넷을 채워요. 마이그레이션은 `migrations/202611110702_fill_thin_composer_highlights.sql`(`python3 build.py` 출력)이고,
리하르트 슈트라우스 작품은 앞 마이그레이션 `202611110701`(`../richard-strauss-catalog-2026-11-11/`)이 넣어요.

| 작곡가 | 전 | 후 | 한 일 |
|---|---:|---:|---|
| 백남준 | 1 | 3 | 실체를 못 찾아 DRAFT 로 둔 두 작품을 실제 작품으로 고치고 공개, 기존 카드의 「플럭서스 공연」을 실제 공연 이름으로 |
| 리하르트 슈트라우스 | 1 | 6 | 작품 목록을 넣고(작품 1 → 93) 다섯 작품 카드, 그 작품에 Apple Music 앨범 링크 |
| J.C. 바흐 | 2 | 5 | 「링크만 있는 채움 곡」으로 뺐던 Op. 5 를 근거 있는 이유로 공개, Op. 13·Op. 11 을 더함 |
| 안익태 | 2 | 2 | 그대로. 「강천성악」·「논개」는 작곡 연도도 확인이 안 되고 음원도 없어서 안 넣었어요 |

문체는 0405 와 같아요: 해요체 두 문장, 첫 문장은 왜 이 작품인지(구체적 사실), 둘째 문장은 들리는(보이는) 지점, 한국어 70자 안쪽, '대표·자주·단골·유명' 안 씀.

## 백남준 작품 고침

- 385 「존 케이지를 위한 교향곡」(1961) → **「존 케이지에게 바치는 경의」**(Hommage à John Cage: Music for Tapes and Piano, 1959). 그런 제목의 교향곡은 없고, 설명(피아노를 부수고 소리 지르는 행위)은 1959년 11월 13일 뒤셀도르프 장피에르 빌헬름의 갤러리 22 데뷔 공연 내용이에요. 기존 Spotify 링크 음반 「Works 1958-1979」(Sub Rosa)에 「Hommage À John Cage - 1958-59」 트랙이 있어요.
  - 근거: Steven Kaplan, ETC 1989(https://releve.erudit.org/fr/revues/etc/1989-n9-etc1084424/36394ac.pdf) "Hommage to John Cage: Music for Tape Recorder and Piano, at Gallery 22 in Dusseldorf … causing an upright piano to tip over", 백남준아트센터 소장품 https://njpart.ggcf.kr/collections/225
- 387 「조작된 피아노를 위한 연습곡」(1959) → **「피아노포르테를 위한 연습곡」**(Étude for Pianoforte, 1960). 1960년 10월 6일 쾰른 마리 바우어마이스터의 작업실에서 존 케이지·데이비드 튜더의 옷을 자르고 샴푸를 부은 공연이에요. 같은 음반에 「Etude For Pianoforte - 1959-60」 트랙이 있어 Spotify 링크를 같은 음반으로 넣었어요.
  - 근거: MoMA 소장 기록 https://www.moma.org/collection/works/128108 (October 6, 1960, Mary Bauermeister's Cologne studio, shampooed Cage's hair and cut off part of Cage's clothing), en.wikipedia 「Nam June Paik」(attacked John Cage and David Tudor, cutting their clothes and pouring shampoo)
- 386 「바이올린 솔로」 카드: 1962년 6월 16일 뒤셀도르프 캄머슈필레 「Neo-Dada in der Musik」 공연. 플럭서스 축제(같은 해 9월 비스바덴)보다 앞이라 「플럭서스 공연」을 고쳤어요.
  - 근거: Tate Etc. https://www.tate.org.uk/tate-etc/issue-21-spring-2011/when-future-was-now, Britannica 「One for Violin」, MoMA https://www.moma.org/collection/works/127502

## 카드 근거

| 카드 | 근거 |
|---|---|
| 슈트라우스 「네 개의 마지막 노래」: 84세에 씀, 사후 1950년 런던 초연, 「저녁노을에」 끝의 「죽음과 변용」 인용 | en.wikipedia 「Four Last Songs」: "composed in 1948 when Richard Strauss was 84", "premiere was given posthumously at the Royal Albert Hall in London on 22 May 1950", "quotes his own tone poem Death and Transfiguration, written 60 years earlier" |
| 「돈 후안」: 24세에 씀, 1889년 바이마르에서 직접 지휘, 이름을 알림, 첫 소절 | en.wikipedia 「Don Juan (Strauss)」: "composed when Strauss was only twenty-four", premiere 11 November 1889 Weimar conducted by Strauss, "established his reputation", "breakaway mood" of the opening bars |
| 「틸 오일렌슈피겔」: 교수형, 호른 첫 주제, D 클라리넷 비명 | en.wikipedia 「Till Eulenspiegel's Merry Pranks」: horn first Till theme, D clarinet second theme, "the stony executioner, who hangs him", D clarinet "wails … his death scream" |
| 「장미의 기사」: 1911년 드레스덴 초연 매진, 시대에 안 맞는 왈츠 | en.wikipedia 「Der Rosenkavalier」: premiered 26 January 1911 in Dresden, tickets "sold out almost immediately", waltz "anachronistic because the story takes place in the 1740s" |
| 「살로메」: 1907년 메트 한 번 뒤 1934년까지 안 올림, 일곱 베일의 춤 | en.wikipedia 「Salome (opera)」: Met 22 January 1907, further performances cancelled "under pressure from wealthy patrons", not staged there again until 1934, dance "very oriental in orchestration and style" |
| J.C. 바흐 Op. 5: 모차르트 K. 107(2·3·4번), 하프시코드 또는 피아노 | en.wikipedia 「Johann Christian Bach」("Mozart arranged three sonatas from Bach's Op. 5 into keyboard concertos"), Henle 판 머리말·IMSLP(초판 표제 "for the Harpsichord or Piano Forte"), MusicWeb 리뷰(Nos. 2–4 → K. 107) |
| Op. 13: 4번에 「The Yellow-Haired Laddie」, 1777년 초판 표지 | IMSLP 「Keyboard Concerto in B-flat major, W.C 65」(Op. 13 No. 4, 끝 악장 Andante con moto "The Yellow-Haired Laddie"), 초판 표제 "A Favorite Concerto for the Piano-Forte In which is Introduced The Yellow Hair'd Laddie" |
| Op. 11: 만하임 오페라 의뢰 뒤 선제후 카를 테오도르 헌정, 편성 | IMSLP 「6 Quintets, Op.11」(flute, oboe, violin, viola, cello), 악보 해설(1772년 만하임에서 오페라 두 편 의뢰 뒤 감사로 헌정) |

## 음원 링크

슈트라우스 카드 작품은 Apple Music 앨범만 넣었어요(트랙 목록에 작품 전곡이 있는 것 확인). Spotify 는 이번에 찾지 않았어요.
「네 개의 마지막 노래」 노먼·마주어(1452223225), 「돈 후안」·「틸」 카라얀·베를린 필 「Tone Poems」(1452343256), 「장미의 기사」 카라얀 1956(1293724292), 「살로메」 솔티·닐손(1452375364).
