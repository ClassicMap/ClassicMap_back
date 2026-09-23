-- 베토벤 교향곡 3번 "영웅" Op. 55(piece 77), 브람스 교향곡 1번 Op. 68(piece 153),
-- 브람스 교향곡 3번 Op. 90(piece 154)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌는 sector 로 붙는다. 적재 직전에 같은 MBID 를 쥔 시드 곡이
-- 있는지 확인했으며 셋 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 77 AS p, 'musicbrainz_work' AS n, '80737426-8ef3-3a9c-a3a6-9507afb93e93' AS v
    UNION ALL SELECT 153, 'musicbrainz_work', 'c1b0e8a2-2461-4d48-9a89-f4e6d624d342'
    UNION ALL SELECT 154, 'musicbrainz_work', 'e79fbd3e-02f2-4d16-b9fe-cf66e9facd27'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
