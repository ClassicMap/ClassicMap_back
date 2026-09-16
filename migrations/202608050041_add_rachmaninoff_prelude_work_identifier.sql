-- 라흐마니노프 전주곡 C#단조(piece 229)의 작품 식별자를 채운다.
--
-- 202608050029 에서 이 곡을 넣지 못한 이유는 그 MBID 가 이미 국제 시드 곡
-- (piece 1920 "Morceaux de fantaisie, op. 3")의 piece_parts 에 있어서
-- 해소 대상이 2건이 되기 때문이었다.
--
-- 적재기의 해소 규칙을 함께 고쳤다. piece_identifiers 는 "이 곡이 그 작품이다"
-- 라는 직접 진술이고 piece_parts 는 "이 곡이 그 작품을 부분으로 담는다"는
-- 포함 관계다. 둘이 같은 MBID 를 가리키면 직접 진술을 따른다.
-- 이제 이 식별자를 붙여도 piece 229 로 해소된다.
--
-- 달빛(piece 220)의 식별자는 202608050027 에 이미 있으므로 여기서 다루지 않는다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 229 AS p, 'musicbrainz_work' AS n,
           'd0261eb5-7e04-3804-94f6-11f1439442a8' AS v
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
