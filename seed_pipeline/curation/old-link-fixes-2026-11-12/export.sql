-- 옛 링크 바로잡기·안 곡 채우기 입력(운영 읽기 전용). 결과를 탭 구분으로 받아 top.tsv·parts.tsv 로 둔다.
-- 대상: (1) 틀린 링크를 바꿀 작품 52·33936·38·35·41, (2) 0501 전부터 작품 링크가 둘 다 있던
-- 12명(슈트라우스·클레멘티·슈타미츠·쇤베르크·리게티·텔레만·퍼셀·스카를라티·몬테베르디·윤이상·홍난파·김동진) 작품 중
-- 안 곡이 있는 것. (2)는 ../new-catalog-links-2026-11-12/top.tsv 에 없던 작품이라 id 로 적는다.
SELECT p.id piece_id, p.composer_id, COALESCE(c.english_name, '') composer_en, c.name composer_ko,
  p.title, COALESCE(p.title_en, '') title_en, p.type, COALESCE(p.genre, '') genre,
  COALESCE(
    CASE WHEN p.catalogue_number IS NOT NULL AND TRIM(p.catalogue_number) <> ''
      THEN TRIM(CONCAT_WS(' ', p.catalogue_system, p.catalogue_number))
      ELSE NULLIF(NULLIF(TRIM(p.opus_number), ''), 'N/A') END, '') catalogue,
  (SELECT COUNT(*) FROM piece_parts pp WHERE pp.piece_id = p.id AND pp.parent_part_id IS NULL
     AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')) nparts,
  COALESCE(p.apple_music_url, '') apple_music_url, COALESCE(p.spotify_url, '') spotify_url
FROM pieces p JOIN composers c ON c.id = p.composer_id
WHERE p.id IN (52, 33936, 38, 35, 41,
  18, 37, 53, 54, 55, 56, 111, 33955, 113, 33953, 313, 314, 316, 34035, 34064)
ORDER BY p.composer_id, p.id;

-- parts.tsv: 그 작품들의 안 곡 전부(곡 안 곡 포함). part-apple-links-2026-11-08/match.py 가 읽는 칸 이름.
SELECT p.id piece_id, p.title, COALESCE(p.title_en, '') title_en,
  COALESCE(
    CASE WHEN p.catalogue_number IS NOT NULL AND TRIM(p.catalogue_number) <> ''
      THEN TRIM(CONCAT_WS(' ', p.catalogue_system, p.catalogue_number))
      ELSE NULLIF(NULLIF(TRIM(p.opus_number), ''), 'N/A') END, '') catalogue,
  COALESCE(p.apple_music_url, '') apple_music_url, COALESCE(p.spotify_url, '') spotify_url, p.composer_id,
  pp.id part_id, pp.sequence_number seq, COALESCE(pp.movement_number, '') movement,
  COALESCE(pp.name_ko, '') name_ko, COALESCE(pp.name_en, '') name_en,
  (SELECT COUNT(*) FROM piece_parts ch WHERE ch.parent_part_id = pp.id) children,
  COALESCE(pp.apple_music_url, '') part_apple, COALESCE(pp.spotify_url, '') part_spotify,
  COALESCE(pp.parent_part_id, '') parent_part_id, COALESCE(pp.linked_piece_id, '') linked_piece_id
FROM pieces p
JOIN piece_parts pp ON pp.piece_id = p.id AND pp.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')
WHERE p.id IN (52, 33936, 38, 35, 41,
  18, 37, 53, 54, 55, 56, 111, 33955, 113, 33953, 313, 314, 316, 34035, 34064)
ORDER BY p.id, pp.parent_part_id IS NOT NULL, pp.parent_part_id, pp.sequence_number;
