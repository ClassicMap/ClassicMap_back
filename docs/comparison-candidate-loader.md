# 비교 영상 후보 적재기

`load_comparison_candidates`는 검수된 비교 영상 후보 JSONL을 운영 공개 전 상태로 적재합니다. 이 명령은 영상을 내려받거나 prewarm manifest를 만들지 않으며, 운영 데이터베이스와 홈서버에서 자동 실행하면 안 됩니다.

## 안전 계약

- 작품은 `piece_identifiers.musicbrainz_work` 또는 `piece_parts.part_key=musicbrainz:{MBID}`로 정확히 해소하고, 연결된 작곡가의 `external_identifiers.wikidata`까지 교차 확인합니다. 악장·부분 작품이면 연주는 상위 `pieces`에, 비교 구간은 해당 `piece_part_id`에 연결합니다.
- 연주자는 `external_identifiers.wikidata → authority_entities → artists` 경로로만 해소합니다. 이름은 근거로 사용하지 않습니다.
- 기존 legacy 작품 또는 연주자를 해소하지 못하면 후보 적재 전체를 rollback합니다. 실패 실행과 `review_queue`만 남기므로 먼저 권위 식별자를 legacy 행에 연결해야 합니다.
- 입력의 `PIANIST`는 API canonical role인 `soloist`로 저장하고 원문 role은 후보 evidence에 보존합니다.
- `rightsMode=unknown` 후보만 받으며 `performance_candidates.REVIEW_REQUIRED`, `performances.DRAFT`, `clip_jobs.PENDING`까지만 만듭니다. `READY` 또는 `PUBLISHED` 전이는 이 명령의 기능이 아닙니다.
- 기존 행은 갱신하지 않습니다. 같은 자연키가 있으면 그대로 사용하며 `manual` 또는 `editor_locked` 행을 변경하지 않습니다.
- 모든 후보 변경과 `seed_mutations`는 하나의 transaction입니다. 중간 오류 시 전부 rollback됩니다.
- JSONL은 알 수 없는 필드를 거부합니다. 구간은 원본 길이 안의 1~600초여야 합니다.

## 실행

마이그레이션을 먼저 적용한 로컬 또는 staging 데이터베이스에서 실행합니다.

```bash
DATABASE_URL='mysql://...' cargo run --bin load_comparison_candidates -- \
  --bundle seed_pipeline/curation/pilot-2026-08-05/candidates.jsonl \
  --run-id 11111111-1111-4111-8111-111111111111 \
  --source-code-version "$(git rev-parse HEAD)" \
  --dry-run \
  --json-report /tmp/comparison-candidates-dry-run.json
```

dry-run은 후보 변경을 rollback하고 `seed_runs`에 검증 결과만 기록합니다. 실제 적재에는 dry-run과 다른 새 `run-id`를 사용하고 `--dry-run`을 제거합니다. 실제 적재 검증은 같은 bundle과 같은 실제 `run-id`에 `--resume`을 붙여 다시 실행하며, `plannedMutations.total`과 `mutations.total`이 모두 0이어야 합니다.

`--resume`은 성공한 동일 `run-id`의 멱등 재검증 전용입니다. 기존 run의 bundle SHA-256, 처리 행 수, run kind, command, status, dry-run 계약이 모두 같아야 합니다. 한 건이라도 새 mutation이 필요하면 전체 transaction을 rollback하고 실패하므로 누락 데이터를 자동 복구하지 않습니다. 후보 처리는 원자적이며 중간 checkpoint를 복원하는 기능은 아닙니다. `--limit N`은 전체 JSONL을 먼저 strict 검증한 다음 `candidateKey` 순으로 앞의 N건만 같은 transaction에 적재합니다.

## 다음 단계

권리 검토가 끝났더라도 이 적재기를 재사용해 공개하지 않습니다. 별도의 승인 절차에서 권리 mode와 근거, 검토 시각을 기록한 뒤 클립을 생성하고 FFprobe, SHA-256, Range 검증을 통과시켜야 합니다. 검증 자산은 `load_clip_assets`로 적재하며 그 전에는 prewarm manifest를 만들지 않습니다.
