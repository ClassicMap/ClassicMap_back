-- 국제 시드가 따로 만든 브람스 바이올린 협주곡 중복 곡의 작품 식별자와 악장을
-- 수동 곡으로 옮긴다.
--
--   브람스 바이올린 협주곡 D장조 Op. 77   11314 → 156
--
-- 202608050108·202608050120 과 같은 이유와 같은 방식이다. 시드 곡 11314 에는 연주·구간이
-- 하나도 없고 MusicBrainz 작품 식별자와 악장 3개뿐인 것을 확인했다. 수동 곡 156 에는
-- 한국어 제목이 있고 editor_locked 다. 시드 곡 자체는 지우지 않는다.

UPDATE piece_identifiers identifier
JOIN (SELECT 11314 AS seed, 156 AS manual) pair ON pair.seed = identifier.piece_id
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
JOIN (SELECT 11314 AS seed, 156 AS manual) pair ON pair.seed = source.piece_id
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = pair.manual AND existing.part_key = source.part_key
);
