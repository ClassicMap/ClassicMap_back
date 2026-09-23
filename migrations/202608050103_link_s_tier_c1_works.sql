-- 리스트 피아노 협주곡 1번(piece 450), 쇼팽 피아노 협주곡 1번(piece 132), 슈만 피아노
-- 협주곡(piece 136)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌(악장 도입)는 sector 로 붙는다. 적재 직전에 piece_identifiers 와
-- piece_parts 를 다시 확인했으며 셋 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 450 AS p, 'musicbrainz_work' AS n, 'd7793d9f-4613-4a34-9f2e-c2dffb8d2412' AS v
    UNION ALL SELECT 132, 'musicbrainz_work', '5f7ded0a-9869-38e5-a9fd-8612919f1a94'
    UNION ALL SELECT 136, 'musicbrainz_work', '5aa383a9-75d7-4b9e-a804-15d6bc5c793e'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
