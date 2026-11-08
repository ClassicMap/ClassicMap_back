-- match.py 의 --parts 입력(parts.tsv)을 뽑는다. 시험 DB 에서 읽기만 한다.
-- 사용: mysql --default-character-set=utf8mb4 -B classicmap < export_parts.sql > parts.tsv
-- 작품 링크가 앨범(트랙 ?i= 아님)인 작품의, 공개된 최상위 곡만.
SELECT p.id piece_id, p.title, COALESCE(p.title_en, '') title_en,
  COALESCE(
    CASE WHEN p.catalogue_number IS NOT NULL AND TRIM(p.catalogue_number) <> ''
      THEN TRIM(CONCAT_WS(' ', p.catalogue_system, p.catalogue_number))
      ELSE NULLIF(TRIM(p.opus_number), '') END,
    '') catalogue,
  p.apple_music_url, p.composer_id,
  pp.id part_id, pp.sequence_number seq, COALESCE(pp.movement_number, '') movement,
  COALESCE(pp.name_ko, '') name_ko, COALESCE(pp.name_en, '') name_en,
  (SELECT COUNT(*) FROM piece_parts ch WHERE ch.parent_part_id = pp.id) children
FROM pieces p
JOIN piece_parts pp ON pp.piece_id = p.id AND pp.parent_part_id IS NULL
  AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')
WHERE p.apple_music_url LIKE '%/album/%' AND p.apple_music_url NOT LIKE '%?i=%'
ORDER BY p.id, pp.sequence_number;
