-- 푸치니 <투란도트> "공주는 잠 못 이루고"(piece 211)의 작품 식별자를 채운다.
--
-- 성악곡을 비교 영상에 넣는 첫 시도다. 지금까지 41곡을 성악이라는 이유로
-- 미뤄 두었는데, 화성 정렬이 성악에서도 통하는지 확인한 적이 없어서였다.
--
-- 오페라 아리아이므로 sectorType 은 EXCERPT 다. 작품은 아리아 단위 work 으로
-- 연결한다. 오페라 전체 work 이 아니라 아리아가 독립된 work 으로 있고
-- 연결된 녹음이 510건으로 압도적이다.
-- 붙이기 전에 piece_parts 와 piece_identifiers 양쪽을 확인했고 비어 있었다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 211 AS p, 'musicbrainz_work' AS n,
           '876aa6e9-0a0a-3408-bbfa-0565582cf8e0' AS v
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
