-- 공개한 영화·드라마 장면 음악 중 작품에 이어진 것
SELECT cue.piece_id, cue.part_label, cue.arranged, cue.usage_kind,
       t.id AS title_id, t.kind, t.title_ko, t.title_en, t.title_original, t.release_year
FROM screen_music_cues cue
JOIN screen_titles t ON t.id = cue.screen_title_id
WHERE cue.editorial_status = 'PUBLISHED' AND t.editorial_status = 'PUBLISHED' AND cue.piece_id IS NOT NULL
ORDER BY cue.piece_id, t.release_year;
