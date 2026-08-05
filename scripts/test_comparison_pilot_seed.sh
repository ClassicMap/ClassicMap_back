#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 4 ]]; then
  echo "사용법: $0 <people-canonical.jsonl> <legacy-links.jsonl> <works-canonical.jsonl> <candidates.jsonl>" >&2
  exit 2
fi

repo_root=$(cd "$(dirname "$0")/.." && pwd)
people_bundle=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
link_bundle=$(cd "$(dirname "$2")" && pwd)/$(basename "$2")
work_bundle=$(cd "$(dirname "$3")" && pwd)/$(basename "$3")
candidate_bundle=$(cd "$(dirname "$4")" && pwd)/$(basename "$4")
container_name="classicmap-comparison-pilot-$$"
database_name="classicmap"
database_password=$(openssl rand -hex 16)
work_dir=$(mktemp -d "/tmp/classicmap-comparison-pilot.XXXXXX")
bootstrap_bundle="$work_dir/people-authority-bootstrap.jsonl"
people_run_id=$(jq -r 'select(.table == "seed_runs") | .natural_key' "$people_bundle")
link_run_id="44444444-4444-4444-8444-444444444444"
candidate_dry_run_id="55555555-5555-4555-8555-555555555555"
candidate_run_id="66666666-6666-4666-8666-666666666666"

cleanup() {
  docker rm -f "$container_name" >/dev/null 2>&1 || true
  rm -rf "$work_dir"
}
trap cleanup EXIT

docker run --detach --rm \
  --name "$container_name" \
  --publish 127.0.0.1::3306 \
  --env MYSQL_ROOT_PASSWORD="$database_password" \
  --env MYSQL_DATABASE="$database_name" \
  mysql:8.0 >/dev/null
for _ in $(seq 1 60); do
  if docker exec --env MYSQL_PWD="$database_password" "$container_name" \
    mysql --batch --skip-column-names --user=root --execute="SELECT 1" >/dev/null 2>&1; then
    break
  fi
  sleep 1
done
docker exec --interactive --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --user=root --default-character-set=utf8mb4 "$database_name" \
  < "$repo_root/classicmap_backup_20251209_061305.sql"
host_port=$(docker port "$container_name" 3306/tcp | awk -F: 'NR == 1 { print $NF }')
export DATABASE_URL="mysql://root:$database_password@127.0.0.1:$host_port/$database_name"
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin migrate

cargo run --quiet --manifest-path "$repo_root/Cargo.toml" \
  --bin prepare_legacy_authority_bootstrap -- \
  --bundle "$people_bundle" \
  --output "$bootstrap_bundle" \
  --run-id "$people_run_id" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$bootstrap_bundle" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin link_legacy_authorities -- \
  --bundle "$link_bundle" \
  --run-id "$link_run_id" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$people_bundle" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$work_bundle" >/dev/null

cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_comparison_candidates -- \
  --bundle "$candidate_bundle" \
  --run-id "$candidate_dry_run_id" \
  --dry-run \
  --json-report "$work_dir/candidate-dry.json" >/dev/null
if [[ $(jq -r '.mutations.total' "$work_dir/candidate-dry.json") != "0" ]] \
  || [[ $(jq -r '.plannedMutations.total' "$work_dir/candidate-dry.json") -le 0 ]]; then
  echo "비교 후보 첫 dry-run 결과가 올바르지 않습니다." >&2
  exit 1
fi
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_comparison_candidates -- \
  --bundle "$candidate_bundle" \
  --run-id "$candidate_run_id" \
  --json-report "$work_dir/candidate.json" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_comparison_candidates -- \
  --bundle "$candidate_bundle" \
  --run-id "$candidate_run_id" \
  --resume \
  --json-report "$work_dir/candidate-rerun.json" >/dev/null
if [[ $(jq -r '.plannedMutations.total' "$work_dir/candidate-rerun.json") != "0" ]]; then
  echo "비교 후보 재실행이 mutation 0이 아닙니다." >&2
  exit 1
fi

state=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT CONCAT(
      (SELECT COUNT(*) FROM classicmap.performance_candidates candidate
       WHERE candidate.seed_run_id='$candidate_run_id' AND candidate.candidate_status='REVIEW_REQUIRED'), ':',
      (SELECT COUNT(*) FROM classicmap.performances performance
       JOIN classicmap.clip_jobs job ON job.performance_id=performance.id
       WHERE performance.seed_run_id='$candidate_run_id'
         AND performance.publish_status='DRAFT' AND job.status='PENDING'), ':',
      (SELECT COUNT(*) FROM classicmap.performance_sectors sector
       JOIN classicmap.performance_candidates candidate ON candidate.sector_id=sector.id
       JOIN classicmap.piece_parts part ON part.id=sector.piece_part_id
       JOIN JSON_TABLE(
         candidate.evidence,
         '$.workCandidate.externalIdentifiers[*]' COLUMNS(
           namespace VARCHAR(64) PATH '$.namespace',
           external_id VARCHAR(64) PATH '$.value'
         )
       ) work_identifier ON work_identifier.namespace='musicbrainz_work'
       WHERE candidate.seed_run_id='$candidate_run_id'
         AND part.part_key=CONCAT('musicbrainz:', work_identifier.external_id)), ':',
      (SELECT COUNT(*) FROM classicmap.clip_assets asset
       JOIN classicmap.performances performance ON performance.id=asset.performance_id
       WHERE performance.seed_run_id='$candidate_run_id'), ':',
      (SELECT COUNT(DISTINCT credit.artist_id) FROM classicmap.performance_credits credit
       JOIN classicmap.performance_sources source ON source.id=credit.performance_source_id
       JOIN classicmap.performance_candidates candidate
         ON candidate.performance_source_id=source.id
       WHERE candidate.seed_run_id='$candidate_run_id')
    );
  ")
if [[ "$state" != "15:15:15:0:13" ]]; then
  echo "비교 후보 상태가 예상과 다릅니다: $state" >&2
  exit 1
fi

jq '{rowCount, mutations, tableMutations}' "$work_dir/candidate.json"
echo "비교 파일럿 15건을 정확 악장·13명 연주자에 DRAFT/PENDING으로 적재하고 재실행 mutation 0 검증 완료"
