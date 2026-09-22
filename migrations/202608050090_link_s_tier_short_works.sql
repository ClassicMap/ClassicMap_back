-- 쇼팽 환상 즉흥곡(piece 128), 리스트 사랑의 꿈 3번(piece 139), 브람스 헝가리 무곡 5번
-- 관현악판(piece 155)의 작품 식별자를 채운다.
--
-- 셋 다 낱곡이지만 ClassicMap 의 곡 자체가 낱곡이므로 낱곡 work 을 쓴다(쇼팽 녹턴 131,
-- 라 캄파넬라 140 과 같다). 적재 직전에 piece_identifiers 와 piece_parts 를 다시 확인했다.
--
-- 헝가리 무곡 5번은 처음 고른 637b6d1e-…("21 Hungarian Dances for Orchestra, WoO 1: No. 5",
-- 녹음 98건)가 국제 시드 곡 11876 의 piece_parts 에 이미 붙어 있어 쓸 수 없었다. 같은
-- 관현악 편곡의 다른 work(e822f7b1-…, 녹음 48건)로 바꿨다. 피아노 연탄 원곡은 F#단조라
-- 다른 work 이고 섞지 않는다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 128 AS p, 'musicbrainz_work' AS n, '3fdac4f1-9077-3e58-a704-994e6ce3562a' AS v
    UNION ALL SELECT 139, 'musicbrainz_work', '0edc5a7d-48e1-393e-9a88-3ed0ce05aee0'
    UNION ALL SELECT 155, 'musicbrainz_work', 'e822f7b1-8cd7-4e34-9950-d13f9f911cda'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
