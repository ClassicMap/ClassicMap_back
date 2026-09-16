-- 비교 영상 S2 넷째 배치(베토벤·슈베르트 2곡)의 작품 식별자를 채운다.
--
-- 202608050024 와 같은 이유다. 적재기는 작품을 piece_identifiers.musicbrainz_work
-- 로 해소하므로 적재 전에 먼저 연결해야 한다.
--
-- 엘리제를 위하여는 같은 제목의 work 가 둘인데 연결된 녹음이 638건인 쪽을 골랐다.
-- 나머지는 2건이다.
-- 악흥의 순간 3번은 검색으로 낱곡이 걸리지 않아 모음곡 부모(6 Moments musicaux,
-- D. 780)의 하위 작품에서 찾았다. 녹음 252건으로 같은 제목의 다른 work(1건, 8건)
-- 보다 압도적이다.
--
-- 이번 배치에 함께 검증한 라흐마니노프 전주곡 C#단조는 여기 넣지 않는다.
-- 그 작품의 MBID 는 이미 국제 시드 곡(piece 1920 "Morceaux de fantaisie, op. 3")
-- 의 piece_parts 에 있어서, legacy piece 229 에 식별자를 붙이면 해소 대상이 2건이
-- 되어 적재가 막힌다. 202608050028 의 달빛과 같은 문제다.
--
-- 연주자(랑랑·리시차·오트·조성진·프레·호로비츠)는 이미 연결돼 있다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 82 AS p, 'musicbrainz_work' AS n,
           'aced4197-c0f2-3964-b0b3-d71288bf5b20' AS v
    UNION ALL SELECT 444, 'musicbrainz_work',
           '07bd01cc-94de-36bb-a17b-dc8ec81a5862'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
