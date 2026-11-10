#!/bin/bash
# 운영 MySQL 에서 자동 카탈로그가 읽는 표를 TSV 로 뽑는다(SELECT 만, 사용자 표 없음).
# 사용: tools/dump.sh <덤프 폴더>
#   pieces.tsv          작품 + MusicBrainz work MBID 목록 + 비교 구간 수·링크 유무
#   all_mbids_taken.tsv 운영에서 이미 쓰는 MusicBrainz work MBID
#   composers.tsv       작곡가 + MusicBrainz artist MBID(external_identifiers, namespace musicbrainz_artist)
#   piece_parts.tsv     작품 part
# 비밀번호는 파드 안에서만 쓴다. 큰 출력은 kubectl exec 스트림이 잘릴 수 있어 파드 안에서 gzip 으로 받는다.
set -euo pipefail
OUT=${1:?덤프 폴더}
mkdir -p "$OUT"
export KUBECONFIG=${KUBECONFIG:-$HOME/.kube/homeserver.yaml}

q() {
  local name=$1 sql=$2
  printf '%s\n' "$sql" | kubectl -n homeserver exec -i classicmap-mysql-0 -- sh -c \
    'mysql --default-character-set=utf8mb4 -uroot -p"$MYSQL_ROOT_PASSWORD" -B "$MYSQL_DATABASE" 2>/dev/null | gzip -c' \
    > "$OUT/$name.tsv.gz"
  gunzip -t "$OUT/$name.tsv.gz"
  gunzip -c "$OUT/$name.tsv.gz" > "$OUT/$name.tsv"
  rm "$OUT/$name.tsv.gz"
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
q piece_parts "SELECT pp.piece_id, pp.id, pp.part_key, pp.editorial_status, pp.origin, pp.editor_locked,
  pp.linked_piece_id FROM piece_parts pp"
wc -l "$OUT"/*.tsv
