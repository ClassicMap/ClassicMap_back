-- 국제 시드가 따로 만든 중복 곡 두 쌍의 작품 식별자와 악장을 수동 곡으로 옮긴다.
--
--   슈베르트 <겨울나그네> D. 911            12271 → 116
--   쇼스타코비치 교향곡 7번 "레닌그라드"     2346  → 318
--
-- 202608050108·202608050120·202608050137·202608050140 과 같은 이유와 같은 방식이다.
-- 두 시드 곡 모두 연주·구간이 하나도 없고 작품 식별자와 악장뿐이다. 수동 곡에는
-- 한국어 제목이 있고 editor_locked 다. 시드 곡 자체는 지우지 않는다.

UPDATE piece_identifiers identifier
JOIN (
    SELECT 12271 AS seed, 116 AS manual
    UNION ALL SELECT 2346, 318
) pair ON pair.seed = identifier.piece_id
SET identifier.piece_id = pair.manual
WHERE NOT EXISTS (
    SELECT 1 FROM (
        SELECT piece_id, namespace FROM piece_identifiers
    ) existing
    WHERE existing.piece_id = pair.manual AND existing.namespace = identifier.namespace
);

INSERT INTO piece_parts
    (piece_id, part_key, sequence_number, movement_number, name_en, duration_ms,
     editorial_status, origin, editor_locked)
SELECT pair.manual, source.part_key, source.sequence_number, source.movement_number,
       source.name_en, source.duration_ms, 'FACTS_VERIFIED', 'manual', 1
FROM (SELECT piece_id, part_key, sequence_number, movement_number, name_en, duration_ms
      FROM piece_parts) source
JOIN (
    SELECT 12271 AS seed, 116 AS manual
    UNION ALL SELECT 2346, 318
) pair ON pair.seed = source.piece_id
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = pair.manual AND existing.part_key = source.part_key
);
