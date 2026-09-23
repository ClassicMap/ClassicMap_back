-- S tier 대기열 F3 (마술피리 "밤의 여왕 아리아")에 필요한 연주자·단체 5곳을 추가한다.
--   소프라노: 에리카 미클로샤, 에디타 그루베로바
--   지휘:     게오르그 솔티, 니콜라우스 아르농쿠르
--   악단:     취리히 오페라 관현악단
--
-- 202608050134 와 같은 방식이다. 솔티는 헝가리 출생이나 영국에 귀화해 활동했으므로
-- 영국으로 적었다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '5b35d900-dcea-54ee-9f38-2b553c678930', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '5b35d900-dcea-54ee-9f38-2b553c678930');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5b35d900-dcea-54ee-9f38-2b553c678930', 'en', 'canonical', 'Erika Miklósa', 'erika miklósa', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5b35d900-dcea-54ee-9f38-2b553c678930' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5b35d900-dcea-54ee-9f38-2b553c678930', 'ko', 'canonical', '에리카 미클로샤', '에리카 미클로샤', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5b35d900-dcea-54ee-9f38-2b553c678930' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '5b35d900-dcea-54ee-9f38-2b553c678930' AS a, 'gnd' AS n, '135435501' AS v UNION ALL SELECT '5b35d900-dcea-54ee-9f38-2b553c678930' AS a, 'isni' AS n, '0000000382136421' AS v UNION ALL SELECT '5b35d900-dcea-54ee-9f38-2b553c678930' AS a, 'musicbrainz_artist' AS n, 'b4b81d18-03f3-4734-8b4f-549771497b62' AS v UNION ALL SELECT '5b35d900-dcea-54ee-9f38-2b553c678930' AS a, 'viaf' AS n, '263558975' AS v UNION ALL SELECT '5b35d900-dcea-54ee-9f38-2b553c678930' AS a, 'wikidata' AS n, 'Q448192' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '에리카 미클로샤', 'Erika Miklósa', 'soprano', 'A', '1971', 'Hungary', '5b35d900-dcea-54ee-9f38-2b553c678930', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '5b35d900-dcea-54ee-9f38-2b553c678930');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '41db5449-5e90-56a7-8925-3beed00b8ae3', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '41db5449-5e90-56a7-8925-3beed00b8ae3');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '41db5449-5e90-56a7-8925-3beed00b8ae3', 'en', 'canonical', 'Edita Gruberová', 'edita gruberová', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '41db5449-5e90-56a7-8925-3beed00b8ae3' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '41db5449-5e90-56a7-8925-3beed00b8ae3', 'ko', 'canonical', '에디타 그루베로바', '에디타 그루베로바', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '41db5449-5e90-56a7-8925-3beed00b8ae3' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '41db5449-5e90-56a7-8925-3beed00b8ae3' AS a, 'gnd' AS n, '119339013' AS v UNION ALL SELECT '41db5449-5e90-56a7-8925-3beed00b8ae3' AS a, 'isni' AS n, '000000010920127X' AS v UNION ALL SELECT '41db5449-5e90-56a7-8925-3beed00b8ae3' AS a, 'musicbrainz_artist' AS n, '0c461736-995c-421c-84dd-af2858dc1f31' AS v UNION ALL SELECT '41db5449-5e90-56a7-8925-3beed00b8ae3' AS a, 'viaf' AS n, '84043266' AS v UNION ALL SELECT '41db5449-5e90-56a7-8925-3beed00b8ae3' AS a, 'wikidata' AS n, 'Q235549' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '에디타 그루베로바', 'Edita Gruberová', 'soprano', 'S', '1946', 'Slovakia', '41db5449-5e90-56a7-8925-3beed00b8ae3', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '41db5449-5e90-56a7-8925-3beed00b8ae3');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '5b3d7906-9339-5d63-a4cb-5d4113494c4f', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '5b3d7906-9339-5d63-a4cb-5d4113494c4f');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5b3d7906-9339-5d63-a4cb-5d4113494c4f', 'en', 'canonical', 'Georg Solti', 'georg solti', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5b3d7906-9339-5d63-a4cb-5d4113494c4f' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '5b3d7906-9339-5d63-a4cb-5d4113494c4f', 'ko', 'canonical', '게오르그 솔티', '게오르그 솔티', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '5b3d7906-9339-5d63-a4cb-5d4113494c4f' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '5b3d7906-9339-5d63-a4cb-5d4113494c4f' AS a, 'gnd' AS n, '118615424' AS v UNION ALL SELECT '5b3d7906-9339-5d63-a4cb-5d4113494c4f' AS a, 'isni' AS n, '0000000121204297' AS v UNION ALL SELECT '5b3d7906-9339-5d63-a4cb-5d4113494c4f' AS a, 'musicbrainz_artist' AS n, '41259fa5-5f9b-445c-8bba-ec28bbb7f2e5' AS v UNION ALL SELECT '5b3d7906-9339-5d63-a4cb-5d4113494c4f' AS a, 'viaf' AS n, '10034770' AS v UNION ALL SELECT '5b3d7906-9339-5d63-a4cb-5d4113494c4f' AS a, 'wikidata' AS n, 'Q128085' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '게오르그 솔티', 'Georg Solti', 'conductor', 'S', '1912', 'United Kingdom', '5b3d7906-9339-5d63-a4cb-5d4113494c4f', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '5b3d7906-9339-5d63-a4cb-5d4113494c4f');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8', 'en', 'canonical', 'Nikolaus Harnoncourt', 'nikolaus harnoncourt', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8', 'ko', 'canonical', '니콜라우스 아르농쿠르', '니콜라우스 아르농쿠르', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8' AS a, 'gnd' AS n, '12162692X' AS v UNION ALL SELECT '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8' AS a, 'isni' AS n, '0000000121008966' AS v UNION ALL SELECT '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8' AS a, 'musicbrainz_artist' AS n, '98b95966-64db-4631-8b9f-8aa66f32cc98' AS v UNION ALL SELECT '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8' AS a, 'viaf' AS n, '42025397' AS v UNION ALL SELECT '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8' AS a, 'wikidata' AS n, 'Q78526' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '니콜라우스 아르농쿠르', 'Nikolaus Harnoncourt', 'conductor', 'S', '1929', 'Austria', '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '2cccf6c9-1a30-5a27-aea7-6f38d6ef86e8');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '290e4e2e-5492-5e71-9e8f-5b75e75447d1', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '290e4e2e-5492-5e71-9e8f-5b75e75447d1');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '290e4e2e-5492-5e71-9e8f-5b75e75447d1', 'en', 'canonical', 'Orchester der Oper Zürich', 'orchester der oper zürich', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '290e4e2e-5492-5e71-9e8f-5b75e75447d1' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '290e4e2e-5492-5e71-9e8f-5b75e75447d1', 'ko', 'canonical', '취리히 오페라 관현악단', '취리히 오페라 관현악단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '290e4e2e-5492-5e71-9e8f-5b75e75447d1' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '290e4e2e-5492-5e71-9e8f-5b75e75447d1' AS a, 'gnd' AS n, '1038746094' AS v UNION ALL SELECT '290e4e2e-5492-5e71-9e8f-5b75e75447d1' AS a, 'isni' AS n, '0000000494670071' AS v UNION ALL SELECT '290e4e2e-5492-5e71-9e8f-5b75e75447d1' AS a, 'musicbrainz_artist' AS n, '8a007796-72f5-4baa-ac6a-338ef0d4679c' AS v UNION ALL SELECT '290e4e2e-5492-5e71-9e8f-5b75e75447d1' AS a, 'viaf' AS n, '305155071' AS v UNION ALL SELECT '290e4e2e-5492-5e71-9e8f-5b75e75447d1' AS a, 'wikidata' AS n, 'Q16854096' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '취리히 오페라 관현악단', 'Orchester der Oper Zürich', 'orchestra', 'A', '1985', 'Switzerland', '290e4e2e-5492-5e71-9e8f-5b75e75447d1', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '290e4e2e-5492-5e71-9e8f-5b75e75447d1');

