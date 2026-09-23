-- 국제 시드가 따로 만든 "죽음과 소녀" 중복 곡의 작품 식별자와 악장을 수동 곡으로 옮긴다.
--
--   슈베르트 현악 4중주 14번 D단조 D. 810   11928 → 120
--
-- 202608050108 과 같은 이유와 같은 방식이다. 시드 곡 11928 에는 연주·구간이 하나도 없고
-- MusicBrainz 작품 식별자와 악장 4개뿐인 것을 확인했다. 수동 곡 120 에는 한국어 제목이
-- 있고 editor_locked 다. 시드 곡 자체는 지우지 않는다.
--
-- MusicBrainz 에는 D. 810 의 work 이 여럿 있는데(db422156 · c6e6e640 · f0ee835c 등),
-- 시드가 이미 쥐고 있는 db422156 을 그대로 쓴다. 새 MBID 를 붙이면 같은 작품에 식별자가
-- 둘로 갈려 다음에 또 충돌한다.

UPDATE piece_identifiers identifier
JOIN (SELECT 11928 AS seed, 120 AS manual) pair ON pair.seed = identifier.piece_id
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
JOIN (SELECT 11928 AS seed, 120 AS manual) pair ON pair.seed = source.piece_id
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = pair.manual AND existing.part_key = source.part_key
);
