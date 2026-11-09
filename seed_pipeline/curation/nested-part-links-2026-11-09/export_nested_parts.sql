-- match.py --nested 의 parts 입력(nested_parts.tsv): 곡 안에 곡이 또 있는 세트(「소나타 1번 → 1~4악장」)의
-- 공개된 곡 전부(맨 위 곡과 그 안의 곡). 시험 DB 에서 읽기만 한다.
SELECT p.id piece_id, p.title, COALESCE(p.title_en, '') title_en,
  COALESCE(
    CASE WHEN p.catalogue_number IS NOT NULL AND TRIM(p.catalogue_number) <> ''
      THEN TRIM(CONCAT_WS(' ', p.catalogue_system, p.catalogue_number))
      ELSE NULLIF(TRIM(p.opus_number), '') END,
    '') catalogue,
  COALESCE(p.apple_music_url, '') apple_music_url, COALESCE(p.spotify_url, '') spotify_url, p.composer_id,
  pp.id part_id, COALESCE(pp.parent_part_id, '') parent_part_id, pp.sequence_number seq,
  COALESCE(pp.movement_number, '') movement,
  COALESCE(pp.name_ko, '') name_ko, COALESCE(pp.name_en, '') name_en,
  (SELECT COUNT(*) FROM piece_parts ch WHERE ch.parent_part_id = pp.id) children,
  COALESCE(pp.apple_music_url, '') part_apple, COALESCE(pp.spotify_url, '') part_spotify
FROM pieces p
JOIN piece_parts pp ON pp.piece_id = p.id
  AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')
WHERE EXISTS (
  SELECT 1 FROM piece_parts nested
  WHERE nested.piece_id = p.id AND nested.parent_part_id IS NOT NULL
    AND nested.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')
)
ORDER BY p.id, pp.parent_part_id IS NOT NULL, pp.parent_part_id, pp.sequence_number;
