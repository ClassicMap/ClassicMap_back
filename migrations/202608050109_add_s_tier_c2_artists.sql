-- S tier 대기열 C2 에 필요한 지휘자 1명과 악단 1곳을 추가한다.
--   쇼스타코비치 첼로 협주곡 1번 마이스키 연주의 지휘자: 마이클 틸슨 토머스
--   모차르트 클라리넷 협주곡 프뢰스트 연주의 악단: 스웨덴 체임버 오케스트라
--
-- 202608050070 과 같은 방식이다. 스웨덴 체임버 오케스트라는 Wikidata 에 국적 항목이
-- 없어 이름과 소재지를 따랐다. 한국어 라벨이 없는 곳은 음역했다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '1b88cd29-8c70-5bf6-b1e6-833b117ebd53', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '1b88cd29-8c70-5bf6-b1e6-833b117ebd53');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1b88cd29-8c70-5bf6-b1e6-833b117ebd53', 'en', 'canonical', 'Michael Tilson Thomas', 'michael tilson thomas', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1b88cd29-8c70-5bf6-b1e6-833b117ebd53' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '1b88cd29-8c70-5bf6-b1e6-833b117ebd53', 'ko', 'canonical', '마이클 틸슨 토머스', '마이클 틸슨 토머스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '1b88cd29-8c70-5bf6-b1e6-833b117ebd53' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '1b88cd29-8c70-5bf6-b1e6-833b117ebd53' AS a, 'gnd' AS n, '121602648' AS v UNION ALL SELECT '1b88cd29-8c70-5bf6-b1e6-833b117ebd53' AS a, 'isni' AS n, '0000000114499533' AS v UNION ALL SELECT '1b88cd29-8c70-5bf6-b1e6-833b117ebd53' AS a, 'musicbrainz_artist' AS n, 'f6df125a-a83c-4161-8cbe-48f4a3a7cad5' AS v UNION ALL SELECT '1b88cd29-8c70-5bf6-b1e6-833b117ebd53' AS a, 'viaf' AS n, '74039011' AS v UNION ALL SELECT '1b88cd29-8c70-5bf6-b1e6-833b117ebd53' AS a, 'viaf' AS n, '84228944' AS v UNION ALL SELECT '1b88cd29-8c70-5bf6-b1e6-833b117ebd53' AS a, 'wikidata' AS n, 'Q520493' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '마이클 틸슨 토머스', 'Michael Tilson Thomas', 'conductor', 'A', '1944', 'United States', '1b88cd29-8c70-5bf6-b1e6-833b117ebd53', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '1b88cd29-8c70-5bf6-b1e6-833b117ebd53');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b', 'en', 'canonical', 'Swedish Chamber Orchestra', 'swedish chamber orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b', 'ko', 'canonical', '스웨덴 체임버 오케스트라', '스웨덴 체임버 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b' AS a, 'isni' AS n, '0000000109450356' AS v UNION ALL SELECT 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b' AS a, 'musicbrainz_artist' AS n, '8f7649f2-a4b1-43d2-8475-dba79db26ad4' AS v UNION ALL SELECT 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b' AS a, 'viaf' AS n, '150332529' AS v UNION ALL SELECT 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b' AS a, 'wikidata' AS n, 'Q2036196' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '스웨덴 체임버 오케스트라', 'Swedish Chamber Orchestra', 'orchestra', 'B', '1995', 'Sweden', 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'efbe0fc4-995a-5b05-9ae9-1bc25808d51b');

