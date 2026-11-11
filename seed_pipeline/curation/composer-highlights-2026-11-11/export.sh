#!/bin/bash
# 운영 DB 를 읽기만 해서 초안 재료를 받는다: ./export.sh <작업 폴더>
# 비밀번호는 파드 안 $MYSQL_ROOT_PASSWORD 로만 쓴다(출력하지 않는다).
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
out="$1/db"
mkdir -p "$out"
for name in composers pieces parts films; do
  kubectl -n homeserver exec -i classicmap-mysql-0 -- \
    sh -c 'mysql --default-character-set=utf8mb4 -B -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' \
    < "$here/export_$name.sql" 2> >(grep -v "Using a password" >&2) > "$out/$name.tsv"
  echo "$name: $(($(wc -l < "$out/$name.tsv") - 1)) rows"
done
