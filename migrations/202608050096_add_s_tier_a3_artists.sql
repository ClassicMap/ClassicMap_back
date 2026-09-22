-- S tier 대기열 A3 (랩소디 인 블루)에 필요한 악단 1곳과 지휘자 1명을 추가한다.
--   번스타인 연주의 반주 악단: 컬럼비아 심포니 오케스트라
--   오라일리 연주의 지휘자: 배리 워즈워스
--
-- 202608050070 과 같은 방식이다. 컬럼비아 심포니 오케스트라는 Wikidata 에 설립 연도가
-- 없어 컬럼비아 레코드가 세션 악단으로 쓰기 시작한 1954 년을 적었다. 한국어 라벨이
-- 없는 곳은 음역했다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '4b72cb78-6f9d-5a07-ab09-492d48c30464', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '4b72cb78-6f9d-5a07-ab09-492d48c30464');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4b72cb78-6f9d-5a07-ab09-492d48c30464', 'en', 'canonical', 'Columbia Symphony Orchestra', 'columbia symphony orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4b72cb78-6f9d-5a07-ab09-492d48c30464' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '4b72cb78-6f9d-5a07-ab09-492d48c30464', 'ko', 'canonical', '컬럼비아 심포니 오케스트라', '컬럼비아 심포니 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '4b72cb78-6f9d-5a07-ab09-492d48c30464' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '4b72cb78-6f9d-5a07-ab09-492d48c30464' AS a, 'gnd' AS n, '1212485-0' AS v UNION ALL SELECT '4b72cb78-6f9d-5a07-ab09-492d48c30464' AS a, 'isni' AS n, '0000000110132056' AS v UNION ALL SELECT '4b72cb78-6f9d-5a07-ab09-492d48c30464' AS a, 'musicbrainz_artist' AS n, '4443207a-5293-44bc-9af0-1fdcca83fee4' AS v UNION ALL SELECT '4b72cb78-6f9d-5a07-ab09-492d48c30464' AS a, 'viaf' AS n, '140849578' AS v UNION ALL SELECT '4b72cb78-6f9d-5a07-ab09-492d48c30464' AS a, 'wikidata' AS n, 'Q1112596' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '컬럼비아 심포니 오케스트라', 'Columbia Symphony Orchestra', 'orchestra', 'B', '1954', 'United States', '4b72cb78-6f9d-5a07-ab09-492d48c30464', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '4b72cb78-6f9d-5a07-ab09-492d48c30464');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ddde96fd-185e-5273-a6d7-71351179af33', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ddde96fd-185e-5273-a6d7-71351179af33');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ddde96fd-185e-5273-a6d7-71351179af33', 'en', 'canonical', 'Barry Wordsworth', 'barry wordsworth', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ddde96fd-185e-5273-a6d7-71351179af33' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ddde96fd-185e-5273-a6d7-71351179af33', 'ko', 'canonical', '배리 워즈워스', '배리 워즈워스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ddde96fd-185e-5273-a6d7-71351179af33' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ddde96fd-185e-5273-a6d7-71351179af33' AS a, 'gnd' AS n, '124355420' AS v UNION ALL SELECT 'ddde96fd-185e-5273-a6d7-71351179af33' AS a, 'isni' AS n, '0000000109028462' AS v UNION ALL SELECT 'ddde96fd-185e-5273-a6d7-71351179af33' AS a, 'musicbrainz_artist' AS n, '92cd8453-66d0-49ec-95c5-539faaa6fa88' AS v UNION ALL SELECT 'ddde96fd-185e-5273-a6d7-71351179af33' AS a, 'viaf' AS n, '54336052' AS v UNION ALL SELECT 'ddde96fd-185e-5273-a6d7-71351179af33' AS a, 'wikidata' AS n, 'Q809113' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '배리 워즈워스', 'Barry Wordsworth', 'conductor', 'B', '1948', 'United Kingdom', 'ddde96fd-185e-5273-a6d7-71351179af33', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ddde96fd-185e-5273-a6d7-71351179af33');

