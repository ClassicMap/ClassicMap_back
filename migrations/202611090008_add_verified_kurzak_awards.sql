-- 알렉산드라 쿠르자크의 확인된 수상 기록 두 개를 넣는다(근거 없던 「오토 크렘퍼 상」은 202611090007 에서 지움).
--   1998 스타니스와프 모니우슈코 국제 성악 콩쿠르 1위 (bachtrack.com/competition/international-stanislaw-moniuszko-vocal-competition 역대 입상자)
--   2015 인터내셔널 오페라 어워드 독자상, 요나스 카우프만과 공동 (en.wikipedia.org/wiki/International_Opera_Awards 수상자 목록, Classic FM 보도)
-- 같은 이름의 기록이 이미 있으면 넣지 않는다. 두 번 넣어도 같다.
INSERT INTO artist_awards (artist_id, year, award_name, award_name_en, award_type, organization, category, ranking, source, notes, display_order)
SELECT artist.id, '1998', '모니우슈코 국제 성악 콩쿠르', 'International Stanisław Moniuszko Vocal Competition',
       'Competition', 'Teatr Wielki – Polish National Opera', 'Voice', '1st Prize', 'Manual Entry',
       'International Stanisław Moniuszko Vocal Competition, Warsaw', 60
FROM artists artist
WHERE artist.english_name = 'Aleksandra Kurzak'
  AND NOT EXISTS (SELECT 1 FROM artist_awards existing
                  WHERE existing.artist_id = artist.id AND existing.award_name = '모니우슈코 국제 성악 콩쿠르');

INSERT INTO artist_awards (artist_id, year, award_name, award_name_en, award_type, organization, category, ranking, source, notes, display_order)
SELECT artist.id, '2015', '인터내셔널 오페라 어워드 독자상', 'International Opera Awards, Readers'' Award',
       'Award', 'International Opera Awards', 'Voice', 'Winner', 'Manual Entry',
       'Shared with Jonas Kaufmann', 50
FROM artists artist
WHERE artist.english_name = 'Aleksandra Kurzak'
  AND NOT EXISTS (SELECT 1 FROM artist_awards existing
                  WHERE existing.artist_id = artist.id AND existing.award_name = '인터내셔널 오페라 어워드 독자상');
