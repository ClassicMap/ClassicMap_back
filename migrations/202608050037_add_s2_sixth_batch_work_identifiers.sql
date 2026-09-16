-- 비교 영상 S2 여섯째 배치(요한 슈트라우스 2세 2곡, 라벨 1곡)의 작품 식별자를 채운다.
--
-- 202608050032 와 같은 이유다. 적재 전에 연결해야 한다.
--
-- 세 곡 모두 독립된 작품이라 국제 시드 piece_parts 와 겹치지 않는다.
-- 붙이기 전에 piece_parts 와 piece_identifiers 양쪽을 확인했고 비어 있었다.
--
-- 천둥과 번개 폴카는 녹음 188건, 박쥐 서곡은 311건, 물의 유희는 Wikidata
-- (Q1684076)의 P435 로 확인했다. 같은 제목의 다른 work 는 모두 11건 이하다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 187 AS p, 'musicbrainz_work' AS n,
           '85be26e9-6dec-3d34-96e5-87ba458133da' AS v
    UNION ALL SELECT 186, 'musicbrainz_work',
           '4147773e-61ee-3b4a-802d-399573d05d67'
    UNION ALL SELECT 232, 'musicbrainz_work',
           '512fddf1-7ae1-3b75-aeed-dc55792dd971'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
