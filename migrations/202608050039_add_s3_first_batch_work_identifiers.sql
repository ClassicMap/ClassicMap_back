-- 비교 영상 S3 첫 배치(베토벤 피아노 소나타 2곡)의 작품 식별자를 채운다.
--
-- S3 는 8~20분 곡이다. 클립은 최대 600초이므로 작품 전체를 한 구간으로 둘 수 없다.
-- 202608050019(S1)에서 협주곡·교향곡에 쓴 방식을 따른다. 작품은 전체 work 로
-- 연결하고 구간은 sector 로 나눈다. 이번에는 악장 단위(MOVEMENT)다.
--
-- 낱 악장에도 MusicBrainz work 이 따로 있지만 쓰지 않는다. 낱곡 work 은 국제 시드
-- piece_parts 와 겹쳐 해소가 막히는 일이 반복됐다(202608050029 참고).
-- 작품 전체 work 을 쓰면 그 문제를 피한다. 붙이기 전에 확인했고 양쪽 다 비어 있었다.
--
-- 월광 소나타는 같은 제목의 work 중 연결된 녹음이 180건인 전체 작품을 골랐다.
-- 739건짜리는 1악장 낱 work 이라 대상이 아니다. 비창 소나타도 같은 이유로 73건인
-- 전체 작품을 골랐다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 78 AS p, 'musicbrainz_work' AS n,
           'd754d820-2036-39f6-9fd5-636cda85b3b2' AS v
    UNION ALL SELECT 79, 'musicbrainz_work',
           'c366ec5b-9d61-3057-827c-afd61a237b23'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
