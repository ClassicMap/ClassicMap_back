-- 작곡가 상세는 v_composers_full 로 읽는다. 뷰는 만들 때의 칸으로 굳으므로 202611090001 에서 더한
-- 영어 글 칸(bio_en·style_en·influence_en)을 더해 다시 만든다(나머지는 그대로).
CREATE OR REPLACE VIEW v_composers_full AS
SELECT c.id,
       c.name,
       c.full_name,
       c.english_name,
       c.period,
       c.tier,
       c.birth_year,
       c.death_year,
       c.nationality,
       c.avatar_url,
       c.cover_image_url,
       c.bio,
       c.style,
       c.influence,
       c.created_at,
       c.updated_at,
       GROUP_CONCAT(DISTINCT CONCAT(p.id, ':', p.title) ORDER BY cmp.display_order ASC SEPARATOR '|') AS major_pieces,
       c.bio_en,
       c.style_en,
       c.influence_en
FROM composers c
LEFT JOIN composer_major_pieces cmp ON c.id = cmp.composer_id
LEFT JOIN pieces p ON cmp.piece_id = p.id
GROUP BY c.id;
