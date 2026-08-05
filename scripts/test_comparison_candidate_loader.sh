#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
container_name="classicmap-comparison-candidate-loader-${$}"
database_name="classicmap"
database_password=${TEST_DB_PASSWORD:-$(openssl rand -hex 16)}

cleanup() {
  docker rm -f "$container_name" >/dev/null 2>&1 || true
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
export DATABASE_URL="mysql://root:${database_password}@127.0.0.1:${host_port}/${database_name}"

cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin migrate
cargo test --quiet --manifest-path "$repo_root/Cargo.toml" \
  --test comparison_seed_loader_integration -- --ignored --test-threads=1

echo "comparison candidate loader 검증 완료"
