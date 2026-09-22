-- 슈만 카니발 Op. 9(piece 138)와 거슈윈 랩소디 인 블루(piece 332)의 작품 식별자를 채운다.
--
-- 슈베르트 즉흥곡(piece 121)은 202608050095 에서 이미 연결했다(시드 곡 13100 과 합치며 옮김).
-- 카니발은 전곡 work 이고 발췌(마지막 곡 다비드 동맹의 행진)는 sector 로 붙는다.
-- 적재 직전에 piece_identifiers 와 piece_parts 를 다시 확인했으며 둘 다 비어 있었다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 138 AS p, 'musicbrainz_work' AS n, '20cb8152-c2ad-3e20-a818-bc32624b1838' AS v
    UNION ALL SELECT 332, 'musicbrainz_work', 'bf7e3ad3-4d47-3425-aa5f-8cc8c91d53ed'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
