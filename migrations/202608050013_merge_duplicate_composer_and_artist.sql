-- 같은 인물이 두 행으로 등록된 것을 하나로 합친다.
--
-- 두 건 모두 한쪽이 다른 쪽의 상위집합이라, 참조를 옮길 필요 없이
-- 중복 행만 지우면 된다. 지우기 전에 확인한 것:
--
-- 쇤베르크 (71 → 82 로 통합)
--   71 의 곡 3 건(정화된 밤·달에 홀린 피에로·바르샤바의 생존자)이 82 에 모두 있고
--   82 에는 "5개의 피아노 소품" 이 하나 더 있다.
--   71 의 곡을 참조하는 performances·sectors·즐겨찾기는 0 건이다.
--
-- 야닌 얀센 (265 → 212 로 통합)
--   두 행이 같은 음반 24 장에 모두 contributor 로 붙어 있어 화면 노출이 같다.
--   265 쪽 음반은 platform_links 가 0 건이고(중복 통합에서 밀린 쪽),
--   같은 제목·연도의 212 쪽 음반이 링크 24 건을 모두 갖고 있다.
--   수상 2 건도 이름·연도·기관이 같은 중복이다.
--
-- pieces·recordings·recording_contributors·artist_awards 의 FK 는 CASCADE 라
-- 부모 행을 지우면 딸린 행이 함께 지워진다.
--
-- 남길 쪽이 없거나 이름이 다르거나 사용자 즐겨찾기가 걸려 있으면 아무것도 지우지 않는다.

DELETE FROM composers
WHERE id = 71
  AND english_name = 'Arnold Schoenberg'
  AND EXISTS (
      SELECT 1 FROM (SELECT id, english_name FROM composers) survivor
      WHERE survivor.id = 82 AND survivor.english_name = 'Arnold Schoenberg'
  )
  AND NOT EXISTS (
      SELECT 1 FROM (SELECT composer_id FROM user_favorite_composers) favorite
      WHERE favorite.composer_id = 71
  )
  AND NOT EXISTS (
      -- 71 에만 있는 곡이 하나라도 있으면 중단한다
      SELECT 1 FROM (SELECT title FROM pieces WHERE composer_id = 71) mine
      WHERE NOT EXISTS (
          SELECT 1 FROM (SELECT title FROM pieces WHERE composer_id = 82) theirs
          WHERE theirs.title = mine.title
      )
  );

DELETE FROM artists
WHERE id = 265
  AND english_name = 'Janine Jansen'
  AND EXISTS (
      SELECT 1 FROM (SELECT id, english_name FROM artists) survivor
      WHERE survivor.id = 212 AND survivor.english_name = 'Janine Jansen'
  )
  AND NOT EXISTS (
      SELECT 1 FROM (SELECT artist_id FROM user_favorite_artists) favorite
      WHERE favorite.artist_id = 265
  )
  AND NOT EXISTS (
      -- 265 쪽 음반이 스트리밍 링크를 갖고 있으면 중단한다
      SELECT 1 FROM (
          SELECT link.id FROM platform_links link
          JOIN recordings recording ON recording.id = link.recording_id
          WHERE recording.artist_id = 265
      ) owned_link
  )
  AND NOT EXISTS (
      -- 265 에만 있는 음반이 하나라도 있으면 중단한다
      SELECT 1 FROM (SELECT title, year FROM recordings WHERE artist_id = 265) mine
      WHERE NOT EXISTS (
          SELECT 1 FROM (SELECT title, year FROM recordings WHERE artist_id = 212) theirs
          WHERE theirs.title = mine.title AND theirs.year = mine.year
      )
  );
