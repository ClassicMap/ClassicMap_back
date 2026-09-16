-- 비교 영상 시드에 필요한 피아니스트 1명(장이브 티보데)을 추가한다.
--
-- 202608050026 과 같은 방식이다. 적재기는 연주자를 external_identifiers.wikidata
-- 로만 해소하므로 적재 전에 넣어야 한다.
--
-- authority_entities.id 는 파이프라인과 같은 규칙으로 계산했다.
--   uuid5(NAMESPACE_URL, 'classicmap-entity:' || sorted(strong 식별자 'ns:value') join '|')
--
-- 라벨 "죽은 왕녀를 위한 파반느"의 세 번째 연주로 쓴다. 이 곡은 피아노 원곡과
-- 관현악 편곡이 모두 유명해서 판본이 섞이기 쉬운데, 세 연주 모두 피아노 원곡이다.
--
-- 한국어 이름은 Wikidata 에 라벨이 없어 국내 표기 관행을 따랐다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '2d8c07a9-0598-5ec9-903f-0be13d676787', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing
    WHERE existing.id = '2d8c07a9-0598-5ec9-903f-0be13d676787'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2d8c07a9-0598-5ec9-903f-0be13d676787', 'en', 'canonical',
       'Jean-Yves Thibaudet', 'jean-yves thibaudet', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2d8c07a9-0598-5ec9-903f-0be13d676787'
      AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2d8c07a9-0598-5ec9-903f-0be13d676787', 'ko', 'canonical',
       '장이브 티보데', '장이브 티보데', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2d8c07a9-0598-5ec9-903f-0be13d676787'
      AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '2d8c07a9-0598-5ec9-903f-0be13d676787' AS a, 'gnd' AS n, '124658849' AS v
    UNION ALL SELECT '2d8c07a9-0598-5ec9-903f-0be13d676787', 'isni', '000000010970204X'
    UNION ALL SELECT '2d8c07a9-0598-5ec9-903f-0be13d676787', 'musicbrainz_artist',
        '519e9293-89ad-4413-af85-f00d4816bd46'
    UNION ALL SELECT '2d8c07a9-0598-5ec9-903f-0be13d676787', 'viaf', '50166618'
    UNION ALL SELECT '2d8c07a9-0598-5ec9-903f-0be13d676787', 'wikidata', 'Q1030549'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '장이브 티보데', 'Jean-Yves Thibaudet', 'pianist', 'A', '1961', 'France',
       '2d8c07a9-0598-5ec9-903f-0be13d676787', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '2d8c07a9-0598-5ec9-903f-0be13d676787'
);
