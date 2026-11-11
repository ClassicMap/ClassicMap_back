-- 사운드트랙 링크 도구 입력(운영 읽기 전용). 결과를 탭 구분으로 받아 top.tsv·parts.tsv 로 둔다.
-- top.tsv: 보이는 사운드트랙 맨 위 작품(다른 작품의 안 곡이 아닌 것)
SELECT p.id, p.composer_id, c.english_name, p.title, p.title_en, p.type, p.apple_music_url, p.spotify_url,
  (SELECT GROUP_CONCAT(i.external_id) FROM piece_identifiers i WHERE i.piece_id = p.id AND i.namespace = 'musicbrainz_work') mbids,
  (SELECT COUNT(*) FROM piece_parts pp WHERE pp.piece_id = p.id) nparts
FROM pieces p JOIN composers c ON c.id = p.composer_id
WHERE p.genre = 'screen' AND p.hidden_reason IS NULL AND c.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM piece_parts l WHERE l.linked_piece_id = p.id)
ORDER BY p.composer_id, p.id;

-- parts.tsv: 그 작품들의 안 곡과 안 곡으로 이어진 작품의 지금 링크
SELECT pp.id part_id, pp.piece_id, pp.parent_part_id, pp.sequence_number, pp.movement_number, pp.name_ko, pp.name_en,
  pp.apple_music_url, pp.spotify_url, pp.linked_piece_id, lp.title linked_title, lp.title_en linked_title_en,
  lp.apple_music_url linked_apple, lp.spotify_url linked_spotify, lp.origin linked_origin, lp.editor_locked linked_locked
FROM piece_parts pp JOIN pieces p ON p.id = pp.piece_id LEFT JOIN pieces lp ON lp.id = pp.linked_piece_id
WHERE p.genre = 'screen' AND p.hidden_reason IS NULL
ORDER BY pp.piece_id, pp.sequence_number;
