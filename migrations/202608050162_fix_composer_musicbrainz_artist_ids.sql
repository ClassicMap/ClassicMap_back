-- 작곡가 네 명에게 잘못 붙은 musicbrainz_artist 식별자를 뗀다.
--
-- A tier 적재를 준비하며 작곡가 arid 로 작품 목록을 받다가 J.C. 바흐만 0곡이
-- 나와서 드러났다. 한 엔티티에 musicbrainz_artist 가 둘씩 붙어 있었고,
-- 조회가 LIMIT 1 이라 그때그때 다른 쪽을 집고 있었다. 전체를 훑으니 네 명이다.
--
-- | 작곡가 | 남기는 것 | 떼는 것 | 뗀 이유 |
-- |---|---|---|---|
-- | J.C. 바흐 | 470967b1 (526곡) | 07a5e339 (0곡) | "Bach and Abel". 1765~1781 년 연주회 시리즈 단체이지 사람이 아니다 |
-- | 구노 | cd4636e1 (638곡) | ce348f4e (0곡) | "Charles Guonod". MusicBrainz 쪽 오타 중복 등록이다 |
-- | 보로딘 | 560b5e65 (171곡) | 2c3524b4 (0곡) | "Alexandre Borodine". 프랑스어 표기 중복이고 작품이 하나도 안 붙어 있다 |
-- | 시벨리우스 | 691b0e9d (1616곡) | 8e2b8876 | 8e2b8876 을 조회하면 응답의 id 가 691b0e9d 로 온다. 합쳐진 뒤 남은 넘겨주기 주소다 |
--
-- 작품 수는 ws/2/work?artist=<arid> 의 work-count 로 셌다.
-- 남기는 쪽은 건드리지 않는다. 떼는 네 줄만 지운다.

DELETE identifier
FROM external_identifiers identifier
JOIN (
    SELECT '07a5e339-7d87-44ce-8475-082f37384e9b' AS wrong_id
    UNION ALL SELECT 'ce348f4e-fa46-488f-b9f2-60c19c871c81'
    UNION ALL SELECT '2c3524b4-c4ba-4431-8d54-c134560a7fa9'
    UNION ALL SELECT '8e2b8876-2d38-4475-a5b8-593c914cb1fe'
) wrong ON wrong.wrong_id = identifier.external_id
WHERE identifier.namespace = 'musicbrainz_artist'
  AND EXISTS (
      SELECT 1
      FROM (SELECT authority_entity_id FROM composers) composer
      WHERE composer.authority_entity_id = identifier.authority_entity_id
  );
