# 묶음 작품과 낱곡 API

쇼팽 「연습곡 Op. 10」처럼 여러 곡을 담은 작품(묶음)을 작곡가 작품 목록에 한 줄로 보이고, 펼치면 그 안의 곡(part)을 보여 주는 계약입니다. 묶음 안의 곡은 `piece_parts` 행이고, 그 곡이 따로 작품 행으로 있으면(「혁명」 = pieces 127) part 가 그 작품을 가리킵니다.

## 스키마

`202610120001_add_piece_part_linked_piece.sql`이 `piece_parts.linked_piece_id INT NULL`을 더합니다.

- `pieces(id)` FK, `ON DELETE SET NULL`. 가리키던 작품이 지워지면 part 는 남고 연결만 끊깁니다.
- 인덱스 `idx_piece_parts_linked_piece`.
- 기존 열과 행은 바꾸지 않습니다.

## `GET /api/composers/<id>/pieces?offset&limit`

offset·limit 이 없으면 전체, 하나라도 있으면 페이지로 주는 동작은 그대로입니다.

- **최상위만**: 같은 작곡가의 다른 작품의 보이는 part 가 `linked_piece_id`로 가리키는 작품은 뺍니다. 묶음을 펼치면 보이기 때문입니다. 숨은 part 가 가리키는 작품, 다른 작곡가의 묶음이 가리키는 작품, 자기 자신을 가리키는 part 는 빼지 않습니다.
- **`partCount`**: 응답 `Piece`에 보이는 최상위 part(`parent_part_id IS NULL`) 수를 더합니다. 0이면 낱곡, 1 이상이면 `/pieces/<id>/parts`로 펼칩니다. 기존 필드는 그대로입니다.
- **`partKind`**: `"movement" | "work" | null`. 센 part 가 전부 악장 번호(`movement_number`, 빈 문자열은 없음으로 봄)를 가지면 `"movement"`(교향곡 "4악장"), 하나라도 없으면 `"work"`(연습곡집 "12곡"), `partCount`가 0이면 `null`입니다.
- **정렬**: 들을 거리 하나로 먼저 나누고, 그 안에서 작품번호 순입니다.
  1. 들을 거리가 있는 작품: 스트리밍 링크(Spotify 또는 Apple Music)나 설명이 있거나, 보이는 part 가 링크·설명 있는 작품을 가리킵니다. 「혁명」을 품은 「연습곡 Op. 10」 묶음은 링크·설명이 없어도 앞에 섭니다.
  2. 작품번호가 있는 작품. `catalogue_number`가 있으면 `catalogue_system catalogue_number`, 없으면 `opus_number`를 작품번호로 봅니다.
  3. `Op`로 시작하는 번호, 그다음 나머지 목록(`B.`, `BWV`, `K.` …)을 접두어 글자의 알파벳 순으로
  4. 첫 숫자, 둘째 숫자를 숫자로 비교. 둘째 숫자가 없는 묶음(`Op. 10`)이 그 안의 곡(`Op. 10, No. 3`)보다 앞섭니다.
  5. 작품번호 문자열, 마지막으로 `id`

예: `Op. 1` → `Op. 9, No. 2` → `Op. 10`(묶음, catalogue `Op.` + `10`) → `Op. 10 No. 3` → `Op. 28` → `Op. 74` → `B. 6` → `B. 49` → 번호 없음. 묶음(catalogue 칼럼)과 낱곡(opus_number)이 한 줄로 섞입니다.

작곡가 `pieceCount`(`/composers/search`, `/composers/<id>`)도 같은 기준으로 최상위 작품만 셉니다.

## `GET /api/pieces/<id>/parts`

작품의 보이는 part 를 화면 순서로 줍니다. 같은 부모 아래에서는 `sequenceNumber`(같으면 `id`) 순이고, 자식 part 는 부모 바로 뒤에 옵니다. 없는 작품이거나 part 가 없으면 `/pieces/<id>/sectors`처럼 빈 배열(200)입니다.

