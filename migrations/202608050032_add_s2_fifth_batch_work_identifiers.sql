-- 비교 영상 S2 다섯째 배치(마스네·쇼팽·라벨 3곡)의 작품 식별자를 채운다.
--
-- 202608050029 와 같은 이유다. 적재기는 작품을 piece_identifiers.musicbrainz_work
-- 로 해소하므로 적재 전에 먼저 연결해야 한다.
--
-- 이번 세 곡은 모두 모음곡의 낱곡이 아니라 독립된 작품이다. 달빛·라흐마니노프
-- 전주곡·그노시엔이 막힌 이유가 국제 시드의 악장 part 와 겹치는 것이었으므로,
-- 붙이기 전에 piece_parts 와 piece_identifiers 양쪽을 확인했고 셋 다 비어 있었다.
--
-- 타이스의 명상곡은 오페라 2막 간주곡이다. 같은 이름의 work 가 여럿인데
-- 연결된 녹음이 230건인 원곡을 골랐다. 나머지는 편곡이거나 28건 이하다.
-- 녹턴 20번은 214건, 파반느는 Wikidata(Q2271923)의 P435 로 확인했다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 260 AS p, 'musicbrainz_work' AS n,
           'c8b5137d-d386-3393-8b6c-f756c31dc8f6' AS v
    UNION ALL SELECT 445, 'musicbrainz_work',
           'a7619cf9-0d62-31a5-aa0c-436edd8b7dd1'
    UNION ALL SELECT 231, 'musicbrainz_work',
           '7158bf7a-df0f-325d-8157-d15ff15bb771'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
