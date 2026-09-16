-- 비교 영상 시드에 필요한 피아니스트 1명(백건우)을 추가한다.
--
-- 202608050036 과 같은 방식이다.
--
-- 슈만 <어린이의 정경> 중 "트로이메라이"의 세 번째 연주로 쓴다.
-- 나머지 둘은 랑랑과 호로비츠다.
--
-- 한국어 이름은 Wikidata 라벨(백건우)이 국내 표기와 같아 그대로 썼다.
INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0024ff73-e965-57df-bc97-1273df6dc5ee', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT id FROM authority_entities) existing
    WHERE existing.id = '0024ff73-e965-57df-bc97-1273df6dc5ee'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0024ff73-e965-57df-bc97-1273df6dc5ee', 'en', 'canonical',
       'Kun-Woo Paik', 'kun-woo paik', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0024ff73-e965-57df-bc97-1273df6dc5ee'
      AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0024ff73-e965-57df-bc97-1273df6dc5ee', 'ko', 'canonical',
       '백건우', '백건우', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0024ff73-e965-57df-bc97-1273df6dc5ee'
      AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (
    SELECT '0024ff73-e965-57df-bc97-1273df6dc5ee' AS a, 'gnd' AS n, '123624053' AS v
    UNION ALL SELECT '0024ff73-e965-57df-bc97-1273df6dc5ee', 'isni', '0000000120195384'
    UNION ALL SELECT '0024ff73-e965-57df-bc97-1273df6dc5ee', 'musicbrainz_artist',
        '432bfbee-70ff-4558-b8e0-96a29d90755f'
    UNION ALL SELECT '0024ff73-e965-57df-bc97-1273df6dc5ee', 'viaf', '201910'
    UNION ALL SELECT '0024ff73-e965-57df-bc97-1273df6dc5ee', 'wikidata', 'Q483798'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a
      AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '백건우', 'Kun-Woo Paik', 'pianist', 'S', '1946', 'South Korea',
       '0024ff73-e965-57df-bc97-1273df6dc5ee', 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing
    WHERE existing.authority_entity_id = '0024ff73-e965-57df-bc97-1273df6dc5ee'
);
