-- S·A tier 작곡가의 작품과 신호. 비교 공개 기준은 src/comparison/repository.rs PUBLIC_COMPARISON_CTE 와 같다.
WITH ready_performance AS (
        SELECT p.id,
               p.sector_id,
               p.piece_id,
               p.performance_source_id,
               p.start_ms,
               p.end_ms,
               clip.public_url AS clip_url
        FROM performances p
        JOIN performance_sectors sector
          ON sector.id = p.sector_id
         AND sector.piece_id = p.piece_id
        JOIN clip_assets clip
          ON clip.performance_id = p.id
         AND clip.is_current = TRUE
         AND clip.status IN ('READY', 'PUBLISHED')
         AND clip.public_url IS NOT NULL
         AND clip.public_url <> ''
        WHERE p.publish_status = 'PUBLISHED'
          AND p.performance_source_id IS NOT NULL
          AND p.start_ms IS NOT NULL
          AND p.end_ms IS NOT NULL
          AND sector.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')
    ),
    public_sector AS (
        SELECT ready.sector_id,
               COUNT(DISTINCT ready.id) AS ready_performance_count,
               COUNT(DISTINCT credit.artist_id) AS primary_artist_count,
               MIN(ready.start_ms) AS first_start_ms
        FROM ready_performance ready
        LEFT JOIN performance_credits credit
          ON credit.performance_source_id = ready.performance_source_id
         AND credit.is_primary = TRUE
        GROUP BY ready.sector_id
        HAVING COUNT(DISTINCT credit.artist_id) >= 3
    )
, cmp AS (
  SELECT sector.piece_id, COUNT(*) AS sector_count, SUM(public_sector.primary_artist_count) AS artist_sum
  FROM public_sector JOIN performance_sectors sector ON sector.id = public_sector.sector_id
  GROUP BY sector.piece_id
)
SELECT piece.id, piece.composer_id, piece.title, piece.title_en, piece.opus_number, piece.catalogue_system, piece.catalogue_number,
       piece.composition_year, piece.composition_date, piece.genre, piece.form_key, piece.notable, piece.notable_locked, piece.fame_score,
       piece.work_type, piece.origin, piece.hidden_reason,
       (piece.description IS NOT NULL AND piece.description <> '') AS has_desc,
       (piece.description_en IS NOT NULL AND piece.description_en <> '') AS has_desc_en,
       REPLACE(REPLACE(COALESCE(piece.description,''), '\t', ' '), '\n', ' ') AS description,
       REPLACE(REPLACE(COALESCE(piece.description_en,''), '\t', ' '), '\n', ' ') AS description_en,
       (piece.apple_music_url IS NOT NULL) AS has_apple, (piece.spotify_url IS NOT NULL) AS has_spotify, (piece.youtube_music_url IS NOT NULL) AS has_ytm,
       COALESCE(cmp.sector_count, 0) AS cmp_sectors, COALESCE(cmp.artist_sum, 0) AS cmp_artists,
       (SELECT COUNT(*) FROM performance_sectors s WHERE s.piece_id = piece.id) AS any_sectors,
       (SELECT COUNT(*) FROM piece_parts part WHERE part.piece_id = piece.id AND part.parent_part_id IS NULL AND part.editorial_status IN ('EDITOR_REVIEWED','PUBLISHED')) AS part_count,
       (SELECT CASE WHEN COUNT(*) = 0 THEN NULL WHEN COUNT(*) = COUNT(NULLIF(TRIM(part.movement_number), '')) THEN 'movement' ELSE 'work' END
          FROM piece_parts part WHERE part.piece_id = piece.id AND part.parent_part_id IS NULL AND part.editorial_status IN ('EDITOR_REVIEWED','PUBLISHED')) AS part_kind,
       (SELECT MIN(bundle.id) FROM piece_parts part JOIN pieces bundle ON bundle.id = part.piece_id
          WHERE part.linked_piece_id = piece.id AND part.editorial_status IN ('EDITOR_REVIEWED','PUBLISHED')
            AND bundle.id <> piece.id AND bundle.composer_id = piece.composer_id AND bundle.hidden_reason IS NULL) AS in_bundle,
       (SELECT GROUP_CONCAT(alias.alias_value SEPARATOR '|') FROM piece_aliases alias WHERE alias.piece_id = piece.id) AS aliases
FROM pieces piece
JOIN composers composer ON composer.id = piece.composer_id
LEFT JOIN cmp ON cmp.piece_id = piece.id
WHERE composer.tier IN ('S','A') AND composer.hidden_reason IS NULL
ORDER BY piece.composer_id, piece.id;
