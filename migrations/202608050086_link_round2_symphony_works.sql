-- 베토벤 교향곡 9번 "합창"(piece 76)과 모차르트 교향곡 40번(piece 67)의 작품 식별자를 채운다.
--
-- 둘 다 전곡 work 이다. 발췌 구간은 sector 로 붙는다. 적재 직전에 piece_identifiers 와
-- piece_parts 를 다시 확인했으며 두 MBID 모두 어디에도 붙어 있지 않았다.
--
-- 같은 배치의 봄의 제전(piece 309)은 정렬이 걸려 보류했으므로 넣지 않는다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 76 AS p, 'musicbrainz_work' AS n, 'c35b4956-d4f8-321a-865b-5b13d9ed192b' AS v
    UNION ALL SELECT 67, 'musicbrainz_work', '724cdab2-00ea-4aa2-b2b4-9d246d3672e0'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
