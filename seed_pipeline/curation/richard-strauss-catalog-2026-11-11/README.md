# 리하르트 슈트라우스 작품 목록 (2026-11-11)

운영에는 「차라투스트라는 이렇게 말했다」 한 곡만 있었어요(작곡가 화면 작품 1개, 「처음 듣는다면」 카드 1장).
마이그레이션 `migrations/202611110701_add_richard_strauss_catalog.sql` 이 작품 92개를 더하고 차라투스트라에 단락 9개를 이어요.

## 왜 손으로 골랐나

4차 자동 규칙(`../catalog-wave4-2026-10-12/auto/auto_catalog.py`)으로 먼저 돌려 봤어요. MusicBrainz 의 `based on`·`other version`·`revision of`
관계가 있는 작품을 편곡·다른 판으로 보고 빼서 「살로메」(와일드 희곡에 based on)·「낙소스섬의 아리아드네」(1912·1916 판)·「군트람」·
「첼로 소나타」가 빠지고, 「Also Rock Zarathustra (Shuttle PC - CD ROM)」·차라투스트라 단락 낱곡·호른 협주곡 2번 두 줄(하나는 틀린 「Op. 132」) 같은
잡음이 들어갔어요. 그래서 작품은 `works.tsv` 에 손으로 고르고, 곡만 MusicBrainz parts 관계에서 가져와요.

## 고른 것

- 교향시·관현악 20, 교향곡 2, 협주곡·협주풍 8, 실내악 6, 피아노 3, 오페라 15, 발레 2, 멜로드라마 1, 작품번호 있는 가곡집 30(관현악 가곡 포함), 합창 5.
- 뺀 것: 작품번호 없는 낱개 가곡·행진곡·팡파르, 발췌(「장미의 기사」 왈츠, 「살로메」 마지막 장면), 다른 사람이 엮은 모음곡(「장미의 기사」 모음곡 1944), 진위가 의심스러운 「교향곡 3번 "영웅"」.
- 제목: 교향시·오페라는 「교향시 <돈 후안>」·「오페라 <살로메>」 꼴(리스트·헨델과 같음), 가곡집은 「5개의 가곡 Op. 15」 꼴(슈만·브람스와 같음).
- 곡 이름은 MusicBrainz 원제. 널리 쓰는 우리말이 있는 노래(헌정, 내일!, 체칠리에, 세레나데, 네 개의 마지막 노래 네 곡 등)만 「우리말 (원제)」.
- 연도는 작곡을 마친 해. 가곡집은 확실한 것(Op. 10·27·66~69)만 넣고 나머지는 비워 뒀어요.
- 관악 소나티네 두 곡은 MusicBrainz 에 같은 악장이 두 벌(영어 번호 없는 판·독일어 번호 판) 걸려 있어 자리마다 하나만 써요.

## 다시 만들기

`seed_pipeline` 에서:

1. `uv run python curation/richard-strauss-catalog-2026-11-11/build.py --out <W>` — `catalog.json`·`seed_map.json`(빈 목록)·`genres.sql`
2. `uv run python curation/catalog-wave4-2026-10-12/gen_catalog.py --composer-id 498 --slug richard-strauss --catalog <W>/catalog.json --pieces <덤프>/pieces.tsv --taken <덤프>/all_mbids_taken.tsv --seed-map <W>/seed_map.json --out <W>/catalog.sql`
3. 마이그레이션 = 머리 설명 + `catalog.sql` + `genres.sql`

덤프는 `../catalog-wave6-2026-11-10/tools/dump.sh`, MusicBrainz 요청은 같은 폴더 `fetch.py`(캐시·1.1초 간격) 를 써요.

## 시험

운영 카탈로그 읽기 덤프를 올린 시험 DB(`devdb.sh`, cm-strauss-mysql)에 한 트랜잭션으로 두 번 넣었어요. 2.2초, 두 번째에 바뀌는 행 없음.
슈트라우스 보이는 작품 93(장르 빈칸 0), 곡 305, `piece_forms.genre` 와 `pieces.genre` 어긋남 0.
