-- S tier 대기열 C4 (실내악)에 필요한 4중주단 3곳을 추가한다.
--   아마데우스 4중주단, 타카치 4중주단, 알반 베르크 4중주단
--
-- 202608050112 와 같은 방식이다. 셋 다 단체이므로 authority_entities 의 entity_kind 는
-- ensemble 이고 artists.category 도 ensemble 이다. 국적은 창단지를 따랐다(타카치는
-- 부다페스트에서 창단해 뒤에 미국으로 옮겼고 Wikidata 는 미국으로 적고 있다).

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'b25f88c6-fa49-5a59-a50c-db8507bfa253', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'b25f88c6-fa49-5a59-a50c-db8507bfa253');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b25f88c6-fa49-5a59-a50c-db8507bfa253', 'en', 'canonical', 'Amadeus Quartet', 'amadeus quartet', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b25f88c6-fa49-5a59-a50c-db8507bfa253' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'b25f88c6-fa49-5a59-a50c-db8507bfa253', 'ko', 'canonical', '아마데우스 4중주단', '아마데우스 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'b25f88c6-fa49-5a59-a50c-db8507bfa253' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'b25f88c6-fa49-5a59-a50c-db8507bfa253' AS a, 'gnd' AS n, '1212441-2' AS v UNION ALL SELECT 'b25f88c6-fa49-5a59-a50c-db8507bfa253' AS a, 'isni' AS n, '0000000119564998' AS v UNION ALL SELECT 'b25f88c6-fa49-5a59-a50c-db8507bfa253' AS a, 'musicbrainz_artist' AS n, '7bf0b7e0-ce0b-411e-9977-aed8e67172a1' AS v UNION ALL SELECT 'b25f88c6-fa49-5a59-a50c-db8507bfa253' AS a, 'viaf' AS n, '134996717' AS v UNION ALL SELECT 'b25f88c6-fa49-5a59-a50c-db8507bfa253' AS a, 'wikidata' AS n, 'Q451806' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '아마데우스 4중주단', 'Amadeus Quartet', 'ensemble', 'S', '1947', 'United Kingdom', 'b25f88c6-fa49-5a59-a50c-db8507bfa253', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'b25f88c6-fa49-5a59-a50c-db8507bfa253');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '839f0689-a4b1-5642-a303-883f7bf07356', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '839f0689-a4b1-5642-a303-883f7bf07356');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '839f0689-a4b1-5642-a303-883f7bf07356', 'en', 'canonical', 'Takács Quartet', 'takács quartet', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '839f0689-a4b1-5642-a303-883f7bf07356' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '839f0689-a4b1-5642-a303-883f7bf07356', 'ko', 'canonical', '타카치 4중주단', '타카치 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '839f0689-a4b1-5642-a303-883f7bf07356' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '839f0689-a4b1-5642-a303-883f7bf07356' AS a, 'isni' AS n, '0000000122965768' AS v UNION ALL SELECT '839f0689-a4b1-5642-a303-883f7bf07356' AS a, 'musicbrainz_artist' AS n, '64dc0b9b-9417-4040-a72e-e70cecf24e72' AS v UNION ALL SELECT '839f0689-a4b1-5642-a303-883f7bf07356' AS a, 'viaf' AS n, '121315928' AS v UNION ALL SELECT '839f0689-a4b1-5642-a303-883f7bf07356' AS a, 'wikidata' AS n, 'Q4218548' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '타카치 4중주단', 'Takács Quartet', 'ensemble', 'S', '1975', 'Hungary', '839f0689-a4b1-5642-a303-883f7bf07356', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '839f0689-a4b1-5642-a303-883f7bf07356');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '636ab222-4902-5864-929d-3cd7f0091434', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '636ab222-4902-5864-929d-3cd7f0091434');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '636ab222-4902-5864-929d-3cd7f0091434', 'en', 'canonical', 'Alban Berg Quartett', 'alban berg quartett', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '636ab222-4902-5864-929d-3cd7f0091434' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '636ab222-4902-5864-929d-3cd7f0091434', 'ko', 'canonical', '알반 베르크 4중주단', '알반 베르크 4중주단', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '636ab222-4902-5864-929d-3cd7f0091434' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '636ab222-4902-5864-929d-3cd7f0091434' AS a, 'gnd' AS n, '672742-6' AS v UNION ALL SELECT '636ab222-4902-5864-929d-3cd7f0091434' AS a, 'isni' AS n, '0000000120349427' AS v UNION ALL SELECT '636ab222-4902-5864-929d-3cd7f0091434' AS a, 'musicbrainz_artist' AS n, '634e882f-d875-4e32-8228-de330b638a28' AS v UNION ALL SELECT '636ab222-4902-5864-929d-3cd7f0091434' AS a, 'viaf' AS n, '153019907' AS v UNION ALL SELECT '636ab222-4902-5864-929d-3cd7f0091434' AS a, 'wikidata' AS n, 'Q389156' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '알반 베르크 4중주단', 'Alban Berg Quartett', 'ensemble', 'S', '1971', 'Austria', '636ab222-4902-5864-929d-3cd7f0091434', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '636ab222-4902-5864-929d-3cd7f0091434');

