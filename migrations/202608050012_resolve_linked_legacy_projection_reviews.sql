-- 이미 legacy 행이 연결된 authority 의 투영 검수 항목을 종결한다.
--
-- 배경: legacy 작곡가·연주자를 Wikidata authority 에 명시 연결한 뒤
-- full canonical 을 적재하면, canonical 쪽 composer/artist 투영은
-- ProtectedReuse 로 legacy 행을 보존한다. 그런데 nationality 같은
-- 필수 표시 필드가 공식 원본에 없어 투영 자체가 만들어지지 않은 authority 는
-- LEGACY_*_REQUIRED_FIELDS_MISSING 으로 검수 큐에 남는다.
--
-- 그 중 "이미 연결된 legacy 행이 있는" 항목은 새로 만들 대상이 아니므로
-- 검수자가 볼 필요가 없다. 연결이 없는 항목만 큐에 남긴다.

UPDATE review_queue queue
JOIN authority_entities authority
  ON authority.id = queue.target_id
SET queue.status = 'APPROVED',
    queue.resolved_at = CURRENT_TIMESTAMP(6),
    queue.resolution = JSON_OBJECT(
        'action', 'legacy_row_already_linked',
        'migration', '202608050012',
        'authorityEntityId', authority.id
    )
WHERE queue.status = 'OPEN'
  AND queue.reason_code = 'LEGACY_COMPOSER_REQUIRED_FIELDS_MISSING'
  AND EXISTS (
      SELECT 1 FROM composers legacy
      WHERE legacy.authority_entity_id = authority.id
  );

UPDATE review_queue queue
JOIN authority_entities authority
  ON authority.id = queue.target_id
SET queue.status = 'APPROVED',
    queue.resolved_at = CURRENT_TIMESTAMP(6),
    queue.resolution = JSON_OBJECT(
        'action', 'legacy_row_already_linked',
        'migration', '202608050012',
        'authorityEntityId', authority.id
    )
WHERE queue.status = 'OPEN'
  AND queue.reason_code = 'LEGACY_ARTIST_REQUIRED_FIELDS_MISSING'
  AND EXISTS (
      SELECT 1 FROM artists legacy
      WHERE legacy.authority_entity_id = authority.id
  );
