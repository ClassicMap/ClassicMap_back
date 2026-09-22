-- 프로코피예프 고전 교향곡(piece 323), 바그너 "발퀴레의 기행"(piece 144), 멘델스존
-- "핑갈의 동굴"(piece 126)의 작품 식별자를 채운다.
--
-- 적재 직전에 piece_identifiers 를 다시 확인했으며 세 MBID 모두 어느 곡에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 323 AS p, 'musicbrainz_work' AS n, '5983b48e-59ce-40d4-a4df-e3c1667655db' AS v
    UNION ALL SELECT 144, 'musicbrainz_work', '6996fc77-b5dc-48ca-a7d5-3434f541f87a'
    UNION ALL SELECT 126, 'musicbrainz_work', '3329a6c8-4785-31ee-ab7e-8ded6804598e'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
