#!/bin/bash
# 마이그레이션 시험용 MySQL. 운영 카탈로그를 읽기 전용 덤프로 받아 docker 컨테이너에 올린다.
# 사용:
#   tools/devdb.sh dump <폴더>                     운영 스키마 + 카탈로그 데이터(사용자·시드 기록 표 제외)
#   tools/devdb.sh up <컨테이너> <포트> <폴더>       mysql:8.0 을 127.0.0.1:<포트> 에 띄우고 덤프를 올린다
#   tools/devdb.sh reload <컨테이너> <폴더>          데이터베이스를 지우고 덤프로 다시 만든다
#   tools/devdb.sh sql <컨테이너> <폴더> [인자...]    stdin 의 SQL 을 시험 DB 에 넣는다
# root 비밀번호는 <폴더>/.pw 에 만들어 둔다(저장소에 넣지 않는다). 운영 비밀번호는 파드 안에서만 쓴다.
set -euo pipefail
cmd=${1:?dump|up|reload|sql}
shift

pw_file() {
  local dir=$1
  [ -f "$dir/.pw" ] || (umask 077 && openssl rand -hex 16 > "$dir/.pw")
  echo "$dir/.pw"
}

wait_ready() {
  local name=$1 pw=$2
  # 첫 기동 때 이미지가 띄우는 임시 서버는 TCP 를 닫고 있다. TCP 로 붙어야 진짜 서버다.
  for _ in $(seq 1 90); do
    docker exec "$name" mysqladmin -h127.0.0.1 -uroot -p"$pw" ping >/dev/null 2>&1 && return 0
    sleep 2
  done
  echo "MySQL 이 뜨지 않음: $name" >&2
  return 1
}

load() {
  local name=$1 dir=$2 pw
  pw=$(cat "$(pw_file "$dir")")
  wait_ready "$name" "$pw"
  docker exec -i "$name" mysql -uroot -p"$pw" -e "DROP DATABASE IF EXISTS classicmap;
    CREATE DATABASE classicmap CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>/dev/null
  docker exec -i "$name" mysql -uroot -p"$pw" --default-character-set=utf8mb4 classicmap \
    < "$dir/schema.clean.sql" 2>&1 | grep -v "Using a password" || true
  gunzip -c "$dir/data.sql.gz" | docker exec -i "$name" mysql -uroot -p"$pw" \
    --default-character-set=utf8mb4 classicmap 2>&1 | grep -v "Using a password" || true
  docker exec "$name" mysql -uroot -p"$pw" -N classicmap -e "SELECT COUNT(*) FROM pieces;
    SELECT COUNT(*) FROM piece_parts; SELECT MAX(version) FROM _sqlx_migrations" 2>/dev/null
}

case "$cmd" in
  dump)
    dir=${1:?폴더}
    mkdir -p "$dir"
    export KUBECONFIG=${KUBECONFIG:-$HOME/.kube/homeserver.yaml}
    exclude=" users deleted_accounts seed_mutations seed_natural_keys source_records review_queue seed_runs source_snapshots "
    tables=$(echo "SHOW TABLES" | kubectl -n homeserver exec -i classicmap-mysql-0 -- sh -c \
      'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -N "$MYSQL_DATABASE" 2>/dev/null')
    keep=""
    for t in $tables; do
      case "$exclude" in *" $t "*) continue;; esac
      case $t in user_*) continue;; esac
      keep="$keep $t"
    done
    kubectl -n homeserver exec classicmap-mysql-0 -- sh -c 'mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" \
      --no-data --skip-comments --set-gtid-purged=OFF --single-transaction --skip-lock-tables \
      --no-tablespaces "$MYSQL_DATABASE" 2>/dev/null' > "$dir/schema.clean.sql"
    # 큰 출력은 kubectl exec 스트림이 잘릴 수 있어 파드 안에서 gzip 으로 받는다.
    kubectl -n homeserver exec classicmap-mysql-0 -- sh -c "mysqldump -uroot -p\"\$MYSQL_ROOT_PASSWORD\" \
      --no-create-info --skip-comments --set-gtid-purged=OFF --skip-triggers --single-transaction \
      --skip-lock-tables --no-tablespaces \"\$MYSQL_DATABASE\" $keep 2>/dev/null | gzip -c" > "$dir/data.sql.gz"
    gunzip -t "$dir/data.sql.gz"
    ls -la "$dir/schema.clean.sql" "$dir/data.sql.gz" | awk '{print $5, $NF}'
    ;;
  up)
    name=${1:?컨테이너}; port=${2:?포트}; dir=${3:?폴더}
    pw=$(cat "$(pw_file "$dir")")
    docker run -d --name "$name" -e MYSQL_ROOT_PASSWORD="$pw" -p "127.0.0.1:$port:3306" mysql:8.0 \
      --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci >/dev/null
    load "$name" "$dir"
    ;;
  reload)
    load "${1:?컨테이너}" "${2:?폴더}"
    ;;
  sql)
    name=${1:?컨테이너}; dir=${2:?폴더}; shift 2
    pw=$(cat "$(pw_file "$dir")")
    docker exec -i "$name" mysql -uroot -p"$pw" --default-character-set=utf8mb4 classicmap "$@" \
      2> >(grep -v "Using a password" >&2)
    ;;
  *)
    echo "모르는 명령: $cmd" >&2
    exit 2
    ;;
esac
