# ClassicMap 국제 초기 시드 v1 실행 사양

## 1. 목적

ClassicMap의 작곡가, 작품, 아티스트, 녹음, 스트리밍 링크, 비교영상 데이터를 국제 범위로 확장합니다. 초기 시드는 데이터베이스 행뿐 아니라 출처, 검수 상태, 홈서버 클립 자산, 곡 비교 및 아티스트 상세 노출까지 하나의 발행 단위로 관리합니다.

## 2. 현재 기준선

2026-08-05 운영 DB 읽기 전용 점검 기준입니다.

| 영역 | 현재 수량 | 핵심 제한 |
|---|---:|---|
| 작곡가 | 112 | 국제 범위와 시대 분류가 좁습니다. |
| 작품 | 451 | 작품번호 누락과 악장 계층 부재가 있습니다. |
| 아티스트 | 182 | 역할, 악기, 국가가 단일 값입니다. |
| 녹음/앨범 | 5,434 | Apple 앨범 중심이며 작품과 연결되지 않습니다. |
| 비교 작품 | 3 | 10개 섹터와 36개 performance만 존재합니다. |

## 3. 공개 목표

- 전체 공식 dump에서 조건에 맞는 후보를 모두 발견합니다.
- 자동 검증 가능한 후보는 숫자 상한 없이 발행합니다.
- 초기 공개 하한은 작곡가 500명, 작품·악장 25,000건, 아티스트 2,000개입니다.
- 연주비교는 대표 300곡, 약 510개 섹터, 활성 1,530개와 예비 510개를 목표로 합니다.
- 비교영상은 DB 행, 생성된 클립 파일, 검증 결과가 모두 준비되어야 발행할 수 있습니다.

## 4. 원본 우선순위

1. 후보 발견은 Wikidata structured dump를 사용합니다.
2. 음악 작품, 악장, 녹음 관계는 MusicBrainz core dump를 중심으로 합니다.
3. GND, VIAF, RISM, IMSLP는 식별과 작품번호 검증에 사용합니다.
4. Open Opus는 누락 후보 탐색에만 사용합니다.
5. 이미지는 Wikimedia Commons 파일별 라이선스를 검증합니다.
6. Apple Music과 Spotify는 ISRC가 확인된 트랙의 외부 링크 계층으로 사용합니다.
7. YouTube는 영상 후보와 원본 video ID, 타임스탬프의 출처로 사용합니다.

Wikipedia, Spotify, Apple Music, YouTube의 설명문을 ClassicMap 설명문으로 복사하거나 생성 모델 입력으로 사용하지 않습니다.

## 5. 식별 규칙

### 인물과 단체

- ClassicMap 내부 UUID를 영구 식별자로 사용합니다.
- MusicBrainz MBID, Wikidata QID, GND, VIAF, ISNI, RISM ID는 외부 식별자로 저장합니다.
- 이름만 같은 후보는 자동 병합하지 않습니다.
- 외부 서비스가 서로 직접 연결하거나 동일한 안정적 ID를 공유할 때만 자동 확정합니다.
- 작곡가와 연주자가 동일 인물일 수 있으므로 공통 authority entity를 사용합니다.

### 작품

작품 식별은 다음 조합을 사용합니다.

```text
작곡가 + 작품번호 체계 + 작품번호 + 판본/편곡/개정 + 악장 경로
```

원곡과 편곡은 별도 작품으로 저장하고 관계를 연결합니다. 작품번호 충돌은 review queue로 보냅니다.

### 녹음

- MusicBrainz Recording MBID와 ISRC를 중심으로 합니다.
- Apple Music과 Spotify는 `platform + storefront + platform_id`로 저장합니다.
- ISRC가 없거나 연주자와 duration이 충돌하면 자동 확정하지 않습니다.

## 6. 호환성 전략

기존 테이블은 v1에서 제거하거나 이름을 변경하지 않습니다.

```text
composers
pieces
artists
recordings
performance_sectors
performances
```

새 정규 테이블을 추가하고 기존 테이블에는 nullable authority/source FK를 연결합니다. 기존 API는 호환 projection으로 유지합니다.

## 7. 필수 정규 모델

### Authority

```text
authority_entities
entity_names
entity_roles
entity_instruments
entity_countries
external_identifiers
entity_images
```

### Works

```text
piece_aliases
piece_identifiers
piece_parts
piece_relations
piece_instrumentation
```

### Recordings

```text
recording_tracks
recording_contributors
track_piece_links
platform_links
```

### Provenance

```text
seed_runs
source_snapshots
source_records
field_provenance
review_queue
seed_mutations
```

### Comparison media

```text
performance_sources
performance_credits
performance_candidates
clip_jobs
clip_assets
```

## 8. 상태 머신

### 데이터 후보

```text
DISCOVERED
→ IDENTIFIERS_MATCHED
→ FACTS_VERIFIED
→ EDITOR_REVIEWED
→ PUBLISHED
```

충돌이나 근거 부족은 `REVIEW_REQUIRED`로 보냅니다.

### 클립 자산

```text
PENDING
→ QUEUED
→ GENERATING
→ READY
→ PUBLISHED
```

실패는 `FAILED`, 교체된 자산은 `RETIRED`로 기록합니다. `clip_assets.status = READY`가 아니면 performance를 공개할 수 없습니다.

## 9. 비교 구간 계약

`performance_sectors`는 다음 정보를 포함해야 합니다.

