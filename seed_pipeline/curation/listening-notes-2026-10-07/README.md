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

적재는 `deploy/listening-notes-load-job.yaml` 에 `RUN=listening-notes-2026-10-07` 로 dry-run → 적재 → dry-run(계획 변경 0).
