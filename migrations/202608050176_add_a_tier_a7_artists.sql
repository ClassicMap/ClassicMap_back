-- A tier A7 배치에 필요한 지휘자 3명을 추가한다.
--   로린 마젤 · 조르주 프레트르 · 프리츠 라이너
--
-- 무소르크스키 <민둥산의 하룻밤>(piece 191)에 쓴다. 악단 셋(베를린필·로열
-- 필하모닉·피츠버그 심포니)은 모두 이미 등록돼 있다.
--
-- 이 셋이 된 사정을 적어 둔다. 이 곡은 통상 10~12분인데 클립 상한이 600초라
-- **이미 등록된 지휘자의 연주는 하나도 600초 안에 들지 않았다**(솔티 621초,
-- 오자와 651초, 번스타인 659초, 뒤투아 662초, 카라얀 688초, 오르만디 701초 등).
-- 600초 아래는 사실상 옛 녹음뿐이라 1948·1959·1963 년 녹음 셋이 됐다.
--
-- 마젤은 미국·프랑스 국적을 함께 갖고 있어 출생지를 따라 미국으로, 라이너는
-- 헝가리·미국 중 출생지를 따라 헝가리로 적었다.
--
-- 202608050070 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '455a305a-eca6-5578-855b-971ebfb10592', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '455a305a-eca6-5578-855b-971ebfb10592');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '455a305a-eca6-5578-855b-971ebfb10592', 'en', 'canonical', 'Lorin Maazel', 'lorin maazel', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '455a305a-eca6-5578-855b-971ebfb10592' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '455a305a-eca6-5578-855b-971ebfb10592', 'ko', 'canonical', '로린 마젤', '로린 마젤', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '455a305a-eca6-5578-855b-971ebfb10592' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '455a305a-eca6-5578-855b-971ebfb10592' AS a, 'gnd' AS n, '118575635' AS v UNION ALL SELECT '455a305a-eca6-5578-855b-971ebfb10592' AS a, 'isni' AS n, '0000000110363356' AS v UNION ALL SELECT '455a305a-eca6-5578-855b-971ebfb10592' AS a, 'musicbrainz_artist' AS n, 'e38bb7a2-c3e5-4be2-894b-7078c40b9955' AS v UNION ALL SELECT '455a305a-eca6-5578-855b-971ebfb10592' AS a, 'viaf' AS n, '5118255' AS v UNION ALL SELECT '455a305a-eca6-5578-855b-971ebfb10592' AS a, 'wikidata' AS n, 'Q117710' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로린 마젤', 'Lorin Maazel', 'conductor', 'S', '1930', 'United States', '455a305a-eca6-5578-855b-971ebfb10592', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '455a305a-eca6-5578-855b-971ebfb10592');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '8b7640c4-258e-5cbb-97dc-9d1a86724980', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '8b7640c4-258e-5cbb-97dc-9d1a86724980');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8b7640c4-258e-5cbb-97dc-9d1a86724980', 'en', 'canonical', 'Georges Prêtre', 'georges prêtre', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8b7640c4-258e-5cbb-97dc-9d1a86724980' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '8b7640c4-258e-5cbb-97dc-9d1a86724980', 'ko', 'canonical', '조르주 프레트르', '조르주 프레트르', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '8b7640c4-258e-5cbb-97dc-9d1a86724980' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '8b7640c4-258e-5cbb-97dc-9d1a86724980' AS a, 'gnd' AS n, '124169546' AS v UNION ALL SELECT '8b7640c4-258e-5cbb-97dc-9d1a86724980' AS a, 'isni' AS n, '0000000114553130' AS v UNION ALL SELECT '8b7640c4-258e-5cbb-97dc-9d1a86724980' AS a, 'isni' AS n, '0000000368589264' AS v UNION ALL SELECT '8b7640c4-258e-5cbb-97dc-9d1a86724980' AS a, 'musicbrainz_artist' AS n, '33ff592d-0cf8-4d40-895d-993aad15d311' AS v UNION ALL SELECT '8b7640c4-258e-5cbb-97dc-9d1a86724980' AS a, 'viaf' AS n, '112687781' AS v UNION ALL SELECT '8b7640c4-258e-5cbb-97dc-9d1a86724980' AS a, 'wikidata' AS n, 'Q342381' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '조르주 프레트르', 'Georges Prêtre', 'conductor', 'A', '1924', 'France', '8b7640c4-258e-5cbb-97dc-9d1a86724980', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '8b7640c4-258e-5cbb-97dc-9d1a86724980');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '7d87195f-a8af-584b-bfbe-0e10dda61986', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '7d87195f-a8af-584b-bfbe-0e10dda61986');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7d87195f-a8af-584b-bfbe-0e10dda61986', 'en', 'canonical', 'Fritz Reiner', 'fritz reiner', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7d87195f-a8af-584b-bfbe-0e10dda61986' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '7d87195f-a8af-584b-bfbe-0e10dda61986', 'ko', 'canonical', '프리츠 라이너', '프리츠 라이너', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '7d87195f-a8af-584b-bfbe-0e10dda61986' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '7d87195f-a8af-584b-bfbe-0e10dda61986' AS a, 'gnd' AS n, '119221144' AS v UNION ALL SELECT '7d87195f-a8af-584b-bfbe-0e10dda61986' AS a, 'isni' AS n, '0000000108919300' AS v UNION ALL SELECT '7d87195f-a8af-584b-bfbe-0e10dda61986' AS a, 'musicbrainz_artist' AS n, '6a720f84-d307-4aa4-a75f-7d85bef56ede' AS v UNION ALL SELECT '7d87195f-a8af-584b-bfbe-0e10dda61986' AS a, 'viaf' AS n, '42026455' AS v UNION ALL SELECT '7d87195f-a8af-584b-bfbe-0e10dda61986' AS a, 'wikidata' AS n, 'Q364179' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '프리츠 라이너', 'Fritz Reiner', 'conductor', 'S', '1888', 'Hungary', '7d87195f-a8af-584b-bfbe-0e10dda61986', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '7d87195f-a8af-584b-bfbe-0e10dda61986');

