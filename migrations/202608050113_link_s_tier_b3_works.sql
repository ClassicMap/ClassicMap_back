-- 하이든 교향곡 101번 "시계"(piece 84), 하이든 교향곡 45번 "고별"(piece 85),
-- 모차르트 교향곡 41번 "주피터"(piece 68)의 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌는 sector 로 붙는다. 적재 직전에 piece_identifiers 와
-- piece_parts 를 다시 확인했으며 셋 다 어디에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 84 AS p, 'musicbrainz_work' AS n, 'da30a1dc-90c4-42b0-8984-9609bcb1156e' AS v
    UNION ALL SELECT 85, 'musicbrainz_work', '772c3aaa-bceb-4c8a-8700-6bab011bec3f'
    UNION ALL SELECT 68, 'musicbrainz_work', '2590a54a-b742-39e0-9f70-f07835ba4dda'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
