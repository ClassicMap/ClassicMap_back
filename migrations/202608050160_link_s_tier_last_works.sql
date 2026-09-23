-- S tier 대기열 마지막 세 곡의 작품 식별자를 채운다.
--
--   69  모차르트 <피가로의 결혼> K. 492
--   145 바그너 <트리스탄과 이졸데> WWV 90
--   329 버르토크 발레 <이상한 만다린> Sz. 73
--
-- 오페라·발레 전곡을 곡으로 두고 낱 번호는 sector 로 붙인다.
--
-- 같은 작품의 외국어 제목판이 MusicBrainz 검색에서 더 높은 점수를 받는다. 피가로의
-- 결혼은 독일어 "Die Hochzeit des Figaro" 가 100점이고 원어 "Le nozze di Figaro, K. 492"
-- 가 95점, 트리스탄은 프랑스어 "Tristan et Isolde" 가 100점이고 "Tristan und Isolde,
-- WWV 90" 이 92점이다. **작품 번호가 붙은 원어 제목을 골랐다.**

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 69  AS p, 'musicbrainz_work' AS n, '8c6d8c96-bb80-4d9d-9fda-96852e10af60' AS v
    UNION ALL SELECT 145, 'musicbrainz_work', 'ae217ba8-0b07-4b0b-aed6-c80535dcd94b'
    UNION ALL SELECT 329, 'musicbrainz_work', '7628784b-557a-4fd6-9cbc-f378178f5e12'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
