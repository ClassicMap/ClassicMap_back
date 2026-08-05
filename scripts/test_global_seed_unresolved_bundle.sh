#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "사용법: $0 <prerequisite.jsonl> <expected-unresolved.jsonl>" >&2
  exit 2
fi

repo_root=$(cd "$(dirname "$0")/.." && pwd)
prerequisite=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
unresolved=$(cd "$(dirname "$2")" && pwd)/$(basename "$2")
container_name="classicmap-unresolved-bundle-$$"
database_name="classicmap"
database_password=$(openssl rand -hex 16)
report_path=$(mktemp "/tmp/classicmap-unresolved-report.XXXXXX")

cleanup() {
  docker rm -f "$container_name" >/dev/null 2>&1 || true
  rm -f "$report_path"
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
  mysql --user=root "$database_name" < "$repo_root/classicmap_backup_20251209_061305.sql"
host_port=$(docker port "$container_name" 3306/tcp | awk -F: 'NR == 1 { print $NF }')
export DATABASE_URL="mysql://root:$database_password@127.0.0.1:$host_port/$database_name"
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin migrate
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$prerequisite" >/dev/null

state_query="
  SELECT CONCAT(
    (SELECT COUNT(*) FROM classicmap.seed_runs), ':',
    (SELECT COUNT(*) FROM classicmap.source_snapshots), ':',
    (SELECT COUNT(*) FROM classicmap.source_records), ':',
    (SELECT COUNT(*) FROM classicmap.pieces), ':',
    (SELECT COUNT(*) FROM classicmap.piece_parts), ':',
    (SELECT COUNT(*) FROM classicmap.seed_natural_keys), ':',
    (SELECT COUNT(*) FROM classicmap.seed_mutations)
  );
"
before=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="$state_query")

set +e
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$unresolved" \
  --json-report "$report_path" >/dev/null 2>&1
exit_code=$?
set -e

if [[ $exit_code -ne 2 ]]; then
  echo "unresolved bundle exit code가 2가 아님: $exit_code" >&2
  cat "$report_path" >&2
  exit 1
fi
if [[ $(jq -r '.error.code' "$report_path") != "EXISTING_FOREIGN_KEY_MISSING" ]]; then
  echo "unresolved bundle 오류 코드가 다름" >&2
  cat "$report_path" >&2
  exit 1
fi

after=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="$state_query")
if [[ "$before" != "$after" ]]; then
  echo "unresolved bundle 실패 후 DB 상태가 변경됨: before=$before after=$after" >&2
  exit 1
fi

unresolved_run_id=$(head -n 1 "$unresolved" | jq -r '.seed_run_id')
persisted=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT
      (SELECT COUNT(*) FROM classicmap.seed_runs WHERE id='$unresolved_run_id')
      +
      (SELECT COUNT(*) FROM classicmap.seed_natural_keys
       WHERE last_seed_run_id='$unresolved_run_id');
  ")
if [[ "$persisted" != "0" ]]; then
  echo "실패한 bundle run이 일부 persist됨" >&2
  exit 1
fi

jq '{status, exitCode, error}' "$report_path"
echo "unresolved bundle preflight 실패 및 zero-write 검증 완료"
