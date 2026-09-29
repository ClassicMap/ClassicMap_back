-- 편곡 비교 배치 2(망각 · 부에노스 아이레스의 여름)에 필요한 인물·단체 넷을 등록한다.
--
--   줄리언 로이드 웨버        (Q319434)   첼로
--   존 윌리엄스              (Q370293)   기타
--   쿠아르테토 라티노아메리카노 (Q4254956)  현악 4중주
--   기돈 크레메르            (Q159915)   바이올린 — **artists 행만 넣는다**
--
-- 고티에 카푸송(277)은 이미 등록돼 있다.
--
-- **크레메르는 authority 엔티티는 있는데 artists 행이 없었다.**
-- 843c0da2-f997-575d-8a4a-dd14cdf788dd 에 식별자 여섯과 이름 여섯(en 넷 · ko 둘)이
-- 이미 붙어 있고 artists 행만 0개다. 새 엔티티를 만들면 같은 viaf·gnd·isni·
-- musicbrainz·lccn 이 두 엔티티에 붙어 external_identifiers 의 유니크 제약을 깬다.
-- 그래서 **기존 엔티티에 artists 행만 붙인다.**
--
-- 등록 전 확인 순서가 이래야 한다.
--   1. wikidata QID 로 artists 를 찾는다 → 있으면 그대로 쓴다
--   2. 없으면 external_identifiers 를 찾는다 → 엔티티가 있으면 artists 행만 넣는다
--   3. 둘 다 없으면 엔티티부터 만든다
-- 202608050217 에서 요요 마가 1번, 여기서 크레메르가 2번 자리다.
--
-- **"John Williams" 는 위키데이터 동명 항목이 넷이다.** 영화음악 작곡가 Q131285 가
-- 첫 결과인데 이 연주자는 **오스트레일리아 기타리스트 Q370293**(1941년생)이다.
-- 이름으로 골랐으면 작곡가 엔티티가 연주자로 붙었다. viaf 가 넷 있어 앞의 것만 넣었다.
--
-- 쿠아르테토 라티노아메리카노는 wikidata 에 한국어 라벨과 나라 진술이 없어 다른
-- 4중주단 표기에 맞춰 적고 멕시코로 두었다.
--
-- 202608050217 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '07efa601-a038-578c-8a4e-c6d62ff8c60e', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '07efa601-a038-578c-8a4e-c6d62ff8c60e');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '07efa601-a038-578c-8a4e-c6d62ff8c60e', 'en', 'canonical', 'Julian Lloyd Webber', 'julian lloyd webber', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '07efa601-a038-578c-8a4e-c6d62ff8c60e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '07efa601-a038-578c-8a4e-c6d62ff8c60e', 'ko', 'canonical', '줄리언 로이드 웨버', '줄리언 로이드 웨버', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '07efa601-a038-578c-8a4e-c6d62ff8c60e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '07efa601-a038-578c-8a4e-c6d62ff8c60e' AS a, 'gnd' AS n, '12382270X' AS v UNION ALL SELECT '07efa601-a038-578c-8a4e-c6d62ff8c60e' AS a, 'isni' AS n, '0000000083593227' AS v UNION ALL SELECT '07efa601-a038-578c-8a4e-c6d62ff8c60e' AS a, 'lccn' AS n, 'n81012220' AS v UNION ALL SELECT '07efa601-a038-578c-8a4e-c6d62ff8c60e' AS a, 'musicbrainz_artist' AS n, '72ed0310-4de1-49ff-a0ac-5ff4f47ab6cf' AS v UNION ALL SELECT '07efa601-a038-578c-8a4e-c6d62ff8c60e' AS a, 'viaf' AS n, '14958812' AS v UNION ALL SELECT '07efa601-a038-578c-8a4e-c6d62ff8c60e' AS a, 'wikidata' AS n, 'Q319434' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '줄리언 로이드 웨버', 'Julian Lloyd Webber', 'cellist', 'A', '1951', 'United Kingdom', '07efa601-a038-578c-8a4e-c6d62ff8c60e', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '07efa601-a038-578c-8a4e-c6d62ff8c60e');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'baff836c-8721-593e-af39-783fcda30192', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'baff836c-8721-593e-af39-783fcda30192');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'baff836c-8721-593e-af39-783fcda30192', 'en', 'canonical', 'John Williams', 'john williams', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'baff836c-8721-593e-af39-783fcda30192' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'baff836c-8721-593e-af39-783fcda30192', 'ko', 'canonical', '존 윌리엄스', '존 윌리엄스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'baff836c-8721-593e-af39-783fcda30192' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'baff836c-8721-593e-af39-783fcda30192' AS a, 'gnd' AS n, '133997316' AS v UNION ALL SELECT 'baff836c-8721-593e-af39-783fcda30192' AS a, 'isni' AS n, '0000000120298201' AS v UNION ALL SELECT 'baff836c-8721-593e-af39-783fcda30192' AS a, 'lccn' AS n, 'n82039534' AS v UNION ALL SELECT 'baff836c-8721-593e-af39-783fcda30192' AS a, 'musicbrainz_artist' AS n, '8b8a38a9-a290-4560-84f6-3d4466e8d791' AS v UNION ALL SELECT 'baff836c-8721-593e-af39-783fcda30192' AS a, 'viaf' AS n, '85440573' AS v UNION ALL SELECT 'baff836c-8721-593e-af39-783fcda30192' AS a, 'wikidata' AS n, 'Q370293' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '존 윌리엄스', 'John Williams', 'guitarist', 'A', '1941', 'Australia', 'baff836c-8721-593e-af39-783fcda30192', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'baff836c-8721-593e-af39-783fcda30192');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '10721429-9b86-517c-ab53-0794927a4b98', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '10721429-9b86-517c-ab53-0794927a4b98');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '10721429-9b86-517c-ab53-0794927a4b98', 'en', 'canonical', 'Cuarteto Latinoamericano', 'cuarteto latinoamericano', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '10721429-9b86-517c-ab53-0794927a4b98' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '10721429-9b86-517c-ab53-0794927a4b98', 'ko', 'canonical', '쿠아르테토 라티노아메리카노', '쿠아르테토 라티노아메리카노', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '10721429-9b86-517c-ab53-0794927a4b98' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '10721429-9b86-517c-ab53-0794927a4b98' AS a, 'gnd' AS n, '5522705-3' AS v UNION ALL SELECT '10721429-9b86-517c-ab53-0794927a4b98' AS a, 'isni' AS n, '0000000119573181' AS v UNION ALL SELECT '10721429-9b86-517c-ab53-0794927a4b98' AS a, 'lccn' AS n, 'nr92000221' AS v UNION ALL SELECT '10721429-9b86-517c-ab53-0794927a4b98' AS a, 'musicbrainz_artist' AS n, 'cb9f44f8-50de-4f8c-9322-7673557bcb31' AS v UNION ALL SELECT '10721429-9b86-517c-ab53-0794927a4b98' AS a, 'viaf' AS n, '145034603' AS v UNION ALL SELECT '10721429-9b86-517c-ab53-0794927a4b98' AS a, 'wikidata' AS n, 'Q4254956' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '쿠아르테토 라티노아메리카노', 'Cuarteto Latinoamericano', 'ensemble', 'A', '1981', 'Mexico', '10721429-9b86-517c-ab53-0794927a4b98', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '10721429-9b86-517c-ab53-0794927a4b98');



-- 크레메르: 기존 엔티티에 artists 행만 붙인다.
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '기돈 크레메르', 'Gidon Kremer', 'violinist', 'A', '1947', 'Latvia',
       '843c0da2-f997-575d-8a4a-dd14cdf788dd', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '843c0da2-f997-575d-8a4a-dd14cdf788dd'
);
