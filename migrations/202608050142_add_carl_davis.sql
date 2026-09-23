-- S tier 대기열 BC1 (심포닉 댄스)에 필요한 지휘자 1명을 추가한다.
--   칼 데이비스 — 미국 출생이나 영국에서 활동했다. 출생지를 따라 미국으로 적었다.
--
-- 202608050112 와 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'f3fc328b-4d26-5938-9100-8b8546573c3f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'f3fc328b-4d26-5938-9100-8b8546573c3f');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f3fc328b-4d26-5938-9100-8b8546573c3f', 'en', 'canonical', 'Carl Davis', 'carl davis', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f3fc328b-4d26-5938-9100-8b8546573c3f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'f3fc328b-4d26-5938-9100-8b8546573c3f', 'ko', 'canonical', '칼 데이비스', '칼 데이비스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'f3fc328b-4d26-5938-9100-8b8546573c3f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'f3fc328b-4d26-5938-9100-8b8546573c3f' AS a, 'gnd' AS n, '134355555' AS v UNION ALL SELECT 'f3fc328b-4d26-5938-9100-8b8546573c3f' AS a, 'isni' AS n, '0000000110279939' AS v UNION ALL SELECT 'f3fc328b-4d26-5938-9100-8b8546573c3f' AS a, 'musicbrainz_artist' AS n, 'da1faeaa-82c8-4072-b40f-0f7f2e1efe76' AS v UNION ALL SELECT 'f3fc328b-4d26-5938-9100-8b8546573c3f' AS a, 'viaf' AS n, '61733923' AS v UNION ALL SELECT 'f3fc328b-4d26-5938-9100-8b8546573c3f' AS a, 'wikidata' AS n, 'Q584221' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '칼 데이비스', 'Carl Davis', 'conductor', 'A', '1936', 'United States', 'f3fc328b-4d26-5938-9100-8b8546573c3f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'f3fc328b-4d26-5938-9100-8b8546573c3f');

