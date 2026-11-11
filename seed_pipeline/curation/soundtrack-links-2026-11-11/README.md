# 사운드트랙 링크 (2026-11-11)

사운드트랙 장르(`genre='screen'`, `202611110901`·`0902`)로 묶인 영화·드라마·게임 음악에 Apple Music·Spotify 링크를 채워요.
6차 카탈로그(`../catalog-wave6-2026-11-10/`)가 MusicBrainz 음반으로 묶은 작품은 링크 없이 들어가서, 「Human Target, Season 1」 같은 음반이
두 서비스에 다 있는데도 링크가 비어 있었어요. 마이그레이션은 `migrations/202611111001_fill_soundtrack_links.sql`(`build_sql.py` 출력)이에요.

## 순서

1. `export.sql` — 운영 읽기 전용으로 사운드트랙 맨 위 작품(`top.tsv`, 227)과 그 안 곡(`parts.tsv`, 2,811)을 받아요.
2. `mb_urls.py` — 6차 음반 묶음 117개는 MusicBrainz release group 의 모든 release 링크(url-rels)에서 Apple·Spotify 앨범을 모아요(Apple 56·Spotify 54).
   MusicBrainz 의 옛 iTunes id 는 없어진 경우가 많아(Human Target 398362447) 그대로 쓰지 않고 3에서 같이 확인해요.
3. `fetch_albums.py` — 검색어는 작곡가 성 + 제목 핵심(음반 묶음은 음반 이름, 사운드트랙 꼬리·작품번호를 뗀 것).
   - Apple: iTunes Search(us, 앨범·영화음악은 곡으로도, 3.3초 간격) → 후보 앨범 트랙은 iTunes Lookup(20개 묶음).
   - Spotify: 웹 플레이어 트랙 검색(`../piece-album-links-2026-11-08/spotify_search.py` 의 세션, 1.5초) → 후보 앨범 트랙은 임베드 페이지.
4. `pick.py` — 앨범 고르기·곡 맞추기·지금 링크 판정(규칙은 파일 머리 설명). 결과 `decisions.jsonl`.
5. `build_sql.py decisions.jsonl` → 마이그레이션.

## 고르는 규칙 (요약)

- 앨범: 작곡가 성이 앨범·아티스트·트랙 아티스트에 있고, 편곡·커버·피아노 독주판·태교 음반이 아니며(쇼스타코비치 영화 모음곡의 「arr. Atovmyan」은 표준이라 허용),
  앨범 이름이 제목을 가리키거나(두 낱말 이상, 철자 조금 다른 것 허용 — 「Draughtman's」↔「Draughtsman's」) 안 곡이 셋 이상·절반 이상 맞을 때.
  한 낱말 제목(「Friends」「Eureka」「Defiance」)은 이름만으로 고르지 않아요 — 「Martha Argerich and Friends」, 「A Very Eureka Christmas」,
  TV 판 「Defiance」에 게임 음반이 걸리던 일을 막아요.
- 안 곡 없는 영화음악(쇼스타코비치·프로코피예프 등)은 트랙이 「from <제목>」 꼴이거나 「<제목> op/suite/film/music」 앞이 맨 앞·작곡가 이름일 때
  그 모음 음반도 써요(「Friends」가 「Girl Friends」, 「The Family」가 다른 음반의 같은 이름 곡에 걸리지 않게).
- 곡: 꼬리·관사를 뗀 이름이 0.88 이상 비슷하거나, 같은 자리 번호면 0.75 이상. 한 트랙에 한 곡.
- 지금 링크: 맨 위 작품은 이 작품이 없는 앨범(다른 작품 음반·편곡 음반·커버 싱글)이면 바꾸거나 지워요.
  안 곡으로 이어진 seed 작품은 예전 검색 1위로 붙은 같은 작곡가의 다른 음반(「Human Target」 곡 「The Devil's Mouth」 → 같은 이름의 다른 영화 음반)이면
  고른 앨범의 트랙으로 바꾸고, 맞는 트랙이 없으면 그 앨범에 같은 이름 트랙도 없을 때만 지워요.

## 결과

| | Apple Music | Spotify |
|---|---:|---:|
| 맨 위 작품 링크 있음(227 중) | 33 → 150 | 12 → 152 |
| 맨 위 작품 채움 / 바꿈 / 지움 | 117 / 3 / 0 | 141 / 3 / 1 |
| 안 곡 링크 채움(2,811 중) | 1,427 (128 → 1,555) | 1,585 (49 → 1,634) |
| 이어진 seed 작품 채움 / 바꿈 / 지움 | 976 / 18 / 17 | 1,108 / 0 / 0 |

바꾸거나 지운 맨 위 작품 링크: 글래스 「Naqoyqatsi」(첼로 편곡 음반 → 원 사운드트랙, 두 서비스), 「Candyman」 Spotify(다른 글래스 음반 → 영화음악 모음),
브리튼 「Night Mail」 Apple(「한여름 밤의 꿈」 → 「Britten on Film」), 나이먼 「안네 프랑크의 일기」 Apple(색소폰 편곡 싱글), 킬라르 「Le roi et l'oiseau」 Spotify(플루트 편곡 모음),
로타 「로미오와 줄리엣」 Spotify(현악 합주 커버 싱글 → 지움).

못 찾은 작품(두 서비스 다): 매크리리 10(「The Cape」, 「Dark Void」 등), 쇼스타코비치 10(「소피야 페롭스카야」, 「여자 친구들」 등 — 모음 음반 트랙 이름에 제목이 안 붙은 것),
Plumeri 10, 로타 7(「8½」, 「나일 강의 죽음」 등), 나이먼 「사랑한다면 이들처럼」 낱곡 6, 프로코피예프 4, 본 윌리엄스 3 등. 확신이 없으면 비웠어요.

받은 검색·앨범 원본과 웹 플레이어 요청(`captured.json`, 토큰 있음)은 repo 밖 작업 폴더에 두고 커밋하지 않아요.

## 시험

운영 카탈로그 덤프 시험 DB(`devdb.sh`, cm-stlinks-mysql)에 트랜잭션으로 두 번 넣어 작품·곡 링크 해시가 같았어요(5,396문, 0.4초).
「Human Target, Season 1」(33589)은 사용자가 준 두 링크와 같은 앨범(Apple 1456276658, Spotify 2Zif2xRrmPhQtCUXP7TLUy)이 됐고,
그 안 곡 「The Devil's Mouth」(23336)는 다른 영화 음반 링크에서 이 음반 트랙으로 바뀌었어요.