```text
piece_id
piece_part_id
sector_key
sector_type
name_ko
name_en
measure_start
measure_end
start_cue
end_cue
target_min_ms
target_max_ms
editorial_status
display_order
```

- `UNIQUE(piece_id, sector_key)`를 강제합니다.
- 권장 구간은 30~120초입니다.
- 기술적 최대 길이는 600초입니다.
- 각 영상의 타임스탬프는 달라도 같은 악보상 구간을 가리켜야 합니다.

## 10. Performance와 크레딧

한 원본 영상에 솔리스트, 지휘자, 오케스트라가 함께 연결될 수 있어야 합니다.

```text
performance_sources
- provider
- provider_video_id
- source_duration_ms
- availability_status
- last_checked_at

performance_credits
- performance_source_id
- artist_id
- role
- is_primary
- display_order
```

기존 `performances.artist_id`는 primary artist 호환 컬럼으로 유지합니다.

## 11. 클립 자산 계약

시드 입력 시 클립을 선생성합니다.

```text
performance DRAFT 입력
→ clip job QUEUED
→ 홈서버 생성
→ FFprobe 검증
→ SHA-256 계산
→ atomic rename
→ HTTP Range 206 검증
→ clip READY
→ performance PUBLISHED
```

파일 키는 다음처럼 결정적이어야 합니다.

```text
{provider_video_id}-{start_ms}-{duration_ms}-{encoding_profile_version}.mp4
```

시작/끝이 변경되면 새 파일을 먼저 생성하고 검증한 뒤 DB 연결을 교체합니다. 이전 파일은 `RETIRED` 후 지연 삭제합니다.

## 12. 아티스트 상세 노출

곡 비교 화면과 아티스트 상세 화면은 같은 performance와 credit을 사용합니다.

- 곡 비교는 `piece_id + sector_id`로 조회합니다.
- 아티스트 상세는 `performance_credits.artist_id`로 조회합니다.
- 아티스트 상세 응답에는 작품, 작곡가, 섹터, 역할, 클립 상태를 포함합니다.
- 목록에서는 모든 영상을 동시에 재생하지 않고 사용자가 선택한 영상만 로드합니다.
- `다른 연주자와 비교하기`는 해당 곡과 섹터가 선택된 비교 화면으로 이동합니다.

## 13. 시드 러너 계약

Python 3.12와 uv를 사용하며 `seed_pipeline/`에 독립 패키지를 둡니다.

```text
sources/
normalize/
resolve/
enrich/
streaming/
comparison/
clips/
validate/
export/
load/
```

모든 명령은 다음 옵션을 지원합니다.

```text
--run-id
--dry-run
--resume
--limit
--json-report
```

원본은 immutable JSONL과 manifest로 저장하며 수집기와 정규화기는 운영 DB에 직접 쓰지 않습니다.

## 14. 멱등성과 롤백

- 외부 ID와 결정적 natural key를 사용해 upsert합니다.
- 동일 run-id 재실행 시 중복 행과 파일을 만들지 않습니다.
- 운영 반영 전 두 번째 dry-run 결과는 mutation 0이어야 합니다.
- `seed_mutations`에 update 이전 값을 저장합니다.
- 롤백은 해당 run이 생성한 행과 자산만 대상으로 합니다.
- `origin = manual` 또는 `editor_locked = true`인 값은 롤백과 자동 수정에서 제외합니다.

## 15. 배치와 용량 게이트

비교영상은 다음 순서로 확대합니다.

```text
20곡 파일럿
→ 100곡
→ 300곡
```

클립 생성 concurrency는 1로 시작하고 100개 벤치마크 후 최대 2로 올립니다. 파일럿에서 초당 p95 바이트를 측정하고 다음 식으로 필요 공간을 계산합니다.

```text
p95 bytes/sec × 전체 클립 초 × 1.5
```

홈서버 여유 공간이 예상 필요량과 20% 여유를 충족하지 못하면 배치를 시작하지 않습니다.

## 16. 발행 합격 조건

### 데이터

- 외부 ID 중복 0건
- 고아 FK 0건
- 이름만으로 병합된 레코드 0건
- 수동 필드 변경 0건
- 공개 필드에 provenance 존재

### 스트리밍

- 자동 확정 링크는 ISRC 일치
- storefront와 검증 시각 존재
- 작품에 앨범 URL을 직접 연결한 신규 데이터 0건

### 비교영상

- 섹터당 서로 다른 primary artist 활성 영상 3개
- 같은 공연의 미러 영상 중복 0건
- 같은 canonical anchor 사용
- `0 < duration <= 600초`
- 클립 파일, SHA-256, FFprobe 결과 존재
- HTTP Range 206 성공
- 곡 비교와 아티스트 상세 양쪽에서 재생 성공

### 배치

- 최소 30건 이중 검수
- 전체의 10% 독립 재검수
- 치명적 오매칭 1건이면 배치 반려
- 경미 오류율 2% 초과면 배치 반려
- rollback manifest 존재
- 두 번째 dry-run mutation 0건

## 17. 절대 중단 조건

- 외부 ID 또는 작품번호 충돌
- 원곡과 편곡 구분 불가
- ISRC, 연주자, duration 충돌
- 같은 악보 구간인지 확인 불가
- 주요 연주자 역할 확인 불가
- 클립이 600초를 초과함
- FFprobe 또는 Range 검증 실패
- 홈서버 용량 부족
- 세 번째 서로 다른 연주자를 확보하지 못함
- 자동 시드가 수동 필드를 덮어쓰려 함
- 두 번째 dry-run에서 mutation이 발생함

