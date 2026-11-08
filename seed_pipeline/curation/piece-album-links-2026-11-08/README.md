# 작품 앨범 링크 찾기 (2026-11-08)

여러 곡이 든 작품(세트)마다 그 작품이 다 든 Apple Music·Spotify 앨범을 찾습니다. 두 가지에 씁니다.

- 작품 링크: 빈칸은 채우고, 틀린 링크는 바꿉니다.
- 세트 안 곡(악장) 링크: 그 앨범의 트랙에서 붙입니다(`../part-apple-links-2026-11-08/match.py`).

작품 행은 `editor_locked=1`입니다. 틀린 링크를 바꾸는 일은 사용자가 승인했습니다(2026-11-08). 마이그레이션은 바꿀 때 지금 값이 그때 본 값과 같을 때만 씁니다. 그사이 사람이 고친 값은 그대로 둡니다.

## 왜 다시 찾나

예전 작품 링크는 검색 1위 앨범을 그대로 쓴 것이 많았습니다. 쇼팽 피아노 협주곡 2번을 검색하면 1위가 녹턴 앨범이라, 피아노 협주곡 1번 링크가 녹턴 앨범이었습니다. Spotify는 앨범 링크가 있던 작품 가운데 상당수가 악장 하나짜리 싱글이거나 엉뚱한 편집 음반이었습니다. 예를 들면 이렇습니다.

- 브람스 교향곡 3번 → "Appassionata - Piano Legends"
- 라흐마니노프 피아노 협주곡 2번 → 가곡 싱글

## 앨범 고르는 규칙 (`album_pick.py`)

- **작품 트랙:** 트랙 이름에 작품번호와 본제목(쉼표 앞)의 뜻 있는 낱말이 있습니다.
  - 작품번호가 없으면, 조성을 뺀 제목 구절이 트랙 이름에 있어야 합니다. 트랙에 다른 조성이 적혀 있으면 다른 작품으로 봅니다.
  - 트랙 이름이 악장 이름뿐이면("I. Allegretto"), 앨범 이름에 작품번호가 있고 트랙 수가 곡 수와 같을 때만 작품 트랙으로 봅니다.
  - 트랙에 다른 작곡가의 작품번호 체계(BWV·HWV·RV·Hob·WAB·Sz·BB·FWV·TrV)가 붙어 있으면 다른 작품으로 봅니다. 비발디 「Op. 5」를 찾다 헨델 「Op. 5, HWV 399」 트랙을 셌던 일이 있었습니다.
  - 악장 이름뿐인 앨범은 트랙에 다른 작품번호나 다른 「No.」가 없을 때만 씁니다. 협주곡 1·2번 앨범에서 2번 트랙만 받아 둔 경우를 거릅니다.
  - 작품번호 없이 제목 구절로 찾았는데 트랙에 작품번호가 있으면 앨범 이름을 봅니다. 여러 작곡가 모음 음반(「Rózsa: Violin Concerto, Op. 24 … - Benjamin: Romantic Fantasy」)에서 이 작곡가 몫에 그 구절이 없으면 다른 작곡가 작품으로 봅니다.
- **작곡가:** 앨범 이름에 작곡가 성이 있거나, 아티스트 이름에 작곡가 이름과 성이 다 있어야 합니다. 성만 보면 연주자 이름에 걸립니다(아서 벤저민 ← 「Benjamin Schmid」).
- **원곡이 아닌 음반:** 앨범 이름이 재즈 편곡, 다시 지은 곡(Recomposed), 태교·수면용 모음이면 쓰지 않습니다.
- **발췌 음반:** 작품 이름 쪽(트랙 이름의 첫 「:」 앞)이나 앨범 이름에 Excerpts·Highlights·Auszüge가 있으면, 트랙이 곡 수보다 많아도 `more`로 보지 않습니다. 곡 수와 같으면(`exact`) 그대로 씁니다.
- **고르는 순서:**
  1. 작품 트랙 수가 곡 수와 같은 앨범
  2. 곡 수 이상인 앨범
  3. 앨범 이름에 작품번호·제목이 있는 앨범
  4. 검색 순서
