#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "사용법: $0 <comparison-people-canonical.jsonl> <legacy-authority-links.jsonl>" >&2
  exit 2
fi

repo_root=$(cd "$(dirname "$0")/.." && pwd)
canonical_bundle=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
link_bundle=$(cd "$(dirname "$2")" && pwd)/$(basename "$2")
container_name="classicmap-comparison-linkage-$$"
database_name="classicmap"
database_password=$(openssl rand -hex 16)
work_dir=$(mktemp -d "/tmp/classicmap-comparison-linkage.XXXXXX")
bootstrap_bundle="$work_dir/authority-bootstrap.jsonl"
canonical_run_id=$(jq -r 'select(.table == "seed_runs") | .natural_key' "$canonical_bundle")
link_run_id="22222222-2222-4222-8222-222222222222"

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

manual_before=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --default-character-set=utf8mb4 \
  --execute="
    SELECT CONCAT(
      (SELECT COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, full_name, english_name,
        period, birth_year, COALESCE(death_year, ''), nationality, origin, editor_locked))), 0)
       FROM classicmap.composers WHERE id IN (4,28,29)), ':',
      (SELECT COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, english_name, category,
        nationality, COALESCE(birth_year, ''), COALESCE(bio, ''), COALESCE(style, ''),
        origin, editor_locked))), 0)
       FROM classicmap.artists WHERE id IN (186,204,207,249,250,256,261,311,367))
    );
  ")

cargo run --quiet --manifest-path "$repo_root/Cargo.toml" \
  --bin prepare_legacy_authority_bootstrap -- \
  --bundle "$canonical_bundle" \
  --output "$bootstrap_bundle" \
  --run-id "$canonical_run_id" \
  --json-report "$work_dir/bootstrap-prepare.json" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$bootstrap_bundle" \
  --json-report "$work_dir/bootstrap-load.json" >/dev/null

cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin link_legacy_authorities -- \
  --bundle "$link_bundle" \
  --run-id "$link_run_id" \
  --dry-run \
  --json-report "$work_dir/link-dry.json" >/dev/null
if [[ $(jq -r '.mutations.total' "$work_dir/link-dry.json") != "0" ]] \
  || [[ $(jq -r '.plannedMutations.total' "$work_dir/link-dry.json") -le 0 ]]; then
  echo "legacy linkage 첫 dry-run 결과가 올바르지 않습니다." >&2
  exit 1
fi
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin link_legacy_authorities -- \
  --bundle "$link_bundle" \
  --run-id "$link_run_id" \
  --json-report "$work_dir/link.json" \
  --rollback-manifest "$work_dir/link-rollback.json" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin link_legacy_authorities -- \
  --bundle "$link_bundle" \
  --run-id "$link_run_id" \
  --json-report "$work_dir/link-rerun.json" >/dev/null
if [[ $(jq -r '.plannedMutations.total' "$work_dir/link-rerun.json") != "0" ]]; then
  echo "legacy linkage 재실행이 mutation 0이 아닙니다." >&2
  exit 1
fi

cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$canonical_bundle" \
  --dry-run \
  --json-report "$work_dir/full-dry.json" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$canonical_bundle" \
  --json-report "$work_dir/full.json" >/dev/null
cargo run --quiet --manifest-path "$repo_root/Cargo.toml" --bin load_global_seed -- \
  --bundle "$canonical_bundle" \
  --json-report "$work_dir/full-rerun.json" >/dev/null
if [[ $(jq -r '.plannedMutations.total' "$work_dir/full-rerun.json") != "0" ]]; then
  echo "comparison people full bundle 재실행이 mutation 0이 아닙니다." >&2
  exit 1
fi
if [[ $(jq -r '.mutations.protectedReused' "$work_dir/full.json") -lt 6 ]]; then
  echo "현재 canonical에 projection이 있는 legacy 6행이 protected reuse되지 않았습니다." >&2
  exit 1
fi

linked_count=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT
      (SELECT COUNT(*) FROM classicmap.composers WHERE id IN (4,28,29)
       AND authority_entity_id IS NOT NULL)
      +
      (SELECT COUNT(*) FROM classicmap.artists WHERE id IN (186,204,207,249,250,256,261,311,367)
       AND authority_entity_id IS NOT NULL);
  ")
if [[ "$linked_count" != "12" ]]; then
  echo "명시 linkage 완료 행이 12개가 아닙니다: $linked_count" >&2
  exit 1
fi

duplicate_projection_count=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --execute="
    SELECT COUNT(*) FROM (
      SELECT authority_entity_id FROM classicmap.composers
      WHERE authority_entity_id IS NOT NULL GROUP BY authority_entity_id HAVING COUNT(*) > 1
      UNION ALL
      SELECT authority_entity_id FROM classicmap.artists
      WHERE authority_entity_id IS NOT NULL GROUP BY authority_entity_id HAVING COUNT(*) > 1
    ) duplicate_projection;
  ")
if [[ "$duplicate_projection_count" != "0" ]]; then
  echo "authority별 legacy projection 중복이 있습니다: $duplicate_projection_count" >&2
  exit 1
fi

manual_after=$(docker exec --env MYSQL_PWD="$database_password" "$container_name" \
  mysql --batch --skip-column-names --user=root --default-character-set=utf8mb4 \
  --execute="
    SELECT CONCAT(
      (SELECT COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, full_name, english_name,
        period, birth_year, COALESCE(death_year, ''), nationality, origin, editor_locked))), 0)
       FROM classicmap.composers WHERE id IN (4,28,29)), ':',
      (SELECT COALESCE(SUM(CRC32(CONCAT_WS('|', id, name, english_name, category,
        nationality, COALESCE(birth_year, ''), COALESCE(bio, ''), COALESCE(style, ''),
        origin, editor_locked))), 0)
       FROM classicmap.artists WHERE id IN (186,204,207,249,250,256,261,311,367))
    );
  ")
if [[ "$manual_before" != "$manual_after" ]]; then
  echo "명시 연결한 legacy 표시 필드가 변경되었습니다." >&2
  exit 1
fi

jq '{rowCount, mutations, plannedMutations}' "$work_dir/link.json"
jq '{rowCount, mutations, tableMutations}' "$work_dir/full.json"
echo "비교 인물 authority bootstrap, legacy 12행 명시 연결, full protected reuse 검증 완료"