```json
[
  {
    "id": 36,
    "parentPartId": null,
    "sequenceNumber": 1,
    "movementNumber": null,
    "name": "C장조",
    "nameKo": "C장조",
    "nameEn": "No. 1 in C major",
    "linkedPiece": null
  },
  {
    "id": 38,
    "parentPartId": null,
    "sequenceNumber": 12,
    "movementNumber": null,
    "name": "C단조 \"혁명\"",
    "nameKo": "C단조 \"혁명\"",
    "nameEn": "No. 12 in C minor \"Revolutionary\"",
    "linkedPiece": {
      "id": 127,
      "title": "연습곡 Op. 10, No. 12 \"혁명\"",
      "comparable": true,
      "spotifyUrl": "https://open.spotify.com/track/…",
      "appleMusicUrl": "https://music.apple.com/…"
    }
  }
]
```

| 필드 | 뜻 |
| --- | --- |
| `name` | 화면용 이름. `nameKo` → `nameEn` → `linkedPiece.title` 순으로 비지 않은 첫 값, 모두 없으면 빈 문자열 |
| `parentPartId` | 악장 안의 하위 곡이면 부모 part id. 최상위면 `null` |
| `linkedPiece` | 이 곡이 따로 작품 행으로 있으면 그 작품. 없으면 `null` |
| `linkedPiece.comparable` | 그 작품에 비교 화면 공개 구간이 하나라도 있는지. `/pieces/<id>/comparison-sectors`·`/comparison-pieces`와 같은 공개 기준(발행된 연주, 현재 클립 READY·PUBLISHED, 구간 EDITOR_REVIEWED 이상, 주연주자 3명 이상)입니다. |

## 보이는 part

`partCount`·`partKind`, `/parts`, 목록 숨김, 정렬의 들을 거리, 작곡가 `pieceCount`가 모두 같은 조건(`VISIBLE_PART`)을 씁니다. `editorial_status`가 `EDITOR_REVIEWED`, `PUBLISHED`인 part 만 보입니다. 국제 시드 part(`IDENTIFIERS_MATCHED`)와 이름이 MusicBrainz 원제로 남은 옛 수동 악장(`FACTS_VERIFIED`)은 개수·종류·목록·숨김·정렬 어디에도 들어가지 않습니다. 부모 part 가 숨은 상태면 그 아래 part 도 `/parts`에서 빠집니다. 그래서 `partCount`와 `/parts`의 최상위 개수가 늘 같습니다.

## 다른 응답의 `partCount`·`partKind`

`GET /api/pieces`, `GET /api/pieces/<id>`, `GET /api/pieces/search`의 작품에도 같은 뜻의 `partCount`·`partKind`가 있습니다. 다른 모듈 응답(즐겨찾기·추천 등)에는 없습니다. 검색과 단건 조회는 묶음에 이어진 작품도 그대로 줍니다.

## 데이터를 넣을 때

- part 가 가리키는 작품(`linked_piece_id`)은 묶음과 같은 작곡가여야 목록에서 빠집니다.
- 화면 이름은 `name_ko`를 먼저 씁니다. 한국어 이름이 있으면 채웁니다.
- 화면에 내려면 `editorial_status`를 `EDITOR_REVIEWED` 이상으로 둡니다.
- 악장이면 `movement_number`를 채우고, 번호곡 모음이면 비워 둡니다. `partKind`가 이걸로 갈립니다.
- 순서는 `sequence_number`로 정합니다. `movement_number`는 표시용 문자열입니다.

## 검증

```bash
scripts/test_piece_parts.sh
```

임시 MySQL 에 최소 표(`scripts/fixtures/piece_parts_minimal_schema.sql`)와 새 migration 만 올려 `tests/piece_parts_integration.rs`를 돌립니다.
