-- 멘델스존 교향곡 4번 "이탈리아"(piece 124), 슈베르트 교향곡 8번 "미완성"(piece 119),
-- 하이든 교향곡 94번 "놀람"(piece 83)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌(악장 도입)는 sector 로 붙는다. 적재 직전에 piece_identifiers 와
-- piece_parts 를 다시 확인했으며 셋 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 124 AS p, 'musicbrainz_work' AS n, '59f6e454-fc95-30d0-ab26-1ece5af0ea78' AS v
    UNION ALL SELECT 119, 'musicbrainz_work', 'b1e3d631-47fb-49fe-8d60-6f0dc7cbe0d8'
    UNION ALL SELECT 83, 'musicbrainz_work', '3e1453b3-0bae-42d2-8768-fc891bde8faf'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
