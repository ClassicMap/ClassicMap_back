#!/bin/bash
# 영화 작곡가 목록(film_composers.txt: "<composer_id> <slug> <wikidata QID>")마다
# 음반 묶음 카탈로그(film_catalog.py) → SQL → 숨김 SQL. 출력 꼴은 run_all.sh 와 같다.
# 사용: tools/run_film.sh <작업 폴더> <film_composers.txt> [films.tsv] [ko_titles.tsv]
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
WAVE4="$(cd "$HERE/../../catalog-wave4-2026-10-12" && pwd)"
SEED="$(cd "$HERE/../../.." && pwd)"
WORK="$(cd "${1:?작업 폴더}" && pwd)"
LIST="$(cd "$(dirname "${2:?film_composers.txt}")" && pwd)/$(basename "$2")"
EXTRA=()
[ -n "${3:-}" ] && EXTRA+=(--films "$(cd "$(dirname "$3")" && pwd)/$(basename "$3")")
[ -n "${4:-}" ] && EXTRA+=(--ko-titles "$(cd "$(dirname "$4")" && pwd)/$(basename "$4")")
DB="$WORK/db"
mkdir -p "$WORK/out" "$WORK/logs"
: > "$WORK/logs/failed.txt"
cd "$SEED"
while read -r id slug qid; do
  [ -z "${id:-}" ] && continue
  case "$id" in \#*) continue;; esac
  if ! uv run python "$HERE/film_catalog.py" --composer-id "$id" --slug "$slug" --db "$DB" \
      --out "$WORK/$slug" --wikidata "$qid" ${EXTRA[@]+"${EXTRA[@]}"} > "$WORK/logs/$slug.film.log" 2>&1; then
    echo "$slug film" >> "$WORK/logs/failed.txt"; continue
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
  echo "$slug $(tail -1 "$WORK/logs/$slug.film.log" | cut -c1-300)"
done < "$LIST"
echo DONE
