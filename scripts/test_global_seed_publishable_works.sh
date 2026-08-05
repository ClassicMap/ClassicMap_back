#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 3 ]]; then
  echo "사용법: $0 <composer.jsonl> <composer-closure.jsonl> <publishable-works.jsonl>" >&2
  exit 2
fi

repo_root=$(cd "$(dirname "$0")/.." && pwd)
composer_bundle=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
closure_bundle=$(cd "$(dirname "$2")" && pwd)/$(basename "$2")
work_bundle=$(cd "$(dirname "$3")" && pwd)/$(basename "$3")
container_name="classicmap-publishable-works-$$"
database_name="classicmap"
database_password=$(openssl rand -hex 16)
report_dir=$(mktemp -d "/tmp/classicmap-publishable-works.XXXXXX")

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
      (SELECT COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, full_name, english_name,
        period, birth_year, COALESCE(death_year, ''), nationality, origin,
        editor_locked))), 0) FROM classicmap.composers WHERE origin='manual'), ':',
      (SELECT COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, english_name, category,
        nationality, COALESCE(birth_year, ''), COALESCE(bio, ''), COALESCE(style, ''),
        origin, editor_locked))), 0) FROM classicmap.artists WHERE origin='manual')
    );
  ")
piece_count_before=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root \
  --execute="SELECT COUNT(*) FROM classicmap.pieces;")

load_bundle() {
  local bundle=$1
  local label=$2
  cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
    --bundle "$bundle" \
    --json-report "$report_dir/$label.json" >/dev/null
}

load_bundle "$composer_bundle" "composer"
load_bundle "$closure_bundle" "closure"

cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$work_bundle" \
  --dry-run \
  --json-report "$report_dir/work-dry.json" >/dev/null
if [[ $(jq -r '.mutations.total' "$report_dir/work-dry.json") != "0" ]] \
  || [[ $(jq -r '.plannedMutations.total' "$report_dir/work-dry.json") -le 0 ]]; then
  echo "작품 첫 dry-run 결과가 올바르지 않습니다." >&2
  exit 1
fi

load_bundle "$work_bundle" "work"
load_bundle "$work_bundle" "work-rerun"
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$work_bundle" \
  --dry-run \
  --json-report "$report_dir/work-second-dry.json" >/dev/null

for report in "$report_dir/work-rerun.json" "$report_dir/work-second-dry.json"; do
  if [[ $(jq -r '.mutations.total' "$report") != "0" ]] \
    || [[ $(jq -r '.plannedMutations.total' "$report") != "0" ]]; then
    echo "작품 재실행이 mutation 0이 아닙니다: $report" >&2
    exit 1
  fi
done

expected_piece_count=$(jq -s '[.[] | select(.table == "pieces")] | length' "$work_bundle")
piece_count_after=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root \
  --execute="SELECT COUNT(*) FROM classicmap.pieces;")
if [[ $((piece_count_after - piece_count_before)) -ne "$expected_piece_count" ]]; then
  echo "작품 증가 수가 bundle과 다릅니다: expected=$expected_piece_count actual=$((piece_count_after - piece_count_before))" >&2
  exit 1
fi

expected_withheld=$(jq -s '[.[] | select(.table == "review_queue" and .values.reason_code == "WORK_COMPOSER_UNAVAILABLE")] | length' "$work_bundle")
work_seed_run_id=$(jq -r 'select(.table == "seed_runs") | .natural_key' "$work_bundle")
actual_withheld=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT COUNT(*) FROM classicmap.review_queue
    WHERE seed_run_id='$work_seed_run_id' AND reason_code='WORK_COMPOSER_UNAVAILABLE';
  ")
if [[ "$actual_withheld" != "$expected_withheld" ]]; then
  echo "미해소 작곡가 review 수가 다릅니다: expected=$expected_withheld actual=$actual_withheld" >&2
  exit 1
fi

orphan_count=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT
      (SELECT COUNT(*) FROM classicmap.pieces piece
       LEFT JOIN classicmap.composers composer ON composer.id=piece.composer_id
       WHERE composer.id IS NULL)
      +
      (SELECT COUNT(*) FROM classicmap.piece_parts part
       LEFT JOIN classicmap.pieces piece ON piece.id=part.piece_id
       WHERE piece.id IS NULL)
      +
      (SELECT COUNT(*) FROM classicmap.piece_parts part
       LEFT JOIN classicmap.piece_parts parent ON parent.id=part.parent_part_id
       WHERE part.parent_part_id IS NOT NULL AND parent.id IS NULL);
  ")
if [[ "$orphan_count" != "0" ]]; then
  echo "작품 또는 악장 FK orphan이 있습니다: $orphan_count" >&2
  exit 1
fi

manual_after=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT CONCAT(
      (SELECT COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, full_name, english_name,
        period, birth_year, COALESCE(death_year, ''), nationality, origin,
        editor_locked))), 0) FROM classicmap.composers WHERE origin='manual'), ':',
      (SELECT COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, english_name, category,
        nationality, COALESCE(birth_year, ''), COALESCE(bio, ''), COALESCE(style, ''),
        origin, editor_locked))), 0) FROM classicmap.artists WHERE origin='manual')
    );
  ")
if [[ "$manual_before" != "$manual_after" ]]; then
  echo "기존 수동 composer 또는 artist 표시 필드가 변경되었습니다." >&2
  exit 1
fi

jq '{rowCount, seedRunId, mutations, tableMutations}' "$report_dir/work.json"
echo "composer 선적재 후 발행 가능 작품 적재 및 재실행 mutation 0 검증 완료"
