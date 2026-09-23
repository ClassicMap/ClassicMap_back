-- 베토벤 피아노 소나타 23번 "열정" Op. 57(piece 440), 모차르트 피아노 소나타 11번
-- K. 331 "터키 행진곡"(piece 73), 베토벤 바이올린 소나타 5번 "봄" Op. 24(piece 439)의
-- 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 악장은 sector 로 붙는다. 적재 직전에 같은 MBID 를 쥔 시드 곡이
-- 있는지 확인했으며 셋 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 440 AS p, 'musicbrainz_work' AS n, '88a8eaa9-d07b-3b9b-b284-72289e2eeb43' AS v
    UNION ALL SELECT 73, 'musicbrainz_work', 'a488a020-884d-3349-a7e7-18993ffed13e'
    UNION ALL SELECT 439, 'musicbrainz_work', '26c8afae-81cd-4d4e-87c6-1b98cda047fc'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
