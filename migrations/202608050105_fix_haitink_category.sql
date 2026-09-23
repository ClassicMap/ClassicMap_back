-- 베르나르트 하이팅크의 분류를 지휘자로 고친다.
--
-- 국제 시드는 Wikidata 의 악기 코드로 분류를 정하는데, 하이팅크는 젊은 시절 바이올린
-- 주자였던 이력 때문에 `바이올린` 으로 들어왔다. 그는 지휘자로 알려져 있고 비교 영상
-- 크레딧도 지휘자로 붙는다. 자동 시드가 다시 덮어쓰지 못하게 editor_locked 를 올린다.
--
-- S tier 대기열 B2 를 고르던 중 발견했다. 같은 이유로 잘못 들어온 다른 연주자는
-- 확인한 범위(지휘자 10명)에서는 없었다.

UPDATE artists artist
SET artist.category = 'conductor',
    artist.editor_locked = 1
WHERE artist.category = '바이올린'
  AND EXISTS (
      SELECT 1
      FROM (
          SELECT authority_entity_id FROM external_identifiers
          WHERE namespace = 'wikidata' AND external_id = 'Q158370'
      ) target
      WHERE target.authority_entity_id = artist.authority_entity_id
  );
