-- 비교 영상 S2 둘째 배치(쇼팽 소품 3곡)의 작품 식별자를 채운다.
--
-- 202608050021 과 같은 이유다. 적재기는 작품을 piece_identifiers.musicbrainz_work
-- 로 해소하므로 적재 전에 먼저 연결해야 한다.
--
-- 세 곡 모두 낱곡 work 를 쓴다.
-- 빗방울 전주곡과 이별의 곡은 모음곡 부모(24 Préludes op.28, Études op.10)의
-- 하위 작품에서 찾았다. 검색으로는 낱곡이 바로 걸리지 않는다.
-- 영웅 폴로네즈는 같은 제목의 work 가 셋 있어 연결된 녹음이 351건인 것을 골랐다.
-- 나머지 둘은 1건 이하다.
--
-- 연주자(랑랑·조성진·호로비츠·폴리니·임윤찬·시시킨·키신)는 이미 연결돼 있다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 446 AS p, 'musicbrainz_work' AS n, 'aa57f86d-8701-34f6-9cb6-c892e8028c7c' AS v
    UNION ALL SELECT 447, 'musicbrainz_work', '1d9d388e-e80f-3702-96b3-64a0949cadce'
    UNION ALL SELECT 130, 'musicbrainz_work', '46e4d18b-1fc4-324e-b045-c586f5f0d4dc'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
