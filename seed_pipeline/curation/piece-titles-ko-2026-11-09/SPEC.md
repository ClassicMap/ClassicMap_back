# 작품 한국어 제목 번역 기준 (ClassicMap)

작품 표(pieces)의 한국어 제목 칸(title)에 원어 제목이 그대로 들어 있는 작품을 한국어 화면 제목으로 바꾼다.
검색은 영어·원어로도 되므로(영어 제목 칸이 따로 있음), 한국어 제목은 한국어 화면에 맞는 꼴이면 된다.

## 출력
입력 tsv(id, composer, work_type, title) 한 줄마다 출력 한 줄. 열: `id<TAB>action<TAB>title_ko`
- `translate`: 일반 갈래 제목을 한국어로 다 옮김. 예) `Symphony no. 2 in F major` → `교향곡 2번 F장조`
- `label`: 고유 제목은 원제 그대로 두고 앞에 한국어 갈래를 붙임. 예) `가곡 <Wonne der Wehmut>`, `영화음악 <Naqoyqatsi>`
  - 널리 쓰는 한국어 제목이 확실히 있으면 그것을 씀: `오페라 <카르멘>`, `교향시 <프로메테우스>`
- `keep`: 그대로 둠(title_ko 에 원제 그대로). 영화·드라마 큐, 대중가요 같은 고유 제목, 갈래를 확신할 수 없을 때, 옮기면 더 어색할 때.
  - 확신이 없으면 keep. 틀린 번역보다 원제가 낫다.

## 낱말(데이터에서 쓰는 표기)
연습곡(에튀드 아님), 녹턴(야상곡 아님), 전주곡, 환상곡, 광시곡, 폴로네즈, 왈츠, 마주르카, 즉흥곡, 발라드, 스케르초, 변주곡, 서곡, 모음곡,
행진곡, 미사, 레퀴엠, 칸타타, 오라토리오, 오페라, 오페레타, 발레, 가곡, 연가곡집, 세레나데, 디베르티멘토, 론도, 푸가, 토카타, 파르티타, 카논,
샤콘, 미뉴에트, 로망스, 소품, 교향시, 교향곡, 협주곡, 콘체르티노, 소나타, 소나티네, 트리오 소나타, 2중주·3중주·4중주·5중주·6중주·8중주,
현악 4중주, 피아노 3중주, 피아노 5중주, 4중창(성악), 합창곡, 모테트, 마드리갈, 시편, 찬가, 마니피카트, 아리아, 춤곡, 무곡(관례가 있을 때),
영화음악, 부수음악, 뮤지컬, 회화적 연습곡(Études-tableaux), 카덴차, 간주곡, 자장가, 뱃노래, 바가텔, 유머레스크, 아라베스크, 탱고.
편성: 피아노, 바이올린, 비올라, 첼로, 더블베이스, 플루트, 오보에, 클라리넷, 바순, 호른, 트럼펫, 트롬본, 기타, 하프, 하프시코드, 오르간, 마림바, 관현악, 현악, 합창, 여성 합창.

## 꼴
- 순서: [N개의] [편성] 갈래 [N번] [조성] ["별명"] [작품번호]
  - `6 Études` / `Six` / `Quatre` / `Drei` → `6개의 연습곡`, `4개의 …`
  - `No. 5` / `nº 1` / `Nr. 3` → `5번`
  - `Cello Sonata` → `첼로 소나타`. `Sonata for clarinet and piano` → `클라리넷과 피아노를 위한 소나타`(조사는 받침에 맞게: 과/와, 을/를)
  - 셋 이상: `플루트, 바이올린, 바순을 위한 협주곡`
