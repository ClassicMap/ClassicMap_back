# 작품 링크 전수 점검 (2026-11-09)

보이는 작품에 걸린 Apple Music·Spotify 링크를 모두 받아 봤습니다. 링크가 그 작품을 담은 앨범·트랙인지 판정하고, 틀린 링크는 바꾸거나 지웠습니다.

계기는 곡 안 곡 링크를 검수하다 본 두 링크입니다. 「브란덴부르크 협주곡」의 Apple Music 링크가 첼로 모음곡 앨범이었습니다. 보케리니 현악 오중주 Op. 13의 링크는 다른 작품(Op. 11 5번) 앨범이었습니다.

## 순서

1. `export_links.sql`, `export_parts.sql`: 링크가 있는 보이는 작품 6,937개와 그 맨 위 곡을 뽑습니다.
2. `fetch_links.py`: 링크가 가리키는 앨범·트랙을 받습니다.
   - Apple Music 앨범은 iTunes Lookup에 20개씩 묶어 묻습니다.
   - Lookup이 막히면 앨범 웹 페이지의 schema.org 트랙 목록(`apple-page`)으로 받습니다.
   - Spotify 앨범·트랙은 임베드 페이지에서 받습니다.
3. `audit.py`: 작품마다 판정합니다(아래 「판정」).
4. 바꿀 작품을 찾습니다. 대상은 틀림·없어짐·어긋남·의심·전집 상자로 판정된 작품입니다.
   - `export_candidates.sql`로 대상을 뽑습니다.
   - `../piece-album-links-2026-11-08/`의 `apple_search.py`·`apple_pick.py`와 `spotify_search.py`·`spotify_pick.py`로 새 앨범을 고릅니다.
5. `build_fix.py`: 바꿀지·지울지·둘지 정하고 마이그레이션을 만듭니다. 바꾸거나 지운 작품은 그 서비스의 곡 링크를 비웁니다.
6. 바꾼 작품의 곡 링크를 새 앨범에서 다시 붙입니다. `../part-apple-links-2026-11-08/match.py`를 맨 위 곡 기준과 `--nested`로 한 번씩 돌립니다.

## 판정 (`audit.py`)

작품 트랙은 `album_pick.pick`과 같은 규칙으로 셉니다.

- **같은 작품으로 보는 경우**
  - 트랙 이름에 작품번호와 제목 낱말이 있습니다.
  - 작품번호가 범위(「BWV 1046–1051」)이면 범위 안의 번호가 있습니다.
- **맞음**
  - `ok`: 작품 트랙이 곡 수 이상입니다.
  - `partial`: 작품 트랙이 곡 수보다 적습니다.
  - `named`: 트랙 이름이 악장 이름뿐이지만 앨범 이름이 이 작품을 가리킵니다.
  - `loose`: 제목 꼴이 달라도 뜻 있는 제목 낱말이 맞고, 작품번호·번호·조성이 어긋나지 않습니다.
    - 예: 「O mio babbino caro from Gianni Schicchi」, 「Candide: Overture」, 「K.466/L.118」
    - 갈래 이름(Sonata·Concerto 등)만으로는 맞다고 보지 않습니다.
- **틀림(`wrong`)**: 이 작품 트랙이 없고, 아래 증거 중 하나가 있습니다(`why`).
  - `conflict-track`: 같은 체계의 다른 작품번호가 있습니다(「Op. 23」↔「Op. 28」). 또는 같은 제목인데 번호·조성이 다릅니다.
  - `other-composer`: 작곡가가 앨범·아티스트·트랙 어디에도 없습니다.
  - `not-original`: 원곡 연주가 아닙니다. 오르골·자장가·운동·명상 모음, 리믹스, 노래방이 그런 예입니다.
  - `track-mismatch`: 트랙 링크인데 그 트랙 이름이 이 작품이 아닙니다.
- **그 밖**
  - `gone`: 앨범이 없어졌습니다.
  - `conflict`: 세트 안 곡 번호의 조성이 우리 곡과 다릅니다. 앨범이 다른 작품을 그 번호로 적은 경우입니다.
  - `box`: 받을 수 있는 트랙 끝(Apple 200·Spotify 100)까지 찬 전집 상자입니다. 작품은 못 찾았습니다.
  - `doubt`: 위 어디에도 안 맞지만 틀렸다는 증거도 없습니다.

## 바로잡기 (`build_fix.py`)

- **바꿈(`replace`)**: 새 앨범을 `audit.judge`로 다시 봐서 ok·loose·named일 때 바꿉니다.
  - 새 앨범은 `album_pick`이 고른 앨범을 먼저 봅니다. 못 고르면 검색 결과를 앨범별로 같은 판정 규칙으로 세어 고릅니다(`fallback`). 「Hob. III:77」처럼 콜론이 든 번호는 `album_pick`이 못 읽습니다.
  - 지금 링크가 의심·어긋남·전집 상자라면, 곡 수가 꼭 맞거나 앨범 이름이 이 작품을 가리킬 때만 바꿉니다. 다른 전집 상자나 편곡 모음으로 바꾸지 않습니다.
  - 아래 앨범은 쓰지 않습니다.
    - 같은 성의 다른 작곡가 앨범(J. C. ↔ J. S. 바흐, 레오폴트 ↔ W. A. 모차르트)
    - 편곡 트랙
    - 이름이 「Hong Nan-pa」 꼴인데 이름(「Nan-pa」)이 크레디트에 없는 앨범
  - 지금 링크가 트랙이면 새 앨범의 첫 작품 트랙으로 바꿉니다.
