-- 베토벤 피아노 협주곡 5번 "황제"(piece 80), 차이콥스키 바이올린 협주곡(piece 160),
-- 모차르트 피아노 협주곡 20번(piece 72)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이다. 발췌 구간은 sector 로 붙는다(낱 악장 work 은 국제 시드의
-- piece_parts 와 겹쳐 해소가 막힌다). 적재 직전에 piece_identifiers 와 piece_parts 를
-- 다시 확인했으며 세 MBID 모두 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 80 AS p, 'musicbrainz_work' AS n, 'e5cfd8b5-74c2-3330-9ca4-42ecd22dffef' AS v
    UNION ALL SELECT 160, 'musicbrainz_work', 'f7136e19-4a8a-42ae-be40-01e9d78b45d5'
    UNION ALL SELECT 72, 'musicbrainz_work', '63ec17bb-39b9-344c-a006-3c30863c25a7'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
