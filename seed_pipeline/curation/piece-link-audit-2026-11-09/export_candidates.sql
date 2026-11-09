-- 판정(audit.jsonl)이 틀림·없어짐·어긋남·의심·전집 상자인 작품 → apple_search·spotify_search 입력.
-- @ids 는 그 작품 id 목록(쉼표). 시험 DB 에서 읽기만 한다.
SELECT p.id piece_id, '' current_url, c.id composer_id,
  COALESCE(NULLIF(TRIM(c.english_name), ''), c.name) composer_en, COALESCE(c.tier, '') tier,
  EXISTS(SELECT 1 FROM performance_sectors s WHERE s.piece_id = p.id) comparable,
  COALESCE(p.notable, 0) notable,
  COALESCE(p.title_en, '') title_en,
  COALESCE(
    CASE WHEN p.catalogue_number IS NOT NULL AND TRIM(p.catalogue_number) <> ''
      THEN TRIM(CONCAT_WS(' ', p.catalogue_system, p.catalogue_number))
      ELSE NULLIF(TRIM(p.opus_number), '') END, '') catalogue,
  (SELECT COUNT(*) FROM piece_parts pp WHERE pp.piece_id = p.id AND pp.parent_part_id IS NULL
     AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')) nparts
FROM pieces p JOIN composers c ON c.id = p.composer_id
WHERE FIND_IN_SET(p.id, @ids)
ORDER BY comparable DESC, FIELD(c.tier, 'S', 'A', 'B', 'C') = 0, FIELD(c.tier, 'S', 'A', 'B', 'C'), p.id;
