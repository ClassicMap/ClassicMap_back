-- S tier 대기열 B3 (하이든 고별 교향곡)에 필요한 지휘자 1명과 악단 1곳을 추가한다.
--   다니엘 바렌보임과 잉글리시 체임버 오케스트라
--
-- 202608050070 과 같은 방식이다. 바렌보임은 아르헨티나·이스라엘·스페인·팔레스타인
-- 국적을 함께 갖고 있어 출생지를 따라 아르헨티나로 적었다. 그는 피아니스트이기도 하지만
-- 이 녹음에서는 지휘자라 분류를 conductor 로 둔다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '055ef955-5641-5acb-bee3-50503e057fe6', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '055ef955-5641-5acb-bee3-50503e057fe6');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '055ef955-5641-5acb-bee3-50503e057fe6', 'en', 'canonical', 'Daniel Barenboim', 'daniel barenboim', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '055ef955-5641-5acb-bee3-50503e057fe6' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '055ef955-5641-5acb-bee3-50503e057fe6', 'ko', 'canonical', '다니엘 바렌보임', '다니엘 바렌보임', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '055ef955-5641-5acb-bee3-50503e057fe6' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '055ef955-5641-5acb-bee3-50503e057fe6' AS a, 'gnd' AS n, '118506560' AS v UNION ALL SELECT '055ef955-5641-5acb-bee3-50503e057fe6' AS a, 'isni' AS n, '0000000121462413' AS v UNION ALL SELECT '055ef955-5641-5acb-bee3-50503e057fe6' AS a, 'musicbrainz_artist' AS n, 'fac566b2-7a0e-4977-ad92-533f43420975' AS v UNION ALL SELECT '055ef955-5641-5acb-bee3-50503e057fe6' AS a, 'viaf' AS n, '104029553' AS v UNION ALL SELECT '055ef955-5641-5acb-bee3-50503e057fe6' AS a, 'wikidata' AS n, 'Q152768' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '다니엘 바렌보임', 'Daniel Barenboim', 'conductor', 'S', '1942', 'Argentina', '055ef955-5641-5acb-bee3-50503e057fe6', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '055ef955-5641-5acb-bee3-50503e057fe6');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '3114c85a-68aa-5b27-a4f9-2188dc354e68', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '3114c85a-68aa-5b27-a4f9-2188dc354e68');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3114c85a-68aa-5b27-a4f9-2188dc354e68', 'en', 'canonical', 'English Chamber Orchestra', 'english chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3114c85a-68aa-5b27-a4f9-2188dc354e68' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3114c85a-68aa-5b27-a4f9-2188dc354e68', 'ko', 'canonical', '잉글리시 체임버 오케스트라', '잉글리시 체임버 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3114c85a-68aa-5b27-a4f9-2188dc354e68' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '3114c85a-68aa-5b27-a4f9-2188dc354e68' AS a, 'gnd' AS n, '1087139-1' AS v UNION ALL SELECT '3114c85a-68aa-5b27-a4f9-2188dc354e68' AS a, 'isni' AS n, '000000011297410X' AS v UNION ALL SELECT '3114c85a-68aa-5b27-a4f9-2188dc354e68' AS a, 'musicbrainz_artist' AS n, '8c936585-f1e5-4729-9402-98f319d265b0' AS v UNION ALL SELECT '3114c85a-68aa-5b27-a4f9-2188dc354e68' AS a, 'viaf' AS n, '145258445' AS v UNION ALL SELECT '3114c85a-68aa-5b27-a4f9-2188dc354e68' AS a, 'wikidata' AS n, 'Q1146465' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '잉글리시 체임버 오케스트라', 'English Chamber Orchestra', 'orchestra', 'A', '1948', 'United Kingdom', '3114c85a-68aa-5b27-a4f9-2188dc354e68', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '3114c85a-68aa-5b27-a4f9-2188dc354e68');

