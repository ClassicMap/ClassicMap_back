# 쇼팽 작품 카탈로그 (2026-10-11)

쇼팽 작품을 출판 단위 묶음(작품)과 그 안의 곡(piece_parts)으로 정리한 자료예요.
`migrations/202610120002_add_chopin_catalog.sql` 이 이 자료로 만든 마이그레이션이에요.

- `catalog.json`: 작품 120개(묶음 38, 낱곡 71, 다악장 11)와 part 205개(Op. 72 3번 아래 3곡 따로).
  MusicBrainz work 와 위키백과 "List of compositions by Frédéric Chopin by opus number/genre" 를 맞췄어요.
- `report.md`: 개수, 이름 규칙, 기존 작품 17개 대응, 위키백과 대조, 걸러 낸 MB work 와 까닭, 애매했던 판단.
- `gen_sql.py`: `catalog.json` 을 마이그레이션 SQL 본문으로 바꿔요. 헤더 주석은 마이그레이션 파일에 손으로 적었어요.
  `uv run python curation/chopin-catalog-2026-10-11/gen_sql.py curation/chopin-catalog-2026-10-11/catalog.json out.sql` (seed_pipeline 에서)

`gen_sql.py` 가 정한 것(마이그레이션 헤더에도 적었어요):

- 넣지 않음: 위작 의심 5곡, 민요를 받아 적은 묶음 2개(B. 160b, KK VIIb/7–8), 라르고 B. 109.
- Op. 2·13·14 는 part 없이 낱곡으로 둬요.
- part 이름에서 "1번"·"1악장" 을 빼요(번호는 sequence_number). Op. 74 가곡은 폴란드어 원제를 괄호로 붙여요.
- part 는 EDITOR_REVIEWED 로 넣어요. 작곡가 화면은 이 상태 이상인 part 만 보여 줘요.

다른 작곡가로 넓힐 때도 같은 꼴(`catalog.json` → `gen_sql.py`)을 쓰면 돼요.
