-- S tier 대기열 C5 (피아노 실내악)에 필요한 연주자 6명을 추가한다.
--   바이올린: 미하엘 바렌보임, 빅토리아 물로바, 르노 카퓌송
--   첼로:     린 하렐, 하인리히 시프
--   피아노:   제러미 뎅크
--
-- 202608050112 와 같은 방식이다. 복수 국적은 현재 활동지를 따라 하나만 적었다
-- (물로바는 소련 출생·러시아·오스트리아 중 러시아).

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '8d56d71c-29df-5d00-a37b-d0ce00704f70', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '8d56d71c-29df-5d00-a37b-d0ce00704f70');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8d56d71c-29df-5d00-a37b-d0ce00704f70', 'en', 'canonical', 'Michael Barenboim', 'michael barenboim', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8d56d71c-29df-5d00-a37b-d0ce00704f70' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8d56d71c-29df-5d00-a37b-d0ce00704f70', 'ko', 'canonical', '미하엘 바렌보임', '미하엘 바렌보임', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8d56d71c-29df-5d00-a37b-d0ce00704f70' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '8d56d71c-29df-5d00-a37b-d0ce00704f70' AS a, 'gnd' AS n, '160096537' AS v UNION ALL SELECT '8d56d71c-29df-5d00-a37b-d0ce00704f70' AS a, 'isni' AS n, '0000000122133179' AS v UNION ALL SELECT '8d56d71c-29df-5d00-a37b-d0ce00704f70' AS a, 'musicbrainz_artist' AS n, 'c042a08d-e59f-49ad-9a06-e0903917bec1' AS v UNION ALL SELECT '8d56d71c-29df-5d00-a37b-d0ce00704f70' AS a, 'viaf' AS n, '88523890' AS v UNION ALL SELECT '8d56d71c-29df-5d00-a37b-d0ce00704f70' AS a, 'wikidata' AS n, 'Q15449943' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '미하엘 바렌보임', 'Michael Barenboim', 'violinist', 'A', '1985', 'France', '8d56d71c-29df-5d00-a37b-d0ce00704f70', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '8d56d71c-29df-5d00-a37b-d0ce00704f70');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '51f90356-51a5-577a-82a7-e6ea0347c595', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '51f90356-51a5-577a-82a7-e6ea0347c595');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '51f90356-51a5-577a-82a7-e6ea0347c595', 'en', 'canonical', 'Lynn Harrell', 'lynn harrell', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '51f90356-51a5-577a-82a7-e6ea0347c595' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '51f90356-51a5-577a-82a7-e6ea0347c595', 'ko', 'canonical', '린 하렐', '린 하렐', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '51f90356-51a5-577a-82a7-e6ea0347c595' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '51f90356-51a5-577a-82a7-e6ea0347c595' AS a, 'gnd' AS n, '133279855' AS v UNION ALL SELECT '51f90356-51a5-577a-82a7-e6ea0347c595' AS a, 'isni' AS n, '0000000114371759' AS v UNION ALL SELECT '51f90356-51a5-577a-82a7-e6ea0347c595' AS a, 'musicbrainz_artist' AS n, '813d4c5f-e81e-4d6a-b6fc-510b9baca853' AS v UNION ALL SELECT '51f90356-51a5-577a-82a7-e6ea0347c595' AS a, 'viaf' AS n, '6118222' AS v UNION ALL SELECT '51f90356-51a5-577a-82a7-e6ea0347c595' AS a, 'wikidata' AS n, 'Q60317' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '린 하렐', 'Lynn Harrell', 'cellist', 'S', '1944', 'United States', '51f90356-51a5-577a-82a7-e6ea0347c595', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '51f90356-51a5-577a-82a7-e6ea0347c595');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80', 'en', 'canonical', 'Viktoria Mullova', 'viktoria mullova', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80', 'ko', 'canonical', '빅토리아 물로바', '빅토리아 물로바', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80' AS a, 'gnd' AS n, '133840220' AS v UNION ALL SELECT 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80' AS a, 'isni' AS n, '0000000110574129' AS v UNION ALL SELECT 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80' AS a, 'musicbrainz_artist' AS n, '02bd2dff-f337-4788-9e75-0eb6beb932ac' AS v UNION ALL SELECT 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80' AS a, 'viaf' AS n, '39563952' AS v UNION ALL SELECT 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80' AS a, 'wikidata' AS n, 'Q268575' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '빅토리아 물로바', 'Viktoria Mullova', 'violinist', 'S', '1959', 'Russia', 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c2bda01c-525b-5c82-9f7d-9fa0d71c3e80');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd668f8c5-e1ea-5730-bb02-6503d38db8a0', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd668f8c5-e1ea-5730-bb02-6503d38db8a0');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd668f8c5-e1ea-5730-bb02-6503d38db8a0', 'en', 'canonical', 'Heinrich Schiff', 'heinrich schiff', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd668f8c5-e1ea-5730-bb02-6503d38db8a0' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd668f8c5-e1ea-5730-bb02-6503d38db8a0', 'ko', 'canonical', '하인리히 시프', '하인리히 시프', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd668f8c5-e1ea-5730-bb02-6503d38db8a0' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd668f8c5-e1ea-5730-bb02-6503d38db8a0' AS a, 'gnd' AS n, '124867227' AS v UNION ALL SELECT 'd668f8c5-e1ea-5730-bb02-6503d38db8a0' AS a, 'isni' AS n, '0000000114719807' AS v UNION ALL SELECT 'd668f8c5-e1ea-5730-bb02-6503d38db8a0' AS a, 'musicbrainz_artist' AS n, 'e6dfd29a-5c7d-4708-9ff5-25cd5f5de5b5' AS v UNION ALL SELECT 'd668f8c5-e1ea-5730-bb02-6503d38db8a0' AS a, 'viaf' AS n, '46947586' AS v UNION ALL SELECT 'd668f8c5-e1ea-5730-bb02-6503d38db8a0' AS a, 'wikidata' AS n, 'Q662066' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '하인리히 시프', 'Heinrich Schiff', 'cellist', 'S', '1951', 'Austria', 'd668f8c5-e1ea-5730-bb02-6503d38db8a0', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd668f8c5-e1ea-5730-bb02-6503d38db8a0');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b', 'en', 'canonical', 'Jeremy Denk', 'jeremy denk', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b', 'ko', 'canonical', '제러미 뎅크', '제러미 뎅크', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b' AS a, 'gnd' AS n, '13512283X' AS v UNION ALL SELECT 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b' AS a, 'isni' AS n, '0000000080003754' AS v UNION ALL SELECT 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b' AS a, 'musicbrainz_artist' AS n, '71987909-1c14-4761-ae93-502df99eec41' AS v UNION ALL SELECT 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b' AS a, 'viaf' AS n, '66050654' AS v UNION ALL SELECT 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b' AS a, 'wikidata' AS n, 'Q6181301' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '제러미 뎅크', 'Jeremy Denk', 'pianist', 'A', '1970', 'United States', 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a7fb7ed8-e180-5e3f-b7f8-c3a1345c2b6b');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '14e84dad-3211-5d71-858a-db5383581a84', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '14e84dad-3211-5d71-858a-db5383581a84');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '14e84dad-3211-5d71-858a-db5383581a84', 'en', 'canonical', 'Renaud Capuçon', 'renaud capuçon', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '14e84dad-3211-5d71-858a-db5383581a84' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '14e84dad-3211-5d71-858a-db5383581a84', 'ko', 'canonical', '르노 카퓌송', '르노 카퓌송', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '14e84dad-3211-5d71-858a-db5383581a84' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '14e84dad-3211-5d71-858a-db5383581a84' AS a, 'gnd' AS n, '124062806' AS v UNION ALL SELECT '14e84dad-3211-5d71-858a-db5383581a84' AS a, 'isni' AS n, '0000000109111047' AS v UNION ALL SELECT '14e84dad-3211-5d71-858a-db5383581a84' AS a, 'musicbrainz_artist' AS n, 'fdef52c9-8dc0-438b-8087-b704811f33a3' AS v UNION ALL SELECT '14e84dad-3211-5d71-858a-db5383581a84' AS a, 'viaf' AS n, '66666374' AS v UNION ALL SELECT '14e84dad-3211-5d71-858a-db5383581a84' AS a, 'wikidata' AS n, 'Q552845' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '르노 카퓌송', 'Renaud Capuçon', 'violinist', 'S', '1976', 'France', '14e84dad-3211-5d71-858a-db5383581a84', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '14e84dad-3211-5d71-858a-db5383581a84');

