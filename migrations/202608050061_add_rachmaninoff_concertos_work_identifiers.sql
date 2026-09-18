-- 라흐마니노프 피아노 협주곡 2번(piece 225)·3번(piece 226)의 작품 식별자를 채운다.
--
-- 두 곡은 클립 자산 없이 수동으로 넣었던 레거시 연주만 있어 새 비교 API 공개 기준에
-- 들지 못했다. 같은 영상과 사람이 잡은 발췌 경계를 출발점으로 이 파이프라인에서
-- 다시 수집하려면 작품 해소가 먼저다.
--
-- 전체 work 으로 연결하고 발췌 구간은 sector(EXCERPT)로 붙인다.
--   2번 aca4167a  녹음 48건 (같은 제목의 다른 work 은 0~3건)
--   3번 21b5596b  녹음 18건 (같은 제목의 다른 work 은 0~2건)
-- 붙이기 전에 piece_parts 와 piece_identifiers 양쪽을 확인했고 비어 있었다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 225 AS p, 'musicbrainz_work' AS n, 'aca4167a-b927-41f5-a839-99cf9ad476cc' AS v
    UNION ALL SELECT 226, 'musicbrainz_work', '21b5596b-5b70-320c-bf3f-c7285f770783'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
