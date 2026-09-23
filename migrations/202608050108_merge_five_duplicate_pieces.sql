-- 국제 시드가 따로 만든 중복 곡 다섯 쌍의 작품 식별자와 악장을 수동 곡으로 옮긴다.
--
--   번스타인 심포닉 댄스        761   → 337
--   거슈윈 피아노 협주곡 F장조   2286  → 335
--   프로코피예프 피아노 협주곡 3번 11327 → 325
--   프로코피예프 피터와 늑대     576   → 324
--   쇼스타코비치 교향곡 5번      2479  → 317
--
-- 202608050081·202608050095 와 같은 이유와 같은 방식이다. 다섯 시드 곡 모두 연주·구간·
-- 관계가 하나도 없고 악장과 별칭뿐인 것을 확인했다. 수동 곡에는 한국어 제목이 있고
-- editor_locked 다. 시드 곡 자체는 지우지 않는다.
--
-- 악장은 시드 곡의 행을 그대로 복사한다. 한국어 이름은 비워 둔다(영문 악장명만 있다).
-- 자동 시드가 덮어쓰지 못하게 origin 을 manual, editor_locked 를 1 로 둔다.
-- 심포닉 댄스는 ISWC 도 함께 옮긴다.

UPDATE piece_identifiers identifier
JOIN (
    SELECT 761 AS seed, 337 AS manual
    UNION ALL SELECT 2286, 335
    UNION ALL SELECT 11327, 325
    UNION ALL SELECT 576, 324
    UNION ALL SELECT 2479, 317
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
    SELECT 761 AS seed, 337 AS manual
    UNION ALL SELECT 2286, 335
    UNION ALL SELECT 11327, 325
    UNION ALL SELECT 576, 324
    UNION ALL SELECT 2479, 317
) pair ON pair.seed = source.piece_id
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = pair.manual AND existing.part_key = source.part_key
);
