-- 차이콥스키 교향곡 5번 Op. 64(piece 453), 버르토크 관현악을 위한 협주곡 Sz. 116
-- (piece 327), 버르토크 현악기·타악기·첼레스타를 위한 음악 Sz. 106(piece 328)의
-- 작품 식별자를 채운다.
--
-- 셋 다 전곡 work 이고 발췌는 sector 로 붙는다. 적재 직전에 같은 MBID 를 쥔 시드 곡이
-- 있는지 확인했으며 셋 다 어디에도 붙어 있지 않았다.
--
-- 328 은 처음에 "전곡 work 이 없다" 고 판단했다가 뒤집었다. MusicBrainz 의 work 검색은
-- 악장 행에 더 높은 점수를 주므로(악장 100, 전곡 78~91) 상위 몇 개만 보면 전곡이
-- 보이지 않는다. 악장 표시가 있는 행을 걸러내니 나왔다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 453 AS p, 'musicbrainz_work' AS n, '9e906d77-a921-3d05-a101-0f757b1c93d2' AS v
    UNION ALL SELECT 327, 'musicbrainz_work', '2720522c-d8cb-4d94-b35a-e7773e8e5070'
    UNION ALL SELECT 328, 'musicbrainz_work', '0c680f6b-c5cf-4045-a689-df318e794383'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