- 조성: `C단조`, `E♭장조`(플랫은 ♭), `C#단조`(샤프는 #). `in C minor` / `en Ré` / `in D-Dur`
  - 프랑스·이탈리아 계이름 Do/Ut=C, Ré=D, Mi=E, Fa=F, Sol=G, La=A, Si=B
  - 독일어 H=B, B=B♭, Es=E♭, As=A♭, Des=D♭, Ges=G♭, Fis=F#, Cis=C#, Gis=G#. dur=장조, moll=단조
- 작품번호는 원제에 있으면 끝에 둠: `Op. 30`, `BWV 124`, `Hob. IV:10`, `K. 525`, `RV 828`, `W 473`, `H. 117`. `op.`→`Op.`, 작품번호 뒤 `no.`→`No.`
- 별명·부제(따옴표 안): 널리 쓰는 한국어가 있으면 옮기고(`"Alleluia"` → `"알렐루야"`), 아니면 원어 그대로 따옴표 안에 둠.
- 「작품: 대목」 꼴(`6 Lieder, Op. 86: Feldeinsamkeit`) → `6개의 가곡 Op. 86 중 "Feldeinsamkeit"`. 복잡하면 keep.
- 고유 이름이 들어간 갈래 제목(`Christmas Overture`, `New York Waltzes`)은 한국어 표기가 자연스러우면 옮김(`크리스마스 서곡`, `뉴욕 왈츠`), 아니면 label 이나 keep.
- 작곡가가 영화·TV 음악가(예: Bear McCreary, Nino Rota, Bernard Herrmann, Wojciech Kilar의 영화 큐)면 큐 제목은 keep. 그 작곡가의 연주회용 작품(교향곡·협주곡 등)은 옮김.
- 따옴표는 곧은 따옴표 `"`를 씀. <> 는 고유 제목에만.

## 데이터에 이미 있는 예(영어 제목 → 한국어 제목)
- `Opera <Ascanio in Alba>` → `오페라 <알바의 아스카니오>`
- `The Maid of Orleans` → `오페라 <오를레앙의 처녀>`
- `On My Mind the Whole Night Long` → `가곡 <On My Mind the Whole Night Long>`
- `Symphony no. 3 “A Pastoral Symphony”` → `교향곡 3번 "A Pastoral Symphony"`
- `Trio Sonata in A minor, RV 828` → `트리오 소나타 A단조 RV 828`
- `O, om du sett (Oh, If You Had Seen)` → `멜로드라마 <O, om du sett>`
- `Willkommen und Abschied` → `가곡 <Willkommen und Abschied>`
- `Schatzgräbers Begehr` → `가곡 <Schatzgräbers Begehr>`
- `Symphony No. 1 in C major` → `교향곡 1번 C장조`
- `Serenity, S. 347` → `가곡 <Serenity>`
- `Divertimento in A major, Hob. IV:10` → `디베르티멘토 A장조 Hob. IV:10`
- `Rejoice in the Lamb, op. 30` → `칸타타 <Rejoice in the Lamb>`
- `Opera <Elisabetta, regina d'Inghilterra>` → `오페라 <잉글랜드 여왕 엘리자베타>`
- `Watchman!, S. 386` → `가곡 <Watchman!>`
- `Mundania` → `가곡 <Mundania>`
- `Symphony No. 30 in C major "Alleluia"` → `교향곡 30번 C장조 "알렐루야"`
- `Waltz <Tausendsapperment-Walzer>` → `왈츠 <Tausendsapperment-Walzer>`
- `Waltz <Die Zillerthaler>` → `왈츠 <Die Zillerthaler>`
- `The Draughtman’s Contract` → `영화음악 <The Draughtman’s Contract>`
- `Sonata in D major, Wq 62 no. 3, H 22` → `소나타 D장조 Wq 62 No. 3`
- `8 Variations on a Theme from Hérold's Marie for Piano Four Hands in C major` → `네 손을 위한 에롤드 <마리> 주제에 의한 8개의 변주곡 C장조`
- `Symphonic Poem <Prometheus>` → `교향시 <프로메테우스>`
- `L'Enfant et les sortilèges` → `오페라 <어린이와 마법>`
- `Quadrille <Maskenfest-Quadrille>` → `카드리유 <Maskenfest-Quadrille>`
- `Wonne der Wehmut` → `가곡 <Wonne der Wehmut>`
- `Le rossignol` → `가곡 <Le rossignol>`
- `6 Lieder, Op. 86: Feldeinsamkeit` → `6개의 가곡 Op. 86 중 "Feldeinsamkeit"`
- `Edone` → `가곡 <Edone>`
- `Cadenza for Mozart's Piano Concerto No. 20, K. 466` → `모차르트 피아노 협주곡 20번을 위한 카덴차`
- `Danse macabre` → `가곡 <Danse macabre>`
- `Cantata <Lungi n'andò Fileno>` → `칸타타 <Lungi n'andò Fileno>`
- `King David's Lament for Jonathan` → `가곡 <King David's Lament for Jonathan>`
- `Moderato for kantele` → `모데라토 (칸텔레)`
- `Cantata "Meinen Jesum laß ich nicht", BWV 124` → `칸타타 <Meinen Jesum laß ich nicht> BWV 124`
- `Regnum Mundi, JW 2/7` → `모테트 <Regnum Mundi>`
- `Vogue, vogue la galère` → `가곡 <Vogue, vogue la galère>`
- `Songs from Schemelli's Gesangbuch, BWV 439–507: "Was bist du doch, o Seele, so betrübt", BWV 506` → `쉬멜리 찬송가집 BWV 439–507 중 "Was bist du doch, o Seele, so betrübt"`
- `Suite from On the Dnieper` → `발레 모음곡 <드네프르 강가에서>`
- `Air and Minuet in D minor` → `에어와 미뉴에트 D단조`
- `15 Hungarian Peasant Songs` → `15개의 헝가리 농민의 노래`
- `Walt Whitman, S. 384` → `가곡 <Walt Whitman>`
- `Cantata <Davide penitente>` → `칸타타 <회개하는 다윗>`
- `4 Quartets, Op. 92` → `4개의 4중창 Op. 92`
- `Pis'mo K. S. Stanislavskomu` → `가곡 <Pis'mo K. S. Stanislavskomu>`
- `Cello Concerto in A minor` → `첼로 협주곡 A단조`
- `Trois mélodies de Verlaine` → `베를렌의 시에 의한 3개의 가곡`
- `Magnificat in C major` → `마니피카트 C장조`
- `12 Lieder und Romanzen for female chorus, Op. 44` → `여성 합창을 위한 12개의 가곡과 로망스 Op. 44`
- `Ave salus mundi` → `모테트 <Ave salus mundi>`
- `Adagio in D minor for string quartet` → `아다지오 D단조 (현악 4중주)`
- `Josef Kajetán Tyl` → `부수음악 <요세프 카예탄 틸>`
- `Four Piano Pieces` → `4개의 피아노 소품`
- `Four-part chorales, BWV 250–438: "Jesu, nun sei gepreiset", BWV 362` → `4성부 코랄 BWV 250–438 중 "Jesu, nun sei gepreiset"`
- `Italian Part-Songs, WoO 99` → `이탈리아어 다성 가곡집`
- `La rose` → `합창곡 <La rose>`
- `Symphony No. 56 in C major` → `교향곡 56번 C장조`
- `Air in B♭ major, HWV 469` → `에어 B♭장조 HWV 469`
- `Naqoyqatsi` → `영화음악 <Naqoyqatsi>`
- `Two Romances on Verses by Lermontov` → `레르몬토프의 시에 의한 2개의 로망스`
- `Concerto for Flute, Violin and Bassoon in F major` → `플루트, 바이올린, 바순을 위한 협주곡 F장조`
- `Lieder und Gesänge aus "Wilhelm Meister"` → `<빌헬름 마이스터>에 의한 가곡과 노래`
- `Quare fremuerunt gentes, Offertory` → `봉헌송 <Quare fremuerunt gentes>`
- `Shall We Dance` → `영화음악 <Shall We Dance>`
- `Cantata "Che giova il sospirar povero core"` → `칸타타 <Che giova il sospirar povero core>`
- `Sonata for Cello Solo and Basso Continuo no. 18 in C minor, G. 18: Sonata for Cello Solo and Basso Continuo no. 18 in C minor, G. 18: III. Minuetto - Trio` → `소나타 18번 C단조 중 "Minuetto - Trio"`
- `Romance in D major, op. 100` → `로망스 D장조 Op. 100`
- `Gesänge des Harfners aus "Wilhelm Meister": Wer nie sein Brot mit Tränen aß` → `가곡집 <하프 타는 사람의 노래> 중 "Wer nie sein Brot mit Tränen aß"`
- `Die Zauberharfe` → `부수음악 <Die Zauberharfe>`
- `Cantata "Schwingt freudig euch empor", BWV 36c` → `칸타타 <Schwingt freudig euch empor> BWV 36c`
- `Piano Trio No. 28 in D major` → `피아노 3중주 28번 D장조`
