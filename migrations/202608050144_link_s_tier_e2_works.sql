-- 스트라빈스키 발레 <불새>(piece 310), <페트루슈카>(piece 311), 멘델스존
-- <한여름 밤의 꿈> 부수음악 Op. 61(piece 123)의 작품 식별자를 채운다.
--
-- 셋 다 전곡을 곡으로 두고 낱 번호는 sector 로 붙인다. 발레는 모음곡 work 이 따로
-- 있으나 쓰지 않는다. 한 작품 안의 다른 대목을 나중에 더 붙이려면 전곡에 sector 를
-- 더하는 편이 낫기 때문이다(202608050141 과 같은 판단).
--
-- 스트라빈스키의 발레 work 은 제목이 프랑스어다(L'Oiseau de feu, Pétrouchka).
-- "Firebird" · "Petrushka" 로 찾으면 모음곡과 낱 번호만 나오고 전곡이 보이지 않는다.
-- arid 에 type:ballet 을 걸어 목록을 훑어 찾았다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 310 AS p, 'musicbrainz_work' AS n, '2fbaaf2d-deff-46fb-ac15-ac76e9e56eca' AS v
    UNION ALL SELECT 311, 'musicbrainz_work', '57deae1f-4fb3-40c3-aa4f-3167ea0e806a'
    UNION ALL SELECT 123, 'musicbrainz_work', 'e2a0b12c-c31c-4802-a57d-6bc2a9266e0f'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
