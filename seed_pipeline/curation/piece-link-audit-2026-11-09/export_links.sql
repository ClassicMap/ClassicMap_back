-- audit.py 의 links 입력(links.tsv): 보이는 작품 중 Apple Music·Spotify 링크가 있는 작품. 시험 DB 에서 읽기만 한다.
SELECT p.id piece_id, p.title, COALESCE(p.title_en, '') title_en,
  COALESCE(NULLIF(TRIM(c.english_name), ''), c.name) composer_en,
  COALESCE(
    CASE WHEN p.catalogue_number IS NOT NULL AND TRIM(p.catalogue_number) <> ''
      THEN TRIM(CONCAT_WS(' ', p.catalogue_system, p.catalogue_number))
      ELSE NULLIF(TRIM(p.opus_number), '') END,
    '') catalogue,
  COALESCE(p.apple_music_url, '') apple_music_url, COALESCE(p.spotify_url, '') spotify_url,
  (SELECT COUNT(*) FROM piece_parts pp WHERE pp.piece_id = p.id AND pp.parent_part_id IS NULL
     AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')) nparts
FROM pieces p
JOIN composers c ON c.id = p.composer_id
WHERE p.hidden_reason IS NULL
  AND (p.apple_music_url IS NOT NULL OR p.spotify_url IS NOT NULL)
ORDER BY p.id;
