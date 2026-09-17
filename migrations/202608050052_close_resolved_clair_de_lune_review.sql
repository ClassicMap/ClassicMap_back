-- 달빛 적재가 막혀 있던 동안 남은 검수 항목 1건을 종결한다.
--
-- 202608050034 와 같은 판정 기준을 쓴다. "그 작품으로 실제 발행된 연주가
-- 있는가"로 본다. 달빛(piece 220)은 202608050041 의 해소 규칙 변경으로
-- 적재가 풀렸고 202608050042 에서 세 연주가 발행됐으므로 이 항목이 가리키는
-- 문제는 사라졌다.
--
-- 이로써 열린 검수 항목이 없어진다.

UPDATE review_queue queue
SET queue.status = 'CANCELLED',
    queue.resolution = JSON_OBJECT(
        'action', 'resolved_by_work_resolution_rule_change',
        'migration', '202608050041',
        'namespace', 'musicbrainz_work',
        'note', 'piece_identifiers 를 piece_parts 보다 앞세우도록 고친 뒤 정상 적재·발행됨'
    ),
    queue.resolved_at = CURRENT_TIMESTAMP(6)
WHERE queue.status = 'OPEN'
  AND queue.target_type = 'piece'
  AND queue.reason_code = 'MISSING_OR_MISMATCHED_LEGACY_WORK'
  AND JSON_UNQUOTE(JSON_EXTRACT(queue.evidence, '$.namespace')) = 'musicbrainz_work'
  AND EXISTS (
      SELECT 1
      FROM piece_identifiers linked
      JOIN performances published ON published.piece_id = linked.piece_id
      WHERE linked.namespace = 'musicbrainz_work'
        AND linked.external_id
            = JSON_UNQUOTE(JSON_EXTRACT(queue.evidence, '$.externalId'))
        AND published.publish_status = 'PUBLISHED'
  );
