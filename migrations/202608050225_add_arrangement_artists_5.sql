-- 편곡 비교 배치 5(보칼리제)에 필요한 인물·단체 셋을 등록한다.
--
--   로저 비뇰스               (Q3439553)   피아노 — 테 카나와 판 반주
--   알렉산드르 데듀힌          (Q112479872) 피아노 — 로스트로포비치 판 반주
--   쾰른 신 필하모닉 오케스트라 (Q22959500)
--
-- 테 카나와(749)와 로스트로포비치(734)는 이미 등록돼 있다.
--
-- **쾰른 신 필하모닉(Q22959500)은 이미 등록된 쾰른 실내관현악단(729, Q111795682)과
-- 다른 악단이다.** 이름이 비슷해 헷갈릴 자리다.
--
-- 두 곳은 항목이 얇다 — 데듀힌 클레임 15개에 식별자 셋(viaf·gnd·isni), 쾰른 신
-- 필하모닉 클레임 11개에 식별자 셋(viaf·gnd·musicbrainz). **354 에서 브루스
-- 레빙스턴(클레임 12, viaf 하나)을 뺀 것과 견주면 이쪽이 낫다** — 권위 레코드가
-- 둘 이상이고 생년·창립연도와 나라가 있다. 대신할 후보도 없다(라자레프 판은 배급
-- 표기에 악단 이름이 없다).
--
-- **데듀힌의 wikidata 영어 라벨에 결합 문자가 섞여 있다**("Aleksandr Dedi︠u︡khin").
-- 배급 표기의 철자 "Alexander Dedyukhin" 으로 적었다. 식별자가 QID 이므로 표기 차이는
-- 문제가 되지 않는다. 나라 진술이 없어 Russia 로 두었다.
--
-- 202608050223 과 같은 방식이다.

INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '0c24fde6-2319-5c00-8b02-719f571e862d', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '0c24fde6-2319-5c00-8b02-719f571e862d');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0c24fde6-2319-5c00-8b02-719f571e862d', 'en', 'canonical', 'Roger Vignoles', 'roger vignoles', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0c24fde6-2319-5c00-8b02-719f571e862d' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '0c24fde6-2319-5c00-8b02-719f571e862d', 'ko', 'canonical', '로저 비뇰스', '로저 비뇰스', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '0c24fde6-2319-5c00-8b02-719f571e862d' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '0c24fde6-2319-5c00-8b02-719f571e862d' AS a, 'gnd' AS n, '128534087' AS v UNION ALL SELECT '0c24fde6-2319-5c00-8b02-719f571e862d' AS a, 'isni' AS n, '0000000114414560' AS v UNION ALL SELECT '0c24fde6-2319-5c00-8b02-719f571e862d' AS a, 'lccn' AS n, 'n80030952' AS v UNION ALL SELECT '0c24fde6-2319-5c00-8b02-719f571e862d' AS a, 'musicbrainz_artist' AS n, 'a02c25d0-2b2b-4275-9ee8-17f37f2811a7' AS v UNION ALL SELECT '0c24fde6-2319-5c00-8b02-719f571e862d' AS a, 'viaf' AS n, '34644843' AS v UNION ALL SELECT '0c24fde6-2319-5c00-8b02-719f571e862d' AS a, 'wikidata' AS n, 'Q3439553' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '로저 비뇰스', 'Roger Vignoles', 'pianist', 'A', '1945', 'United Kingdom', '0c24fde6-2319-5c00-8b02-719f571e862d', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '0c24fde6-2319-5c00-8b02-719f571e862d');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT 'a47bed8c-fdfb-5b56-aafd-076355dce2c5', 'person', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = 'a47bed8c-fdfb-5b56-aafd-076355dce2c5');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a47bed8c-fdfb-5b56-aafd-076355dce2c5', 'en', 'canonical', 'Alexander Dedyukhin', 'alexander dedyukhin', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a47bed8c-fdfb-5b56-aafd-076355dce2c5' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT 'a47bed8c-fdfb-5b56-aafd-076355dce2c5', 'ko', 'canonical', '알렉산드르 데듀힌', '알렉산드르 데듀힌', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = 'a47bed8c-fdfb-5b56-aafd-076355dce2c5' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT 'a47bed8c-fdfb-5b56-aafd-076355dce2c5' AS a, 'gnd' AS n, '13509075X' AS v UNION ALL SELECT 'a47bed8c-fdfb-5b56-aafd-076355dce2c5' AS a, 'isni' AS n, '0000000080969591' AS v UNION ALL SELECT 'a47bed8c-fdfb-5b56-aafd-076355dce2c5' AS a, 'viaf' AS n, '17419195' AS v UNION ALL SELECT 'a47bed8c-fdfb-5b56-aafd-076355dce2c5' AS a, 'wikidata' AS n, 'Q112479872' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '알렉산드르 데듀힌', 'Alexander Dedyukhin', 'pianist', 'A', '1907', 'Russia', 'a47bed8c-fdfb-5b56-aafd-076355dce2c5', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = 'a47bed8c-fdfb-5b56-aafd-076355dce2c5');



