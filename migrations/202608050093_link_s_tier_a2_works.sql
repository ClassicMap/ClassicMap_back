-- 쇼스타코비치 왈츠 2번(piece 319)과 모차르트 K.265 변주곡(piece 436)의 작품 식별자를 채운다.
--
-- 왈츠 2번은 Suite for Variety Orchestra 의 일곱째 곡이다. ClassicMap 의 곡 자체가 이
-- 낱곡이므로 낱곡 work 을 쓴다. 적재 직전에 piece_identifiers 와 piece_parts 를 다시
-- 확인했으며 둘 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 319 AS p, 'musicbrainz_work' AS n, '8fcac0d0-d728-32e1-b7a5-8e5560ed36ab' AS v
    UNION ALL SELECT 436, 'musicbrainz_work', '1ecee37a-d6b6-3489-a542-5517c38e59f4'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
