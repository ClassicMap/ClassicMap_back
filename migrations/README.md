# ClassicMap SQL migrations

운영 데이터베이스 변경은 이 디렉터리의 additive SQL migration으로만 수행합니다.

- 기존 `schema.sql`은 신규 로컬 데이터베이스 초기화 전용이며 migration으로 실행하지 않습니다.
- 적용된 migration은 수정하지 않고 후속 migration을 추가합니다.
- 기존 컬럼의 삭제, 이름 변경, 타입 축소는 국제 초기 시드 v1 범위에서 금지합니다.
- migration은 애플리케이션이 데이터베이스 연결 직후 실행하며, 실패하면 서버 시작을 중단합니다.

## global-seed-v1 적재

load_global_seed는 Python pipeline의 CanonicalLoadRecord JSONL을 한 bundle 단위
트랜잭션으로 적재합니다. 24개 LoadTable을 모두 명시적으로 지원하며 알 수 없는
table, column, 타입, 누락 FK는 첫 SQL 전에 실패합니다.

~~~bash
DATABASE_URL='mysql://...' cargo run --bin load_global_seed -- \
  --bundle /absolute/path/to/canonical.jsonl \
  --dry-run \
  --json-report /tmp/global-seed-dry.json \
  --rollback-manifest /tmp/global-seed-rollback.json
~~~

검증 후 --dry-run만 제거해 실제 적재합니다. 동일 bundle 재실행과 두 번째
dry-run의 plannedMutations.total은 0이어야 합니다. --limit은 부분 적재가
아니라 bundle 최대 허용 행 수입니다.

- exit code 0: 성공
- exit code 2: strict JSONL, 계약, natural key, FK 또는 파일 오류
- exit code 3: DB 연결/트랜잭션 또는 보고서 작성 오류

historical backup 기반 전체 migration/소형 bundle 검증:

~~~bash
scripts/test_global_seed_migration.sh
~~~

실제 pipeline canonical artifact 대량 적재/재실행 검증:

~~~bash
scripts/test_global_seed_canonical_bundle.sh /absolute/path/to/canonical.jsonl
~~~

두 스크립트 모두 임시 MySQL Docker만 사용하며 운영·홈서버 DB에는 쓰지 않습니다.

기존 수동 composer/artist를 authority에 명시 연결하는 JSONL 계약과 안전한
`authority bootstrap → explicit link → full canonical` 순서는
`docs/legacy-authority-linkage.md`를 따릅니다. 이름 자동 매칭은 사용하지 않습니다.
