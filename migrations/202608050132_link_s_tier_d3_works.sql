-- 브람스 교향곡 4번 Op. 98(piece 452), 슈만 교향곡 3번 "라인" Op. 97(piece 137),
-- 차이콥스키 교향곡 6번 "비창" Op. 74(piece 158)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌는 sector 로 붙는다. 적재 직전에 같은 MBID 를 쥔 시드 곡이
-- 있는지 확인했으며 셋 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 452 AS p, 'musicbrainz_work' AS n, 'abc15adc-3442-359e-a051-72a0f5a7f90a' AS v
    UNION ALL SELECT 137, 'musicbrainz_work', '9676e339-c433-4d26-b28d-a454eec164eb'
    UNION ALL SELECT 158, 'musicbrainz_work', '15e0a721-5332-3452-8a56-e00af7b9e4ca'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
