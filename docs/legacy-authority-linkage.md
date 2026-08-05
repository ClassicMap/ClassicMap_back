# Legacy composer/artist authority 명시 연결

기존 `origin=manual`, `editor_locked=true` composer/artist를 국제 시드의 authority entity와
연결할 때는 이름 자동 매칭을 사용하지 않습니다. 검수자가 legacy ID와 안정적 외부 식별자를
명시하고, 실행기는 현재 표시필드 fingerprint를 drift guard로만 사용합니다.

## 안전한 3단계 순서

full canonical bundle에는 authority와 composer/artist projection이 함께 있습니다. legacy 연결
전에 full bundle을 적재하지 않습니다. 다음 순서를 지켜야 합니다.

### 1. Authority bootstrap 생성 및 적재

full canonical 전체를 strict parse한 뒤 `authority_entities`, `external_identifiers`와 이들이
참조하는 `source_records`, `source_snapshots`, `seed_runs` 의존성 폐쇄만 추출합니다.

```bash
prepare_legacy_authority_bootstrap \
  --bundle /data/global-seed-v1.jsonl \
  --output /data/global-seed-v1-authority-bootstrap.jsonl \
  --run-id 11111111-1111-4111-8111-111111111111 \
  --dry-run \
  --json-report /data/authority-prepare-dry.json

prepare_legacy_authority_bootstrap \
  --bundle /data/global-seed-v1.jsonl \
  --output /data/global-seed-v1-authority-bootstrap.jsonl \
  --run-id 11111111-1111-4111-8111-111111111111 \
  --json-report /data/authority-prepare.json

load_global_seed \
  --bundle /data/global-seed-v1-authority-bootstrap.jsonl \
  --dry-run \
  --json-report /data/authority-load-dry.json

load_global_seed \
  --bundle /data/global-seed-v1-authority-bootstrap.jsonl \
  --json-report /data/authority-load.json \
  --rollback-manifest /data/authority-load-rollback.json
```

bootstrap 생성기는 출력 SHA-256과 table별 행 수를 보고합니다. 기존 출력이 같은 내용이면
`--resume`에서 재사용하고, 내용이 다르면 `BOOTSTRAP_OUTPUT_CONFLICT`로 중단합니다.

### 2. Legacy ID 명시 연결

linkage JSONL은 각 행에 다음 필드를 사용합니다.

```json
{
  "entityType": "composer",
  "legacyId": 28,
  "expectedFingerprint": {
    "name": "라흐마니노프",
    "englishName": "Sergei Rachmaninoff",
    "birthYear": "1873"
  },
  "authorityIdentifier": {
    "namespace": "wikidata",
    "value": "Q992"
  },
  "reviewedAt": "2026-08-05T00:00:00Z",
  "reviewer": "reviewer-id",
  "evidence": {
    "url": "https://www.wikidata.org/wiki/Q992",
    "note": "Legacy ID와 Wikidata 인물을 명시적으로 대조했습니다."
  }
}
```

- `entityType`: `composer` 또는 `artist`
- `legacyId`: 기존 table의 양의 정수 ID
- `expectedFingerprint.name`: 필수이며 DB 값과 byte 단위로 같아야 합니다.
- `expectedFingerprint.englishName`, `birthYear`: DB에 값이 있으면 반드시 포함해야 합니다.
- `authorityIdentifier.namespace`: `wikidata` 또는 `musicbrainz_artist`
- `authorityIdentifier.value`: QID 또는 MusicBrainz artist UUID
- `reviewedAt`: RFC3339 timestamp
- `reviewer`: 검수자 식별 문자열
- `evidence.url`: HTTPS URL
- `evidence.note`: 검수 근거

```bash
link_legacy_authorities \
  --bundle /data/legacy-authority-links.jsonl \
  --run-id 22222222-2222-4222-8222-222222222222 \
  --dry-run \
  --json-report /data/legacy-links-dry.json

link_legacy_authorities \
  --bundle /data/legacy-authority-links.jsonl \
  --run-id 22222222-2222-4222-8222-222222222222 \
  --json-report /data/legacy-links.json \
  --rollback-manifest /data/legacy-links-rollback.json
```

실행기는 외부 ID를 DB에서 정확히 한 authority로 해소하고, 모든 legacy row를 `FOR UPDATE`로
잠근 뒤 한 transaction에서 처리합니다. 한 행이라도 fingerprint, authority, ownership 검증에
실패하면 전체 bundle이 zero-write로 종료됩니다.

변경 가능한 컬럼은 `authority_entity_id`와, 기존 값이 `NULL`일 때의 `source_record_id`뿐입니다.
이름, 소개, 이미지, 분류, 국가, `origin`, `editor_locked` 등 기존 표시·소유권 필드는 변경하지
않습니다. 각 변경은 `seed_runs`와 `seed_mutations`에 검수 근거와 함께 기록합니다.

### 3. Full canonical 적재

```bash
load_global_seed \
  --bundle /data/global-seed-v1.jsonl \
  --dry-run \
  --json-report /data/global-full-dry.json

load_global_seed \
  --bundle /data/global-seed-v1.jsonl \
  --json-report /data/global-full.json \
  --rollback-manifest /data/global-full-rollback.json

load_global_seed \
  --bundle /data/global-seed-v1.jsonl \
  --dry-run \
  --json-report /data/global-full-second-dry.json
```

full loader는 같은 legacy table/ID/authority에 성공한 `legacy_authority_linkage`
`seed_mutations`가 있을 때만 다른 canonical 표시값을 `ProtectedReuse`합니다. audit가 없거나
authority가 다르면 기존 `MANUAL_ROW_CONFLICT`를 유지합니다. 따라서 명시 연결된 수동 행은
보존되고 canonical composer/artist 중복은 생성되지 않습니다.

## 중단 조건

- 알 수 없는 JSON field, 빈 JSONL 행
- 중복 `(entityType, legacyId)` 또는 중복 `(namespace, value)`
- 지원하지 않는 namespace 또는 잘못된 QID/UUID
- 외부 ID가 없거나 둘 이상의 authority로 해소됨
- legacy row가 없거나 `origin=manual`, `editor_locked=true`가 아님
- 현재 name/englishName/birthYear가 expected fingerprint와 다름
- 같은 entity type의 다른 legacy row가 authority를 이미 사용함
- 대상 legacy row가 다른 authority에 이미 연결됨
- 같은 run ID의 기존 manifest가 현재 input SHA-256과 다름

오류 exit code는 입력/계약 오류 `2`, DB/보고서 오류 `3`입니다.

## 멱등성과 롤백

같은 `--run-id`, 같은 bundle의 재실행과 두 번째 dry-run은 `plannedMutations.total=0`이어야
합니다. 실제 실행의 linkage rollback manifest는 legacy 연결 컬럼 복원, 이번 실행에서 새로
생성한 audit ID의 삭제, 새로 만든 seed run 삭제 순서를 기록합니다. 기존 run을 resume해
복구한 경우에도 과거 audit는 삭제 대상으로 잡지 않습니다. dry-run manifest의 audit 삭제는
아직 ID가 없으므로 run 단위 계획으로 표시됩니다. 현재 manifest는 검수 가능한 실행 계획이며
자동 rollback executor는 제공하지 않습니다. full canonical을 적재한 뒤에는 full rollback을
먼저 수행해야 합니다.