- **판정:** `exact`(같음), `more`(많음), `partial`(적음). `partial`이면 앨범 트랙을 다 받아 다시 셉니다.
  - 그래도 `partial`이면 짧은 검색어(작곡가 성 + 작품번호)로 한 번 더 찾습니다.
- **작품 링크에 쓰는 앨범:** `exact`·`more`만 씁니다.
- **곡 링크에 쓰는 앨범:** 앞의 앨범과 함께, 이름이 「작곡가: …」 꼴인 `partial` 앨범도 씁니다. 편집 음반에 한두 곡만 든 경우는 뺍니다.
- **Spotify의 지금 링크:**
  - 그 앨범에 작품 트랙이 곡 수 이상 있으면 그대로 둡니다(`kept`).
  - 트랙 이름으로는 알아볼 수 없어도 앨범 이름이 이 작품을 가리키면 그대로 둡니다.

## 파일

| 파일 | 하는 일 |
|---|---|
| `export_apple_candidates.sql` | Apple 작품 링크가 빈 세트 → `candidates.tsv` |
| `export_apple_fix.sql` | Apple 작품 링크가 틀린 세트 → `candidates-fix.tsv`. 앨범 의심 74곳(`../part-apple-links-2026-11-08/suspect_albums.tsv`), 앨범 트랙 0개, 곡 링크가 하나도 안 붙은 트랙 링크(`?i=`)가 대상 |
| `export_spotify_sets.sql` | 세트 전부와 지금 Spotify 링크 → `sets.tsv` |
| `export_all_parts.sql` | 모든 작품의 공개된 최상위 곡 → `all_parts.tsv` |
| `apple_search.py` | iTunes Search(분당 20회쯤 제한, 3.3초 간격) → `search_raw/` |
| `apple_pick.py` | 앨범 고르기. 모자라면 iTunes Lookup → `lookup_raw/`, 두 번째 검색 → `search_raw_b/`. 결과는 `picks-final.jsonl`, `albums/` |
| `spotify_search.py`, `spotify_capture.cjs` | Spotify 웹 플레이어의 트랙 검색 요청을 잡아 검색어만 바꿔 다시 보냄 → `search_raw/`. 공개 Web API는 웹 플레이어 토큰으로 429가 남. 잡은 요청(`captured.json`)에는 토큰이 있어 커밋하지 않음 |
| `spotify_pick.py` | 앨범 고르기. 앨범 트랙은 임베드 페이지(`open.spotify.com/embed/album/<id>`)에서 받음 → `raw/`. `--second`를 주면 두 번째 검색 → `picks-final.jsonl` |
| `build_links.py` | picks → 작품 링크 마이그레이션 + `match.py` 입력 tsv. `--existing`을 주면 이번에 손대지 않은 작품의 지금 앨범도 넣음 |
| `fix_links.py` | 이미 넣은 결과와 규칙을 고친 뒤의 결과를 견줘, 다른 곳만 바로잡는 마이그레이션을 만듦 |
| `apple-picks.jsonl`, `spotify-picks.jsonl` | 작품마다 고른 앨범·작품 트랙 수·판정 |
| `apple-pieces.jsonl`, `spotify-pieces.jsonl` | 작품 링크를 채우거나 바꾼 작품(예전 값·새 값) |
| `spotify-fix.jsonl` | `202611082207`에서 바로잡은 Spotify 작품·곡 링크(앞 값·새 값) |

검색·앨범 트랙 원본과 `captured.json`은 repo 밖의 작업 폴더에 둡니다(`.gitignore`).

## 다시 만들기

`$W`는 repo 밖의 작업 폴더입니다. SQL은 시험 DB에서 읽기만 합니다.

