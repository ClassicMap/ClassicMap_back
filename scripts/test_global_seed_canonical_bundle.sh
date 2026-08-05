#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "사용법: $0 <global-seed-v1.jsonl>" >&2
  exit 2
fi

repo_root=$(cd "$(dirname "$0")/.." && pwd)
bundle_path=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
container_name="classicmap-canonical-bundle-$$"
database_name="classicmap"
database_password=$(openssl rand -hex 16)
report_dir=$(mktemp -d "/tmp/classicmap-canonical-report.XXXXXX")

cleanup() {
  docker rm -f "$container_name" >/dev/null 2>&1 || true
  rm -rf "$report_dir"
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

docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="SELECT 1" >/dev/null
docker exec --interactive --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --user=root "$database_name" < "$repo_root/classicmap_backup_20251209_061305.sql"

host_port=$(docker port "$container_name" 3306/tcp | awk -F: 'NR == 1 { print $NF }')
export DATABASE_URL="mysql://root:$database_password@127.0.0.1:$host_port/$database_name"
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin migrate

manual_before=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT CONCAT(
      COUNT(*), ':',
      COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, full_name, english_name, period,
        birth_year, COALESCE(death_year, ''), nationality, origin, editor_locked))), 0)
    )
    FROM classicmap.composers
    WHERE origin='manual';
  ")

cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$bundle_path" \
  --dry-run \
  --json-report "$report_dir/first-dry.json" \
  --rollback-manifest "$report_dir/first-dry-rollback.json" >/dev/null

if [[ $(jq -r '.mutations.total' "$report_dir/first-dry.json") != "0" ]]; then
  echo "첫 dry-run이 DB mutation을 기록함" >&2
  exit 1
fi
if [[ $(jq -r '.plannedMutations.total' "$report_dir/first-dry.json") -le 0 ]]; then
  echo "첫 dry-run planned mutation이 없음" >&2
  exit 1
fi

cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$bundle_path" \
  --json-report "$report_dir/load.json" \
  --rollback-manifest "$report_dir/rollback.json" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$bundle_path" \
  --json-report "$report_dir/rerun.json" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$bundle_path" \
  --dry-run \
  --json-report "$report_dir/second-dry.json" >/dev/null

for report in "$report_dir/rerun.json" "$report_dir/second-dry.json"; do
  if [[ $(jq -r '.mutations.total' "$report") != "0" ]] \
    || [[ $(jq -r '.plannedMutations.total' "$report") != "0" ]]; then
    echo "재실행이 mutation 0이 아님: $report" >&2
    jq '{mutations, plannedMutations}' "$report" >&2
    exit 1
  fi
done

manual_after=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT CONCAT(
      COUNT(*), ':',
      COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, full_name, english_name, period,
        birth_year, COALESCE(death_year, ''), nationality, origin, editor_locked))), 0)
    )
    FROM classicmap.composers
    WHERE origin='manual';
  ")
if [[ "$manual_before" != "$manual_after" ]]; then
  echo "manual composer checksum이 변경됨" >&2
  exit 1
fi

seed_run_id=$(jq -r '.seedRunId' "$report_dir/load.json")
actual_mutations=$(jq -r '.mutations.total' "$report_dir/load.json")
database_mutations=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT COUNT(*) FROM classicmap.seed_mutations WHERE seed_run_id='$seed_run_id';
  ")
if [[ "$actual_mutations" != "$database_mutations" ]]; then
  echo "report와 seed_mutations count가 다름" >&2
  exit 1
fi

orphan_count=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT
      (SELECT COUNT(*) FROM classicmap.source_records record
       LEFT JOIN classicmap.source_snapshots snapshot ON snapshot.id=record.snapshot_id
       WHERE snapshot.id IS NULL)
      +
      (SELECT COUNT(*) FROM classicmap.authority_entities authority
       LEFT JOIN classicmap.source_records record ON record.id=authority.canonical_source_record_id
       WHERE authority.canonical_source_record_id IS NOT NULL AND record.id IS NULL)
      +
      (SELECT COUNT(*) FROM classicmap.composers composer
       LEFT JOIN classicmap.authority_entities authority ON authority.id=composer.authority_entity_id
       WHERE composer.origin='seed' AND authority.id IS NULL);
  ")
if [[ "$orphan_count" != "0" ]]; then
  echo "canonical bundle FK orphan이 있음: $orphan_count" >&2
  exit 1
fi

jq '{
  rowCount,
  seedRunId,
  mutations,
  plannedMutations,
  tableMutations
}' "$report_dir/load.json"
echo "canonical bundle 실제 적재 및 재실행 mutation 0 검증 완료"
