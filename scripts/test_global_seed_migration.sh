#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
container_name="classicmap-global-seed-migration-${$}"
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
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin migrate
cargo test --quiet --manifest-path "$repo_root/Cargo.toml" \
  --test comparison_repository_integration -- --ignored
cargo test --quiet --manifest-path "$repo_root/Cargo.toml" \
  --test clip_asset_loader_integration -- --ignored --test-threads=1

backfill_counts_before=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT CONCAT(
      (SELECT COUNT(*) FROM classicmap.performance_sources), ':',
      (SELECT COUNT(*) FROM classicmap.performance_credits), ':',
      (SELECT COUNT(*) FROM classicmap.performances WHERE performance_source_id IS NOT NULL)
    );
  ")
docker exec --interactive --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --user=root "$database_name" \
  < "$repo_root/migrations/202608050003_backfill_legacy_performances.sql"
backfill_counts_after=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT CONCAT(
      (SELECT COUNT(*) FROM classicmap.performance_sources), ':',
      (SELECT COUNT(*) FROM classicmap.performance_credits), ':',
      (SELECT COUNT(*) FROM classicmap.performances WHERE performance_source_id IS NOT NULL)
    );
  ")
if [[ "$backfill_counts_before" != "$backfill_counts_after" ]]; then
  echo "legacy performance backfill이 멱등하지 않음" >&2
  exit 1
fi

assert_sql() {
  local sql=$1
  local expected=$2
  local actual
  actual=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
    mysql --batch --skip-column-names --user=root --execute="$sql")
  if [[ "$actual" != "$expected" ]]; then
    echo "검증 실패: expected=$expected actual=$actual" >&2
    exit 1
  fi
}

assert_sql \
  "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='classicmap' AND table_name IN ('authority_entities','piece_parts','recording_tracks','seed_runs','performance_sources','clip_assets');" \
  "6"
assert_sql \
  "SELECT IF(COUNT(*) = SUM(origin='manual' AND editor_locked=1), 1, 0) FROM classicmap.composers;" \
  "1"
assert_sql \
  "SELECT IF(COUNT(*) = SUM(origin='manual' AND editor_locked=1), 1, 0) FROM classicmap.artists;" \
  "1"
assert_sql \
  "SELECT IF(COUNT(*) = SUM(origin='manual' AND editor_locked=1), 1, 0) FROM classicmap.recordings;" \
  "1"
assert_sql \
  "SELECT IF(COUNT(*) = SUM(origin='manual' AND editor_locked=1), 1, 0) FROM classicmap.performances;" \
  "1"
assert_sql \
  "SELECT COUNT(*) FROM classicmap.performances WHERE performance_source_id IS NULL OR start_ms IS NULL OR end_ms IS NULL;" \
  "0"
assert_sql \
  "SELECT COUNT(*) FROM classicmap.performances performance LEFT JOIN classicmap.performance_credits credit ON credit.performance_source_id=performance.performance_source_id AND credit.artist_id=performance.artist_id AND credit.is_primary=1 WHERE credit.id IS NULL;" \
  "0"
assert_sql \
  "SELECT COUNT(*) FROM classicmap._sqlx_migrations WHERE success=1;" \
  "4"

if docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --user=root --execute="
    INSERT INTO classicmap.performances (
      sector_id, piece_id, artist_id, video_id, start_ms, end_ms
    )
    SELECT id, piece_id, (SELECT id FROM classicmap.artists LIMIT 1),
           'invalid-duration', 0, 600001
    FROM classicmap.performance_sectors LIMIT 1;
  " >/dev/null 2>&1; then
  echo "600초 초과 performance가 허용됨" >&2
  exit 1
fi

echo "global seed migration 검증 완료"
