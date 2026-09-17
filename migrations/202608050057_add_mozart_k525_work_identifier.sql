-- 모차르트 아이네 클라이네 나흐트무지크 K.525(piece 66)의 작품 식별자를 채운다.
--
-- 전체 work 으로 연결하고 1악장은 sector(MOVEMENT)로 붙인다.
-- 악장 work(4악장 378건)이 전체 work(140건)보다 녹음이 많지만, 낱곡 work 은
-- 국제 시드의 piece_parts 와 겹칠 수 있어 전체 work 을 쓴다(01-selection.md).
-- 붙이기 전에 piece_parts 와 piece_identifiers 양쪽을 확인했고 비어 있었다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 66 AS p, 'musicbrainz_work' AS n,
           'f334182c-42f7-4808-9576-6c73efe2c632' AS v
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
