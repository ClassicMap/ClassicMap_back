-- 작품 Apple Music 링크가 없는 세트(곡이 있는 작품) 목록 → candidates.tsv. 시험 DB 에서 읽기만 한다.
-- 우선순위: 비교 작품, S, A, 대표곡, B, C.
SELECT p.id piece_id, c.id composer_id, COALESCE(c.english_name, '') composer_en, COALESCE(c.tier, '') tier,
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
WHERE p.hidden_reason IS NULL AND c.hidden_reason IS NULL AND p.apple_music_url IS NULL
HAVING nparts > 0
ORDER BY comparable DESC, FIELD(tier, 'S', 'A', 'B', 'C') = 0, FIELD(tier, 'S', 'A', 'B', 'C'), notable DESC, p.id;
