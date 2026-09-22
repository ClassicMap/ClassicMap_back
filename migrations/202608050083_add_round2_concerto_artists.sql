-- 2라운드 발췌 배치(협주곡)에 필요한 지휘자 2명과 악단 1곳을 추가한다.
--   차이콥스키 바이올린 협주곡(piece 160) 얀센 연주: 다니엘 하딩
--   모차르트 피아노 협주곡 20번(piece 72) 리시에츠키 연주: 크리스티안 차하리아스
--   같은 곡 조성진 연주: 유럽 체임버 오케스트라
--
-- 202608050070 과 같은 방식이다. 한국어 라벨이 없는 곳은 음역했다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'ff2ee837-a92c-5db9-aecf-77b1601c54c0', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'ff2ee837-a92c-5db9-aecf-77b1601c54c0');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ff2ee837-a92c-5db9-aecf-77b1601c54c0', 'en', 'canonical', 'Daniel Harding', 'daniel harding', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ff2ee837-a92c-5db9-aecf-77b1601c54c0' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'ff2ee837-a92c-5db9-aecf-77b1601c54c0', 'ko', 'canonical', '다니엘 하딩', '다니엘 하딩', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'ff2ee837-a92c-5db9-aecf-77b1601c54c0' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'ff2ee837-a92c-5db9-aecf-77b1601c54c0' AS a, 'gnd' AS n, '124509916' AS v UNION ALL SELECT 'ff2ee837-a92c-5db9-aecf-77b1601c54c0' AS a, 'isni' AS n, '0000000081853590' AS v UNION ALL SELECT 'ff2ee837-a92c-5db9-aecf-77b1601c54c0' AS a, 'musicbrainz_artist' AS n, '50e23cf8-d4ec-4a3b-ac9e-6a182cc69f2b' AS v UNION ALL SELECT 'ff2ee837-a92c-5db9-aecf-77b1601c54c0' AS a, 'viaf' AS n, '116515215' AS v UNION ALL SELECT 'ff2ee837-a92c-5db9-aecf-77b1601c54c0' AS a, 'wikidata' AS n, 'Q524328' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '다니엘 하딩', 'Daniel Harding', 'conductor', 'A', '1975', 'United Kingdom', 'ff2ee837-a92c-5db9-aecf-77b1601c54c0', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'ff2ee837-a92c-5db9-aecf-77b1601c54c0');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '8f74d049-979b-55c8-a1a7-0aee1c88dd15', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '8f74d049-979b-55c8-a1a7-0aee1c88dd15');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8f74d049-979b-55c8-a1a7-0aee1c88dd15', 'en', 'canonical', 'Christian Zacharias', 'christian zacharias', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8f74d049-979b-55c8-a1a7-0aee1c88dd15' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8f74d049-979b-55c8-a1a7-0aee1c88dd15', 'ko', 'canonical', '크리스티안 차하리아스', '크리스티안 차하리아스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8f74d049-979b-55c8-a1a7-0aee1c88dd15' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '8f74d049-979b-55c8-a1a7-0aee1c88dd15' AS a, 'gnd' AS n, '121280071' AS v UNION ALL SELECT '8f74d049-979b-55c8-a1a7-0aee1c88dd15' AS a, 'isni' AS n, '0000000108675107' AS v UNION ALL SELECT '8f74d049-979b-55c8-a1a7-0aee1c88dd15' AS a, 'musicbrainz_artist' AS n, '0c0920e8-c64c-4329-b3be-f58bd0cf7c6b' AS v UNION ALL SELECT '8f74d049-979b-55c8-a1a7-0aee1c88dd15' AS a, 'viaf' AS n, '7575864' AS v UNION ALL SELECT '8f74d049-979b-55c8-a1a7-0aee1c88dd15' AS a, 'wikidata' AS n, 'Q62739' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '크리스티안 차하리아스', 'Christian Zacharias', 'conductor', 'B', '1950', 'Germany', '8f74d049-979b-55c8-a1a7-0aee1c88dd15', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '8f74d049-979b-55c8-a1a7-0aee1c88dd15');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '644a09cb-e918-59c9-acf8-aad4aabbf459', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '644a09cb-e918-59c9-acf8-aad4aabbf459');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '644a09cb-e918-59c9-acf8-aad4aabbf459', 'en', 'canonical', 'Chamber Orchestra of Europe', 'chamber orchestra of europe', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '644a09cb-e918-59c9-acf8-aad4aabbf459' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '644a09cb-e918-59c9-acf8-aad4aabbf459', 'ko', 'canonical', '유럽 체임버 오케스트라', '유럽 체임버 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '644a09cb-e918-59c9-acf8-aad4aabbf459' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '644a09cb-e918-59c9-acf8-aad4aabbf459' AS a, 'gnd' AS n, '809942-X' AS v UNION ALL SELECT '644a09cb-e918-59c9-acf8-aad4aabbf459' AS a, 'isni' AS n, '0000000110177393' AS v UNION ALL SELECT '644a09cb-e918-59c9-acf8-aad4aabbf459' AS a, 'musicbrainz_artist' AS n, '3f221c60-2568-40f5-b1c3-625fed319258' AS v UNION ALL SELECT '644a09cb-e918-59c9-acf8-aad4aabbf459' AS a, 'viaf' AS n, '152604200' AS v UNION ALL SELECT '644a09cb-e918-59c9-acf8-aad4aabbf459' AS a, 'viaf' AS n, '154627747' AS v UNION ALL SELECT '644a09cb-e918-59c9-acf8-aad4aabbf459' AS a, 'wikidata' AS n, 'Q661670' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '유럽 체임버 오케스트라', 'Chamber Orchestra of Europe', 'orchestra', 'A', '1981', 'United Kingdom', '644a09cb-e918-59c9-acf8-aad4aabbf459', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '644a09cb-e918-59c9-acf8-aad4aabbf459');