```bash
cd seed_pipeline
D=curation/piece-album-links-2026-11-08
mysql --default-character-set=utf8mb4 -B <db> < $D/export_apple_candidates.sql > $W/apple/candidates.tsv
#   export_apple_fix.sql, export_spotify_sets.sql, export_all_parts.sql 도 같은 식으로 받습니다
uv run python $D/apple_search.py $W/apple/candidates-fix.tsv $W/apple/search_raw
uv run python $D/apple_search.py $W/apple/candidates.tsv $W/apple/search_raw
uv run python $D/apple_pick.py $W/apple $W/apple/candidates-fix.tsv $W/apple/candidates.tsv
uv run python $D/spotify_search.py $W/spotify/sets.tsv $W/spotify/search_raw
uv run python $D/spotify_pick.py $W/spotify $W/spotify/sets.tsv --second
```

마이그레이션을 만드는 명령은 `../part-spotify-links-2026-11-08/README.md`에 있습니다. Apple은 같은 명령에 `apple`·`--existing`을 주고, `match.py`에 `--skip`으로 앞서 넣은 matches를 줍니다.

```bash
uv run python $D/build_links.py apple $W/apple/picks-final.jsonl $W/all_parts.tsv $W/apple \
  ../migrations/202611082205_fill_piece_apple_music_album_links.sql piece-album-links-2026-11-08 \
  $W/apple/candidates-fix.tsv $W/apple/candidates.tsv --existing
#   $W/apple_raw = $W/apple/albums/*.json + 세션 1 에서 받은 앨범 트랙(겹치면 세션 1 것)
uv run python curation/part-apple-links-2026-11-08/match.py --parts $W/apple/apple_parts.tsv \
  --raw $W/apple_raw --out curation/part-apple-links-2026-11-08 --name matches-3.jsonl \
  --skip curation/part-apple-links-2026-11-08/matches.jsonl \
  --skip curation/part-apple-links-2026-11-08/matches-2.jsonl \
  --migration ../migrations/202611082206_fill_even_more_piece_part_apple_music_url.sql
```

### Spotify 바로잡기(`202611082207`)

Spotify 링크(`202611082203`·`2204`)를 넣은 뒤 Apple을 보다가 위 규칙(발췌 음반, 원곡이 아닌 음반, 다른 작곡가 번호, 아티스트 이름, 모음 음반, 악장 이름뿐인 앨범)을 더했습니다. 그 규칙으로 Spotify를 다시 고른 결과가 지금 `spotify-picks.jsonl`·`spotify-pieces.jsonl`·`../part-spotify-links-2026-11-08/matches.jsonl`입니다. 앞서 넣은 값과 다른 곳은 `fix_links.py`로 바로잡습니다. 앞서 넣은 값은 이 파일들의 이전 커밋 판입니다.

```bash
uv run python $D/fix_links.py spotify $W/spotify/sets.tsv <이전 spotify-pieces.jsonl> \
  $W/spotify_pieces.jsonl <이전 matches.jsonl> $W/matches.jsonl $D/spotify-fix.jsonl \
  ../migrations/202611082207_fix_piece_spotify_links.sql piece-album-links-2026-11-08
```

## 결과

| 무엇 | Spotify | Apple |
|---|---|---|
| 대상 세트 | 6,188 | 5,000 |
| 지금 링크 그대로 둠 | 72 | 1(이미 같은 앨범) |
| 작품 링크 빈칸 채움 | 4,650 | 3,530 |
| 작품 링크 바꿈 | 57 | 134 |
| 앨범 못 찾음 | 968 | 1,105 |
| 곡 링크 | 17,749곡 | 13,405곡 더함(모두 17,775곡) |

Spotify 수는 바로잡은 뒤의 값입니다. `202611082203`은 빈칸 4,660곳을 채웠고, `202611082207`이 작품 43곳(그중 10곳은 비움)과 곡 112곡(새로 붙임 12곡, 뺌 13곡)을 바로잡습니다.
