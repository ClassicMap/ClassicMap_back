-- audit.py 의 parts 입력(parts.tsv): links.tsv 작품의 공개된 맨 위 곡(조성·번호 대조용). 시험 DB 에서 읽기만 한다.
SELECT pp.piece_id, pp.id part_id, pp.sequence_number seq,
  COALESCE(pp.name_ko, '') name_ko, COALESCE(pp.name_en, '') name_en,
  COALESCE(pp.apple_music_url, '') part_apple, COALESCE(pp.spotify_url, '') part_spotify
FROM piece_parts pp
JOIN pieces p ON p.id = pp.piece_id
WHERE p.hidden_reason IS NULL AND pp.parent_part_id IS NULL
  AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')
  AND (p.apple_music_url IS NOT NULL OR p.spotify_url IS NOT NULL)
ORDER BY pp.piece_id, pp.sequence_number;
