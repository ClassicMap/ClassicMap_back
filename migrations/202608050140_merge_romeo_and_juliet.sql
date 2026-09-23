-- 국제 시드가 따로 만든 <로미오와 줄리엣> 발레 전곡의 작품 식별자와 악장을
-- 수동 곡으로 옮긴다.
--
--   프로코피예프 발레 <로미오와 줄리엣> Op. 64   11336 → 322
--
-- 202608050108·202608050120·202608050137 과 같은 이유와 같은 방식이다. 시드 곡 11336 에는
-- 연주·구간이 하나도 없고 작품 식별자와 악장 54개(발레 전곡의 번호들)뿐이다.
-- 수동 곡 322 에는 한국어 제목이 있고 editor_locked 다. 시드 곡 자체는 지우지 않는다.
--
-- 이 발레는 시드에 낱 번호가 따로 곡으로 여럿 들어와 있다(11421 Masks, 11642 Dance of
-- the Knights, 11923 Balcony scene 등). 그것들은 합치지 않는다. 우리는 발레 전곡을
-- 곡으로 두고 낱 번호는 sector 로 붙이기 때문이다.

UPDATE piece_identifiers identifier
JOIN (SELECT 11336 AS seed, 322 AS manual) pair ON pair.seed = identifier.piece_id
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
JOIN (SELECT 11336 AS seed, 322 AS manual) pair ON pair.seed = source.piece_id
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = pair.manual AND existing.part_key = source.part_key
);