INSERT INTO authority_entities (id, entity_kind, editorial_status, origin, editor_locked)
SELECT '85395d9d-70f9-5ab8-99ec-33f33299719b', 'ensemble', 'IDENTIFIERS_MATCHED', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT id FROM authority_entities) existing WHERE existing.id = '85395d9d-70f9-5ab8-99ec-33f33299719b');

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '85395d9d-70f9-5ab8-99ec-33f33299719b', 'en', 'canonical', 'Cologne New Philharmonic Orchestra', 'cologne new philharmonic orchestra', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '85395d9d-70f9-5ab8-99ec-33f33299719b' AND existing.locale = 'en' AND existing.name_kind = 'canonical'
);

INSERT INTO entity_names
    (authority_entity_id, locale, name_kind, name_value, normalized_value, is_preferred, origin, editor_locked)
SELECT '85395d9d-70f9-5ab8-99ec-33f33299719b', 'ko', 'canonical', '쾰른 신 필하모닉 오케스트라', '쾰른 신 필하모닉 오케스트라', 1, 'manual', 1
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, locale, name_kind FROM entity_names) existing
    WHERE existing.authority_entity_id = '85395d9d-70f9-5ab8-99ec-33f33299719b' AND existing.locale = 'ko' AND existing.name_kind = 'canonical'
);

INSERT INTO external_identifiers (authority_entity_id, namespace, external_id)
SELECT * FROM (SELECT '85395d9d-70f9-5ab8-99ec-33f33299719b' AS a, 'gnd' AS n, '10155205-1' AS v UNION ALL SELECT '85395d9d-70f9-5ab8-99ec-33f33299719b' AS a, 'musicbrainz_artist' AS n, '9366e3b3-99dc-48a3-930c-1190ef15f5c8' AS v UNION ALL SELECT '85395d9d-70f9-5ab8-99ec-33f33299719b' AS a, 'viaf' AS n, '126509552' AS v UNION ALL SELECT '85395d9d-70f9-5ab8-99ec-33f33299719b' AS a, 'wikidata' AS n, 'Q22959500' AS v) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT authority_entity_id, namespace, external_id FROM external_identifiers) existing
    WHERE existing.authority_entity_id = incoming.a AND existing.namespace = incoming.n
      AND existing.external_id = incoming.v
);

INSERT INTO artists
    (name, english_name, category, tier, birth_year, nationality, authority_entity_id, origin, editor_locked)
SELECT '쾰른 신 필하모닉 오케스트라', 'Cologne New Philharmonic Orchestra', 'orchestra', 'A', '1972', 'Germany', '85395d9d-70f9-5ab8-99ec-33f33299719b', 'manual', 1
WHERE NOT EXISTS (SELECT 1 FROM (SELECT authority_entity_id FROM artists) existing WHERE existing.authority_entity_id = '85395d9d-70f9-5ab8-99ec-33f33299719b');


