-- 모차르트 피아노 소나타 16번 K.545(piece 435)의 작품 식별자를 채운다.
--
-- 전체 work 으로 연결하고 1악장은 sector(MOVEMENT)로 붙인다.
-- 악장 work 들은 녹음이 0건이고 전체 work 이 28건으로 유일하게 녹음이 붙어 있다.
-- "Sonata semplice" 표기의 중복 work 둘도 0건이라 쓰지 않는다.
-- 붙이기 전에 piece_parts 와 piece_identifiers 양쪽을 확인했고 비어 있었다.
--
-- 이 배치는 서브에이전트에 맡긴 첫 시험 배치다. 영상 선정부터 후보 생성까지
-- 서브에이전트가 했고, 작품 해소와 적재는 호출한 쪽이 했다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 435 AS p, 'musicbrainz_work' AS n,
           'a2ad223d-d73b-3775-9580-fd25b4d986e1' AS v
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
