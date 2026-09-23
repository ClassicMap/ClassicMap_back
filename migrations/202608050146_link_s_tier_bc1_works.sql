-- 쇤베르크 <정화된 밤> Op. 4(piece 313)의 작품 식별자를 채운다.
--
-- 브람스 바이올린 협주곡(piece 156)은 202608050137 에서 시드 쌍둥이 11314 의 것을
-- 옮겨 받았고, 번스타인 심포닉 댄스(piece 337)는 202608050108 에서 받았다.
--
-- 정화된 밤은 현악 6중주 원곡(1899)과 현악 합주 편곡(1917/1943)이 같은 work 을 쓴다.
-- 이 배치는 현악 합주판 1943년 제2판으로 통일했다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 313 AS p, 'musicbrainz_work' AS n, '47ac23fb-acab-42b6-8f81-10550f8b1f83' AS v
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
