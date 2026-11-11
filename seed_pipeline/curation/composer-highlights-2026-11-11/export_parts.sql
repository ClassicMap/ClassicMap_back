-- S·A tier 작곡가 작품의 보이는 part(EDITOR_REVIEWED·PUBLISHED)
SELECT part.id, part.piece_id, COALESCE(part.parent_part_id, 0) AS parent, part.sequence_number, part.movement_number,
       REPLACE(COALESCE(part.name_ko,''), '\t', ' ') AS name_ko, REPLACE(COALESCE(part.name_en,''), '\t', ' ') AS name_en,
       part.notable, part.notable_locked, COALESCE(part.linked_piece_id, 0) AS linked_piece_id, part.part_key,
       (part.apple_music_url IS NOT NULL) AS has_apple, (part.spotify_url IS NOT NULL) AS has_spotify
FROM piece_parts part
JOIN pieces piece ON piece.id = part.piece_id
JOIN composers composer ON composer.id = piece.composer_id
WHERE composer.tier IN ('S','A') AND composer.hidden_reason IS NULL
  AND part.editorial_status IN ('EDITOR_REVIEWED','PUBLISHED')
ORDER BY part.piece_id, part.parent_part_id, part.sequence_number, part.id;
