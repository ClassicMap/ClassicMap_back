-- A tier A16 에서 출생 연도를 비워 둔 둘을 채운다.
--   루시 파럼 1966 · 홀리 매시슨 1981
--
-- 202608050190 에서 등록할 때 wikidata 에 P569(출생일) 진술이 없어 NULL 로 두었다.
-- 영어 위키백과에 연도가 있어 채운다 — 파럼 1966, 매시슨 1981-05-28(더니든 출생).
--   https://en.wikipedia.org/wiki/Lucy_Parham
--   https://en.wikipedia.org/wiki/Holly_Mathieson
--
-- 출처가 wikidata 가 아니므로 연도만 넣고 날짜는 넣지 않는다. 이미 값이 있으면
-- 덮어쓰지 않는다. editor_locked 행은 건드리지 않는다.

UPDATE artists artist
SET artist.birth_year = '1966'
WHERE artist.birth_year IS NULL
  AND artist.editor_locked = 1
  AND EXISTS (
      SELECT 1 FROM (
          SELECT authority_entity_id FROM external_identifiers
          WHERE namespace = 'wikidata' AND external_id = 'Q62619403'
      ) matched WHERE matched.authority_entity_id = artist.authority_entity_id
  );

UPDATE artists artist
SET artist.birth_year = '1981'
WHERE artist.birth_year IS NULL
  AND artist.editor_locked = 1
  AND EXISTS (
      SELECT 1 FROM (
          SELECT authority_entity_id FROM external_identifiers
          WHERE namespace = 'wikidata' AND external_id = 'Q21998639'
      ) matched WHERE matched.authority_entity_id = artist.authority_entity_id
  );