- **지움(`clear`)**: 새 앨범이 없고 지금 링크가 틀림·없어짐이면 지웁니다. 틀린 링크보다 링크가 없는 편이 낫습니다.
- **둠(`keep`)**: 그 밖입니다. 의심·어긋남·전집 상자인데 더 나은 앨범이 없는 경우입니다.

작품 링크는 지금 값이 판정 때 본 값과 같을 때만 바꿉니다. 그사이 사람이 고쳤으면 그대로 둡니다.

## 결과

링크가 있는 보이는 작품은 6,937개입니다.

| 판정 | Apple Music | Spotify |
|---|---|---|
| 링크 수 | 6,568 | 5,097 |
| 맞음(ok·loose·named·partial) | 6,247 | 4,897 |
| 틀림(`wrong`) | 120 | 57 |
| 없어짐(`gone`) | 26 | 0 |
| 어긋남(`conflict`) | 11 | 15 |
| 의심(`doubt`) | 150 | 15 |
| 전집 상자(`box`) | 14 | 113 |

틀림을 까닭별로 나누면 아래와 같습니다.

| 까닭 | Apple Music | Spotify |
|---|---|---|
| 다른 작품번호·번호 | 77 | 33 |
| 다른 작곡가 | 21 | 20 |
| 원곡 아님 | 20 | 0 |
| 다른 트랙 | 2 | 4 |

틀린 링크의 예입니다.

- 쇼팽 「혁명」 에튀드: Apple은 Op. 10-3 「이별」, Spotify는 Op. 10-1
- 엘가 「현을 위한 세레나데」: Apple은 다른 작곡가의 「Piano Sonatina, Op. 20」, Spotify는 「제론티어스의 꿈」의 20번
- 차이콥스키 「1812 서곡」(Op. 49): 브람스 「자장가」(Op. 49-4)
- 「브란덴부르크 협주곡」: 첼로 모음곡 앨범
- 하이든 「황제」 사중주: Op. 77-1 앨범
- 비발디 Op. 1: 알비노니 앨범
- 쉬멜리 가곡집: 오르골 편곡
- 「아이다」: 아기 수면 음반
- 한국 가곡 Spotify 트랙: 이름이 비슷한 팝송

바로잡은 결과입니다.

| 결정 | Apple Music(`202611090014`) | Spotify(`202611090011`) |
|---|---|---|
| 바꿈 | 181 | 86 |
| 지움(새 앨범 없음) | 29 | 21 |
| 둠 | 114 | 96 |

결정마다의 예전 값·새 값·까닭은 `apple-decisions.jsonl`, `spotify-decisions.jsonl`에 있습니다. 판정 가운데 맞음이 아닌 것만 `audit-flagged.jsonl`에 둡니다. 전체 판정은 다시 만들 수 있어 넣지 않았습니다.

바꾼 작품의 곡 링크는 새 앨범에서 다시 붙였습니다.

| 곡 링크 | Apple Music | Spotify |
|---|---|---|
| 맨 위 곡(`0015`·`0012`) | 109곡 | 175곡 |
| 곡 안 곡(`0016`·`0013`) | 54곡 | 26곡 |
| 운영 전체 곡 링크 수 | 20,954 → 21,042 | 20,681 → 20,878 |

남은 것은 아래와 같습니다.

- 의심 86곳·어긋남 8곳·전집 상자 11곳(Apple)과 전집 상자 74곳·어긋남 13곳·의심 6곳(Spotify)은 더 나은 앨범이 없어 그대로 뒀습니다.
- 어긋남은 대개 우리 곡 순서와 앨범 번호가 다른 세트입니다. J. C. 바흐 Op. 6, C. P. E. 바흐 Wq. 51이 그렇습니다.
- 한국 작곡가 곡은 크레디트가 한글이거나 비어 있어 대체 트랙을 찾지 못했습니다. 틀린 링크는 지웠습니다.

## 애매한 링크 검토 (2026-11-09 저녁)

바로잡기에서 그대로 둔 애매한 링크(의심·어긋남·전집 상자)는 Apple 105곳, Spotify 93곳입니다. 이 링크들을 근거를 모아 하나씩 정했습니다. 결정과 근거는 `review-decisions.jsonl`에 한 줄씩 있습니다.

1. **전집 상자: 트랙을 끝까지 받았습니다.** `fetch_full_albums.py`를 썼습니다.
   - Apple은 앨범 웹 페이지(300곡쯤까지)로 받았습니다.
   - Spotify는 웹 플레이어의 getAlbum 요청을 offset만 바꿔 받았습니다. 요청은 `spotify_album_capture.cjs`로 잡습니다.
   - 85곳 모두 그 작품이 실제로 들어 있었습니다(82곳 전부, 3곳 일부). 링크는 그대로 두고, 빈 곡 링크만 끝까지 받은 트랙에서 채웠습니다.
