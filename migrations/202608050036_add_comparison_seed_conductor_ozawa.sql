-- 비교 영상 시드에 필요한 지휘자 1명(오자와 세이지)을 추가한다.
--
-- 202608050035 와 같은 방식이다.
--
-- 박쥐 서곡의 세 번째 연주로 처음에는 주빈 메타(202608050035)를 넣으려 했으나
-- 교차 정렬에서 다른 두 연주와 0.096~0.105 로 어긋났다. 구간을 셋으로 나눠 보니
-- 뒤 1/3 에서만 나빴고, 끝점을 ±10초 훑어도 비용이 0.104 근처에서 평평했다.
-- 경계 문제가 아니라 연주 자체가 다른 것으로 보고 교체했다.
-- 메타는 유효한 지휘자이므로 202608050035 는 되돌리지 않고 남겨 둔다.
--
-- 한국어 이름은 Wikidata 라벨(오자와 세이지)이 국내 표기와 같아 그대로 썼다.
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '81b49a8b-8aab-55ae-af2c-e98ad6846d37', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing
    WHERE existing.id = '81b49a8b-8aab-55ae-af2c-e98ad6846d37'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '81b49a8b-8aab-55ae-af2c-e98ad6846d37', 'en', 'canonical',
       'Seiji Ozawa', 'seiji ozawa', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '81b49a8b-8aab-55ae-af2c-e98ad6846d37'
      AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '81b49a8b-8aab-55ae-af2c-e98ad6846d37', 'ko', 'canonical',
       '오자와 세이지', '오자와 세이지', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '81b49a8b-8aab-55ae-af2c-e98ad6846d37'
      AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '81b49a8b-8aab-55ae-af2c-e98ad6846d37' AS a, 'gnd' AS n, '121084507' AS v
    UNION ALL SELECT '81b49a8b-8aab-55ae-af2c-e98ad6846d37', 'isni', '0000000110823228'
    UNION ALL SELECT '81b49a8b-8aab-55ae-af2c-e98ad6846d37', 'musicbrainz_artist',
        '98c3e4e1-2f01-4ead-911f-8d4b95a6c461'
    UNION ALL SELECT '81b49a8b-8aab-55ae-af2c-e98ad6846d37', 'viaf', '109893732'
    UNION ALL SELECT '81b49a8b-8aab-55ae-af2c-e98ad6846d37', 'wikidata', 'Q313649'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '오자와 세이지', 'Seiji Ozawa', 'conductor', 'S', '1935', 'Japan',
       '81b49a8b-8aab-55ae-af2c-e98ad6846d37', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '81b49a8b-8aab-55ae-af2c-e98ad6846d37'
);
