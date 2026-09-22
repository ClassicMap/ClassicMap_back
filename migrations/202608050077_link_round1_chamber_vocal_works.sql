-- 쇼스타코비치 현악 4중주 8번(piece 320), 슈베르트 "아베 마리아"(piece 443),
-- 쇤베르크 5개의 피아노 소품 Op.23(piece 316)의 작품 식별자를 채운다.
--
-- 적재 직전에 piece_identifiers 를 다시 확인했으며 세 MBID 모두 어느 곡에도 붙어 있지 않았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 320 AS p, 'musicbrainz_work' AS n, '725265f4-4b9e-46d2-832b-50b0466f1b6f' AS v
    UNION ALL SELECT 443, 'musicbrainz_work', 'b2be878e-12f4-3ce1-85e0-6b84d07ea43c'
    UNION ALL SELECT 316, 'musicbrainz_work', 'cfd0d254-2062-42fc-b260-f56600fc7527'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