2. **의심·어긋남: 트랙 목록을 읽고 정했습니다.** 근거로 본 것은 아래와 같습니다.
   - 앨범 아티스트와 전체 트랙 목록
   - 같은 작품을 검색했을 때 지금 앨범의 트랙이 나오는지
   - 검색 결과에 없으면 검색어를 바꿔 한 번 더 찾은 결과
   - 판본마다 다른 번호 매김(쇼팽 마주르카 Op. 33, 시벨리우스 유모레스크 Op. 89의 전체 번호와 작품 안 번호 등)은 같은 작품으로 봤습니다.
   - 부제로만 적힌 트랙은 그 작품으로 봤습니다(아미로프 현악 교향곡 「Nizami」).

| 결정 | Apple(`0020`) | Spotify(`0017`) |
|---|---|---|
| 그대로(링크가 맞음을 확인) | 55 | 81 |
| 맞는 앨범으로 바꿈 | 20 | 4 |
| 지움(맞는 음원을 찾지 못함) | 30 | 8 |

바꾼 예입니다.

- 루토스와프스키 피아노 협주곡: 「관현악을 위한 협주곡」 앨범 → 지메르만 음반
- 비발디 Op. 1: 알비노니 앨범 → 「Vivaldi: Trio Sonatas, Op. 1」
- 슈토크하우젠 「Stimmung」: 피아노곡 앨범 → 힐리어 음반
- 자파 「I Have Been in You」: 다른 앨범 → 「Sheik Yerbouti」

지운 예입니다. 지운 링크는 모두 다른 작품이나 다른 가수의 곡을 가리켰습니다.

- 아호 협주곡 다섯 곡: 소프라노 색소폰 협주곡 앨범
- 보케리니 오중주 Op. 29의 1~3번: 6번만 든 앨범
- 김동진 「Sinfonietta」: 아널드 앨범

곡 링크는 `0018`·`0019`(Spotify), `0021`·`0022`(Apple)로 다시 붙였습니다. 운영 곡 링크 수가 Apple 21,042 → 21,122, Spotify 20,878 → 21,145로 늘어납니다.

## 다시 만들기

`$W`는 repo 밖의 작업 폴더입니다. SQL은 시험 DB에서 읽기만 합니다.

```bash
cd seed_pipeline
A=curation/piece-link-audit-2026-11-09
P=curation/piece-album-links-2026-11-08
M=curation/part-apple-links-2026-11-08/match.py
mysql -B <db> < $A/export_links.sql > $W/links.tsv
mysql -B <db> < $A/export_parts.sql > $W/parts.tsv
python3 -I $A/fetch_links.py $W/links.tsv $W apple        # 막히면 apple-page 를 같이
python3 -I $A/fetch_links.py $W/links.tsv $W spotify
python3 -I $A/fetch_links.py $W/links.tsv $W spotify-track
uv run python -I $A/audit.py $W/links.tsv $W/parts.tsv $W $W/audit.jsonl
# 대상 id 를 @ids 로 주고 export_candidates.sql → $W/fix-<서비스>/candidates.tsv,
# export_fix_parts.sql → $W/fix_parts.tsv
(cd $P && uv run python apple_search.py $W/fix-apple/candidates.tsv $W/fix-apple/search_raw \
  && uv run python apple_pick.py $W/fix-apple $W/fix-apple/candidates.tsv)
(cd $P && uv run python spotify_search.py $W/fix-spotify/candidates.tsv $W/fix-spotify/search_raw \
  && uv run python spotify_pick.py $W/fix-spotify $W/fix-spotify/candidates.tsv --second)
uv run python -I $A/build_fix.py spotify $W/audit.jsonl $W/fix-spotify/candidates.tsv \
  $W/fix-spotify/picks-final.jsonl $W/fix-spotify/raw $W/fix_parts.tsv $W/out \
  ../migrations/202611090011_fix_piece_spotify_links.sql $W/fix-spotify/search_raw
uv run python -I $M --parts $W/out/spotify-match-top.tsv --raw $W/fix-spotify/raw --out $A \
  --name spotify-part-matches.jsonl --column spotify_url --source-dir piece-link-audit-2026-11-09 \
  --migration ../migrations/202611090012_refill_fixed_piece_part_spotify_url.sql
uv run python -I $M --nested --parts $W/out/spotify-match-parts.tsv --raw $W/fix-spotify/raw --out $A \
  --name spotify-nested-matches.jsonl --column spotify_url --source-dir piece-link-audit-2026-11-09 \
  --migration ../migrations/202611090013_refill_fixed_nested_piece_part_spotify_url.sql
# 결정 jsonl 은 $W/out 에서 $A 로 옮긴다
# Apple 은 같은 명령에 apple, $W/fix-apple/full(새 앨범 트랙), 202611090014~0016
```
