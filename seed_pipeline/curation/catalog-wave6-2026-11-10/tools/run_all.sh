#!/bin/bash
# 작곡가 목록(composers.txt: "<composer_id> <slug>" 한 줄씩)마다 자동 카탈로그 → SQL → 숨김 SQL.
# 사용: tools/run_all.sh <작업 폴더> <composers.txt>
#   <작업 폴더>/db/          tools/dump.sh 로 받은 운영 읽기 덤프
#   <작업 폴더>/<slug>/      catalog.json·seed_map.json·stats.json
#   <작업 폴더>/out/         <slug>.sql·<slug>_hide.sql·<slug>.stats.json
#   <작업 폴더>/logs/        작곡가별 로그, failed.txt 에 실패한 단계
# 규칙은 4차 auto/auto_catalog.py·gen_catalog.py 를 그대로 쓴다.
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
WAVE4="$(cd "$HERE/../../catalog-wave4-2026-10-12" && pwd)"
SEED="$(cd "$HERE/../../.." && pwd)"
WORK="$(cd "${1:?작업 폴더}" && pwd)"
LIST="$(cd "$(dirname "${2:?composers.txt}")" && pwd)/$(basename "$2")"
DB="$WORK/db"
mkdir -p "$WORK/out" "$WORK/logs"
: > "$WORK/logs/failed.txt"
cd "$SEED"
while read -r id slug; do
  [ -z "${id:-}" ] && continue
  case "$id" in \#*) continue;; esac
  if ! uv run python "$HERE/run_auto.py" --composer-id "$id" --slug "$slug" --db "$DB" \
      --out "$WORK/$slug" > "$WORK/logs/$slug.auto.log" 2>&1; then
    echo "$slug auto" >> "$WORK/logs/failed.txt"; continue
  fi
  if ! uv run python "$WAVE4/gen_catalog.py" --composer-id "$id" --slug "$slug" \
      --catalog "$WORK/$slug/catalog.json" --pieces "$DB/pieces.tsv" --taken "$DB/all_mbids_taken.tsv" \
      --seed-map "$WORK/$slug/seed_map.json" --out "$WORK/out/$slug.sql" \
      > "$WORK/out/$slug.stats.json" 2> "$WORK/logs/$slug.gen.log"; then
    echo "$slug gen" >> "$WORK/logs/failed.txt"; continue
  fi
  if ! uv run python "$WAVE4/gen_catalog.py" --hide-only --composer-id "$id" --pieces "$DB/pieces.tsv" \
      --seed-map "$WORK/$slug/seed_map.json" --out "$WORK/out/${slug}_hide.sql" \
      > /dev/null 2> "$WORK/logs/$slug.hide.log"; then
    echo "$slug hide" >> "$WORK/logs/failed.txt"; continue
  fi
  echo "$slug $(tail -1 "$WORK/logs/$slug.auto.log" | cut -c1-200)"
done < "$LIST"
echo DONE
