# 비교 카탈로그 API

## `GET /comparison-pieces`

공개 비교 구간이 하나 이상 있는 작품 목록. 공개 기준은 `/pieces/<id>/comparison-sectors` 와 같다.
연주자 수가 많은 작품부터, 같으면 공개 구간이 많은 작품부터 준다.

| 쿼리 | 뜻 |
|---|---|
| `composer` | 한 작곡가의 작품만 |
| `genre` | 한 장르의 작품만. 아래 키 말고는 400 |
| `offset` | 0 이상. 음수면 400 |
| `limit` | 1~50로 맞춘다. 기본 20 |

### 응답 한 줄

| 필드 | 뜻 |
|---|---|
| `pieceId`, `pieceTitle`, `opusNumber` | 작품 |
| `composerId`, `composerName`, `composerAvatarUrl` | 작곡가 |
| `genre` | 장르 키 또는 `null`(아직 분류하지 않음) |
| `sectorCount` | 공개 구간 수 |
| `performerCount` | 공개 구간에 나오는 서로 다른 주 연주자 수 |
| `performers` | 카드에 얼굴로 쓸 주 연주자, 최대 4명 |

홈 추천(`/me/recommendations/home`, `POST /recommendations/home`)의 `today`·`shelves[].items[]` 는
이 꼴에 `sectorId`·`sectorName`·`reasons` 를 더한 것이라 `genre` 도 같이 실린다.
온보딩 '아는 곡'(`/taste/onboarding-pieces`)에도 `genre` 가 있다.

## 장르 키

`pieces.genre` 의 CHECK 제약, `comparison::model::PIECE_GENRES` 와 같다.

| 키 | 화면 이름 | 넣는 곡 |
|---|---|---|
| `symphony` | 교향곡 | 교향곡(합창 교향곡 포함) |
| `concerto` | 협주곡 | 협주곡과 협주풍 작품 |
| `piano` | 피아노 | 건반 독주(하프시코드·피아노 연탄 포함) |
| `chamber` | 실내악 | 실내악과 건반 아닌 독주 |
| `orchestral` | 관현악 | 교향곡·협주곡이 아닌 관현악 |
| `stage` | 오페라·발레 | 오페라·오페레타·발레와 그 발췌 |
| `vocal` | 성악 | 가곡·합창·종교곡 |

분류 원본과 기준은 `seed_pipeline/curation/piece-genres-2026-11-07/`. 새 비교 작품은 이 파일에 줄을 더하고
새 마이그레이션으로 채운다(`.claude/skills/comparison-seed/references/04-loading.md`).
