-- S tier 대기열 C1 (피아노 협주곡 세 곡)에 필요한 지휘자 4명을 추가한다.
--   리스트 1번 오트 연주: 토마스 헹엘브로크
--   쇼팽 1번 조성진 연주: 잔안드레아 노세다
--   쇼팽 1번 쓰지이 연주: 제임스 콘론
--   슈만 키신 연주: 콜린 데이비스
--
-- 202608050070 과 같은 방식이다. 동명이인을 확인했다(제임스 콘론은 연구자 Q102177219 이
-- 아니고, 콜린 데이비스는 레이서 Q172819 가 아니다). 한국어 라벨이 없는 곳은 음역했다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e3f321ea-8e2c-5110-923c-1bca0286ed17', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e3f321ea-8e2c-5110-923c-1bca0286ed17');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e3f321ea-8e2c-5110-923c-1bca0286ed17', 'en', 'canonical', 'Thomas Hengelbrock', 'thomas hengelbrock', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e3f321ea-8e2c-5110-923c-1bca0286ed17' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e3f321ea-8e2c-5110-923c-1bca0286ed17', 'ko', 'canonical', '토마스 헹엘브로크', '토마스 헹엘브로크', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e3f321ea-8e2c-5110-923c-1bca0286ed17' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e3f321ea-8e2c-5110-923c-1bca0286ed17' AS a, 'gnd' AS n, '134730194' AS v UNION ALL SELECT 'e3f321ea-8e2c-5110-923c-1bca0286ed17' AS a, 'isni' AS n, '0000000108754198' AS v UNION ALL SELECT 'e3f321ea-8e2c-5110-923c-1bca0286ed17' AS a, 'musicbrainz_artist' AS n, '5a566302-d6ff-4daf-87f7-6615cde91b42' AS v UNION ALL SELECT 'e3f321ea-8e2c-5110-923c-1bca0286ed17' AS a, 'viaf' AS n, '17414795' AS v UNION ALL SELECT 'e3f321ea-8e2c-5110-923c-1bca0286ed17' AS a, 'wikidata' AS n, 'Q87912' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '토마스 헹엘브로크', 'Thomas Hengelbrock', 'conductor', 'B', '1958', 'Germany', 'e3f321ea-8e2c-5110-923c-1bca0286ed17', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e3f321ea-8e2c-5110-923c-1bca0286ed17');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '64361bc9-8de0-5e25-bea2-5da6755127cb', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '64361bc9-8de0-5e25-bea2-5da6755127cb');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '64361bc9-8de0-5e25-bea2-5da6755127cb', 'en', 'canonical', 'Gianandrea Noseda', 'gianandrea noseda', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '64361bc9-8de0-5e25-bea2-5da6755127cb' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '64361bc9-8de0-5e25-bea2-5da6755127cb', 'ko', 'canonical', '잔안드레아 노세다', '잔안드레아 노세다', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '64361bc9-8de0-5e25-bea2-5da6755127cb' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '64361bc9-8de0-5e25-bea2-5da6755127cb' AS a, 'gnd' AS n, '124295398' AS v UNION ALL SELECT '64361bc9-8de0-5e25-bea2-5da6755127cb' AS a, 'isni' AS n, '0000000120266760' AS v UNION ALL SELECT '64361bc9-8de0-5e25-bea2-5da6755127cb' AS a, 'musicbrainz_artist' AS n, '7bf70168-f9e0-4adc-a04f-de84b1cf1c8a' AS v UNION ALL SELECT '64361bc9-8de0-5e25-bea2-5da6755127cb' AS a, 'viaf' AS n, '59278139' AS v UNION ALL SELECT '64361bc9-8de0-5e25-bea2-5da6755127cb' AS a, 'wikidata' AS n, 'Q2631069' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '잔안드레아 노세다', 'Gianandrea Noseda', 'conductor', 'A', '1964', 'Italy', '64361bc9-8de0-5e25-bea2-5da6755127cb', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '64361bc9-8de0-5e25-bea2-5da6755127cb');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a75432cb-acd2-509b-9aff-075272dc98d9', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a75432cb-acd2-509b-9aff-075272dc98d9');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a75432cb-acd2-509b-9aff-075272dc98d9', 'en', 'canonical', 'James Conlon', 'james conlon', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a75432cb-acd2-509b-9aff-075272dc98d9' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a75432cb-acd2-509b-9aff-075272dc98d9', 'ko', 'canonical', '제임스 콘론', '제임스 콘론', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a75432cb-acd2-509b-9aff-075272dc98d9' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a75432cb-acd2-509b-9aff-075272dc98d9' AS a, 'gnd' AS n, '12422394X' AS v UNION ALL SELECT 'a75432cb-acd2-509b-9aff-075272dc98d9' AS a, 'isni' AS n, '0000000117770413' AS v UNION ALL SELECT 'a75432cb-acd2-509b-9aff-075272dc98d9' AS a, 'musicbrainz_artist' AS n, '0a4a9585-c3c7-4231-a19a-465041b7d99f' AS v UNION ALL SELECT 'a75432cb-acd2-509b-9aff-075272dc98d9' AS a, 'viaf' AS n, '98521729' AS v UNION ALL SELECT 'a75432cb-acd2-509b-9aff-075272dc98d9' AS a, 'wikidata' AS n, 'Q1348801' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '제임스 콘론', 'James Conlon', 'conductor', 'B', '1950', 'United States', 'a75432cb-acd2-509b-9aff-075272dc98d9', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a75432cb-acd2-509b-9aff-075272dc98d9');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1d606c37-1f2c-545e-8b42-1eee7c07fd4d', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1d606c37-1f2c-545e-8b42-1eee7c07fd4d');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1d606c37-1f2c-545e-8b42-1eee7c07fd4d', 'en', 'canonical', 'Colin Davis', 'colin davis', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1d606c37-1f2c-545e-8b42-1eee7c07fd4d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1d606c37-1f2c-545e-8b42-1eee7c07fd4d', 'ko', 'canonical', '콜린 데이비스', '콜린 데이비스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1d606c37-1f2c-545e-8b42-1eee7c07fd4d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1d606c37-1f2c-545e-8b42-1eee7c07fd4d' AS a, 'gnd' AS n, '118671170' AS v UNION ALL SELECT '1d606c37-1f2c-545e-8b42-1eee7c07fd4d' AS a, 'isni' AS n, '0000000108694084' AS v UNION ALL SELECT '1d606c37-1f2c-545e-8b42-1eee7c07fd4d' AS a, 'musicbrainz_artist' AS n, '68ee0381-c3a6-4b41-ad68-9de513e8e97f' AS v UNION ALL SELECT '1d606c37-1f2c-545e-8b42-1eee7c07fd4d' AS a, 'viaf' AS n, '10032941' AS v UNION ALL SELECT '1d606c37-1f2c-545e-8b42-1eee7c07fd4d' AS a, 'wikidata' AS n, 'Q366624' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '콜린 데이비스', 'Colin Davis', 'conductor', 'A', '1927', 'United Kingdom', '1d606c37-1f2c-545e-8b42-1eee7c07fd4d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1d606c37-1f2c-545e-8b42-1eee7c07fd4d');

