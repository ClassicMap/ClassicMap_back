# Apple Music 앨범 링크 backfill 검증 기준선

## 범위

`202608050006_backfill_apple_music_album_links.sql`을 2025년 12월 9일 historical backup을 복원한 로컬 MySQL 8.0.46 전용 데이터베이스에서 검증했습니다. 운영 데이터베이스와 홈서버에는 쓰지 않았습니다.

## 적재 규칙

- 정규 링크의 대상은 `recording_id`이며 `track_id`를 사용하지 않습니다.
- 숫자로 검증된 `apple_music_id`를 우선 사용합니다.
- ID가 없을 때만 공식 `https://music.apple.com/{storefront}/album/{slug}/{album_id}` URL의 마지막 경로에서 숫자 앨범 ID를 추출합니다.
- storefront는 공식 URL의 `album` 앞 경로가 영문 두 글자일 때만 소문자로 저장합니다. ID만 있는 행은 빈 storefront와 `https://music.apple.com/album/{album_id}` URL을 사용합니다.
- ID와 URL이 모두 있으면서 값이 다르거나, 값이 있지만 검증할 수 없으면 링크를 추정하지 않고 `APPLE_ALBUM_SOURCE_CONFLICT` 검토 항목을 만듭니다.
- 기존 `platform_links`는 수정하거나 삭제하지 않습니다. 동일 고유 키의 대상 또는 URL이 다르면 `APPLE_ALBUM_EXISTING_LINK_CONFLICT`로 남깁니다.
- 같은 Apple 앨범 ID를 여러 legacy recording이 공유하고 기존 링크가 없으면 가장 작은 `recording_id`만 결정적으로 연결합니다. 나머지는 `APPLE_ALBUM_DUPLICATE_RECORDING`으로 남기며 legacy 컬럼은 유지합니다.
- `INSERT IGNORE`를 사용하지 않습니다. 충돌을 먼저 분류하고 새 고유 키만 삽입합니다.

## Historical backup 결과

| 항목 | 결과 |
|---|---:|
| recordings | 5,434 |
| 숫자 Apple ID와 일치하는 공식 앨범 URL | 5,434 |
| 고유 Apple album ID | 4,868 |
| 생성된 recording 대상 `platform_links` | 4,868 |
| 중복 recording 검토 항목 | 566 |
| source conflict | 0 |
| 기존 link conflict | 0 |
| storefront `us` | 4,868 |
| legacy ID·URL 정확 일치 | 4,868 |

같은 album ID를 공유한 476개 그룹에서 총 566개 추가 recording이 검토 대상으로 분리되었습니다. 예를 들어 `1296746883`은 recording `4242`, `4682`, `5487`, `6898`, `7065`가 공유했습니다. `4242`가 정규 링크를 소유하고 나머지 네 행은 검토 큐에 기록되었습니다.

샘플 recording `3538`은 다음 값으로 정확히 유지되었습니다.

```text
recording_id: 3538
storefront: us
platform_id: 1452313974
url: https://music.apple.com/us/album/debussy/1452313974
track_id: NULL
```

## 재실행 검증

동일 migration을 두 번 실행하기 전후로 링크와 해당 검토 큐의 행 수, 최대 ID, 행 내용 CRC 합계를 비교했습니다.

```text
platform_links before: 4868 / max_id 4868 / crc_sum 10567768608366
platform_links after:  4868 / max_id 4868 / crc_sum 10567768608366

review_queue before: 566 / max_id 566 / crc_sum 1242795753219
review_queue after:  566 / max_id 566 / crc_sum 1242795753219
```

두 번째 실행의 mutation은 0건이었습니다.

## 수동 링크 보존 검증

별도 복원 데이터베이스에서 다음 두 기존 링크를 migration 전에 넣었습니다.

- recording `3538`: legacy와 정확히 같은 링크, `verified_at` 지정
- recording `3539`: 같은 Apple 고유 키에 수동 URL을 지정, `verified_at` 지정

적용 후 두 행의 ID, URL, `verified_at`이 바뀌지 않았습니다. 전체 Apple 링크는 4,868건을 유지했고, 두 번째 수동 URL은 `APPLE_ALBUM_EXISTING_LINK_CONFLICT` 한 건으로 보고되었습니다. 동일 migration을 다시 실행했을 때 링크와 검토 큐의 행 수·최대 ID·CRC 합계가 그대로여서 mutation 0을 확인했습니다.

## 입력 경계 fixture

별도 로컬 fixture로 다음 경계를 실제 MySQL에서 확인했습니다.

| 입력 | 결과 |
|---|---|
| 숫자 ID만 존재 | 빈 storefront와 ID 기반 공식 URL로 연결 |
| 공식 `kr` 앨범 URL만 존재 | URL에서 ID를 추출하고 storefront `kr`로 연결 |
| ID와 URL의 앨범 ID 불일치 | 링크 없이 source conflict |
| 비공식 URL만 존재 | 링크 없이 source conflict |
| ID와 URL 모두 없음 | 추정하거나 검토 항목을 만들지 않음 |

Historical fixture assertion은 `scripts/verify_apple_music_album_backfill_historical.sql`로 재실행할 수 있습니다.
