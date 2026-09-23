-- 차이콥스키 발레 <호두까기 인형> Op. 71(piece 161)과 <백조의 호수> Op. 20(piece 162)의
-- 작품 식별자를 채운다.
--
-- <로미오와 줄리엣>(piece 322)은 202608050140 에서 시드 쌍둥이 11336 의 것을 옮겨 받았다.
--
-- 셋 다 발레 전곡을 곡으로 두고 낱 번호는 sector 로 붙인다. MusicBrainz 에는 낱 번호도
-- 따로 work 으로 있으나 쓰지 않는다. 한 작품 안의 여러 대목을 나중에 더 붙이려면
-- 전곡에 sector 를 더하는 편이 낫기 때문이다(202608050095 어린이의 정경과 같은 판단).

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 161 AS p, 'musicbrainz_work' AS n, 'f3281e81-eea2-409f-88b8-9e1e1de5ca10' AS v
    UNION ALL SELECT 162, 'musicbrainz_work', '11f48c5e-5ee9-4646-9826-fb7c2fccce7f'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
