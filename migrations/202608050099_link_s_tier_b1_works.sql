-- 거슈윈 파리의 미국인(piece 334), 리스트 교향시 전주곡(piece 142), 차이콥스키 1812년
-- 서곡(piece 163)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌는 sector 로 붙는다. 적재 직전에 piece_identifiers 와
-- piece_parts 를 다시 확인했으며 셋 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 334 AS p, 'musicbrainz_work' AS n, '7e7d799a-babe-3d9c-b271-9ad417ac650f' AS v
    UNION ALL SELECT 142, 'musicbrainz_work', '5e852053-64ba-3013-a86b-daf146791dda'
    UNION ALL SELECT 163, 'musicbrainz_work', '36dfecf2-b58c-3997-a629-3b34979791ae'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
