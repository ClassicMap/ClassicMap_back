-- A tier A4 배치에 필요한 피아니스트 3명·메조소프라노 3명·악단 1곳을 추가한다.
--
--   클레멘티 소나타 G단조 "버림받은 디도": 셸리 / 매케이브 / 데 팔마
--   글루크 "에우리디체 없이 어찌하리": 베르간사 / 카사로바 / 폰 슈타데
--   글루크 "정령들의 춤" 은 지휘자·악단이 모두 이미 등록돼 있다
--
-- 202608050070 과 같은 방식이다.
--
-- 카사로바(Q441867)는 authority_entities 와 external_identifiers 가 국제 시드로
-- 이미 들어와 있고 artists 행만 없었다. 식별자 다섯 개로 계산한 uuid5 가 기존
-- 엔티티 id(bca8a925-4db0-535c-98c2-0c2be6b20bd2)와 정확히 같아 NOT EXISTS 가
-- 엔티티·이름·식별자 삽입을 건너뛰고 artists 행만 붙는다. 시드 쪽 영문 표기는
-- "Vesselina Katsarova" 인데 여기서는 "Vesselina Kasarova" 로 적는다. 해소는
-- wikidata 로 하므로 표기가 달라도 적재된다.
--
-- 메조소프라노 셋은 category 를 mezzo_soprano 로 둔다. 적재기가
-- canonical_credit_role 에서 vocalist 로 줄인다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac', 'en', 'canonical', 'Howard Shelley', 'howard shelley', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac', 'ko', 'canonical', '하워드 셸리', '하워드 셸리', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac' AS a, 'gnd' AS n, '123772192' AS v UNION ALL SELECT '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac' AS a, 'isni' AS n, '0000000110355479' AS v UNION ALL SELECT '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac' AS a, 'musicbrainz_artist' AS n, '3d461f98-53ba-4a3c-8302-42de280b3adf' AS v UNION ALL SELECT '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac' AS a, 'viaf' AS n, '2659175' AS v UNION ALL SELECT '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac' AS a, 'wikidata' AS n, 'Q11327040' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '하워드 셸리', 'Howard Shelley', 'pianist', 'A', '1950', 'United Kingdom', '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '15998880-6dcd-5e0b-b0f8-4c3d9884e5ac');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1', 'en', 'canonical', 'John McCabe', 'john mccabe', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1', 'ko', 'canonical', '존 매케이브', '존 매케이브', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1' AS a, 'gnd' AS n, '119322412' AS v UNION ALL SELECT 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1' AS a, 'isni' AS n, '000000011675186X' AS v UNION ALL SELECT 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1' AS a, 'musicbrainz_artist' AS n, '96df4f19-232c-4215-9a9c-aeacc2378655' AS v UNION ALL SELECT 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1' AS a, 'viaf' AS n, '3584149068532365730005' AS v UNION ALL SELECT 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1' AS a, 'wikidata' AS n, 'Q949396' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '존 매케이브', 'John McCabe', 'pianist', 'A', '1939', 'United Kingdom', 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'cf2acfa4-2c22-5ff0-9a79-02c1e308a8f1');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '3332fb7e-06b7-5dd2-b5fd-49fd5a570b7f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '3332fb7e-06b7-5dd2-b5fd-49fd5a570b7f');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3332fb7e-06b7-5dd2-b5fd-49fd5a570b7f', 'en', 'canonical', 'Sandro De Palma', 'sandro de palma', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3332fb7e-06b7-5dd2-b5fd-49fd5a570b7f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '3332fb7e-06b7-5dd2-b5fd-49fd5a570b7f', 'ko', 'canonical', '산드로 데 팔마', '산드로 데 팔마', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '3332fb7e-06b7-5dd2-b5fd-49fd5a570b7f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '3332fb7e-06b7-5dd2-b5fd-49fd5a570b7f' AS a, 'wikidata' AS n, 'Q3948214' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '산드로 데 팔마', 'Sandro De Palma', 'pianist', 'A', '1957', 'Italy', '3332fb7e-06b7-5dd2-b5fd-49fd5a570b7f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '3332fb7e-06b7-5dd2-b5fd-49fd5a570b7f');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '937f5935-d7db-558a-b3f0-591c5b756853', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '937f5935-d7db-558a-b3f0-591c5b756853');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '937f5935-d7db-558a-b3f0-591c5b756853', 'en', 'canonical', 'Teresa Berganza', 'teresa berganza', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '937f5935-d7db-558a-b3f0-591c5b756853' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '937f5935-d7db-558a-b3f0-591c5b756853', 'ko', 'canonical', '테레사 베르간사', '테레사 베르간사', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '937f5935-d7db-558a-b3f0-591c5b756853' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '937f5935-d7db-558a-b3f0-591c5b756853' AS a, 'gnd' AS n, '123259177' AS v UNION ALL SELECT '937f5935-d7db-558a-b3f0-591c5b756853' AS a, 'isni' AS n, '0000000114714651' AS v UNION ALL SELECT '937f5935-d7db-558a-b3f0-591c5b756853' AS a, 'musicbrainz_artist' AS n, '5ad2e7ff-2d19-44c1-a2e1-bdeca63e57b3' AS v UNION ALL SELECT '937f5935-d7db-558a-b3f0-591c5b756853' AS a, 'viaf' AS n, '44484328' AS v UNION ALL SELECT '937f5935-d7db-558a-b3f0-591c5b756853' AS a, 'wikidata' AS n, 'Q233876' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '테레사 베르간사', 'Teresa Berganza', 'mezzo_soprano', 'A', '1933', 'Spain', '937f5935-d7db-558a-b3f0-591c5b756853', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '937f5935-d7db-558a-b3f0-591c5b756853');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'bca8a925-4db0-535c-98c2-0c2be6b20bd2', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'bca8a925-4db0-535c-98c2-0c2be6b20bd2');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bca8a925-4db0-535c-98c2-0c2be6b20bd2', 'en', 'canonical', 'Vesselina Kasarova', 'vesselina kasarova', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bca8a925-4db0-535c-98c2-0c2be6b20bd2' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'bca8a925-4db0-535c-98c2-0c2be6b20bd2', 'ko', 'canonical', '베셀리나 카사로바', '베셀리나 카사로바', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'bca8a925-4db0-535c-98c2-0c2be6b20bd2' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'bca8a925-4db0-535c-98c2-0c2be6b20bd2' AS a, 'gnd' AS n, '128748524' AS v UNION ALL SELECT 'bca8a925-4db0-535c-98c2-0c2be6b20bd2' AS a, 'isni' AS n, '000000011449947X' AS v UNION ALL SELECT 'bca8a925-4db0-535c-98c2-0c2be6b20bd2' AS a, 'musicbrainz_artist' AS n, '18d519b8-c6b2-412f-96a9-4e2036b768ed' AS v UNION ALL SELECT 'bca8a925-4db0-535c-98c2-0c2be6b20bd2' AS a, 'viaf' AS n, '84223754' AS v UNION ALL SELECT 'bca8a925-4db0-535c-98c2-0c2be6b20bd2' AS a, 'wikidata' AS n, 'Q441867' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '베셀리나 카사로바', 'Vesselina Kasarova', 'mezzo_soprano', 'A', '1965', 'Bulgaria', 'bca8a925-4db0-535c-98c2-0c2be6b20bd2', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'bca8a925-4db0-535c-98c2-0c2be6b20bd2');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62', 'en', 'canonical', 'Frederica von Stade', 'frederica von stade', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62', 'ko', 'canonical', '프레데리카 폰 슈타데', '프레데리카 폰 슈타데', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62' AS a, 'gnd' AS n, '123935059' AS v UNION ALL SELECT '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62' AS a, 'isni' AS n, '0000000073600059' AS v UNION ALL SELECT '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62' AS a, 'musicbrainz_artist' AS n, 'b688171b-a5c3-4392-aa2b-79c37707407e' AS v UNION ALL SELECT '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62' AS a, 'viaf' AS n, '54334124' AS v UNION ALL SELECT '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62' AS a, 'wikidata' AS n, 'Q265872' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '프레데리카 폰 슈타데', 'Frederica von Stade', 'mezzo_soprano', 'A', '1945', 'United States', '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0c7dfd98-59c1-5db3-9cfe-2ee3488a3e62');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'c0250b02-6954-5c5e-b1f3-32d991f9977d', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'c0250b02-6954-5c5e-b1f3-32d991f9977d');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c0250b02-6954-5c5e-b1f3-32d991f9977d', 'en', 'canonical', 'Utah Symphony', 'utah symphony', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c0250b02-6954-5c5e-b1f3-32d991f9977d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'c0250b02-6954-5c5e-b1f3-32d991f9977d', 'ko', 'canonical', '유타 심포니 오케스트라', '유타 심포니 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'c0250b02-6954-5c5e-b1f3-32d991f9977d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'c0250b02-6954-5c5e-b1f3-32d991f9977d' AS a, 'isni' AS n, '000000041388671X' AS v UNION ALL SELECT 'c0250b02-6954-5c5e-b1f3-32d991f9977d' AS a, 'musicbrainz_artist' AS n, '86d70563-24b0-4bd6-97c5-a1407273c8ec' AS v UNION ALL SELECT 'c0250b02-6954-5c5e-b1f3-32d991f9977d' AS a, 'viaf' AS n, '141905382' AS v UNION ALL SELECT 'c0250b02-6954-5c5e-b1f3-32d991f9977d' AS a, 'wikidata' AS n, 'Q2778079' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '유타 심포니 오케스트라', 'Utah Symphony', 'orchestra', 'A', '1940', 'United States', 'c0250b02-6954-5c5e-b1f3-32d991f9977d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'c0250b02-6954-5c5e-b1f3-32d991f9977d');

