#!/bin/bash
# 결정에 쓰는 읽기 덤프. 6차 tools/dump.sh 와 같은 표(pieces·all_mbids_taken·composers·piece_parts)에
# part 이름·순서까지 든 parts_full.tsv 를 더한다(SELECT 만).
# 사용: tools/dump_parts.sh <덤프 폴더> [<시험 DB 컨테이너> <devdb 폴더>]
#   컨테이너를 주면 운영 대신 시험 DB(6차 devdb.sh)에서 받는다. 이번 결정은 운영 덤프에
#   먼저 들어갈 마이그레이션(0501 중복 합치기·0701·0702)을 넣은 시험 DB 에서 받았다.
set -euo pipefail
OUT=${1:?덤프 폴더}
CONTAINER=${2:-}
DEVDB=${3:-}
HERE="$(cd "$(dirname "$0")" && pwd)"
WAVE6="$HERE/../../catalog-wave6-2026-11-10/tools"
mkdir -p "$OUT"
export KUBECONFIG=${KUBECONFIG:-$HOME/.kube/homeserver.yaml}

q() {
  local name=$1 sql=$2
  if [ -n "$CONTAINER" ]; then
    printf '%s\n' "$sql" | "$WAVE6/devdb.sh" sql "$CONTAINER" "$DEVDB" -B > "$OUT/$name.tsv"
  else
    printf '%s\n' "$sql" | kubectl -n homeserver exec -i classicmap-mysql-0 -- sh -c \
      'mysql --default-character-set=utf8mb4 -uroot -p"$MYSQL_ROOT_PASSWORD" -B "$MYSQL_DATABASE" 2>/dev/null | gzip -c' \
      > "$OUT/$name.tsv.gz"
    gunzip -f "$OUT/$name.tsv.gz"
  fi
}

q pieces "SELECT p.composer_id, p.id, p.title, p.title_en, p.type, p.opus_number, p.catalogue_system,
  p.catalogue_number, p.composition_year, p.origin, p.editor_locked,
  (p.description IS NOT NULL AND p.description <> '') AS has_desc,
  (p.spotify_url IS NOT NULL OR p.apple_music_url IS NOT NULL) AS has_link,
  (SELECT COUNT(*) FROM performance_sectors s WHERE s.piece_id = p.id) AS sectors,
  (SELECT GROUP_CONCAT(i.external_id) FROM piece_identifiers i
     WHERE i.piece_id = p.id AND i.namespace = 'musicbrainz_work') AS mbids,
  p.hidden_reason,
  (SELECT COUNT(*) FROM piece_parts l WHERE l.linked_piece_id = p.id) AS linked_by
FROM pieces p ORDER BY p.composer_id, p.id"
q all_mbids_taken "SELECT i.external_id, i.piece_id, p.composer_id FROM piece_identifiers i
JOIN pieces p ON p.id = i.piece_id WHERE i.namespace = 'musicbrainz_work'"
q composers "SELECT c.id, c.name, c.english_name, c.origin, c.hidden_reason,
  (SELECT GROUP_CONCAT(a.external_id) FROM external_identifiers a
     WHERE a.authority_entity_id = c.authority_entity_id AND a.namespace = 'musicbrainz_artist') AS mb_artist
FROM composers c"
q parts_full "SELECT pp.piece_id, pp.id, pp.parent_part_id, pp.part_key, pp.sequence_number,
  pp.movement_number,
  REPLACE(REPLACE(pp.name_ko, '\t', ' '), '\n', ' ') AS name_ko,
  REPLACE(REPLACE(pp.name_en, '\t', ' '), '\n', ' ') AS name_en,
  pp.editorial_status, pp.origin, pp.editor_locked, pp.linked_piece_id
FROM piece_parts pp"
wc -l "$OUT"/*.tsv
