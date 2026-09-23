-- 번스타인 <캔디드> 서곡(piece 338), 바그너 <탄호이저> 서곡(piece 147),
-- 모차르트 <마술피리> K. 620(piece 70)의 작품 식별자를 채운다.
--
-- 338·147 은 서곡 자체가 곡이므로 서곡 work 을 쓴다. 70 은 오페라 전곡을 곡으로 두고
-- 아리아를 sector 로 붙인다.
--
-- <마술피리>는 영어 제목 "The Magic Flute" 가 검색에서 더 높은 점수를 받지만
-- 쾨헬 번호가 붙은 원어 제목 "Die Zauberflöte, K. 620" 을 골랐다.
-- <탄호이저> 서곡도 WWV 번호가 붙은 것을 골랐다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 338 AS p, 'musicbrainz_work' AS n, 'f27a6729-0610-348e-83b3-d55c5d53ff86' AS v
    UNION ALL SELECT 147, 'musicbrainz_work', '1cba82ba-a6f3-3590-a0c1-b9e742fa742d'
    UNION ALL SELECT 70, 'musicbrainz_work', 'e208c5f5-5d37-3dfc-ac0b-999f207c9e46'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
