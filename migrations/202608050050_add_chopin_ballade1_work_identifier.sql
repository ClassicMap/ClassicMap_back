-- 쇼팽 발라드 1번(piece 129)의 작품 식별자를 채운다.
--
-- 202608050039 와 같은 이유다. 이 곡은 단일 악장이라 sector 는 전곡이다.
-- 9분대 연주라 클립 한도(600초) 안에 들어온다.
--
-- 같은 제목의 work 중 연결된 녹음이 313건인 것을 골랐다. 나머지는 3건 이하다.
-- 붙이기 전에 piece_parts 와 piece_identifiers 양쪽을 확인했고 비어 있었다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 129 AS p, 'musicbrainz_work' AS n,
           'f94364c5-b4ca-3555-af9e-86dff67757af' AS v
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
