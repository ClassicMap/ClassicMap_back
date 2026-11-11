#!/bin/bash
# 운영 MySQL 에서 분류 입력(보이는 작품 + 지금 갈래·형식·대표곡·비교 구간·카드 수)과 작곡가 표를 TSV 로 뽑는다(SELECT 만).
# 사용: tools/dump.sh <덤프 폴더>
set -euo pipefail
OUT=${1:?덤프 폴더}
HERE=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$OUT"
export KUBECONFIG=${KUBECONFIG:-$HOME/.kube/homeserver.yaml}
q() {
  local name=$1
  kubectl -n homeserver exec -i classicmap-mysql-0 -- sh -c \
    'mysql --default-character-set=utf8mb4 -uroot -p"$MYSQL_ROOT_PASSWORD" -B "$MYSQL_DATABASE" 2>/dev/null | gzip -c' \
    > "$OUT/$name.tsv.gz"
  gunzip -t "$OUT/$name.tsv.gz"
  gunzip -c "$OUT/$name.tsv.gz" > "$OUT/$name.tsv"
  rm "$OUT/$name.tsv.gz"
}
q classify_input < "$HERE/classify_input.sql"
echo "SELECT id, name, english_name, hidden_reason FROM composers" | q composers
echo "SELECT form_key, genre, name_ko FROM piece_forms" | q piece_forms
wc -l "$OUT"/*.tsv
