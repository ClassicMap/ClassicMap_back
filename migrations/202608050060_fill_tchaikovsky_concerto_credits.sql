-- 차이콥스키 피아노 협주곡 1번(piece 159) 발행 연주에 지휘자·악단 크레딧을 채운다.
--
-- 협주곡 크레딧 규칙(01-selection.md)이 생기기 전에 발행돼 독주자 크레딧만 있었다.
-- 순서는 독주자(0, primary) → 지휘자(1) → 악단(2)이다.
--
-- 근거는 영상 설명 원문이다. 곡 상식이나 기억으로 채우지 않았다.
--   2DmfJu3oNDM 아르헤리치 (DW Classical Music)
--     "Conducted by Charles Dutoit, Argerich performed with the Verbier Festival Orchestra
--      at the Verbier Festival in 2014."
--   Ybg2BEy_pu0 랑랑 (GreatPerformers1, 공식 채널이 아닌 업로드)
--     "From 2015, Lang Lang performs Tchaikovsky's Piano Concerto # 1 in B flat minor with
--      Paavo Järvi conducting the Orchestre de Paris."
--   w2xGStX7ppU 손열음: 설명에 지휘자·악단이 없어 독주자만 둔다.
--
-- 연주자는 wikidata 식별자로 찾는다. 202608050059 가 먼저 적용돼야 한다.

INSERT INTO performance_credits (performance_source_id, artist_id, role_code, is_primary, display_order)
SELECT source.id, artist.id, incoming.role_code, 0, incoming.display_order
FROM (
    SELECT '2DmfJu3oNDM' AS video, 'Q116995' AS qid, 'conductor' AS role_code, 1 AS display_order
    UNION ALL SELECT '2DmfJu3oNDM', 'Q11352165', 'orchestra', 2
    UNION ALL SELECT 'Ybg2BEy_pu0', 'Q700791', 'conductor', 1
    UNION ALL SELECT 'Ybg2BEy_pu0', 'Q1053524', 'orchestra', 2
) incoming
JOIN performance_sources source ON source.provider_video_id = incoming.video
JOIN external_identifiers identifier
  ON identifier.namespace = 'wikidata' AND identifier.external_id = incoming.qid
JOIN artists artist ON artist.authority_entity_id = identifier.authority_entity_id
WHERE EXISTS (
    SELECT 1 FROM performances performance
    WHERE performance.performance_source_id = source.id AND performance.piece_id = 159
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT performance_source_id, artist_id, role_code FROM performance_credits) existing
    WHERE existing.performance_source_id = source.id
      AND existing.artist_id = artist.id
      AND existing.role_code = incoming.role_code
);
