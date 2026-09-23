-- 베토벤 교향곡 7번 Op. 92(piece 438), 베토벤 교향곡 6번 "전원" Op. 68(piece 437),
-- 차이콥스키 현을 위한 세레나데 Op. 48(piece 454)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌는 sector 로 붙는다. 적재 직전에 piece_identifiers 와
-- 같은 MBID 를 쥔 시드 곡이 있는지 확인했으며 셋 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 438 AS p, 'musicbrainz_work' AS n, 'c7caedf2-954f-394b-9601-5878b76577ac' AS v
    UNION ALL SELECT 437, 'musicbrainz_work', '60e1dcf6-e728-35be-8948-ba74500b6c6e'
    UNION ALL SELECT 454, 'musicbrainz_work', 'ec6691e5-79c3-471b-b82d-e94462e42e14'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
