-- 차이콥스키 피아노 협주곡 1번(piece 159) 크레딧을 채우는 데 필요한 지휘자 2명과 악단 1곳을 추가한다.
--
-- 202608050056 과 같은 방식이다. authority_entities.id 는 강한 식별자를 정렬해 이은
-- 문자열의 uuid5 다.
--
-- 이 곡은 협주곡 크레딧 규칙(독주자 → 지휘자 → 악단)이 생기기 전에 발행돼 독주자만 있었다.
-- 지휘자·악단은 영상 설명에 적힌 것만 근거로 삼았다. 곡 상식이나 기억으로 채우지 않았다.
--
-- 한국어 이름: 샤를 뒤투아·파보 예르비는 Wikidata 라벨을 따랐다. 베르비에 페스티벌
-- 오케스트라는 한국어 라벨이 없어 음역했다. 예르비의 Wikidata 국적은 출생 당시의
-- 소련이지만 에스토니아로 적었다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d', 'en', 'canonical', 'Charles Dutoit', 'charles dutoit', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d', 'ko', 'canonical', '샤를 뒤투아', '샤를 뒤투아', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d' AS a, 'gnd' AS n, '130456314' AS v UNION ALL SELECT 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d' AS a, 'isni' AS n, '0000000122824543' AS v UNION ALL SELECT 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d' AS a, 'musicbrainz_artist' AS n, '64a7dc4d-79b0-4033-9b9a-6c64671de8b7' AS v UNION ALL SELECT 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d' AS a, 'viaf' AS n, '84241553' AS v UNION ALL SELECT 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d' AS a, 'wikidata' AS n, 'Q116995' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '샤를 뒤투아', 'Charles Dutoit', 'conductor', 'A', '1936', 'Switzerland', 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'db551d0d-d8ad-57b3-8d6a-f7835c831b1d');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b6942e7f-9961-5829-8a0e-d3bafb027bd2', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b6942e7f-9961-5829-8a0e-d3bafb027bd2');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b6942e7f-9961-5829-8a0e-d3bafb027bd2', 'en', 'canonical', 'Verbier Festival Orchestra', 'verbier festival orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b6942e7f-9961-5829-8a0e-d3bafb027bd2' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b6942e7f-9961-5829-8a0e-d3bafb027bd2', 'ko', 'canonical', '베르비에 페스티벌 오케스트라', '베르비에 페스티벌 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b6942e7f-9961-5829-8a0e-d3bafb027bd2' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b6942e7f-9961-5829-8a0e-d3bafb027bd2' AS a, 'gnd' AS n, '1172898391' AS v UNION ALL SELECT 'b6942e7f-9961-5829-8a0e-d3bafb027bd2' AS a, 'isni' AS n, '000000011019445X' AS v UNION ALL SELECT 'b6942e7f-9961-5829-8a0e-d3bafb027bd2' AS a, 'musicbrainz_artist' AS n, '4c2392ca-fdcf-4bdd-b6a5-868da669f0ad' AS v UNION ALL SELECT 'b6942e7f-9961-5829-8a0e-d3bafb027bd2' AS a, 'viaf' AS n, '160416945' AS v UNION ALL SELECT 'b6942e7f-9961-5829-8a0e-d3bafb027bd2' AS a, 'wikidata' AS n, 'Q11352165' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '베르비에 페스티벌 오케스트라', 'Verbier Festival Orchestra', 'orchestra', 'B', NULL, 'Switzerland', 'b6942e7f-9961-5829-8a0e-d3bafb027bd2', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b6942e7f-9961-5829-8a0e-d3bafb027bd2');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb', 'en', 'canonical', 'Paavo Järvi', 'paavo järvi', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb', 'ko', 'canonical', '파보 예르비', '파보 예르비', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb' AS a, 'gnd' AS n, '124299989' AS v UNION ALL SELECT '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb' AS a, 'isni' AS n, '0000000083744611' AS v UNION ALL SELECT '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb' AS a, 'musicbrainz_artist' AS n, 'a1830e61-221e-4770-be88-07b63724dd80' AS v UNION ALL SELECT '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb' AS a, 'viaf' AS n, '39562179' AS v UNION ALL SELECT '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb' AS a, 'wikidata' AS n, 'Q700791' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '파보 예르비', 'Paavo Järvi', 'conductor', 'A', '1962', 'Estonia', '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0c03b360-ba79-50ae-99e9-cc9fa2cb61fb');
