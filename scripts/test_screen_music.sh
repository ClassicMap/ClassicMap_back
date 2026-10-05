#!/usr/bin/env bash
# 영화 속 클래식 적재기·조회 통합 테스트. 임시 MySQL 에 최소 표와 새 migration 만 올려 돌린다.
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
container_name="classicmap-screen-music-${$}"
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

for _ in $(seq 1 90); do
  if docker exec --env MYSQL_PWD="$database_password" "$container_name" \
    mysql --user=root --execute="SELECT 1" >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

for file in scripts/fixtures/screen_music_minimal_schema.sql migrations/202610050002_add_screen_music.sql migrations/202610050003_add_screen_title_cover_clip.sql; do
  docker exec --interactive --env MYSQL_PWD="$database_password" "$container_name" \
    mysql --user=root classicmap < "$repo_root/$file"
done

host_port=$(docker port "$container_name" 3306/tcp | awk -F: 'NR == 1 { print $NF }')
export DATABASE_URL="mysql://root:${database_password}@127.0.0.1:${host_port}/classicmap"

cargo test --quiet --manifest-path "$repo_root/Cargo.toml" \
  --test screen_music_integration -- --ignored --test-threads=1
