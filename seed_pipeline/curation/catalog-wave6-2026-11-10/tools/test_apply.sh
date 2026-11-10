#!/bin/bash
# 마이그레이션 파일을 시험 DB 에 (파일마다 트랜잭션으로) 두 번 넣어 시간과 멱등성을 본다.
# 사용: tools/test_apply.sh <컨테이너> <devdb 폴더> <마이그레이션 파일...>
# 덤프는 tools/devdb.sh 로 미리 올려 둔다. _sqlx_migrations 에는 적지 않는다(백엔드가 뜰 때 적는다).
set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
NAME=${1:?컨테이너}; DIR=${2:?devdb 폴더}; shift 2
M() { "$HERE/devdb.sh" sql "$NAME" "$DIR" "$@"; }
run() {
  for f in "$@"; do echo "START TRANSACTION;"; cat "$f"; echo; echo "COMMIT;"; done | M || echo FAIL
}
snap() {
  M -N -e "SET SESSION group_concat_max_len = 1073741824;
    SELECT MD5(GROUP_CONCAT(CONCAT_WS('|',id,title,COALESCE(title_en,''),COALESCE(opus_number,''),
      COALESCE(catalogue_number,''),editor_locked,COALESCE(hidden_reason,'')) ORDER BY id SEPARATOR ';')) FROM pieces;
    SELECT MD5(GROUP_CONCAT(CONCAT_WS('|',id,piece_id,COALESCE(parent_part_id,''),COALESCE(linked_piece_id,''),
      sequence_number,COALESCE(name_ko,''),editorial_status) ORDER BY id SEPARATOR ';')) FROM piece_parts;
    SELECT COUNT(*) FROM piece_identifiers"
}
s=$(date +%s); run "$@"; echo "round1 $(( $(date +%s) - s ))s"; a=$(snap)
s=$(date +%s); run "$@"; echo "round2 $(( $(date +%s) - s ))s"; b=$(snap)
[ "$a" = "$b" ] && echo idempotent || echo "CHANGED on round2"
M -N -e "SELECT COUNT(*), SUM(hidden_reason IS NOT NULL) FROM pieces; SELECT COUNT(*) FROM piece_parts"
