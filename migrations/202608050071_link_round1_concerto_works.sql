-- 하이든 트럼펫 협주곡(piece 88)과 모차르트 호른 협주곡 4번(piece 434)의 작품 식별자를
-- 채운다.
--
-- 적재 직전에 piece_identifiers 를 다시 확인했으며 두 MBID 모두 어느 곡에도 붙어 있지 않았다.
-- 쇼스타코비치 피아노 협주곡 2번(piece 458)의 MBID 는 국제 시드 곡(piece 12515)에 이미
-- 붙어 있어 넣지 않는다. 프로코피예프 소나타 7번(326 ↔ 11317)과 같이 두 곡을 합치는
-- 결정이 먼저다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 88 AS p, 'musicbrainz_work' AS n, '0c2f8487-6439-3b21-8284-8d578fcf8e1d' AS v
    UNION ALL SELECT 434, 'musicbrainz_work', '57f35a3f-1f6d-3ed0-940b-b6e2885de715'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
