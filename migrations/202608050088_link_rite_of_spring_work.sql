-- 스트라빈스키 발레 <봄의 제전>(piece 309)의 작품 식별자를 채운다.
--
-- 전곡 work 이고 발췌(제1부 서주)는 sector 로 붙는다. 적재 직전에 piece_identifiers 와
-- piece_parts 를 다시 확인했으며 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 309 AS p, 'musicbrainz_work' AS n, '54dacada-b00c-34b6-bbbb-e89855c7219f' AS v
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
