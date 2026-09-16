-- 비교 영상 S2 셋째 배치(드뷔시·사티 3곡)의 작품 식별자를 채운다.
--
-- 202608050021·202608050024 와 같은 이유다. 적재기는 작품을
-- piece_identifiers.musicbrainz_work 로 해소하므로 적재 전에 먼저 연결한다.
--
-- 셋 다 낱곡 work 다.
--   달빛은 Suite bergamasque 의 제3곡이다. 같은 이름의 work 가 따로 있는데
--   그쪽은 베를렌 시에 붙인 가곡이라 쓰지 않는다.
--   아라베스크 1번은 Deux arabesques 의 제1곡이다.
--   짐노페디 1번은 "Gymnopédies: I. Lent et grave" 로 등록돼 있어 제목 검색으로는
--   바로 걸리지 않는다. 동명 work 중 연결된 녹음이 83건인 것을 골랐다(나머지는 2건 이하).

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 220 AS p, 'musicbrainz_work' AS n, '8d331505-4d88-39ae-81c7-bec5da77af96' AS v
    UNION ALL SELECT 224, 'musicbrainz_work', 'e92cdd58-c0b1-315a-8193-5f2bfccda28c'
    UNION ALL SELECT 378, 'musicbrainz_work', 'f684a145-0650-3acf-8761-c9ba2bdc7e30'
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
