-- S2 첫 배치를 적재하다 남은 검수 항목 2건을 종결한다.
--
-- load_comparison_candidates 는 작품을 해소하지 못하면 후보 적재를 rollback 하고
-- review_queue 만 남긴다. 설계된 동작이다.
--
-- 쇼팽 혁명 에튀드(piece 127)의 musicbrainz_work 식별자를 붙이기 전에
-- dry-run 을 두 번 돌렸고 그때마다 한 건씩 쌓였다.
-- 202608050021 에서 식별자를 연결한 뒤 같은 bundle 이 정상 적재됐으므로
-- 두 항목이 가리키는 문제는 이미 해소됐다.
--
-- 문제 자체가 사라진 항목이므로 CANCELLED 로 닫는다.
-- 대상은 그 식별자를 가리키면서 지금은 실제로 연결돼 있는 항목뿐이다.
-- 아직 연결되지 않은 작품의 검수 항목은 그대로 열어 둔다.

UPDATE review_queue queue
SET queue.status = 'CANCELLED',
    queue.resolution = JSON_OBJECT(
        'action', 'linked_piece_identifier',
        'migration', '202608050021',
        'namespace', 'musicbrainz_work',
        'note', '작품 식별자를 legacy 행에 연결한 뒤 같은 bundle이 정상 적재됨'
    ),
    queue.resolved_at = CURRENT_TIMESTAMP(6)
WHERE queue.status = 'OPEN'
  AND queue.target_type = 'piece'
  AND queue.reason_code = 'MISSING_OR_MISMATCHED_LEGACY_WORK'
  AND JSON_UNQUOTE(JSON_EXTRACT(queue.evidence, '$.namespace')) = 'musicbrainz_work'
  AND EXISTS (
      SELECT 1
      FROM piece_identifiers linked
      WHERE linked.namespace = 'musicbrainz_work'
        AND linked.external_id
            = JSON_UNQUOTE(JSON_EXTRACT(queue.evidence, '$.externalId'))
  );
