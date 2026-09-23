-- 슈베르트 가곡 <마왕> D. 328(piece 117), 베르디 <나부코> 중 "히브리 노예들의
-- 합창"(piece 151), 바그너 <로엔그린> 중 "혼례의 합창"(piece 146)의 작품 식별자를 채운다.
--
-- 151·146 은 오페라의 한 번호라 부분 work 을 쓴다. 곡 자체가 그 대목이므로 맞다.
--
-- 마왕은 시드 곡이 다섯 개(1463 · 9963 · 11263 · 11425 · 12552) 같은 이름으로 있으나
-- 셋은 리스트의 피아노 편곡(S. 557a · S. 558)과 영문 제목판이고, 나머지 둘도 연주·구간·
-- 악장이 하나도 없는 빈 목록 행이다. 합칠 것이 없어 표준 work 을 새로 붙였다.
-- 여럿 중 하나를 임의로 고르는 것은 모호함을 줄이지 못한다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 117 AS p, 'musicbrainz_work' AS n, 'd783dab0-9f74-3226-81a0-645de2b56d3e' AS v
    UNION ALL SELECT 151, 'musicbrainz_work', '8c33f7c4-23cf-43d0-a638-f2c2901ed646'
    UNION ALL SELECT 146, 'musicbrainz_work', '5a75bea9-985d-4267-9a0a-2ace57e20716'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
