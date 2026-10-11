#!/usr/bin/env bash
# 묶음 작품 part 조회·작곡가 작품 목록·목록 숨김 통합 테스트. 임시 MySQL 에 최소 표와 새 migration 만 올려 돌린다.
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
container_name="classicmap-piece-parts-${$}"
database_password=${TEST_DB_PASSWORD:-$(openssl rand -hex 16)}

cleanup() {
  docker rm -f "$container_name" >/dev/null 2>&1 || true
}
trap cleanup EXIT

docker run --detach --rm \
  --name "$container_name" \
  --publish 127.0.0.1::3306 \
  --env MYSQL_ROOT_PASSWORD="$database_password" \
  --env MYSQL_DATABASE=classicmap \
  mysql:8.0 >/dev/null

# 초기화 중 임시 서버는 소켓으로만 받는다. TCP 로 붙어야 본 서버가 뜬 것이다
for _ in $(seq 1 90); do
  if docker exec --env MYSQL_PWD="$database_password" "$container_name" \
    mysql --protocol=tcp --host=127.0.0.1 --user=root --execute="SELECT 1" >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

for file in scripts/fixtures/piece_parts_minimal_schema.sql \
  migrations/202610120001_add_piece_part_linked_piece.sql \
  migrations/202610120035_add_catalog_hidden_reason.sql; do
  docker exec --interactive --env MYSQL_PWD="$database_password" "$container_name" \
    mysql --user=root classicmap < "$repo_root/$file"
done

host_port=$(docker port "$container_name" 3306/tcp | awk -F: 'NR == 1 { print $NF }')
export DATABASE_URL="mysql://root:${database_password}@127.0.0.1:${host_port}/classicmap"

cargo test --quiet --manifest-path "$repo_root/Cargo.toml" \
  --test piece_parts_integration -- --ignored --test-threads=1
