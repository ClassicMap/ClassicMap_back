-- 멘델스존 바이올린 협주곡(piece 122), 모차르트 클라리넷 협주곡(piece 74), 쇼스타코비치
-- 첼로 협주곡 1번(piece 321)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌(악장 도입)는 sector 로 붙는다. 적재 직전에 piece_identifiers 와
-- piece_parts 를 다시 확인했으며 셋 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 122 AS p, 'musicbrainz_work' AS n, 'c230858f-8b2b-3e77-aa3e-777743980263' AS v
    UNION ALL SELECT 74, 'musicbrainz_work', 'd180cb96-0471-4626-bf85-d8083df7272e'
    UNION ALL SELECT 321, 'musicbrainz_work', '357a8194-bc80-478b-86cd-e3a90fe28c39'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
