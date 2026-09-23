-- S tier 대기열 D1 (베토벤 "봄" 소나타)에 필요한 피아니스트 1명을 추가한다.
--   램버트 오키스 — 안네 소피 무터의 오랜 듀오 상대다.
--
-- 202608050112 와 같은 방식이다. 바이올린 소나타의 피아노는 반주가 아니라 대등한
-- 짝이므로 분류를 pianist 로 두고, 크레딧 역할도 ACCOMPANIST 가 아니라 PIANIST 다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'e9014e61-1367-5261-8309-6222a552ceb9', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'e9014e61-1367-5261-8309-6222a552ceb9');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e9014e61-1367-5261-8309-6222a552ceb9', 'en', 'canonical', 'Lambert Orkis', 'lambert orkis', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e9014e61-1367-5261-8309-6222a552ceb9' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'e9014e61-1367-5261-8309-6222a552ceb9', 'ko', 'canonical', '램버트 오키스', '램버트 오키스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'e9014e61-1367-5261-8309-6222a552ceb9' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'e9014e61-1367-5261-8309-6222a552ceb9' AS a, 'gnd' AS n, '132513250' AS v UNION ALL SELECT 'e9014e61-1367-5261-8309-6222a552ceb9' AS a, 'isni' AS n, '0000000116570049' AS v UNION ALL SELECT 'e9014e61-1367-5261-8309-6222a552ceb9' AS a, 'musicbrainz_artist' AS n, '4d9b0383-11a5-4faa-b8c8-30416df1ce1d' AS v UNION ALL SELECT 'e9014e61-1367-5261-8309-6222a552ceb9' AS a, 'viaf' AS n, '62710978' AS v UNION ALL SELECT 'e9014e61-1367-5261-8309-6222a552ceb9' AS a, 'wikidata' AS n, 'Q1250415' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '램버트 오키스', 'Lambert Orkis', 'pianist', 'A', '1946', 'United States', 'e9014e61-1367-5261-8309-6222a552ceb9', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'e9014e61-1367-5261-8309-6222a552ceb9');

