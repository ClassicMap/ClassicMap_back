-- build_links.py 의 parts 입력(all_parts.tsv): 모든 작품의 공개된 최상위 곡. 시험 DB 에서 읽기만 한다.
SELECT p.id piece_id, p.title, COALESCE(p.title_en, '') title_en,
  COALESCE(
    CASE WHEN p.catalogue_number IS NOT NULL AND TRIM(p.catalogue_number) <> ''
      THEN TRIM(CONCAT_WS(' ', p.catalogue_system, p.catalogue_number))
      ELSE NULLIF(TRIM(p.opus_number), '') END,
    '') catalogue,
  COALESCE(p.apple_music_url, '') apple_music_url, COALESCE(p.spotify_url, '') spotify_url, p.composer_id,
  pp.id part_id, pp.sequence_number seq, COALESCE(pp.movement_number, '') movement,
  COALESCE(pp.name_ko, '') name_ko, COALESCE(pp.name_en, '') name_en,
  (SELECT COUNT(*) FROM piece_parts ch WHERE ch.parent_part_id = pp.id) children,
  COALESCE(pp.apple_music_url, '') part_apple, '' part_spotify
FROM pieces p
JOIN piece_parts pp ON pp.piece_id = p.id AND pp.parent_part_id IS NULL
  AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')
ORDER BY p.id, pp.sequence_number;
