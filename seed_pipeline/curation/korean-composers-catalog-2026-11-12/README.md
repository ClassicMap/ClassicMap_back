# 한국 작곡가 작품 목록 (2026-11-12)

작곡가 화면에 작품이 3~5개뿐이던 윤이상·홍난파·김동진의 작품을 손으로 골라 채워요.
방식은 [리하르트 슈트라우스](../richard-strauss-catalog-2026-11-11/README.md)와 같아요. 작품을 `works.tsv` 에 고르고, `build.py` 가 `catalog.json` 을 만들고,
4차 `gen_catalog.py` 가 SQL 을 만들어요. 다만 한국 작곡가는 MusicBrainz 자료가 적어서 MBID 가 없는 작품도 넣어요(식별자 없이 넣고, 제목으로 중복을 막아요).

| 작곡가 | composer_id | 전 → 후(보이는 작품) | 새 작품 | MBID 이음 | 곡 | 마이그레이션 |
|---|---:|---|---:|---:|---:|---|
| 윤이상 | 90 | 4 → 99 | 95 | 31(기존 첼로 협주곡 포함) | 42 | `202611120301_add_isang_yun_catalog.sql` |

## 폴더

- `build.py` 세 작곡가 공용. `uv run python curation/korean-composers-catalog-2026-11-12/build.py <slug> --out <폴더>`
- `<slug>/works.tsv` 키(ASCII)·MBID 앞 8자·기존 piece id·우리말 제목·영어 제목·연도·genre·form_key·곡 출처(`n` 낱곡, `mb` MusicBrainz parts, `tsv` parts.tsv)
- `<slug>/parts.tsv` MusicBrainz 에 없는 곡(악장·노래)
- `<slug>/sources.jsonl` 작품마다 근거 URL·작사·연도 메모. `build.py` 는 works.tsv 의 모든 키에 근거가 있어야 돌아가요

## 공통 규칙

- 기존 작품(손으로 넣은 manual 작품)은 제목·설명·링크·「처음 듣는다면」 카드를 건드리지 않아요. MusicBrainz work 가 확실한 것만 식별자를 이어요(윤이상 첼로 협주곡 346, 홍난파 「봉선화」 342).
- 장르·형식은 운영 `piece_forms` 에 있는 짝만 써요(`build.py` 의 `FORM_GENRE` 가 짝을 검사해요). 새 작품에만, 비어 있을 때만 채워요.
- 설명(description)은 쓰지 않았어요. 작사가는 `sources.jsonl` 에만 있어요.
- 연도는 근거가 작곡 연도로 적은 것만 넣었어요. 범위(1967/68)는 끝 해, 「1932년경」은 1932. 발표·출판·초연·영화 연도이거나 근거끼리 엇갈리면 비웠어요.

## 윤이상

