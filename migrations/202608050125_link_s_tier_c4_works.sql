-- 슈베르트 피아노 5중주 "송어" D. 667(piece 118)과 하이든 현악 4중주 "황제"
-- Op. 76-3 Hob. III:77(piece 86)의 작품 식별자를 채운다.
--
-- 슈베르트 현악 4중주 "죽음과 소녀"(piece 120)는 202608050120 에서 시드 쌍둥이 11928 의
-- 식별자를 옮겨 받아 이미 붙어 있다.
--
-- 송어는 MusicBrainz 에서 "The Trout" 로 찾으면 가곡 D. 550 이 먼저 나온다. 5중주는
-- 독일어 제목 "Quintett A-Dur, D. 667 Forellenquintett" 로만 걸린다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 118 AS p, 'musicbrainz_work' AS n, 'ed002d99-2ca2-4fb1-9e1b-2cb16b61fd14' AS v
    UNION ALL SELECT 86, 'musicbrainz_work', 'a723b328-ae25-4f0e-ad92-d6423f31b4ab'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
