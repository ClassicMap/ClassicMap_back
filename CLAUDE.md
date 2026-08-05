# ClassicMap Backend 작업 지침

## 기준 문서

- 국제 초기 시드 작업은 `docs/specs/2026-08-05-global-seed-v1.md`를 기준으로 수행합니다.
- 승인된 데이터 계약을 변경해야 하면 구현을 중단하고 변경 사유와 영향을 먼저 보고합니다.

## 안전 경계

- 운영 DB에 직접 쓰지 않습니다.
- 기존 `schema.sql`은 테이블을 삭제하므로 운영 또는 staging migration에 사용하지 않습니다.
- 스키마 변경은 `migrations/`의 additive SQL로만 추가합니다.
- 기존 수동 데이터와 `editor_locked` 필드를 자동 시드가 덮어쓰지 못하게 합니다.
- 이름만으로 인물, 작품, 녹음을 자동 병합하지 않습니다.
- 비밀값을 코드, 로그, fixture, 문서에 기록하지 않습니다.

## 구현 원칙

- 기존 `composers`, `pieces`, `artists`, `recordings`, `performance_sectors`, `performances` API 호환성을 유지합니다.
- 새 정규 테이블을 먼저 추가하고 기존 컬럼 제거와 이름 변경은 별도 호환성 제거 작업으로 미룹니다.
- 모든 시드 명령은 `--run-id`, `--dry-run`, `--resume`, `--limit`, `--json-report`를 지원합니다.
- 외부 데이터는 immutable snapshot과 SHA-256 manifest를 거쳐 staging에 적재합니다.
- 시드의 두 번째 dry-run에서 mutation이 발생하면 배포하지 않습니다.
- 새 코드는 명시적 타입을 사용하며 `any`, 하드코딩된 비밀값, 임의의 fallback scraping을 추가하지 않습니다.

## 비교영상

- 비교 구간은 같은 작품의 같은 악보상 구간을 가리켜야 합니다.
- 기본 권장 길이는 30~120초이고 기술적 최대는 600초입니다.
- `performance`는 클립 자산이 `ready`가 되기 전에는 공개할 수 없습니다.
- 곡 비교 화면과 아티스트 상세 화면은 동일한 performance/credit 데이터를 사용합니다.
- 기존 `artist_id`는 호환용이며 새 크레딧은 다대다 구조를 사용합니다.

## 검증

변경 범위에 맞게 다음을 실행합니다.

```bash
cargo fmt --check
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-features
cargo build --release
```

시드 파이프라인은 다음을 통과해야 합니다.

```bash
uv run ruff check .
uv run mypy .
uv run pytest
```

## Git

- 한 커밋에는 하나의 작업 패킷만 포함합니다.
- 커밋 메시지는 한국어로 작성합니다.
- 다른 worktree의 미커밋 변경을 복사하거나 되돌리지 않습니다.

