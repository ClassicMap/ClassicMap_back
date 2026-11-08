-- 작품 Apple Music 링크가 틀린 세트 → candidates-fix.tsv. 시험 DB 에서 읽기만 한다.
-- id 목록 = part-apple-links-2026-11-08/suspect_albums.tsv(작품번호가 앨범 트랙 어디에도 없음) + 앨범 트랙 0개,
-- 그리고 링크가 트랙(?i=)인데 곡 링크가 하나도 안 붙은 세트.
SELECT p.id piece_id, p.apple_music_url current_url, c.id composer_id, COALESCE(c.english_name, '') composer_en, COALESCE(c.tier, '') tier,
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
WHERE p.hidden_reason IS NULL AND c.hidden_reason IS NULL AND (p.id IN (23,66,74,79,108,116,118,119,120,132,156,158,159,165,166,176,179,196,215,216,222,223,233,312,321,330,359,368,371,372,382,461,470,484,495,513,540,679,712,922,953,990,1026,1064,1147,1164,1253,1370,1421,1432,1452,1508,1594,1900,1915,2050,2082,2175,2403,2538,2558,2561,2575,2636,2653,2799,2977,2989,3000,7507,7687,7768,7892,7898,7951,7961,8022,8061,8100,8119,8227,8328,8372,8381,8431,8526,8595,8659,8756,8796,8889,8911,8993,9002,9123,9370,9375,9545,9669,9715,10014,10142,10249,10280,10325,10346,10372,10375,10445,10493,10925,10991,11007,11012,11169,11288,11429,11439,11465,11646,11660,11910,12014,12077,12269,12768,12823,13776,13785,13789,13809,13887,13929,14504,14603,15061,15522,16469,16882,16978,17671,18193,18287,18326,18580,19240,19468,20098,23059,23064,23065,23096,23100,23238,23396,23426,23457,23556,23640,23666,23691,23747,23798,23953,24048,24083,24308,24471,24527,24549,24607,24761,24932,24960,25085,25195,25213,25434,25461,25565,25590,25617,25629,25736,25765,25768,26037,26056) OR (p.apple_music_url LIKE '%?i=%' AND NOT EXISTS (SELECT 1 FROM piece_parts l WHERE l.piece_id = p.id AND l.apple_music_url IS NOT NULL)))
HAVING nparts > 0
ORDER BY comparable DESC, FIELD(tier, 'S', 'A', 'B', 'C') = 0, FIELD(tier, 'S', 'A', 'B', 'C'), notable DESC, p.id;
