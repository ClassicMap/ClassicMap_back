-- S tier 대기열 C3 (협주곡 세 곡)에 필요한 지휘자 3명과 악단 2곳을 추가한다.
--   앙드레 프레빈, 베르트랑 드 비이, 데이비드 진먼
--   볼티모어 심포니 오케스트라, 빈 방송 교향악단
--
-- 202608050112 와 같은 방식이다. 복수 국적은 주된 활동지를 따라 하나만 적었다
-- (프레빈은 독일 출생이지만 미국에서 활동했고, 드 비이는 프랑스·스위스 중 프랑스,
-- 진먼은 미국·스위스 중 미국).

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '040e0978-d8b1-57ba-bc48-be07a2237ea5', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '040e0978-d8b1-57ba-bc48-be07a2237ea5');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '040e0978-d8b1-57ba-bc48-be07a2237ea5', 'en', 'canonical', 'André Previn', 'andré previn', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '040e0978-d8b1-57ba-bc48-be07a2237ea5' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '040e0978-d8b1-57ba-bc48-be07a2237ea5', 'ko', 'canonical', '앙드레 프레빈', '앙드레 프레빈', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '040e0978-d8b1-57ba-bc48-be07a2237ea5' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '040e0978-d8b1-57ba-bc48-be07a2237ea5' AS a, 'gnd' AS n, '122379322' AS v UNION ALL SELECT '040e0978-d8b1-57ba-bc48-be07a2237ea5' AS a, 'isni' AS n, '0000000110326977' AS v UNION ALL SELECT '040e0978-d8b1-57ba-bc48-be07a2237ea5' AS a, 'isni' AS n, '0000000368574070' AS v UNION ALL SELECT '040e0978-d8b1-57ba-bc48-be07a2237ea5' AS a, 'musicbrainz_artist' AS n, '06538137-47eb-4dd6-bb78-5c8afa1a1885' AS v UNION ALL SELECT '040e0978-d8b1-57ba-bc48-be07a2237ea5' AS a, 'viaf' AS n, '110759893' AS v UNION ALL SELECT '040e0978-d8b1-57ba-bc48-be07a2237ea5' AS a, 'wikidata' AS n, 'Q155712' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '앙드레 프레빈', 'André Previn', 'conductor', 'S', '1929', 'United States', '040e0978-d8b1-57ba-bc48-be07a2237ea5', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '040e0978-d8b1-57ba-bc48-be07a2237ea5');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0cd9ab54-4e09-5320-a0fe-b13ad6476428', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0cd9ab54-4e09-5320-a0fe-b13ad6476428');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0cd9ab54-4e09-5320-a0fe-b13ad6476428', 'en', 'canonical', 'Bertrand de Billy', 'bertrand de billy', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0cd9ab54-4e09-5320-a0fe-b13ad6476428' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0cd9ab54-4e09-5320-a0fe-b13ad6476428', 'ko', 'canonical', '베르트랑 드 비이', '베르트랑 드 비이', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0cd9ab54-4e09-5320-a0fe-b13ad6476428' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0cd9ab54-4e09-5320-a0fe-b13ad6476428' AS a, 'gnd' AS n, '135224578' AS v UNION ALL SELECT '0cd9ab54-4e09-5320-a0fe-b13ad6476428' AS a, 'isni' AS n, '0000000108785947' AS v UNION ALL SELECT '0cd9ab54-4e09-5320-a0fe-b13ad6476428' AS a, 'musicbrainz_artist' AS n, 'e6b40b76-dd7e-4988-bbb0-1fe1b0716443' AS v UNION ALL SELECT '0cd9ab54-4e09-5320-a0fe-b13ad6476428' AS a, 'viaf' AS n, '22350707' AS v UNION ALL SELECT '0cd9ab54-4e09-5320-a0fe-b13ad6476428' AS a, 'wikidata' AS n, 'Q697105' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '베르트랑 드 비이', 'Bertrand de Billy', 'conductor', 'A', '1965', 'France', '0cd9ab54-4e09-5320-a0fe-b13ad6476428', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0cd9ab54-4e09-5320-a0fe-b13ad6476428');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc', 'en', 'canonical', 'David Zinman', 'david zinman', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc', 'ko', 'canonical', '데이비드 진먼', '데이비드 진먼', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc' AS a, 'gnd' AS n, '124002218' AS v UNION ALL SELECT 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc' AS a, 'isni' AS n, '0000000114507679' AS v UNION ALL SELECT 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc' AS a, 'musicbrainz_artist' AS n, '1cb86cd3-3e28-403e-9197-9ce0cdaffbd9' AS v UNION ALL SELECT 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc' AS a, 'viaf' AS n, '85822165' AS v UNION ALL SELECT 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc' AS a, 'wikidata' AS n, 'Q115696' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '데이비드 진먼', 'David Zinman', 'conductor', 'A', '1936', 'United States', 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd0f50cb1-cf1d-5c9a-989a-e5050c2ec5cc');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '3181e20e-8560-56bf-9788-799e35f50fc4', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '3181e20e-8560-56bf-9788-799e35f50fc4');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3181e20e-8560-56bf-9788-799e35f50fc4', 'en', 'canonical', 'Baltimore Symphony Orchestra', 'baltimore symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3181e20e-8560-56bf-9788-799e35f50fc4' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3181e20e-8560-56bf-9788-799e35f50fc4', 'ko', 'canonical', '볼티모어 심포니 오케스트라', '볼티모어 심포니 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3181e20e-8560-56bf-9788-799e35f50fc4' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '3181e20e-8560-56bf-9788-799e35f50fc4' AS a, 'gnd' AS n, '5234901-9' AS v UNION ALL SELECT '3181e20e-8560-56bf-9788-799e35f50fc4' AS a, 'isni' AS n, '0000000097553701' AS v UNION ALL SELECT '3181e20e-8560-56bf-9788-799e35f50fc4' AS a, 'musicbrainz_artist' AS n, 'dbf991f7-8689-4c44-82f5-1adf488d3c2c' AS v UNION ALL SELECT '3181e20e-8560-56bf-9788-799e35f50fc4' AS a, 'viaf' AS n, '144389490' AS v UNION ALL SELECT '3181e20e-8560-56bf-9788-799e35f50fc4' AS a, 'wikidata' AS n, 'Q131874' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '볼티모어 심포니 오케스트라', 'Baltimore Symphony Orchestra', 'orchestra', 'A', '1916', 'United States', '3181e20e-8560-56bf-9788-799e35f50fc4', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '3181e20e-8560-56bf-9788-799e35f50fc4');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a', 'en', 'canonical', 'Vienna Radio Symphony Orchestra', 'vienna radio symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a', 'ko', 'canonical', '빈 방송 교향악단', '빈 방송 교향악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a' AS a, 'gnd' AS n, '5520304-8' AS v UNION ALL SELECT '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a' AS a, 'isni' AS n, '0000000106750345' AS v UNION ALL SELECT '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a' AS a, 'musicbrainz_artist' AS n, '26f87ee2-8d3c-4cd0-8c95-ccae3c980aa1' AS v UNION ALL SELECT '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a' AS a, 'viaf' AS n, '137337418' AS v UNION ALL SELECT '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a' AS a, 'viaf' AS n, '149425550' AS v UNION ALL SELECT '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a' AS a, 'wikidata' AS n, 'Q695491' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '빈 방송 교향악단', 'Vienna Radio Symphony Orchestra', 'orchestra', 'A', '1945', 'Austria', '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '9f73f6e3-d9f4-5830-bdb4-bbda9cb0972a');

