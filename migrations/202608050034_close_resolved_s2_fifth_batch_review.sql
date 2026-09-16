-- S2 다섯째 배치를 적재하다 남은 검수 항목 1건을 종결한다.
--
-- load_comparison_candidates 는 작품을 해소하지 못하면 후보 적재를 rollback 하고
-- review_queue 만 남긴다. 설계된 동작이다.
--
-- 라벨 "죽은 왕녀를 위한 파반느"(piece 231)의 첫 적재에서 작곡가 Wikidata QID 를
-- 잘못 적어(Q781, 실제로는 Q1178) 해소에 실패했고 한 건이 쌓였다.
-- 고쳐서 다시 돌린 bundle 이 정상 적재됐으므로 그 항목이 가리키는 문제는 해소됐다.
--
-- 202608050023 은 "식별자가 연결돼 있는가"로 판정했는데, 달빛처럼 식별자를 붙이고도
-- piece_parts 와 겹쳐 해소되지 않는 경우를 구분하지 못한다.
-- 그래서 여기서는 "그 작품으로 실제 발행된 연주가 있는가"로 판정한다.
-- 달빛(piece 220)은 식별자는 있지만 발행된 연주가 없으므로 그대로 열려 있다.

UPDATE review_queue queue
SET queue.status = 'CANCELLED',
    queue.resolution = JSON_OBJECT(
        'action', 'reloaded_with_corrected_composer_qid',
        'migration', '202608050032',
        'namespace', 'musicbrainz_work',
        'note', '작곡가 QID를 고쳐 같은 bundle이 정상 적재되고 연주가 발행됨'
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
