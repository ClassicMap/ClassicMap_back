-- 리스트 초절기교 연습곡 4번 "마제파"(piece 143)와 헝가리 광시곡 2번(piece 141)의
-- 작품 식별자를 채운다.
--
-- 둘 다 전곡(WHOLE_WORK)이다. MBID 는 준비 단계에서 녹음 수로 골랐고,
-- 적재 직전에 piece_parts 와 piece_identifiers 양쪽을 다시 확인했으며 비어 있었다.
--
-- 같은 라운드의 프로코피예프 피아노 소나타 7번(piece 326)은 MBID 가 국제 시드 곡
-- (piece 11317)에 이미 식별자로 붙어 있어 넣지 않는다. 식별자는 유일해야 하므로
-- 두 곡을 합치는 결정이 먼저다. 후보는 curation 에 남겨 둔다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 143 AS p, 'musicbrainz_work' AS n, '3ea62b96-e31e-4797-8d7b-cdeadbc6f27f' AS v
    UNION ALL SELECT 141, 'musicbrainz_work', '90929826-5064-3212-89c1-689be90e1d4d'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