근거는 [국제윤이상협회 작품 목록](https://yun-gesellschaft.de/isang-yun-de/werke/)(작품 번호·편성·작곡 연도·초연)이에요. 이 목록의 독립 작품에서 골랐어요.

- 고른 것: 오페라 3, 성악·합창 13(「오 연꽃 속의 진주여」·「나의 땅, 나의 민족이여」·초기 가곡 다섯 곡 등), 관현악 15, 교향곡 1~5번·실내 교향곡 1·2번, 협주곡 9, 앙상블·실내악·독주 44, 피아노·오르간 4.
- 뺀 것
  - 다른 사람의 편곡·같은 곡의 다른 판: 「요정의 사랑」 중 무당의 노래(코흐라파엘 편곡), 「가곡」 기타판·하프판, 두 플루트용 「인벤션」, 바순용 「모놀로그」, 「작은 이중 협주곡」(오보에·하프 협주곡에서 떼어 냄).
  - 「에필로그」: 「화염에 휩싸인 천사」 끝에 붙여야 하는 곡이라 따로 넣지 않았어요.
  - 짧은 소편성 곡과 편성이 자유로운 곡: 「Impression」, 관악 8중주, 클라리넷·바순·호른 3중주, 호른·트럼펫·트롬본·피아노 4중주, 「Ost-West-Miniaturen」, 「Pezzo fantasioso」, 「Intermezzo」, 두 오보에 「인벤션」, 두 바이올린 소나티네, 오르간 「Fragment」, 관악 5중주(1991)·「Festlicher Tanz」, 플루트 4중주, 「Together」, 첼로·하프 이중주, 「Rufe」, 「Espace II」, 베이스클라리넷 「모놀로그」, 피아노 3중주(1955).
  - **플루트(들)를 위한 5개의 연습곡(1974)**: 운영의 348 「5개의 피아노를 위한 연습곡」(1974)이 이 곡을 잘못 적은 것으로 보여요(1974년 「Etüden」은 플루트용이고 윤이상의 피아노 연습곡은 없어요). 348 을 어떻게 고칠지 정할 때까지 새로 넣지도, 348 에 MBID 를 잇지도 않았어요.
- 제목: 우리말 제목은 [한국어 위키백과 「윤이상」](https://ko.wikipedia.org/wiki/윤이상)에 있는 것만 썼어요(「유동」·「차원」·「무악」·「광주여 영원히」·「가사」·「피리」·「활주」·「대왕의 주제」 등). 거기 없는 고유 제목은 원제를 `<>` 안에 둬요(「Teile dich Nacht」·「Tapis」·「Li-Na im Garten」 등). 편성은 「바이올린과 피아노를 위한 <가사>」 꼴, 관현악은 운영 관례대로 「관현악을 위한」(기존 「오케스트라를 위한 <예악>」은 그대로).
- 곡: MusicBrainz parts 가 있는 6곡(피아노 소품 다섯, 첼로 연습곡 일곱, 현악 4중주 1·6번, 「중국의 그림」, 「나의 땅, 나의 민족이여」)과 협회 목록에 악장 이름이 있는 3곡(「오 연꽃 속의 진주여」·교향곡 5번·초기 가곡 다섯 곡). 「나의 땅, 나의 민족이여」 악장은 한국어 원제(역사·현실 I·II·미래)로 써요. 교향곡 2·4번은 MusicBrainz 악장에 이름이 없어 곡을 붙이지 않았어요.
- MBID: 편성과 제목이 확실한 31곡만. 「Quartett」(어느 4중주인지 모름), 「Cantata The Wise Man: Salomo」(녹음은 플루트 「살로모」), 「East West Miniature II」(두 곡 중 하나), 「Monologue」(바순판)는 잇지 않았어요. 실내 교향곡 1번은 두 줄 중 녹음이 많은 `b97dc3e5` 를 써요.

## 다시 만들기

`seed_pipeline` 에서 작곡가마다(`<slug>`·`<id>`: isang-yun 90, hong-nanpa 89, kim-dongjin 103):

1. `../catalog-wave6-2026-11-10/tools/dump.sh <덤프>` — 운영 읽기 덤프
2. `uv run python curation/korean-composers-catalog-2026-11-12/build.py <slug> --out <W>` — `catalog.json`·`seed_map.json`(빈 목록)·`genres.sql`
3. `uv run python curation/catalog-wave4-2026-10-12/gen_catalog.py --composer-id <id> --slug <slug> --catalog <W>/catalog.json --pieces <덤프>/pieces.tsv --taken <덤프>/all_mbids_taken.tsv --seed-map <W>/seed_map.json --out <W>/catalog.sql`
4. 마이그레이션 = 머리 설명 + `catalog.sql`(주석 `-- None ` 을 `-- ` 로) + `genres.sql`

MusicBrainz 요청은 `../catalog-wave6-2026-11-10/tools/fetch.py`(캐시·1.1초 간격)를 써요. 같은 입력이면 출력이 같아요.

## 시험

운영 카탈로그 읽기 덤프를 올린 시험 DB(`devdb.sh`, cm-cat-c-mysql)에 세 파일을 파일마다 한 트랜잭션으로 두 번 넣었어요.
`test_apply.sh` 의 스냅숏은 장르·형식·연도·설명·링크·카드를 보지 않아서, 그것까지 넣은 스냅숏을 1회·2회 뒤에 따로 비교했어요.

- 1회 0.13초, 2회 0.10초. 두 번째에 pieces·piece_parts·piece_identifiers·composer_highlights 모두 바뀌지 않음.
- 작품 26,534 → 26,674(+140), 곡 50,205 → 50,253(+48), 식별자 25,494 → 25,526(+32, 기존 작품에는 342·346 두 줄만).
- 기존 작품 12개(제목·영어 제목·연도·장르·형식·설명·링크)와 카드 12장은 그대로.
- `piece_forms.genre` 와 `pieces.genre` 어긋남 0, 장르·형식 한쪽만 빈 작품 0.
