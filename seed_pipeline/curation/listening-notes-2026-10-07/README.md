# 듣기 노트 2026-10-07

영화 속 클래식 1~5차(`comparison-film-f1`~`f5-2026-10-07`)로 새로 만든 구간 10개(268·269·270·273·274·276·278·282·283·284)의
구간 안내 10, 추천 비교 10, 연주 노트 30.

- 2026-10-01 과 같은 방식으로 **듣기 없이** 잰 값(음량 곡선·클립 길이)과 악보 자료로 썼다. 추천 비교·연주 노트 줄마다
  `{"kind":"listening","status":"skipped","at":"2026-10-07"}` 가 있고, 들어 볼 물음은 같은 줄의 `about` 에 있다
- 문체는 `.claude/skills/comparison-seed/references/08-listening-notes.md` 의 "문체 (2026-10-02)". 검사:
  `python3 .claude/skills/comparison-seed/scripts/lint_listening_notes.py seed_pipeline/curation/listening-notes-2026-10-07/notes.jsonl`
  (10-02 notes.jsonl 과 합쳐 돌려도 문제 0개)
- facts 는 대표 연주자가 지휘자면 악단만, 독주자·가수면 `지휘자 · 악단` 으로 적었다(10-02 와 같은 규칙)
- 구간 안내 줄은 적재기가 다른 필드를 받지 않아 출처를 못 단다. 안내에 쓴 악보 사실의 출처:
  - 268·276 라 트라비아타: librettidopera.it 리브레토(1막·2막), 영어 위키백과 La traviata
  - 269 말러 5번: Peters 1904 총보(Wikimedia Commons, 10마디 'Nicht schleppen'), 영어 위키백과
  - 270 라흐마니노프 2번: 영어 위키백과, Hollywood Bowl 곡 해설
  - 273 황제: Steingräber 판 악보(Wikimedia Commons, 'Vl. I u. II con sordino', 16마디 SOLO pp), 영어 위키백과
  - 274·278 베토벤 9번: 독일어·영어 위키백과(2악장 푸가토 입장·T.57 ff, 4악장 T.543 D장조 6/8, T.595 Seid umschlungen)
  - 282 피가로 서곡: 독일어 위키백과 Le nozze di Figaro(NMA, 느린 중간부를 빼고 현의 이음을 둠), Colorado 대학 소나타 형식 자료
  - 283 골드베르크 아리아: 영어 위키백과, West Cork Music 해설(16마디씩 둘), PTNA 곡 해설
  - 284 레퀴엠 Confutatis: 영어 위키백과 Requiem(Mozart)

  - 308 드보르자크 9번 4악장 도입: IMSLP #922878, 영어 위키백과
  - 309 쇼팽 Op. 25-11: IMSLP #843798, 영어 위키백과
  - 310 말러 5번 Adagietto m.90~103: IMSLP #360483, 8차 review-report 의 m.95 이정표
  - 311 윌리엄 텔 서곡 피날레: IMSLP #33461(m.226·m.243·m.316)
  - 312 쇼스타코비치 피아노 협주곡 2번 1악장: 영어 위키백과(총보는 저작권 때문에 못 봐서 셈여림 표시는 쓰지 않았다)
- 2026-10-10 에 8차 새 구간 다섯(308~312)의 안내 5·추천 비교 5·연주 노트 15를 덧붙였다(듣기 없이, listening skipped 2026-10-10)
  - 318 쇼팽 뱃노래: Breitkopf 전집 악보(Wikimedia Commons), 영어 위키백과
  - 319 슈만·리스트 「헌정」: Flaxland 1869 리스트 편곡 악보(Wikimedia Commons), 영어 위키백과 Myrthen
  - 320 쇼팽 소나타 2번 3악장: 악보(Wikimedia Commons), 영어 위키백과
  - 321 크라이슬러·라흐마니노프 「사랑의 슬픔」: 라흐마니노프 트랜스크립션집(Muzyka 1990, archive.org), 영어 위키백과 Alt-Wiener Tanzweisen
  - 322 쇼팽 Op. 10-1: 영어 위키백과('stays in f throughout and never once reaches ff')
  - 327 모차르트 K. 467 2악장·329 K. 183 1악장·330 K. 361 3악장: IMSLP NMA, 영어 위키백과
  - 328 바버 현을 위한 아다지오: 영어 위키백과(악보는 저작권 때문에 못 봤다)
- 2026-10-10 에 9·10차 새 구간 아홉(318~322, 327~330)의 안내 9·추천 비교 9·연주 노트 27을 덧붙였다(듣기 없이, listening skipped 2026-10-10). 10차 피아노 독주는 facts 를 비운다
  - 336 라벨 「요정의 정원」: PTNA 곡 해설, 영어 위키백과 Ma mère l'Oye(관현악 총보는 못 봤다)
  - 337 바흐 BWV 106 소나티나: 영어 위키백과(조성은 자료마다 달라 쓰지 않았다)
  - 338 바흐 BWV 82 「Ich habe genug」: 영어 위키백과, bach-cantatas.com 독일어 원문(가사는 직접 옮김)
  - 339 차이콥스키 「사계」 4월: 영어 위키백과, PTNA 곡 해설
  - 340 그리그 「솔베이그의 노래」: 노르웨이어 위키백과 Solveigs sang
  - 346 멘델스존 바이올린 협주곡 2악장: 영어 위키백과
  - 347 생상스 죽음의 무도: 영어 위키백과, Cramer 피아노 편곡 악보(Wikimedia Commons)
  - 348 로시니 「Una voce poco fa」: Ricordi 피아노 악보(Wikimedia Commons), 영어 위키백과
  - 349 베토벤 황제 2악장: 영어 위키백과, 13차 review-report
  - 350 쇼팽 피아노 협주곡 1번 3악장: 영어 위키백과, 곡 해설 PDF
  - 355 생상스 서주와 론도 카프리치오소: BnF 필사 총보(Wikimedia Commons), 영어 위키백과
  - 356 말러 3번 4악장: 총보(archive.org Sibley 사본, Durchaus ppp·mit Dämpfer·Wie ein Naturlaut), 영어 위키백과
  - 357 탄호이저 베누스베르크 음악: 영어 위키백과, 12차 review-report(드레스덴판)
  - 358 돈 조반니 기사장 장면: Gugler판 총보(archive.org), 영어 위키백과
- 2026-10-10 에 11~13차 새 구간 열넷(336~340, 346~350, 355~358)의 안내 14·추천 비교 14·연주 노트 42를 덧붙였다(듣기 없이, listening skipped 2026-10-10). 11차 편곡 큐 넷은 영화 장면을 안내에 넣지 않았다
적재는 `deploy/listening-notes-load-job.yaml` 에 `RUN=listening-notes-2026-10-07` 로 dry-run → 적재 → dry-run(계획 변경 0).
