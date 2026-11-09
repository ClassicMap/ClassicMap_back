# 곡 안 곡 링크 (2026-11-09)

세트 안 곡 링크(`../part-apple-links-2026-11-08/`, `../part-spotify-links-2026-11-08/`)는 맨 위 곡만 봤습니다. 그래서 한 단계 더 들어간 곡에는 링크가 하나도 없었습니다. 「비발디 바이올린 소나타 Op. 2 → 1번 → 1~4악장」의 악장, 「첼로 모음곡 1번 → 프렐류드」, 오페라 「1막 → 번호」가 그런 곡입니다. 이 폴더는 그 곡들(공개된 6,525곡)에 Apple Music·Spotify 트랙 링크를 붙인 자료입니다.

## 붙이는 법

`../part-apple-links-2026-11-08/match.py --nested`를 씁니다. 맨 위 곡을 붙이는 기존 방식은 바꾸지 않았습니다. `--nested` 없이 돌린 결과는 고치기 전과 바이트까지 같습니다.

1. **그 곡의 트랙 가려내기.** 안에 곡이 있는 곡(「No. 1: Violin Sonata in G minor, RV 27」)마다 그 곡의 트랙만 앨범에서 가려냅니다. 아래 순서로 처음 맞는 것을 씁니다.
   - 이 곡만 가진 작품번호: 「RV 27」「H. 663」처럼 형제 곡과 세트 작품번호에 없는 번호
   - 세트 작품번호와 번호: 「Op. 2, No. 1」. 번호는 순서와 이름의 번호 둘 다 봅니다. 「Duetto No. 6 …, MS 110」처럼 번호가 앞에 와도 찾습니다.
   - 이름의 「Wq. 183 no. 1」「op. 194 no. 1」
   - 작품번호 범위의 N번째: 「BWV 1007–1012」의 1번째 = 「BWV 1007」. 맨 위 곡 수와 범위가 같을 때만 씁니다.
   - 이름의 「Brandenburg Concerto No. 1」
   - 막·부·권·장면: 「Act I」「Première partie」「Volume II」「Tableau I」. 트랙에서는 같은 갈래의 다른 말(Acte·Akt, Teil·Pt., Book·Vol.)로도 찾습니다.

   가려낸 트랙이 형제 곡과 겹치거나, 곡과 트랙의 조성이 다르면 그 곡은 건너뜁니다.
2. **그 트랙 안에서 곡 안 곡 붙이기.** 맨 위 곡과 같은 규칙(number·movement·name·tail·order)을 씁니다.
   - 이름이 「I. Allegro」「…: I. Allegro」꼴이면 악장 번호 칸이 비어 있어도 악장으로 봅니다.
   - 이름에 번호가 있으면(「Book 1: No. 3. Come With Us!」) 순서 대신 그 번호로 찾습니다. 우리 목록에 빠진 곡이 있어 순서가 밀린 세트(야나체크 「수풀이 우거진 오솔길에서」)가 있습니다.
   - 앞 「a. 」를 떼고, 따옴표 가사가 있는 이름은 끝 괄호(출연자 목록)를 떼고 맞춥니다. 출연자 목록이 같은 다른 트랙에 걸린 일이 있었습니다.
3. **안에 곡이 있는 곡의 링크.** 비어 있으면 첫 곡의 트랙을 줍니다(`first`). 맨 위 곡을 붙일 때 다악장 곡에 첫 트랙을 준 것과 같습니다.
4. **트랙이 곡을 나누지 않은 앨범.** 「Verdi: Messa da Requiem: IV. Tuba mirum」처럼 어느 곡도 가려낼 수 없는 앨범이 있습니다. 이런 앨범에서는 이름으로만 붙입니다(`flat-name`, `flat-tail`). 붙이는 곡은 아래 셋을 모두 갖춰야 합니다.
   - 흔한 빠르기·형식 말을 빼고도 낱말이 둘 넘게 남습니다.
   - 세트 안에서 그 이름이 하나뿐입니다.
   - 앨범에서 그 이름이 든 트랙이 하나뿐입니다.

   「I. Allemande」처럼 한 낱말 이름은 다른 파르티타의 것일 수 있어 붙이지 않습니다.

## 파일

| 파일 | 하는 일 |
|---|---|
| `export_nested_parts.sql` | 곡 안에 곡이 있는 세트의 공개된 곡 전부 → `nested_parts.tsv`(시험 DB 에서 읽기만) |
| `fetch_spotify_tracks.py` | Spotify 앨범 트랙(임베드 페이지 `__NEXT_DATA__`) → `spotify_raw/` |
| `apple-matches.jsonl`, `spotify-matches.jsonl` | 곡마다 붙인 트랙·규칙(`parentPartId`가 없으면 안에 곡이 있는 맨 위 곡) |

Apple 앨범 트랙은 `../part-apple-links-2026-11-08/fetch_tracks.py`(iTunes Lookup)로 받습니다.

## 다시 만들기

`$W`는 repo 밖의 작업 폴더입니다.

```bash
cd seed_pipeline
D=curation/nested-part-links-2026-11-09
M=curation/part-apple-links-2026-11-08
mysql --default-character-set=utf8mb4 -B <db> < $D/export_nested_parts.sql > $W/nested_parts.tsv
python3 -I $M/fetch_tracks.py $W/nested_parts.tsv $W/apple_raw
python3 -I $D/fetch_spotify_tracks.py $W/nested_parts.tsv $W/spotify_raw
uv run python -I $M/match.py --nested --parts $W/nested_parts.tsv --raw $W/spotify_raw \
  --out $D --name spotify-matches.jsonl --column spotify_url --source-dir nested-part-links-2026-11-09 \
  --migration ../migrations/202611090009_fill_nested_piece_part_spotify_url.sql
uv run python -I $M/match.py --nested --parts $W/nested_parts.tsv --raw $W/apple_raw \
  --out $D --name apple-matches.jsonl --source-dir nested-part-links-2026-11-09 \
  --migration ../migrations/202611090010_fill_nested_piece_part_apple_music_url.sql
```

## 결과

곡 안에 곡이 있는 세트는 313개입니다. 그 안의 공개된 곡은 6,525곡입니다.

| 무엇 | Spotify | Apple Music |
|---|---|---|
| 앨범 트랙을 받은 세트 | 255 | 269 |
| 곡 안 곡 링크 | 2,537곡 | 2,744곡 |
| 안에 곡이 있는 곡 링크(`first`) | 395곡 | 435곡 |
| 마이그레이션 | `202611090009` | `202611090010` |

못 붙은 곡은 대부분 아래 셋 중 하나입니다.

- 세트 앨범이 그 곡을 담지 않았습니다. 예를 들면 「라주모프스키」 앨범에는 3번만 있습니다.
- 앨범이 악장을 나누지 않았습니다. Spotify 「사계」 앨범은 협주곡 하나가 트랙 하나입니다.
- 트랙 이름이 우리 이름과 다른 말입니다. 「카르멘」 곡 이름이 영어 번역입니다.

검수하다 본 기존 작품 링크 오류는 이번에 고치지 않았습니다. 「브란덴부르크 협주곡」(14)의 Apple Music 링크가 첼로 모음곡 앨범입니다. 보케리니 현악 오중주 Op. 13(11223)의 Apple Music 링크는 Op. 11 5번 앨범입니다.
