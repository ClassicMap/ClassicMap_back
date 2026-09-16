-- 비교 영상 S2 첫 배치(짧은 피아노 소품 3곡)의 작품 식별자를 채운다.
--
-- load_comparison_candidates 는 작품을 piece_identifiers.musicbrainz_work 로 해소하고
-- 연결된 작곡가의 external_identifiers.wikidata 까지 교차 확인한다.
-- 해소에 실패하면 후보 적재 전체가 rollback 되므로 적재 전에 먼저 연결한다.
--
-- 세 곡 모두 낱곡 work 를 쓴다. 모음곡 전체 work(Études op.10, Waltzes op.64,
-- Nocturnes op.9)를 붙이면 다른 낱곡과 구분되지 않는다.
-- 혁명 에튀드는 MusicBrainz 검색으로 바로 찾히지 않아
-- Études op.10 (09fb2287-f5d3-4bf6-aa2d-ae6b07352b68) 의 하위 작품에서 확인했다.
--
-- 연주자(키신·조성진·폴리니·랑랑·루빈스타인)는 이미 wikidata 로 연결돼 있어
-- 추가할 권위 행이 없다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 127 AS p, 'musicbrainz_work' AS n, '45fc7e48-c655-3f5c-bfe7-704a9784225e' AS v
    UNION ALL SELECT 131, 'musicbrainz_work', '1e14127f-0686-3b29-b56f-501044d019b3'
    UNION ALL SELECT 133, 'musicbrainz_work', '3ea59e6f-4d98-3ef2-93ed-b698fc38ada5'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
