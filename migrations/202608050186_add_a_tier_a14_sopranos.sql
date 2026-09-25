-- A tier A14 배치에 필요한 소프라노 3명을 추가한다.
--   키리 테 카나와 · 실라 암스트롱 · 루치아 포프
--
-- 포레 레퀴엠(piece 206)의 4곡 "Pie Jesu" 에 쓴다. **이 악장은 소프라노 독창이다.**
-- 배치 정의는 role 을 CONDUCTOR 로 두었고 서브에이전트는 지시대로 지휘자와 악단만
-- 붙였는데, 이 섹터에서 실제로 비교되는 것은 소프라노다. 크레딧을 보탠다.
-- A12 의 천인 교향곡에서 합창단을 보탠 것과 같은 판단이다.
--
-- 합창단은 보태지 않는다. Pie Jesu 는 합창이 노래하지 않는 악장이라 붙이면 이
-- 섹터에 대해 틀린 크레딧이 된다. 뒤투아의 Choeur de l'OSM 은 wikidata 항목도 없다.
--
-- 셋 다 wikidata 항목이 충실하다(클레임 50~170개, 한국어 라벨 있음).
-- 202608050183 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434', 'en', 'canonical', 'Kiri Te Kanawa', 'kiri te kanawa', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434', 'ko', 'canonical', '키리 테 카나와', '키리 테 카나와', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434' AS a, 'gnd' AS n, '119554410' AS v UNION ALL SELECT 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434' AS a, 'isni' AS n, '0000000114712250' AS v UNION ALL SELECT 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434' AS a, 'musicbrainz_artist' AS n, '1a78bb97-ad86-4f89-b4b4-cc10953103c3' AS v UNION ALL SELECT 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434' AS a, 'viaf' AS n, '42025635' AS v UNION ALL SELECT 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434' AS a, 'wikidata' AS n, 'Q380133' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '키리 테 카나와', 'Kiri Te Kanawa', 'soprano', 'A', '1944', 'New Zealand', 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'd5cf5d13-fed4-5d75-93cb-7f6ffe6d0434');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '411b2eae-c1de-58c6-9032-f25106095090', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '411b2eae-c1de-58c6-9032-f25106095090');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '411b2eae-c1de-58c6-9032-f25106095090', 'en', 'canonical', 'Sheila Armstrong', 'sheila armstrong', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '411b2eae-c1de-58c6-9032-f25106095090' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '411b2eae-c1de-58c6-9032-f25106095090', 'ko', 'canonical', '실라 암스트롱', '실라 암스트롱', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '411b2eae-c1de-58c6-9032-f25106095090' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '411b2eae-c1de-58c6-9032-f25106095090' AS a, 'gnd' AS n, '130421618' AS v UNION ALL SELECT '411b2eae-c1de-58c6-9032-f25106095090' AS a, 'isni' AS n, '0000000114439020' AS v UNION ALL SELECT '411b2eae-c1de-58c6-9032-f25106095090' AS a, 'musicbrainz_artist' AS n, '537ec27f-a880-466e-aa16-09669c8852b6' AS v UNION ALL SELECT '411b2eae-c1de-58c6-9032-f25106095090' AS a, 'viaf' AS n, '51874294' AS v UNION ALL SELECT '411b2eae-c1de-58c6-9032-f25106095090' AS a, 'wikidata' AS n, 'Q1394650' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '실라 암스트롱', 'Sheila Armstrong', 'soprano', 'A', '1942', 'United Kingdom', '411b2eae-c1de-58c6-9032-f25106095090', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '411b2eae-c1de-58c6-9032-f25106095090');

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e');
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e', 'en', 'canonical', 'Lucia Popp', 'lucia popp', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);
INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e', 'ko', 'canonical', '루치아 포프', '루치아 포프', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);
INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e' AS a, 'gnd' AS n, '122068165' AS v UNION ALL SELECT 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e' AS a, 'isni' AS n, '0000000118842087' AS v UNION ALL SELECT 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e' AS a, 'musicbrainz_artist' AS n, '78fb5470-e2e6-4c56-9d0d-692152c351d4' AS v UNION ALL SELECT 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e' AS a, 'viaf' AS n, '22328398' AS v UNION ALL SELECT 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e' AS a, 'wikidata' AS n, 'Q241014' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);
INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '루치아 포프', 'Lucia Popp', 'soprano', 'A', '1939', 'Slovakia', 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a8666b60-fd64-5f7b-9fb9-d087f7254c9e');

