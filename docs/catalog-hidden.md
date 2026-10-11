# 목록 숨김

국제 시드가 넣은 대중음악 작곡가(록·팝·재즈)와 잡음 작품(악장 하나짜리, 팝 편곡 등)을 지우지 않고 목록·검색·개수에서 빼는 계약입니다. 숨겨도 상세는 열려서 직접 링크와 즐겨찾기가 깨지지 않습니다.

## 스키마

`202610120035_add_catalog_hidden_reason.sql`이 두 표에 칼럼을 더합니다.

- `composers.hidden_reason VARCHAR(32) NULL`, `pieces.hidden_reason VARCHAR(32) NULL`. `NULL`이면 보이고, 값이 있으면 숨긴 까닭입니다.
- 까닭 예: `non_classical`, `performer`, `catalog_unmatched`. API 는 값이 있는지만 보고 종류는 묶지 않습니다.
- 빈 문자열은 CHECK(`chk_composers_hidden_reason`, `chk_pieces_hidden_reason`)로 막습니다. 숨김 해제는 `NULL`입니다.
- 인덱스 `idx_pieces_composer_hidden (composer_id, hidden_reason)`. 작곡가 작품 목록과 작품 수가 씁니다.
- 기존 열과 행은 바꾸지 않습니다. 숨김은 별도 migration 의 `UPDATE`로 겁니다.

## API 동작

| API | 숨긴 작곡가 | 숨긴 작품 |
| --- | --- | --- |
| `GET /api/composers`, `/api/composers/search` | 빠집니다 | `pieceCount`에서 빠집니다. 남는 최상위 작품이 없으면 작곡가도 빠집니다 |
| `GET /api/composers/with-performances` | 빠집니다 | 빠집니다 |
| `GET /api/composers/<id>` | 열립니다 | `pieceCount`에서 빠집니다 |
| `GET /api/composers/<id>/pieces` | 숨긴 작곡가의 목록도 열립니다(상세에서 여는 목록) | 빠집니다 |
| `GET /api/pieces`, `/api/pieces/search` | 그 작곡가의 작품이 모두 빠집니다. 작곡가 이름으로 찾아도 나오지 않습니다 | 빠집니다 |
| `GET /api/pieces/<id>`, `/api/pieces/<id>/parts` | 열립니다 | 열립니다 |

`pieceCount`는 늘 `/composers/<id>/pieces` 전체 목록의 길이와 같습니다.

## 묶음과 숨김

- 보이는 묶음의 part 가 숨긴 작품을 가리키면 `/parts`의 `linkedPiece`로 그대로 보입니다. 작곡가 작품 목록 최상위에는 원래처럼 나오지 않습니다.
- 숨긴 묶음의 part 가 보이는 작품을 가리키면, 목록에서 그 묶음을 펼칠 길이 없으므로 가리켜진 작품이 최상위로 올라오고 `pieceCount`에 셉니다.

## 숨김을 보지 않는 곳

| 기능 | 까닭 |
| --- | --- |
| 즐겨찾기(`/me/favorites/composers`, `/me/favorites/pieces`) | 사용자가 고른 것입니다 |
| 비교(`/comparison-pieces`, `/pieces/<id>/comparison-sectors`, 연주자 비교 연주) | 발행된 비교 구간이라는 따로 된 공개 기준이 있습니다. 숨김은 시드 잡음을 거르는 것이라 발행된 비교와 겹치면 숨김이 잘못 걸린 쪽입니다. 비교가 말없이 사라지지 않게 둡니다 |
| 취향(`/taste/onboarding-pieces`, 홈 추천) | 온보딩 곡은 편집자가 `onboarding_order`로 고른 것이고, 추천 후보는 비교 카탈로그입니다 |
| 영화 속 클래식 큐, 작곡가 상세의 주요 작품(`majorPieces`) | 편집자가 이은 연결입니다 |

## 쿼리에서 쓰는 법

- 조건은 `src/piece/repository.rs`의 `listed_condition(alias)` 하나(`{alias}.hidden_reason IS NULL`)입니다. 작품·작곡가 표 모두 씁니다.
- 작곡가를 가로지르는 작품 목록은 작품과 작곡가를 둘 다 보고, 작곡가 작품 목록과 작품 수는 작품만 봅니다.
- 작품 수와 빈 작곡가 판정은 같은 `pieces p` 조인(`counted_pieces_join`)과 `HAVING COUNT(p.id) > 0`으로 맞춥니다.
- 작품·작곡가를 늘어놓는 쿼리를 새로 만들면 이 조건을 붙입니다.

## 성능

작곡가 3천·작품 2.5만·part 2.4만 합성 데이터에서 숨김 전후 SQL 을 번갈아 돌려 같은 시간을 확인했습니다(작곡가 검색·작곡가 작품 페이지 수십 ms 안).

- 빈 작곡가를 `EXISTS`로 따로 보면 숨김 조건 때문에 MySQL 이 작곡가 수를 작게 어림해 작품 수 조인을 작품마다 도는 길로 바꿉니다. `HAVING COUNT`로 거르면 전처럼 작곡가 기본 키 순으로 한 번에 셉니다.
- 최상위 조건의 묶음(`bundle`)은 `FORCE INDEX (PRIMARY)`로 찾습니다. 작곡가 인덱스로 같은 작곡가 작품을 작품마다 다시 훑는 계획(작곡가 목록 40초)을 막습니다.

## 검증

```bash
scripts/test_piece_parts.sh
```

임시 MySQL 에 최소 표와 `202610120001`, `202610120035` migration 을 올려 `tests/piece_parts_integration.rs`를 돌립니다.
