-- 남은 여섯 곡 중 넷의 작품 식별자를 채운다.
--
--   134 슈만 <시인의 사랑> Op. 48        87  하이든 <천지창조> Hob. XXI:2
--   312 스트라빈스키 시편 교향곡
--
-- 116 겨울나그네와 318 레닌그라드는 202608050154 에서 시드 쌍둥이의 것을 옮겨 받았고,
-- 317 쇼스타코비치 5번은 202608050108 에서 받았다.
--
-- 연가곡·오라토리오는 MusicBrainz 의 work 검색에서 낱 노래에 파묻힌다. 겨울나그네를
-- 제목으로 찾으면 24곡이 먼저 나오고 전곡처럼 보이는 "Winterreise, S. 561" 은 리스트의
-- 피아노 편곡이다. type:song-cycle 을 걸어야 D. 911 전곡이 나온다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 134 AS p, 'musicbrainz_work' AS n, '6c060724-fd7e-4b77-99e9-e7f10c58aebd' AS v
    UNION ALL SELECT 87,  'musicbrainz_work', 'c77e1961-e301-4957-9660-f6607be5cbac'
    UNION ALL SELECT 312, 'musicbrainz_work', '84070a93-3b55-4c11-a15c-7f4efec7df7f'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
