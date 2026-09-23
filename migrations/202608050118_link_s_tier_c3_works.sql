-- 베토벤 바이올린 협주곡 D장조 Op. 61(piece 81)의 작품 식별자를 채운다.
--
-- 프로코피예프 피아노 협주곡 3번(piece 325)과 거슈윈 피아노 협주곡 F장조(piece 335)는
-- 202608050108 에서 시드 쌍둥이와 합치며 이미 식별자를 받았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 81 AS p, 'musicbrainz_work' AS n, '5364d796-ca6e-4b24-b605-f802d905583a' AS v
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
