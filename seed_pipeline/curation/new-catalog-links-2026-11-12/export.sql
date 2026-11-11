-- 새 카탈로그 링크 도구 입력(운영 읽기 전용). 결과를 탭 구분으로 받아 top.tsv·parts.tsv 로 둔다.
-- 대상 작곡가: 슈트라우스 498, 클레멘티 25, 슈타미츠 24, 쇤베르크 82, 리게티 499, 텔레만 11, 퍼셀 8,
--   스카를라티 9, 몬테베르디 5, 윤이상 90, 홍난파 89, 김동진 103.
-- top.tsv: 보이는 맨 위 작품(다른 작품의 안 곡이 아닌 것) 중 Apple Music·Spotify 링크가 하나라도 빈 것
SELECT p.id piece_id, p.composer_id, COALESCE(c.english_name, '') composer_en, c.name composer_ko,
  p.title, COALESCE(p.title_en, '') title_en, p.type, COALESCE(p.genre, '') genre,
  COALESCE(
    CASE WHEN p.catalogue_number IS NOT NULL AND TRIM(p.catalogue_number) <> ''
      THEN TRIM(CONCAT_WS(' ', p.catalogue_system, p.catalogue_number))
      ELSE NULLIF(NULLIF(TRIM(p.opus_number), ''), 'N/A') END, '') catalogue,
  (SELECT COUNT(*) FROM piece_parts pp WHERE pp.piece_id = p.id AND pp.parent_part_id IS NULL
     AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')) nparts,
  COALESCE(p.apple_music_url, '') apple_music_url, COALESCE(p.spotify_url, '') spotify_url
FROM pieces p JOIN composers c ON c.id = p.composer_id
WHERE p.composer_id IN (498, 25, 24, 82, 499, 11, 8, 9, 5, 90, 89, 103)
  AND p.hidden_reason IS NULL AND c.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM piece_parts l WHERE l.linked_piece_id = p.id)
  AND (p.apple_music_url IS NULL OR p.apple_music_url = '' OR p.spotify_url IS NULL OR p.spotify_url = '')
ORDER BY p.composer_id, p.id;

-- parts.tsv: 그 작품들의 안 곡 전부(곡 안 곡 포함). part-apple-links-2026-11-08/match.py 가 읽는 칸 이름.
SELECT p.id piece_id, p.title, COALESCE(p.title_en, '') title_en,
  COALESCE(
    CASE WHEN p.catalogue_number IS NOT NULL AND TRIM(p.catalogue_number) <> ''
      THEN TRIM(CONCAT_WS(' ', p.catalogue_system, p.catalogue_number))
      ELSE NULLIF(NULLIF(TRIM(p.opus_number), ''), 'N/A') END, '') catalogue,
  COALESCE(p.apple_music_url, '') apple_music_url, COALESCE(p.spotify_url, '') spotify_url, p.composer_id,
  pp.id part_id, pp.sequence_number seq, COALESCE(pp.movement_number, '') movement,
  COALESCE(pp.name_ko, '') name_ko, COALESCE(pp.name_en, '') name_en,
  (SELECT COUNT(*) FROM piece_parts ch WHERE ch.parent_part_id = pp.id) children,
  COALESCE(pp.apple_music_url, '') part_apple, COALESCE(pp.spotify_url, '') part_spotify,
  COALESCE(pp.parent_part_id, '') parent_part_id, COALESCE(pp.linked_piece_id, '') linked_piece_id
FROM pieces p JOIN composers c ON c.id = p.composer_id
JOIN piece_parts pp ON pp.piece_id = p.id AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')
WHERE p.composer_id IN (498, 25, 24, 82, 499, 11, 8, 9, 5, 90, 89, 103)
  AND p.hidden_reason IS NULL AND c.hidden_reason IS NULL
  AND NOT EXISTS (SELECT 1 FROM piece_parts l WHERE l.linked_piece_id = p.id)
  AND (p.apple_music_url IS NULL OR p.apple_music_url = '' OR p.spotify_url IS NULL OR p.spotify_url = '')
ORDER BY p.id, pp.parent_part_id IS NOT NULL, pp.parent_part_id, pp.sequence_number;
